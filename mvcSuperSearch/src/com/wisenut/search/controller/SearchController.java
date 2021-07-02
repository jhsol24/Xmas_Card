package com.wisenut.search.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wisenut.common.Page;
import com.wisenut.common.vo.QueryVo;
import com.wisenut.search.service.SearchService;

@Controller
@RequestMapping(value="/search")
public class SearchController {
		
	private static Logger logger = LogManager.getLogger(SearchController.class);
	
	@Autowired
	private SearchService searchService;

	/**
	 * @return 페이지 이동
	 */
	@RequestMapping(value = "/searchMove.wn")
	public String searchMove(Model model) {
		logger.debug("### Comming Search Page!!");
		return "search";
	}
	
	/**
	 * 분석대상 검색
	 * @param model
	 * @param queryVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSearchResults.wn")
	@ResponseBody
	public Map<String, Object> getSearchResults( @RequestBody @ModelAttribute QueryVo queryVo
											, @Value("#{common['paging.pageBlock']}") String pagingPageBlock
									        , @Value("#{common['paging.pageSize']}")  String pagingPageSize) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(queryVo.getCollection().split(",").length == 1){
			String pageNum = "".equals(queryVo.getPageNum()) ||  queryVo.getPageNum() == null ? "1" : queryVo.getPageNum();
			
			logger.debug("### pageSize  : " + pagingPageSize);
			logger.debug("### pageBlock : " + pagingPageBlock);
			
			// 페이징 start
			Page page 		= Page.getInstance();
			int pageSize 	= Integer.parseInt(pagingPageSize);
			int pageBlock 	= Integer.parseInt(pagingPageBlock);
			
			map = searchService.getTotalSearchList(queryVo);
			
			page.paging(Integer.parseInt(pageNum), (Integer) map.get("totalCount"), pageSize, pageBlock, "fn_doSearch");
			
			map.put("pageCode", page.getSb().toString());
		}else {
			map = searchService.getTotalSearchList(queryVo);
		}
		
		
		logger.debug("### startCount : " + queryVo.getStartCount());
		logger.debug("### Query  	 : " + queryVo.getQuery());
		logger.debug("### Collection : " + queryVo.getCollection());

		return map;
	}
	
	/**
	 * 컬렉션 리스트 출력
	 * @return
	 */
	@RequestMapping(value = "/getCollectionList.wn", method=RequestMethod.GET)
	@ResponseBody
	public List<Map<String, String>> getCollectionList() {
		return searchService.getCollectionList();
	}
	
	/**
	 * 개별 문서 검색
	 * @param queryVo
	 * @param uid
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value ="/getSearchDetail.wn", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getDetail(@RequestBody @ModelAttribute QueryVo queryVo, String uid) throws Exception {
		return searchService.getJsonDetail(queryVo, uid);
	}
	
	
	/**
	 * @param queryVo
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/getCategoryGubun.wn")
	@ResponseBody
	public List<Map<String, Object>> getCategoryGubun(@RequestBody @ModelAttribute QueryVo queryVo) throws Exception {
		return searchService.getCategoryXGGubun(queryVo);
	}
	
	
	/**
	 * 검색결과 다운로드
	 * @param queryVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/downloadSearchResult.wn")
	@ResponseBody
	public Map<String, String> downloadSearchResult(@RequestBody @ModelAttribute QueryVo queryVo,@RequestParam("gubun") String gubun) throws Exception {
		return searchService.downloadSearchResult(queryVo, gubun);
	}
}
