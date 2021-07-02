package com.wisenut.superSearch.Controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.wisenut.superSearch.service.idesk.IdeskTest_dctn;
import com.wisenut.superSearch.service.impl.impl.WiseSearchServiceImpl;

import java.util.*;

@Controller
public class SuperSearchController {
//	final private Logger logger = LoggerFactory.getLogger(this.getClass());


//	@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private WiseSearchServiceImpl  wssi; // 서비스
	
	
	 
	
	

//	private final static String MAIN_SITE = Constant.APP_PATH + Constant.SITE_ID_PATH;
	
	/*#origin_search 페이지 이동 
	 * 
	 * 
	 * 
	 * */

	
	/*#search 페이지 이동 
	 * 
	 * 
	 * 
	 * */
	@RequestMapping(value ="/superSearch/moveSearchList.wn", method = RequestMethod.GET)
	public String search(Model model, @RequestParam Map<String, String> searchMap) {
		System.out.println("처음진입");
		for (String key : searchMap.keySet()) {
			System.out.println(searchMap.get(key));
			System.out.println("/");
		}
		System.out.println();
		String homepath="search/total_search";
		model.addAttribute("colList", wssi.doSearch(searchMap));
		return homepath;
	}
	
	
	/*#검색
	 * 
	 * 
	 * 
	 * */
	/*
	 * @RequestMapping(value ="/superSearch/getSearch.wn", method =
	 * RequestMethod.POST) public ModelAndView getSearchList01(@RequestParam
	 * Map<String, String> searchMap) { System.out.println("검색진입");
	 * System.out.println(searchMap.toString()); ModelAndView mv = new
	 * ModelAndView(); System.out.println("here");
	 * mv.setViewName("search/total_search"); mv.addObject("colList",
	 * wssi.doSearch(searchMap)); return mv; }
	 */
	 //onclick 이벤트 -> get 방식 
	 @RequestMapping(value ="/superSearch/getSearch.wn", method = RequestMethod.GET) 
	 public ModelAndView getSearchList02(@RequestParam Map<String, String> searchMap) { 
		
	 	System.out.println("검색진입");
	 	for (String key : searchMap.keySet()) {
		System.out.println(key);
		System.out.println(searchMap.get(key));
		System.out.println("/"); }
			
		
		 ModelAndView mv = new ModelAndView();
			/* System.out.println("here"); */
		 mv.setViewName("search/total_search");
		 mv.addObject("colList", wssi.doSearch(searchMap));
		 return mv; 
	 }
	 

	 
	 //idesk컨트롤러 추가하기
	

}
