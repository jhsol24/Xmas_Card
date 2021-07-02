package com.wisenut.superSearch.controller;

import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.wisenut.superSearch.service.WiseSearchServiceImpl;

@Controller
public class SuperSearchController {
	
	@Autowired
	private WiseSearchServiceImpl wssi;

	private Logger logger = Logger.getLogger(SuperSearchController.class);
	
	/*
	 * search 페이지 이동
	 * 
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="superSearch/moveSearchList.wn")
	public String moveSearchList() throws Exception {
		
		return "search/jhs_search";
	}
	
	/*
	 * 검색 조회
	 *   
	 * @throws Exception
	 */
	
	@RequestMapping(value="superSearch/getSearchList.wn")
	public ModelAndView getSearchList(@RequestParam Map<String, String> searchMap) throws Exception {

		logger.debug("########## getSearchList ##########");
		
		ModelAndView mv = new ModelAndView();
		
		/*
		 * 서비스 만들기
		 */
		
		// Controller 와 View 연결을 위한 확인
		System.out.println("파라미터 "+searchMap);
		mv.addObject("colList", wssi.doSearch(searchMap));
		mv.setViewName("search/jhs_search");
		
		
		return mv;
	}
}
