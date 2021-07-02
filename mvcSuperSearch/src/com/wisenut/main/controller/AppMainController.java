package com.wisenut.main.controller;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppMainController {

	
	private static Logger logger =  LogManager.getLogger(AppMainController.class);
	
	
	@RequestMapping(value="/")   
	public String root() {
		return "dashboard";             
	}
	
	@RequestMapping(value="/main.wn")   
	public String main() {
		
		logger.info("### Comming Main Admin!! ");
		
		return "dashboard";             
	}
	
	
	
	
	@RequestMapping(value="/dashboard.wn")   
	public String dashboard() {
		
		logger.info("### Comming dashboard !! ");
		
		return "dashboard";             
	}
	
	@RequestMapping(value="/login.wn")   
	public String login() {
		
		logger.info("### Comming dashboard !! ");
		
		return "login/login";             
	}
	
	@RequestMapping(value="/training.wn")   
	public String training() {
		
		logger.info("### Comming dashboard !! ");
		
		return "training";             
	}
	
	@RequestMapping(value="/drag.wn")   
	public String drag() {
		
		logger.info("### Comming dashboard !! ");
		
		return "drag";             
	}
	
	@RequestMapping(value="/test.wn")   
	public String test() {
		
		logger.info("### Comming dashboard !! ");
		
		return "sample/test";             
	}
	
	
}
