package com.wisenut.util.cfHttp;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.google.gson.Gson;

@Component
public class HttpService {
	
	private static Logger logger = LogManager.getLogger(HttpService.class);
	
	public static CfResultVo callHttp(String clIp, String clPort, String mode, String method,  Map<String, Object> params){
		
		Gson gson = new Gson();
		CfResultVo vo = null;
		BufferedReader in 	= null;
		String inputLine 	= "";
		StringBuffer sb 	= new StringBuffer();
		String strUrl 		= "http://" + clIp + ":" + clPort + "/classifier:" + mode;
		try {
			
			
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
				vo = gson.fromJson(sb.toString(), CfResultVo.class);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return vo;
	}
	
	
	public static CfResultVo callHttp(String clIp, String clPort, String mode, String method){
		
		Gson gson = new Gson();
		CfResultVo vo = null;
		BufferedReader in 	= null;
		String inputLine 	= "";
		StringBuffer sb 	= new StringBuffer();
		String strUrl 		= "http://" + clIp + ":" + clPort + "/classifier:" + mode;
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
			logger.debug("### 서버 멈춰 있는 상태 !!");
			inputLine = "서버 다이!";
			logger.debug("inputLine: " + inputLine);
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
				vo = gson.fromJson(sb.toString(), CfResultVo.class);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		return vo;
		
	}

	
}
