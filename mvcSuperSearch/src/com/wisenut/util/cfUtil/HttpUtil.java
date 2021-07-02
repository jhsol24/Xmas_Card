package com.wisenut.util.cfUtil;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;

public class HttpUtil {
	
	public static String callHttp(String strUrl, String method, Map<String, Object> paramMap) throws Exception{
		
		
		BufferedReader in = null;
		String inputLine = "";
		StringBuffer sb = new StringBuffer();
		HttpURLConnection conn = null;
		ObjectMapper mapper = new ObjectMapper();
		
		
		try {
			
			URL url = new URL(strUrl);
			StringBuilder postData = new StringBuilder();
			
			for(Map.Entry<String, Object> param : paramMap.entrySet()) {
				if(postData.length() != 0) {
					postData.append("&");
				}

				postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
				postData.append("=");
				postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
				
				
				
				
			}
			byte[] postDataBytes = postData.toString().getBytes("UTF-8");
			
			conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod(method);
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Content-length", String.valueOf(postDataBytes));
			conn.setDoOutput(true);
			conn.getOutputStream().write(postDataBytes);
			
			in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			while((inputLine = in.readLine()) != null) {
				sb.append(inputLine);
			}
					
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				if(in != null) in.close();
				if(conn != null) {
					conn.disconnect();
					conn = null;
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return sb.toString();
		
	}

}
