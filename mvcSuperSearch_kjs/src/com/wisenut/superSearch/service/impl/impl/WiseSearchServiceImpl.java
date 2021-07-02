package com.wisenut.superSearch.service.impl.impl;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sun.corba.se.impl.oa.poa.ActiveObjectMap.Key;
import com.wisenut.superSearch.common.WNCollection;
import com.wisenut.superSearch.common.WNSearch;
import com.wisenut.superSearch.common.WNUtils;
import com.wisenut.superSearch.service.impl.WiseSearchService;

import java.io.*;
import java.net.*;
import java.util.*;
import java.util.Map.Entry;


@Service
public class WiseSearchServiceImpl implements WiseSearchService {
	

	@Override
	public LinkedHashMap<String,Object> doSearch(Map<String, String> searchMap)  {
		//public HashMap<String, Object> doSearch(HttpServletRequest request) {
		WNCollection wncol = new WNCollection();

		
		//더보기 클릭
		boolean moresee = false;
				
		//실시간 검색어 화면 출력 여부 체크
		boolean isRealTimeKeyword = false;
		//오타 후 추천 검색어 화면 출력 여부 체크
		boolean useSuggestedQuery = true;
		//디버깅 보기 설정
		boolean isDebug = false;

		final int TOTAL_VIEW_COUNT = 3;    //통합검색시 출력건수
		final int COLLECTION_VIEW_COUNT = 10;    //더보기시 출력건수
		final int PHOTOCOLLECTIONVIEWCOUNT = 12;

		final String START_DATE = "1970/01/01";	// 기본 시작일
		final String END_DATE = "2030/12/31";	// 기본 시작일
		String[] searchFields = null;
		String collectionName = "";

		// 결과 시작 넘버
		int startCount 	= WNUtils.parseInt(WNUtils.getCheckReqXSS(searchMap, "startCount", "0"), 0);	//시작 번호
		int listCount 	= WNUtils.parseInt(WNUtils.getCheckReqXSS(searchMap, "listCount", "3"), 3);	//시작 번호
		String query 		= WNUtils.getCheckReqXSS(searchMap, "query", "");							    //검색어
		String collection 	= WNUtils.getCheckReqXSS(searchMap, "collection", "ALL");
		System.out.println("컬렉션이름 "+collection);//컬렉션이름
		String rt 			= WNUtils.getCheckReqXSS(searchMap, "rt", "");							        //결과내 재검색 체크필드
		String rt2 		= WNUtils.getCheckReqXSS(searchMap, "rt2", "");								    //결과내 재검색 체크필드
		String reQuery 	= WNUtils.getCheckReqXSS(searchMap, "reQuery", "");							    //결과내 재검색 체크필드
		String realQuery 	= WNUtils.getCheckReqXSS(searchMap, "realQuery", "");						    //결과내 검색어
		String sort 		= WNUtils.getCheckReqXSS(searchMap, "sort", "DATE");							//정렬필드
		String startDate 	= WNUtils.getCheckReqXSS(searchMap, "startDate", START_DATE);								//시작날짜
		String endDate 		= WNUtils.getCheckReqXSS(searchMap, "endDate", END_DATE);									//끝날짜
		String searchField = WNUtils.getCheckReqXSS(searchMap, "searchField", "ALL");						//검색필드
		String filter 		= WNUtils.getCheckReqXSS(searchMap, "filter", "");								//조직 결과그룹
		String alias 		= WNUtils.getCheckReqXSS(searchMap, "alias", "");								//alias
		String searchWordIFound = WNUtils.getCheckReqXSS(searchMap, "searchWordIFound", "T");				//인기검색어플래그
		String range = WNUtils.getCheckReqXSS(searchMap, "range", "A");									//기간관련필드

		String strOperation	= "" ;																									//operation 조건 필드
		String exquery 		= "" ;																									//exquery 조건 필드
		String pageLink = "";
		String[] collections_basic_info = wncol.COLLECTIONS_BASIC_INFO;
		System.out.println("collections_basic_info:"+collections_basic_info[0]+"/"+collections_basic_info[1]);
		int totalCount 		= 0;
		//컬렉션설정
		String[] collections = null;
		if(collection.equals("ALL")) { //통합검색인 경우
			collections = wncol.COLLECTIONS;
			listCount = 3;
		}else{
			System.out.println("잘진입?"+collection);
			collections = new String[] { collection };
			listCount = 10;
		}
	
		//결과내 재검색
		if (reQuery.equals("1")) {
			realQuery = query + " " + realQuery;
		} else if (!reQuery.equals("2")) {
			realQuery = query;
		}
		//페이징설정
		int viewResultCount = COLLECTION_VIEW_COUNT;
		if (collection.equals("ALL")) viewResultCount = TOTAL_VIEW_COUNT;
		if (collection.equals("photo")) viewResultCount = PHOTOCOLLECTIONVIEWCOUNT;

		LinkedHashMap<String, Object> colList = new LinkedHashMap<String, Object>();
		
		if(!collection.equals("photo")) {

			//#검색API 호출
			WNSearch wnsearch = new WNSearch(isDebug, false, collections, searchFields);

			for (int i = 0; i < collections.length; i++) {
				//출력건수
				wnsearch.setCollectionInfoValue(collections[i], WNCollection.PAGE_INFO, startCount + "," + listCount);

				//search.js에서 상황별정렬
				if (!"".equals(sort)) {
					if (!"member_info".equals(collections[i]) && !"menu_new".equals(collections[i])) {
						if ("DATE".equals(sort)) {
							wnsearch.setCollectionInfoValue(collections[i], WNCollection.SORT_FIELD, "DATE/DESC,RANK/DESC");
						} else {
							wnsearch.setCollectionInfoValue(collections[i], WNCollection.SORT_FIELD, "RANK/DESC,DATE/DESC");
						}
					}
				}

				//searchField 값이 있으면 설정, 없으면 기본검색필드
				if (searchField.indexOf("ALL") == -1) {
					//js 수정  - 제목별 검색 및 내용 검색
					if("TITLE".equals(searchField)){
		        		if("doc".equals(collections[i])){
		            		searchField = "DOC_NM";
		            	} else {
		        			searchField = "HDWD_NM";
		            	}
		        	} else if ("CONTENT".equals(searchField)){
		        		if("dctn".equals(collections[i])){
		            		searchField = "TMNL_DEF";
		            	} else {
		            	
		            		searchField = "HDWD_SRCHWD";
		            	}
		        	} 
		        	wnsearch.setCollectionInfoValue(collections[i], WNCollection.SEARCH_FIELD, searchField);
					
					//searchField 기준 TITLE, CONTENT로 바꿔주기.
					searchField = ("DOC_NM".equals(searchField) || "HDWD_NM".equals(searchField)) ? "TITLE" : "CONTENT";	
				}


				
				
				
				//operation 설정
				if (!strOperation.equals("")) {
					wnsearch.setCollectionInfoValue(collections[i], WNCollection.FILTER_OPERATION, strOperation);
				}

				//exquery 설정
				exquery = "";
				if ("CONTENT".equals(searchField)) {
					//검색필드가 내용인 경우 첨부파일 필드없는 컬렉션 0건처리
					if ("budget".equals(collections[i]) || "duty".equals(collections[i])) {
						exquery = "<ALIAS:contains:none>";
					}
				} else if ("ATTACH".equals(searchField)) {
					//검색필드가 첨부파일인 경우 첨부파일 필드없는 컬렉션 0건처리
					if ("admin_member".equals(collections[i]) || "member_info".equals(collections[i]) || "menu_new".equals(collections[i]) || "minutes_new".equals(collections[i]) || "movie_new".equals(collections[i])) {
						exquery = "<ALIAS:contains:none>";
					}
				}
				if (!exquery.equals("")) {
					wnsearch.setCollectionInfoValue(collections[i], WNCollection.EXQUERY_FIELD, exquery);
				}

				wnsearch.setCollectionInfoValue(collections[i], WNCollection.DATE_RANGE, startDate + "," + endDate + ",-");
			}

			wnsearch.search(realQuery, isRealTimeKeyword, WNCollection.CONNECTION_CLOSE, useSuggestedQuery);


			//#결과값 저장
			// 디버그 메시지 출력
			if (isDebug) {
				String debugMsg = wnsearch.printDebug() != null ? wnsearch.printDebug().trim() : "";
				System.out.println(debugMsg);
			}

			//결과 객체 생성 시작
			//컬렉션 리스트
			for (int i = 0; i < collections.length; i++) { //dctn,doc,info,law
				//검색 결과건별 리스트
				List<Map<String, String>> colResultList = new ArrayList<Map<String, String>>();
				HashMap<String, Object> colSet = new HashMap<>();
				Map<String, String> colBasicInfo = new HashMap<String, String>();
				int thisResultCount = wnsearch.getResultCount(collections[i]);
				System.out.println("test:"+thisResultCount);
				int thisTotalCount = wnsearch.getResultTotalCount(collections[i]);

				totalCount += thisTotalCount;

				collectionName = wnsearch.getCollectionKorName(collections[i]);
				String[] documentFields = wnsearch.getCollectionInfoValue(collections[i], WNCollection.RESULT_FIELD).replaceAll("/[0-9]+", "").split(",");
				String[] innerFields = new String[]{"UID", "RANK", "DATE", "WEIGHT", "SEARCHERID", "COLLECTIONID"};
				List<String> resultFields = new ArrayList<String>(Arrays.asList(documentFields));
				for (int j = 0; j < innerFields.length; j++) {
					if (!resultFields.contains(innerFields[j])) resultFields.add(innerFields[j]);
				}

				//컬렉션별 일반 정보 셋팅
				for (int j = 0; j < collections_basic_info.length; j++) {
					colBasicInfo.put(collections_basic_info[j], wnsearch.getCollectionBasicInfo(collections[i], collections_basic_info[j]));
				}
				colSet.put("DocumentSet", colBasicInfo);
				//검색결과 순차적으로 입력
				if (thisTotalCount > 0) {
					for (int j = 0; j < thisResultCount; j++) {
						//결과 필드별 리스트
						Map<String, String> colResultMap = new HashMap<String, String>();
						for (int l = 0; l < resultFields.size(); l++) {
							colResultMap.put(resultFields.get(l), wnsearch.getField(collections[i], resultFields.get(l), j, true));
						}
						colResultList.add(colResultMap);
					}
				}
				colSet.put("Document", colResultList);
			
				colList.put(collections[i], colSet);
			}

			pageLink = wnsearch.getPageLinks(startCount, totalCount, listCount, 10);
			colList.put("suggestQuery", wnsearch.suggestedQuery);
			if (wnsearch != null) {
				wnsearch.closeServer();
			}
		}
		//#사진API호출
		List<Map<String, String>> phtoResultList = new ArrayList<Map<String, String>>();
		String photoTotalCnt = "0";

		//첨부파일 검색아닌경우
		//컬렉션이 전체검색, 사진인 경우 검색
		//if(!searchField.equals("ATTACH") && ("ALL".equals(collection) || "photo".equals(collection)) ){
//		String photoMsg = "";
//		HashMap<String, Object> rs = null;
//		String Ud_content_id 	= "5";
//		String Start_date 		= startDate.replace("/", "");
//		String End_date 		= endDate.replace("/", "");
//		final String ARCHIVE_ADDRESS = EgovProperties.getProperty("archive.address");
//		String category_title = "\"*/*/*/*\",\"*/의회견학\",\"*/회기/*/*\",\"*/특별위원회\",\"*/상설위원회\",\"*/기자회견\",\"*/도의원행사/*\"";
//		String photoSearchField ="keyword";
//
//		//검색필드
//		if(searchField.equals("TITLE")){
//			photoSearchField = "title";
//		}else if(searchField.equals("CONTENT")){
//			photoSearchField = "comment";
//		}else{
//			photoSearchField ="keyword";
//		}
//
//		//검색어
//		String archQuery = "";
//		if(realQuery.contains("|")){
//			archQuery = realQuery.replace("|", " ");
//		}else{
//			archQuery = realQuery;
//		}
//
//		try {
//			archQuery = URLEncoder.encode(archQuery, "UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		}
//		//사진 viewCount 설정
//		int viewResultCount2 = viewResultCount;
//		if("ALL".equals(collection))
//			viewResultCount2 = 4;
//
//		String testUrl = "http://"+ARCHIVE_ADDRESS+"/interface/search/?ud_content_id="+Ud_content_id+"&start="+(startCount+1)+"&end="+(startCount+viewResultCount2)+"&start_date="+Start_date+"&end_date="+End_date+"&"+photoSearchField+"="+archQuery+"&category_title=["+category_title+"]";
//		URL url = null;
//		try {
//			url = new URL(testUrl);
//		} catch (MalformedURLException e) {
//			e.printStackTrace();
//		}
//		if(url != null){
//			HttpURLConnection con = null;
//			try {
//				con = (HttpURLConnection)url.openConnection();
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//
//			if(con != null){
//				con.setDoInput(true);
//				con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
//				InputStream in = null;
//				ByteArrayOutputStream bos = new ByteArrayOutputStream();
//				byte[] buf = new byte[4096];
//				String output = ""; //{ \"success\": true,\"total\" : 30, \"data\" : [{\"bs_content_id\":518,\"ud_content_id\":5,\"category_full_path\":\"/0/5/70/1002/\",\"category_title\":\"/9대(후반기)/의장단행사\",\"content_id\":\"300410\",\"created_date\":\"20120224122144\",\"proxy_path\":\"http://IP/data/2012/02/24/300410/Proxy/Proxy_300414.jpg\",\"thumb_path\":\" http://IP/data/2012/02/24/300410/Proxy/Thumb_Proxy_300414.jpg\",\"title\":\"대표단 예방\",\"usr_comment\":\"대표단 예방\",\"usr_focus\":\"Y\",\"usr_isopen\":\"Y\",\"usr_lawmaker\":\"\",\"usr_location\":\"\",\"usr_photographer\":\"\",\"usr_shotdate\":\"20120222000000\",\"usr_source\":\"경기도의회\",\"usr_content\":\"\"},{\"bs_content_id\":518,\"ud_content_id\":5,\"category_full_path\":\"/0/5/70/1002/\",\"category_title\":\"/9대(후반기)/의장단행사\",\"content_id\":\"300410\",\"created_date\":\"20120224122144\",\"proxy_path\":\"http://IP/data/2012/02/24/300410/Proxy/Proxy_300414.jpg\",\"thumb_path\":\" http://IP/data/2012/02/24/300410/Proxy/Thumb_Proxy_300414.jpg\",\"title\":\"대표단 예방\",\"usr_comment\":\"대표단 예방\",\"usr_focus\":\"Y\",\"usr_isopen\":\"Y\",\"usr_lawmaker\":\"\",\"usr_location\":\"\",\"usr_photographer\":\"\",\"usr_shotdate\":\"20120222000000\",\"usr_source\":\"경기도의회\",\"usr_content\":\"\"},{\"bs_content_id\":518,\"ud_content_id\":5,\"category_full_path\":\"/0/5/70/1002/\",\"category_title\":\"/9대(후반기)/의장단행사\",\"content_id\":\"300410\",\"created_date\":\"20120224122144\",\"proxy_path\":\"http://IP/data/2012/02/24/300410/Proxy/Proxy_300414.jpg\",\"thumb_path\":\" http://IP/data/2012/02/24/300410/Proxy/Thumb_Proxy_300414.jpg\",\"title\":\"대표단 예방\",\"usr_comment\":\"대표단 예방\",\"usr_focus\":\"Y\",\"usr_isopen\":\"Y\",\"usr_lawmaker\":\"\",\"usr_location\":\"\",\"usr_photographer\":\"\",\"usr_shotdate\":\"20120222000000\",\"usr_source\":\"경기도의회\",\"usr_content\":\"\"},{\"bs_content_id\":518,\"ud_content_id\":5,\"category_full_path\":\"/0/5/70/1002/\",\"category_title\":\"/9대(후반기)/의장단행사\",\"content_id\":\"300410\",\"created_date\":\"20120224122144\",\"proxy_path\":\"http://IP/data/2012/02/24/300410/Proxy/Proxy_300414.jpg\",\"thumb_path\":\" http://IP/data/2012/02/24/300410/Proxy/Thumb_Proxy_300414.jpg\",\"title\":\"대표단 예방\",\"usr_comment\":\"대표단 예방\",\"usr_focus\":\"Y\",\"usr_isopen\":\"Y\",\"usr_lawmaker\":\"\",\"usr_location\":\"\",\"usr_photographer\":\"\",\"usr_shotdate\":\"20120222000000\",\"usr_source\":\"경기도의회\",\"usr_content\":\"\"},{\"bs_content_id\":518,\"ud_content_id\":5,\"category_full_path\":\"/0/5/70/1002/\",\"category_title\":\"/9대(후반기)/의장단행사\",\"content_id\":\"300410\",\"created_date\":\"20120224122144\",\"proxy_path\":\"http://IP/data/2012/02/24/300410/Proxy/Proxy_300414.jpg\",\"thumb_path\":\" http://IP/data/2012/02/24/300410/Proxy/Thumb_Proxy_300414.jpg\",\"title\":\"대표단 예방\",\"usr_comment\":\"대표단 예방\",\"usr_focus\":\"Y\",\"usr_isopen\":\"Y\",\"usr_lawmaker\":\"\",\"usr_location\":\"\",\"usr_photographer\":\"\",\"usr_shotdate\":\"20120222000000\",\"usr_source\":\"경기도의회\",\"usr_content\":\"\"}]}";
//
//				try{
//					in = con.getInputStream();
//					while(true)
//					{
//						int readlen = in.read(buf);
//						if( readlen < 1 )
//							break;
//						bos.write(buf, 0, readlen);
//					}
//					output = new String(bos.toByteArray(), "UTF-8");
//				}catch(Exception e){
//					output = null;
//				}finally{
//					if(bos != null) try{bos.close();}catch(IOException aa){}
//					if(in != null) try{bos.close();}catch(IOException aa){}
//				}
//
//				if(output != null){
//					try {
//						rs = new ObjectMapper().readValue(output, HashMap.class) ;//jsonPrettyPrintString.toString(), HashMap.class) ;
//					} catch (IOException e) {
//						e.printStackTrace();
//					}
//					if(rs != null){
//						boolean issuccess	= (Boolean) rs.get("success");
//						if(issuccess){
//							phtoResultList	=  (List<Map<String, String>>) rs.get("data");
//							photoTotalCnt = rs.get("total").toString();
//							photoMsg = "s";
//						}else{
//							photoMsg = "f";
//						}
//					}else{
//						photoMsg = "f";
//					}
//				}else{
//					photoMsg = "f";
//				}
//			}
//		}
//		//사진페이징
//		/*if("".equals(pageLink)){
//			pageLink = this.getPageLinks(startCount, Integer.parseInt(photoTotalCnt), viewResultCount, 10);
//		}*/
//		colList.put("photoMsg", photoMsg);
//	}
//	colList.put("photo", phtoResultList);
//	colList.put("photoTotalCnt", photoTotalCnt);
		
		/*
		 * //추천검색어 ArrayList<Map<String, String>> recWordList = new
		 * ArrayList<Map<String,String>>(); if(!"".equals(query.trim()) ){ String recUrl
		 * = "http://"+wncol.MANAGER_IP+":"+wncol.MANAGER_PORT+
		 * "/manager/WNRun.do?target=recommend&query="+query+
		 * "&label=_ALL_&datatype=json"; String recJson = this.getHtml(recUrl, 500);
		 * if(!"err".equals(recJson)){ HashMap<String, Object> recResult = null; try {
		 * recResult = new ObjectMapper().readValue(recJson, HashMap.class); } catch
		 * (IOException ioException) { throw new AsaproException("ioException !"); }
		 * HashMap<String, Object> recData = (HashMap<String, Object>)
		 * recResult.get("Data"); String returnCnt = recData.get("Return").toString();
		 * 
		 * if(Integer.parseInt(returnCnt)>0){ ArrayList<String> tmp =
		 * (ArrayList<String>) recData.get("Word"); for(int i=0; i<tmp.size(); i++){
		 * HashMap<String, String> recListMap = new HashMap<String, String>();
		 * recListMap.put("word", tmp.get(i)); recWordList.add(recListMap); } } } }
		 */
				 
		
		
		//인기검색어
				String popUrl = "http://"+wncol.MANAGER_IP+":"+wncol.MANAGER_PORT+"/manager/WNRun.do?target=popword&collection=_ALL_&range=day&datatype=json";
				String popJson = null;
				try {
					popJson = this.getHtml(popUrl, 500);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				ArrayList<Map<String, String>> popWordList = new ArrayList<Map<String,String>>();
				if(!"err".equals(popJson)){
					HashMap<String, Object> popResult;
					try {
						popResult = new ObjectMapper().readValue(popJson, HashMap.class);
						HashMap<String, Object> popData = (HashMap<String, Object>) popResult.get("Data");
						
						if (popData.get("Query") instanceof ArrayList<?>) {
							popWordList = (ArrayList<Map<String, String>>) popData.get("Query"); 
						}else{
							Map<String, String> popMap = (HashMap<String, String>) popData.get("Query");
							popWordList.add(popMap);
						}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
		 
		//주간
		String popUrlW = "http://"+wncol.MANAGER_IP+":"+wncol.MANAGER_PORT+"/manager/WNRun.do?target=popword&collection=_ALL_&range=week&datatype=json";
		String popJsonW = null;
		try {
			popJsonW = this.getHtml(popUrlW, 500);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		ArrayList<Map<String, String>> popWordListW = new ArrayList<Map<String,String>>();
		if(!"err".equals(popJson)){
			HashMap<String, Object> popResult;
			try {
				popResult = new ObjectMapper().readValue(popJsonW, HashMap.class);
				HashMap<String, Object> popData = (HashMap<String, Object>) popResult.get("Data");
				if (popData.get("Query") instanceof ArrayList<?>) {
					popWordListW = (ArrayList<Map<String, String>>) popData.get("Query"); 
				}else{
					Map<String, String> popMap = (HashMap<String, String>) popData.get("Query");
					popWordListW.add(popMap);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}

		colList.put("popwordDay", popWordList);
		colList.put("popwordWeek", popWordListW);
		colList.put("collections", collections);
		//colList.put("recword", recWordList); //추천검색어
		colList.put("pageLink", pageLink);
		colList.put("totalCount", totalCount);
		colList.put("searchWordIFound", searchWordIFound);
	/*	colList.put("popFlag", popFlag);
		colList.put("mykeyword_slide", mykeyword_slide);
		colList.put("popword_slide", popword_slide);
		colList.put("searchword_slide", searchword_slide);*/
		//colList 출력
		System.out.println("-------colList출력----------");
		
		
		/*
		 * System.out.println("LinkedHashMap 순서"); for (Entry<String, Object> key :
		 * colList.entrySet()) { System.out.println("키값"+key + "////"); if
		 * (key.equals("collections=[Ljava.lang.String;@7e2bcfaf")) {
		 * System.out.println(Arrays.toString((Object[]) key.getValue())); }else {
		 * System.out.println(key.getValue()); }
		 * 
		 * }
		 */
		
		
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("startCount", Integer.toString(startCount));
		 
		conditionMap.put("TOTAL_VIEW_COUNT", Integer.toString(TOTAL_VIEW_COUNT));
		conditionMap.put("query", query);
		conditionMap.put("collection", collection);
	    System.out.println("여기"+collection);
		conditionMap.put("rt", rt);
		conditionMap.put("reQuery", reQuery);
		conditionMap.put("realQuery", realQuery);
		/*conditionMap.put("mode", mode);*/
		conditionMap.put("sort", sort);
		conditionMap.put("startDate", startDate);
		conditionMap.put("endDate", endDate);
		/*conditionMap.put("writer", writer);
		conditionMap.put("attach", attach);*/
		conditionMap.put("searchField", searchField);
		conditionMap.put("strOperation", strOperation);
		conditionMap.put("exquery", exquery);
		conditionMap.put("filter", filter);
		conditionMap.put("alias", alias);
		conditionMap.put("range", range);
		colList.put("condition", conditionMap);
		//지수 
		colList.put("COLLECTIONS_NAME", wncol.COLLECTIONS_NAME);
		
		colList.put("COLLECTION_VIEW_COUNT", COLLECTION_VIEW_COUNT);
		colList.put("TOTAL_VIEW_COUNT", TOTAL_VIEW_COUNT);
	
		//더보기 체크 
		if(searchMap.get("moresee") != null) {
			if(searchMap.get("moresee").equals("true")) {
				moresee=true;
			}
		}
		
		colList.put("moresee", moresee);
	    return colList;
	}

	//출력프린트 
	public static void printResult(Map<String,Object>map) {
		Set<String> set = map.keySet();
		Iterator<String> iter= set.iterator();
		
		while(iter.hasNext()) {
			String key = ((String)iter.next());
			String value=(String) map.get(key);
			
			System.out.println("key :"+key+"  / value :" + value);
			
		}
		
	}
	
	
	/*
	 * private String getHtml(String receiverURL, int timeout) { StringBuffer
	 * receiveMsg = new StringBuffer(); HttpURLConnection uc = null; BufferedReader
	 * in = null; try { int errorCode = 0; // -- receive servlet connect URL
	 * servletUrl = new URL(receiverURL); uc = (HttpURLConnection)
	 * servletUrl.openConnection(); uc.setReadTimeout(timeout);
	 * uc.setRequestMethod("POST"); uc.setDoOutput(true); uc.setDoInput(true);
	 * uc.setUseCaches(false); uc.connect(); // init errorCode = 0; // -- Network
	 * error check if (uc.getResponseCode() == HttpURLConnection.HTTP_OK) { String
	 * currLine = ""; // UTF-8인 경우 in = new BufferedReader(new InputStreamReader(
	 * uc.getInputStream()));
	 * 
	 * // BufferedReader in = new BufferedReader(new //
	 * InputStreamReader(uc.getInputStream())); while ((currLine = in.readLine()) !=
	 * null) { receiveMsg.append(currLine).append("\r\n"); } in.close(); } else {
	 * errorCode = uc.getResponseCode(); receiveMsg.append("err"); }
	 * uc.disconnect(); } catch (IOException e) { receiveMsg.append("err"); }
	 * finally { if (in != null) { try { in.close(); } catch (IOException
	 * ioException) { throw new AsaproException("IOException");
	 * //ioException.printStackTrace(); } } if(uc != null) uc.disconnect(); } return
	 * receiveMsg.toString(); }
	 */
	
	public String getHtml(String receiverURL, int timeout) throws Exception{
	    StringBuffer receiveMsg = new StringBuffer();
	    HttpURLConnection uc = null;
	    BufferedReader in = null;
	    try{
	        int errorCode   = 0;
	        // -- receive servlet connect
	        URL servletUrl = new URL(receiverURL);
	        uc = (HttpURLConnection)servletUrl.openConnection();
			uc.setReadTimeout(timeout);
	        uc.setRequestMethod("POST");
	        uc.setDoOutput(true);
	        uc.setDoInput(true);
	        uc.setUseCaches(false);
	        uc.connect();
	        // init
	        errorCode = 0;
	        // -- Network error check
	        if(uc.getResponseCode() == HttpURLConnection.HTTP_OK){
				String currLine = new String();
				//UTF-8인 경우
				in = new BufferedReader(new InputStreamReader(uc.getInputStream(), "UTF-8"));
				//BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
				while ((currLine = in.readLine()) != null){
					receiveMsg.append(currLine).append("\r\n");
				}
				in.close();
	        }else{
	            errorCode = uc.getResponseCode();
				return receiveMsg.toString();
	        }
	        uc.disconnect();
	    }catch(Exception ex){
	       // System.out.println( ex );
	    } finally {
	 	   if(in != null) in.close();
	       if(uc != null) uc.disconnect();
	    }
	    return receiveMsg.toString(); 
	}
	
	public String getHtmls(String receiverURL, int timeout) throws Exception{
	    StringBuffer receiveMsg = new StringBuffer();
	    HttpURLConnection uc = null;
	    BufferedReader in = null;
	    try{
	        int errorCode   = 0;
	        // -- receive servlet connect
	        URL servletUrl = new URL(receiverURL);
	        uc = (HttpURLConnection)servletUrl.openConnection();
			uc.setReadTimeout(timeout);
	        uc.setRequestMethod("POST");
	        uc.setDoOutput(true);
	        uc.setDoInput(true);
	        uc.setUseCaches(false);
	        uc.connect();
	        // init
	        errorCode = 0;
	        // -- Network error check
	        if(uc.getResponseCode() == HttpURLConnection.HTTP_OK){
				String currLine = new String();
				//UTF-8인 경우
				in = new BufferedReader(new InputStreamReader(uc.getInputStream(), "UTF-8"));
				//BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
				while ((currLine = in.readLine()) != null){
					receiveMsg.append(currLine).append("\r\n");
				}
				in.close();
	        }else{
	            errorCode = uc.getResponseCode();
				return receiveMsg.toString();
	        }
	        uc.disconnect();
	    }catch(Exception ex){
	       // System.out.println( ex );
	    } finally {
	 	   if(in != null) in.close();
	       if(uc != null) uc.disconnect();
	    }
	    return receiveMsg.toString(); 
	}
}
