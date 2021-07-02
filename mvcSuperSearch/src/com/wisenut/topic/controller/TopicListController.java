package com.wisenut.topic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wisenut.common.vo.QueryVo;
import com.wisenut.topic.service.TopicListService;
import com.wisenut.topic.vo.TopicListVo;
import com.wisenut.topic.vo.Topics;

@Controller
@RequestMapping(value="/topic")
public class TopicListController {

	private static Logger logger = LogManager.getLogger(TopicListController.class);
	
	@Autowired
	TopicListService service;
	
	@RequestMapping(value="/topic.wn")
	public String topicRelationMove() {
		return "topic/topic";
	}
	
	@RequestMapping(value="/topiclist.wn")
	@ResponseBody
	public Map<String, Object> topicList() {
		Map<String, Object> map = new HashMap<String, Object>();
		TopicListVo topic = service.getTopicList();
		
		map.put("Topics", topic.getResponse().get(0).getTopics());
		return map;
	}
	
	@RequestMapping(value="/termslist.wn")
	@ResponseBody
	public Map<String, Object> getTermsGroup(@RequestBody @ModelAttribute QueryVo searchQuery) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("data", service.getTermsGroupList(searchQuery));
		
		return map;
	}
}