package com.wisenut.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/login")
public class LoginController {

	private Logger logger = Logger.getLogger(LoginController.class);
	
	/*
	 * @Autowired private LoginService service;
	 */
	
	@RequestMapping(value="/login.wn")
	public String login() throws Exception{
		
		return "login/login";
	}
	
	@RequestMapping(value="/logout.wn")
	public String logout(HttpServletRequest req) throws Exception{
		req.getSession().invalidate();
		req.getSession(true);
		return "login/login";
	}

	
	/**
	 * 서버 authLogin
	 * @param model
	 * @param loginVo
	 * @throws Exception
	 */
	@RequestMapping(value="/authLogin.wn")
	@ResponseBody
	public Map<String, Object> authLogin( @RequestParam("id") String id
				, @RequestParam("pw") String pw, HttpServletRequest request, HttpServletResponse response ) throws Exception {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
	    map.put("redirectUrl", "login/login.wn");
	    map.put("ok", false);
		
		HttpSession session = request.getSession(false);
		boolean loginSessionResult = loginSessionCheck(id, pw, map, request);
		if ( ((boolean) map.get("ok")) && loginSessionResult && ( ((String)session.getAttribute("id")!=null) || (session.getAttribute("id").toString().length() > 0)) ) logger.debug("### 로그인 : Session으로 정상 로그인 되었습니다.");//예외사항없이 true값을 받을 시에는

	    return map;
		
	} //authLogin
	
	
	//로그인 Session Check 메소드
	private boolean loginSessionCheck(String id, String pw, HashMap<String, Object> map,  HttpServletRequest request) throws Exception{
		try {
			
			boolean loginSessionResult = false;
		    HttpSession session = request.getSession(false);
		    
        	if(session == null) {
        		session = request.getSession(true);
        	}else {
        		session = request.getSession(true);
        	}

    		session.setAttribute("id", id);
        	session.setAttribute("loginUserId", id);

        	if (session.isNew()) {
        		//logger.debug("@@@ session.isNew() : session.getAttribute(id) : " + session.getAttribute(id));
        		//logger.debug("@@@ session.isNew() :  session.getAttribute('loginUserId') " + session.getAttribute("loginUserId"));
        	}else {
        		//logger.debug("@@X session.isNotNew() :  session.getAttribute('id') " + session.getAttribute("id"));
        	}
        	
        	if ( loginValCheck(id, pw, map) && (boolean) map.get("ok") ) loginSessionResult = true;

			if (loginSessionResult) logger.debug("Session 로그인 되었습니다");
		}
		catch (Exception e) {
			logger.info("Error Message \n LoginController:loginSessionCheck:");
			logger.info(e.getMessage());
		}
		finally {
		}
		
		return true;
		
	}
		
	
		
	
	
	//로그인 Val 메소드
	private boolean loginValCheck(String id, String pw, HashMap<String, Object> map) throws Exception{
		
		
		String[] aId = { "wisenut",		"uracle" };
		String[] aPw = { "wisenut1!",	"uracle1!" };
		
		
	    int i = 0;
		forBk:
		    for (i = 0; i < aId.length; i++) {//비교중.
		        if (aId[i].equals(id) && aPw[i].equals(pw)) { //일치함.
		        		map.put("ok", true);
		        		map.put("id", id);
		        		map.put("loginUserId", id);
		        		
		        		map.put("redirectUrl", "/main.wn");
		        		
		        	    break forBk;
	        	}//일치함.End.
	    	} //비교.End.

	    if ( i  > aId.length ) {
			map.put("ok", false);
			map.put("id", "");
    		map.put("loginUserId", ""); 
			map.put("error", "ID 또는 비밀번호를 다시 한 번 더 확인 하시고 재 시도해 주시기 바랍니다.");

		    map.put("redirectUrl", "/login/login.wn"); 
	    	
	    }
		
		return true;
		
	}		
		
	

	
} //LoginController