package com.wisenut.server.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wisenut.common.Page;
import com.wisenut.server.service.ServerService;
import com.wisenut.server.vo.ServerVo;

@Controller
@RequestMapping(value="/server")
public class ServerController {

	private Logger logger = Logger.getLogger(ServerController.class);
	
	@Autowired
	private ServerService service;
	
	@RequestMapping(value="/serverMove.wn")
	public String serverMove() throws Exception{
		
		return "server/server";
	}

	
	/**
	 * 서버 등록
	 * @param model
	 * @param serverVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveServer.wn")
	@ResponseBody
	public Map<String, Object> saveServer( Model model
			                             , @RequestBody @ModelAttribute ServerVo serverVo
										 ) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		int chkCnt = 0;
		
		logger.debug("### Cfsv_stat : " + serverVo.getCfsv_stat()); //C/U
		logger.debug("## Key_id : " + serverVo.getKey_id());
		logger.debug("## Cfsv_id : " + serverVo.getCfsv_id()); //서버ID
		
		if("C".equals(serverVo.getCfsv_stat())){
			chkCnt = service.saveServer(serverVo);
			map.put("key_id",serverVo.getKey_id());
		}else if("U".equals(serverVo.getCfsv_stat())){
			chkCnt = service.updateServer(serverVo);
			map.put("key_id",serverVo.getCfsv_id());
		}else{
			chkCnt = service.updateServer(serverVo);
			map.put("key_id",serverVo.getCfsv_id());
		}
		
		map.put("chkCnt", chkCnt);
		
		return map;
	}
	
	
	/**
	 * 서버 삭제
	 * @param model
	 * @param serverVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteServer.wn")
	@ResponseBody
	public Map<String, Object> deleteServer( Model model
											, @RequestBody @ModelAttribute ServerVo serverVo
											) throws Exception {
	
		Map<String, Object> map = new HashMap<String, Object>();
		int chkCnt = 0;
		
		logger.debug("### deleteServer ### cfsv_stat : " + serverVo.getCfsv_stat()); //C/U
		logger.debug("## key_id : " + serverVo.getKey_id());		//서버ID :* 서버 등록/수정 : 0
		logger.debug("## sfsv_id : " + serverVo.getCfsv_id());		//서버ID :서버ID : cfsv_id  :3
		logger.debug("## d_cfsv_id : " + serverVo.getD_cfsv_id());	//서버ID :서버ID : ## p_cfsv_id : n

		chkCnt = service.deleteServer(serverVo);
		map.put("chkCnt", chkCnt);
		
		return map;
	}
	
	
	/**
	 * 서버목록 검색 
	 * @param model
	 * @param serverVo //actVo
	 * @param query
	 * @param pagingPageBlock
	 * @param pagingPageSize
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getList.wn")
	@ResponseBody
	public Map<String, Object> getList(  Model model
			                           , @RequestBody @ModelAttribute ServerVo serverVo
							           , @Value("#{common['paging.pageBlock']}") String pagingPageBlock
							           , @Value("#{common['paging.pageSize']}")  String pagingPageSize) throws Exception {
		
		Map<String,Object> map = new HashMap<String,Object>();
		String pageNum = "".equals(serverVo.getPageNum()) ||  serverVo.getPageNum() == null ? "1" : serverVo.getPageNum();
		
		logger.debug("### pageNum   : " + serverVo.getPageNum());
		logger.debug("### pageSize  : " + pagingPageSize);
		logger.debug("### pageBlock : " + pagingPageBlock);
		logger.debug("### query : " + serverVo.getQuery());
		// 페이징 start
		Page page 		= Page.getInstance();
		int pageSize 	= Integer.parseInt(pagingPageSize);
		int pageBlock 	= Integer.parseInt(pagingPageBlock);
		
		int totalCount 	= service.getTotalActList(serverVo); //화면별 총갯수 필수.
		logger.info("totalCount : " + totalCount);
		page.paging(Integer.parseInt(pageNum), totalCount, pageSize, pageBlock, "fn_getList");
		// 페이징 end
		
		serverVo.setStartNum(page.getStartRow());
		serverVo.setPageSize(pageSize);
		
		List<ServerVo> list = service.getList(serverVo);

		map.put("pageCode"	, page.getSb().toString());
		map.put("totalCount", totalCount);
		map.put("serverVo"	, serverVo);
		map.put("list"		, list);
		
		return map;
	}
	
	
	/**
	 * 서버 상세
	 * @param model
	 * @param serverVo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getDetail.wn")
	@ResponseBody
	public Map<String, Object> getDetail( Model model
            							, @RequestBody @ModelAttribute ServerVo serverVo
            							) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		ServerVo vo = service.getDetail(serverVo);
		
		map.put("serverVo", vo);
		
		return map;
	}
	
	
}

