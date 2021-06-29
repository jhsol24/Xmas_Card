package com.wisenut.topic.service;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.stream.JsonReader;
import com.wisenut.common.vo.QueryVo;
import com.wisenut.common.wnsearch.WNSearch;
import com.wisenut.search.service.SearchService;
import com.wisenut.topic.vo.TopicListVo;

@Service
public class TopicListService {
	
	private static Logger logger = LogManager.getLogger(TopicListService.class);
	
	@Value("#{common['tea.ip']}")
	String teaIp;

	@Value("#{common['tea.port']}")
	String teaPort;
	
	@Autowired
	SearchService search;
	
	/**
	 * TEA 연동 주제어 리스트 출력
	 * @return
	 */
	public TopicListVo getTopicList() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("coll_id", "cf_data_sigint");
		params.put("num_topics", "100");
		params.put("num_keywords", "5");
		params.put("format", "json");
		
		return callHttp(teaIp, teaPort, "GET", params);
	}
	
	
	
	private static TopicListVo callHttp(String teaIp, String teaPort, String method,  Map<String, Object> params){
		
		Gson gson 			= new Gson();
		TopicListVo vo 		= null;
		BufferedReader in 	= null;
		String str  = "";
		JsonReader jr = null;
		
		String strUrl 		= "http://" + teaIp + ":" + teaPort + "/topic_list_w.tea2?";
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
			
			jr = new JsonReader(in);
			jr.setLenient(true);
			
		} catch(ConnectException ex){
			ex.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				vo = gson.fromJson(jr, TopicListVo.class);
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return vo;
	}



	public List<HashMap<String, Object>> getTermsGroupList(QueryVo searchQuery) throws Exception {
		return search.getTermsGroup(searchQuery);
	}

}
