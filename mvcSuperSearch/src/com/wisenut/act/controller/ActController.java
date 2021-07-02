 package com.wisenut.act.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wisenut.act.service.ActService;
import com.wisenut.act.vo.ActVo;
import com.wisenut.common.Page;
import com.wisenut.common.vo.QueryVo;
import com.wisenut.search.service.SearchService;
import com.wisenut.server.vo.ServerVo;

@Controller
@RequestMapping(value = "/act")
public class ActController {
//test
//test
	private static Logger logger = LogManager.getLogger(ActController.class);

	@Autowired
	private ActService actService;


	@Autowired
	private SearchService searchService;

	
	/**
	 * 시뮬레이션 화면 이동
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/actMove.wn")
	public String actMove(Model model) throws Exception {

		return "act/act";
	}

	
	/**
	 * 시뮬레이션 결과
	 * 
	 * @param model
	 * @param sentence
	 * @param clIp
	 * @param clPort
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getActRs.wn")
	@ResponseBody
	public Map<String, Object> getActRs(Model model
			                          , @RequestParam("sentence") String sentence
			                          , @RequestParam("cfsv_id") String cfsv_id
			                          , @RequestParam("clthreshold") String anal_threshold ) throws Exception {

		ServerVo serverVo = actService.getServer(cfsv_id);
		
		logger.info(serverVo.toString());

		Map<String, Object> map = actService.getCfText(serverVo.getCfsv_ip(), serverVo.getCfsv_port(), sentence, cfsv_id, anal_threshold);
		
		return map;
	}
	

	/**
	 * 분석대상 검색 ( 검색엔진 연동 )
	 * @param model
	 * @param searchQuery
	 * @param pagingPageBlock
	 * @param pagingPageSize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSearchList.wn")
	@ResponseBody
	public Map<String, Object> getSearchList(Model model, @RequestBody @ModelAttribute QueryVo searchQuery
										, @Value("#{common['paging.pageBlock']}") String pagingPageBlock
								        , @Value("#{common['paging.pageSize']}")  String pagingPageSize) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map = searchService.getTotalSearchList(searchQuery);
		
		String pageNum = "".equals(searchQuery.getPageNum()) ||  searchQuery.getPageNum() == null ? "1" : searchQuery.getPageNum();
		
		logger.debug("### pageSize   : " + pagingPageSize);
		logger.debug("### pageBlock  : " + pagingPageBlock);
		
		// 페이징 start
		Page page 		= Page.getInstance();
		int pageSize 	= Integer.parseInt(pagingPageSize);
		int pageBlock 	= Integer.parseInt(pagingPageBlock);
		
		page.paging(Integer.parseInt(pageNum), (Integer) map.get("totalCount"), pageSize, pageBlock, "fn_getList");
		
		logger.debug("### totalCount : " + map.get("totalCount"));
		logger.debug("### Query  : " + searchQuery.getQuery());
		logger.debug("### Collection  : " + searchQuery.getCollection());
		
		map.put("pageCode"	, page.getSb().toString());
		map.put("query", searchQuery.getQuery());
		map.put("startPage", searchQuery.getStartCount());
		
		return map;
	}
	
	
	/**
	 * 분석대상 검색 
	 * @param model
	 * @param actVo
	 * @param query
	 * @param pagingPageBlock
	 * @param pagingPageSize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getList.wn")
	@ResponseBody
	public Map<String, Object> getList(  Model model
			                           , @RequestBody @ModelAttribute ActVo actVo
							           , @RequestParam("query") String query
							           , @Value("#{common['paging.pageBlock']}") String pagingPageBlock
							           , @Value("#{common['paging.pageSize']}")  String pagingPageSize) throws Exception{
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		String pageNum = "".equals(actVo.getPageNum()) ||  actVo.getPageNum() == null ? "1" : actVo.getPageNum();
		
		logger.debug("### pageNum   : " + actVo.getPageNum());
		logger.debug("### pageSize  : " + pagingPageSize);
		logger.debug("### pageBlock : " + pagingPageBlock);
		
		// 페이징 start
		Page page 		= Page.getInstance();
		int pageSize 	= Integer.parseInt(pagingPageSize);
		int pageBlock 	= Integer.parseInt(pagingPageBlock);
		
		int totalCount 	= actService.getTotalActList(actVo); //화면별 총갯수 필수.
		page.paging(Integer.parseInt(pageNum), totalCount, pageSize, pageBlock, "fn_getList");
		// 페이징 end
	
		
//		logger.info("totalCount : " + totalCount);
		
		actVo.setStartNum(page.getStartRow());
		actVo.setPageSize(pageSize);
		
		List<ActVo> list = actService.getActList(actVo);
		
		map.put("pageCode"	, page.getSb().toString());
		map.put("totalCount", totalCount);
		map.put("actVo"		, actVo);
		map.put("query"		, query);
		map.put("list"		, list);
		
		return map;
	}
	

	/**
	 * @return
	 */
	@RequestMapping(value = "/getCollectionList.wn")
	@ResponseBody
	public List<Map<String, String>> getCollectionList() {
		return searchService.getCollectionList();
	}
	
	/**
	 * @param model
	 * @param searchQuery
	 * @param uid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSearchDetail.wn")
	@ResponseBody
	public List<Map<String, Object>> getSearchDetail(Model model, @RequestBody @ModelAttribute QueryVo searchQuery, @RequestParam("uid") String uid) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = searchService.getJsonDetail(searchQuery, uid);
		return list;
	}

	
	/**
	 * 분석대상 상세
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getDetail.wn")
	@ResponseBody
	public Map<String, Object> getDetail(Model model, @RequestBody @ModelAttribute ActVo actVo) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		ActVo dtVo = actService.getDetail(actVo.getCf_id());

		map.put("dtVo", dtVo);

		return map;
	}
}
