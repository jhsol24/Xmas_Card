package com.wisenut.util.cfUtil;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import com.google.gson.Gson;

public class CfApiUtil {

	
	private static Logger logger = LogManager.getLogger(CfApiUtil.class);
	
	/**
	 * 분석 실행
	 * @param collection
	 * @param content
	 * @param ip
	 * @param port
	 * @param maxThreashHolder
	 * @return
	 * @throws Exception
	 */
	public static CfApiVo runAnalyCf(String collection, String content, String ip, String port, double maxThreashHolder) throws Exception {
		
		String strAnalResult = "";
		String strdismatchingWord = "null";	
		double strAnalResultval = 0;   	
		CfApiVo cfApiVo = new CfApiVo(); 
		
		// 파라미터 세팅
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("content", content); //파라미터 처리
		paramMap.put("collection", collection);
		
		
		// CF API 호출
		String strUrl = "http://" + ip + ":" + port + "/analyzer:simulate";
		String retStr = HttpUtil.callHttp(strUrl, "POST", paramMap);
		
		// 결과 JSON 데이터 파싱
		ObjectMapper om = new ObjectMapper();
		Map<String, Object> omMap = new HashMap<String, Object>();
		try {
			
			omMap = om.readValue(retStr, new TypeReference<Map<String, Object>>() {});
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("#### : retStr : " + retStr);
		}
		
		Boolean responseCheck = (Boolean) omMap.get("response");
		
		if(responseCheck) {
			
			List<Map<String, Object>> list = (List<Map<String, Object>>) omMap.get("result");
			
			//////////////////////////////
			// 분석결과
			//////////////////////////////
			// 20201125 변경
			strAnalResultval = Float.valueOf(list.get(0).get("value").toString()); 
			
			if(strAnalResultval >= maxThreashHolder) {
				strAnalResult = list.get(0).get("key").toString();
			}else {
				strAnalResult = strdismatchingWord;
			}
			// 20201125 변경
			
			cfApiVo.setList(list);
			cfApiVo.setResponse(responseCheck);
			cfApiVo.setResultAnal(strAnalResult);
			cfApiVo.setMessage("성공");
			
		}else {
			cfApiVo.setResponse(responseCheck);
			cfApiVo.setMessage("연결 실패");
		}
		
		
		return cfApiVo;
		
	}
	
	
	/**
	 * 학습실행
	 * @param clIp
	 * @param clPort
	 * @param mode
	 * @param method
	 * @param params
	 * @return
	 */
	public static CfApiVo runTrainCf(String clIp, String clPort, String mode, String method,  Map<String, Object> params){
		
		Gson gson = new Gson();
		CfApiVo vo = null;
		BufferedReader in 	= null;
		String inputLine 	= "";
		StringBuffer sb 	= new StringBuffer();
		clIp = clIp.replaceAll(" ", "");
		clPort = clPort.replaceAll(" ", "");
		mode = mode.replaceAll(" ", "");
		
		String strUrl 		= "http://" + clIp + ":" + clPort + "/trainer:" + mode;
		try {
			
			logger.debug("#### strUrl : " + strUrl);
			URL url = new URL(strUrl);
			StringBuilder postData = new StringBuilder();
			
			for (Map.Entry<String, Object> param : params.entrySet()) {
				if (postData.length() != 0)
					postData.append('&');
				postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
				postData.append('=');
				postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
			}
			
			byte[] postDataBytes = postData.toString().getBytes("UTF-8");
			
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod(method);
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
			conn.setDoOutput(true);
			conn.getOutputStream().write(postDataBytes); // POST 호출
			
			in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			
			while ((inputLine = in.readLine()) != null) { // response 출력
				logger.debug(inputLine);
				sb.append(inputLine);
			}
			
		} catch(ConnectException ex){
			
			ex.printStackTrace();
			logger.debug("### 서버 멈춰 있는 상태 !!");
			inputLine = "서버 다이!";
			logger.debug("inputLine: " + inputLine);
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
				vo = gson.fromJson(sb.toString(), CfApiVo.class);
				logger.debug("#### gson : " + vo);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return vo;
	}
	
	

	/**
	 * 학습 진행상태 체크
	 * @param clIp
	 * @param clPort
	 * @param mode
	 * @param method
	 * @return
	 */
	public static CfApiVo getStudyStatus(String clIp, String clPort, String mode, String method){
		
		Gson gson = new Gson();
		CfApiVo vo = null;
		BufferedReader in 	= null;
		String inputLine 	= "";
		StringBuffer sb 	= new StringBuffer();
		clIp = clIp.replaceAll(" ", "");
		clPort = clPort.replaceAll(" ", "");
		mode = mode.replaceAll(" ", "");
		String strUrl 		= "http://" + clIp + ":" + clPort + "/trainer/" + mode;
		try {
			
			
			URL url = new URL(strUrl);
			
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod(method);
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setDoOutput(true);
			
			in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			
			while ((inputLine = in.readLine()) != null) { // response 출력
				logger.debug(inputLine);
				sb.append(inputLine);
			}
			
		} catch(ConnectException ex){
			
			ex.printStackTrace();
			logger.debug("### 학습 상태체크 ###");
			inputLine = "서버 다이!";
			logger.debug("inputLine: " + inputLine);
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
				vo = gson.fromJson(sb.toString(), CfApiVo.class);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		return vo;
	}
	

	
	
	
	
	/**
	 * 서버 상태 체크
	 * @param clIp
	 * @param clPort
	 * @param mode
	 * @param method
	 * @return
	 */
	public static CfApiVo getServerSatatus(String clIp, String clPort, String mode, String method){
		
		Gson gson = new Gson();
		CfApiVo vo = new CfApiVo();
		BufferedReader in 	= null;
		String inputLine 	= "";
		StringBuffer sb 	= new StringBuffer();
		clIp = clIp.replaceAll(" ", "");
		clPort = clPort.replaceAll(" ", "");
		mode = mode.replaceAll(" ", "");
		String strUrl 		= "http://" + clIp + ":" + clPort + "/analyzer/" + mode;
		try {
			
			
			URL url = new URL(strUrl);
			
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod(method);
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setDoOutput(true);
			
			in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			
			while ((inputLine = in.readLine()) != null) { // response 출력
				logger.debug(inputLine);
				sb.append(inputLine);
			}
			
			vo = gson.fromJson(sb.toString(), CfApiVo.class);
			
		} catch(ConnectException ex){
			
			ex.printStackTrace();
			logger.debug("### 서버상태 체크 : 서버 멈춰 있는 상태 !!");
			inputLine = "서버 다이!";
			logger.debug("inputLine: " + inputLine);
			vo.setResponse(false);
			vo.setStatus("BREAK");
			
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(in != null) in.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return vo;
	}
	
	
	
	
	/**
	 * 모델 정보 조회
	 * @param clIp
	 * @param clPort
	 * @param mode
	 * @param method
	 * @return
	 */
	public static CfApiVo getModelInfo(String clIp, String clPort, String mode, String method, String collection){
		
		Gson gson = new Gson();
		CfApiVo vo = new CfApiVo();
		BufferedReader in 	= null;
		String inputLine 	= "";
		StringBuffer sb 	= new StringBuffer();
		clIp = clIp.replaceAll(" ", "");
		clPort = clPort.replaceAll(" ", "");
		mode = mode.replaceAll(" ", "");
		String strUrl 		= "http://" + clIp + ":" + clPort + "/trainer/" + mode + "?collection=" + collection;
		try {
			
			
			URL url = new URL(strUrl);
			
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod(method);
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setDoOutput(true);
			
			in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			
			while ((inputLine = in.readLine()) != null) { // response 출력
				logger.debug(inputLine);
				sb.append(inputLine);
			}
			
			vo = gson.fromJson(sb.toString(), CfApiVo.class);
			
		} catch(ConnectException ex){
			
			ex.printStackTrace();
			logger.debug("### 서버상태 체크 : 서버 멈춰 있는 상태 !!");
			inputLine = "서버 다이!";
			logger.debug("inputLine: " + inputLine);
			vo.setResponse(false);
			vo.setStatus("BREAK");
			
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(in != null) in.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return vo;
	}
	
	
	
	
	
	
	
	
	
	public static void main(String[] args) throws Exception{
		

		String strAnalResult = "";
		
		String strdismatchingWord 		= "null";	// 20201125 추가
		double strAnalResultval 		= 0;   		// 20201125 추가
		final double maxThreashHolder 	= 0.89; 	// 20201125 추가
		
		
		// 파라미터 세팅
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("content", "test 중입니다."); //파라미터 처리
		paramMap.put("collection", "singo");
		
		
		// CF API 호출
		String strUrl = "http://211.39.140.162:16100/analyzer:simulate";
		String retStr = HttpUtil.callHttp(strUrl, "POST", paramMap);
		
		
		// 결과 JSON 데이터 파싱
		ObjectMapper om = new ObjectMapper();
		Map<String, Object> omMap = new HashMap<String, Object>();
		omMap = om.readValue(retStr, new TypeReference<Map<String, Object>>() {});
		
		
		Boolean responseCheck = (Boolean) omMap.get("response");
		
		System.out.println(responseCheck);
		
		
		if(responseCheck) {
			
			List<Map<String, Object>> list = (List<Map<String, Object>>) omMap.get("result");
			
			// 모든 결과 출력
			for(Map resultMap : list) {
				System.out.println(resultMap.get("key"));
				System.out.println(resultMap.get("value"));
			}
			
			//////////////////////////////
			// 분석결과
			//////////////////////////////
			
			// 20201125 변경
			strAnalResultval = Float.valueOf(list.get(0).get("value").toString()); 
			System.out.println("strAnalResultval + " + strAnalResultval);
			
			if(strAnalResultval >= maxThreashHolder) {
				strAnalResult = list.get(0).get("key").toString();
			}else {
				strAnalResult = strdismatchingWord;
			}
			// 20201125 변경
			
			
			
			
			System.out.println("###############################");
			System.out.println("분석결과 : " + strAnalResult);
			System.out.println("###############################");
			//////////////////////////////
			
			
			
		}else {
			System.out.println("연결 실패");
		}
		

	}
	
}


