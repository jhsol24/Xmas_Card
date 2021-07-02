package com.wisenut.act.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wisenut.act.service.StudyResultService;
import com.wisenut.common.vo.QueryVo;
import com.wisenut.common.wnsearch.WNSearch;

@Controller
@RequestMapping(value="/result")
public class StudyResultController {
	
	private static Logger logger = LogManager.getLogger(StudyResultController.class);
	
	@Autowired
	StudyResultService service;
	
	@Autowired
	WNSearch search;
	
	@RequestMapping(value = "/results.wn")
	public String search2Move(Model model) {
		logger.debug("### Comming Search2 Page!!");
		return "act/result";
	}
	
	@RequestMapping(value = "/moveSearchResults.wn")
	@ResponseBody
	public Map<String, Boolean> moveSearchResults(@RequestBody @ModelAttribute QueryVo searchQuery,
																@RequestParam("cfsv_id") String cfsv_id,
																@RequestParam("docField") String docField,
																@RequestParam("uid") String uid,
																@RequestParam("gubun") String gubun) throws Exception {
		
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		logger.debug("### SearchController -> moveSearchResults.wn");
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list = search.getJsonDetail(searchQuery, uid);
		
		//studyService.setStudy(list, cfsv_id, searchQuery.getCollection(), docField);
		service.makeScdFile(searchQuery.getCollection(), uid, gubun);
		Boolean isSuccess = service.startIndexer(searchQuery.getCollection(), "dynamic");
		
		if(isSuccess){
			map.put("status", true);
		} else {
			map.put("status", false);
		}
	
		return map;
	}
	
	@RequestMapping("/mergeSearchResults.wn")
	@ResponseBody
	public Map<String, Boolean> mergeSearchResults(@RequestBody @ModelAttribute QueryVo searchQuery) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		Boolean isSuccess = service.startIndexer(searchQuery.getCollection(), "merge");
	
		if(isSuccess){
			map.put("status", true);
		} else {
			map.put("status", false);
		}
		
		return map;
	}
}
