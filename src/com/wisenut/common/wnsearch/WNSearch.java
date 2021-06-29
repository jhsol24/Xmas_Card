package com.wisenut.common.wnsearch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.wisenut.common.vo.QueryVo;

import QueryAPI530.Search;

@Component
public class WNSearch extends WNSearchBase {
	
	private String CATEGORY_FIELD = "TERMS";
	private String seperator = ",";
	
	/**
	 * @return Collections 영어, 한글
	 */
	public List<Map<String, String>> getCollectionList() {
		List<Map<String, String>> collectionList = new ArrayList<Map<String, String>>();
		Map<String, String> collection = null;

		for (int idx = 0; idx < WNDefine.COLLECTIONS.split(seperator).length; idx++) {
			collection = new HashMap<String, String>();
			collection.put("en", WNDefine.COLLECTIONS.split(seperator)[idx]);
			collection.put("ko", WNDefine.COLLECTIONS_KO.split(seperator)[idx]);
			collectionList.add(collection);
		}

		return collectionList;
	}
	
	/**
	 * 검색엔진 통합검색
	 * @param searchQuery
	 * @return Map<String, Object> ALL일 경우 컬렉션 그외 list
	 * @throws Exception
	 */
	public Map<String, Object> getTotalSearchList(QueryVo searchQuery) throws Exception {
		Map<String, Object> map = new HashMap<>();;
		
		String collection = searchQuery.getCollection();
		
		if(collection.split(",").length > 1) {
			List<Map<String, String>> collectionList = getCollectionList();
			
			for(Map<String, String> colName : collectionList){
				searchQuery.setCollection(colName.get("en"));
				map.put(colName.get("en"), getSearchResult(searchQuery));
			}

		}else {
			map = getSearchResult(searchQuery);
		}
		
		return map; 
	}
	
	
	/**
	 * @param searchQuery
	 * @return
	 * @throws Exception
	 */
	public int getSearchTotalCount(QueryVo searchQuery) throws Exception {
		Search searcher = initSearch(searchQuery, WNSearchMode.COMMON);
		int totalCount = 0;
		String collection = searchQuery.getCollection();
		
		try{
			totalCount = searcher.w3GetResultTotalCount(collection);
		}catch(Exception e) {
			e.printStackTrace();
			totalCount = -1;
		}finally {
			searcher.w3CloseServer();
		}
		
		return totalCount;
	}
	
	/**
	 * 카테고리 그룹핑 결과 개수
	 * @param searchQuery
	 * @return
	 * @throws Exception
	 */
	public int getSearchResultCount(QueryVo searchQuery) throws Exception {
		Search searcher = initSearch(searchQuery, WNSearchMode.COMMON);
		int resultCount = 0;
		String collection = searchQuery.getCollection();
		
		try{
			resultCount = searcher.w3GetResultCount(collection);
			
		}catch(Exception e){
			e.printStackTrace();
			resultCount = -1;
		}finally{
			searcher.w3CloseServer();
		}
		return resultCount;
	}
	
	
	/**
	 * 카테고리 그룹핑 총 개수
	 * @param searchQuery
	 * @return
	 * @throws Exception
	 */
	public int getCategoryGroupTotalCount(QueryVo searchQuery) throws Exception {
		Search searcher = initSearch(searchQuery, WNSearchMode.CATEGORY);
		String collection = searchQuery.getCollection();
		int totalGroup = 0;
				
		try{
			totalGroup = searcher.w3GetResultTotalGroupCount(collection);
		}catch (Exception e){
			e.printStackTrace();
			totalGroup = -1;
		}finally{
			searcher.w3CloseServer();
		}
		return totalGroup;
	}
	
	
	/**
	 * @param searchQuery
	 * @return
	 * @throws Exception
	 */
	public int getCategoryGroupResultCount(QueryVo searchQuery) throws Exception {
		Search searcher = initSearch(searchQuery, WNSearchMode.CATEGORY);
		String collection = searchQuery.getCollection();
		int resultGroup = 0;
		
		try{
			resultGroup = searcher.w3GetResultGroupCount(collection);
		}catch (Exception e){
			e.printStackTrace();
			resultGroup = -1;
		}finally{
			searcher.w3CloseServer();
		}
		
		return resultGroup;
	}
	
	
	/**
	 * 통합검색 카테고리 그룹핑 구분
	 * @param searchQuery
	 * @return
	 * @throws Exception
	 */
	public Map<String, Integer> getCategoryGroupGubun(QueryVo searchQuery) throws Exception {
		Map<String, Integer> categoryGubun = new HashMap<>();

		Search searcher = initSearch(searchQuery, WNSearchMode.CATEGORY);
		
		try{
			String collection = searchQuery.getCollection();
			int resultGroup = searcher.w3GetResultGroupCount(collection); 
			
			for(int i = 0; i < resultGroup; i++ ) {  
				int totalCount = searcher.w3GetTotalCountInGroup( collection, i );  
				int resultCount = searcher.w3GetCountInGroup( collection, i );
	
				for(int j = 0; j < resultCount; j ++ )  {
					categoryGubun.put(searcher.w3GetFieldInGroup( collection, searchQuery.getGroupField(), i, j ), totalCount);
				} 
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			categoryGubun.put("error", -1);
		}finally {
			searcher.w3CloseServer();
		}
		return categoryGubun;
	}
	
	
	/**
	 * @param searchQuery
	 * @return
	 * @throws Exception
	 */
	public List<HashMap<String, Object>> getTermsGroup(QueryVo searchQuery) throws Exception {
		Search search = initSearch(searchQuery, WNSearchMode.GROUP);
		
		//logger.debug("### query : " + searchQuery.getQuery());
		
		int depth = 1; 
		//int groupCount = search.w3GetCategoryCount( searchQuery.getCollection(), "TERMS", depth);
		int groupCount = searchQuery.getListCount();
		List<HashMap<String, Object>> termsList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = null;
		
		try {
			for(int i = 0; i < groupCount; i++ ) {  
				map = new HashMap<String, Object>();
				String name  = search.w3GetCategoryName( searchQuery.getCollection(), CATEGORY_FIELD, depth, i ); 
				int count = search.w3GetDocumentCountInCategory( searchQuery.getCollection(), CATEGORY_FIELD, depth, i ); 
				map.put("name", name);
				map.put("count", count);
				termsList.add(map);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			search.w3CloseServer();
		}
		
		return termsList;
	}
	
	/**
	 * 검색엔진 개별 문서 검색
	 * 
	 * @param searchQuery
	 * @param uid (,)
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getJsonDetail(QueryVo searchQuery, String uid) throws Exception {
		Search searcher = new Search();
		String collection = searchQuery.getCollection();
		String docField = getDocumentField(collection);
		String fields[] = docField.split(seperator);
		
		int ret = setSearchDetail(searcher, searchQuery);
		
		if(uid.split(seperator).length > 1) {
			for(String id : uid.split(seperator)){
				ret = searcher.w3AddUid(collection, Integer.parseInt(id), "sc");
			}
		}else {
			ret = searcher.w3AddUid(collection, Integer.parseInt(uid), "sc");			
		}
		searcher = getConnection(searcher);
		ret = searcher.w3ReceiveUidResult(3);
		
		settingErrorCheck(searcher);
		
		if (ret == 0) {
			List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
			int resultCount = searcher.w3GetResultCount(collection);
			dataList = getJsonDataList(searcher, collection, fields, resultCount);
			searcher.w3CloseServer();
			return dataList;
		}
		return null;
	}
	
	public String getScdDetail(QueryVo searchQuery, String uid) throws Exception {
		Search searcher = new Search();
		String collection = searchQuery.getCollection();
		String docField = getDocumentField(collection);
		String fields[] = docField.split(seperator);
		
		int ret = setSearchDetail(searcher, searchQuery);
		
		if(uid.split(seperator).length > 1) {
			for(String id : uid.split(seperator)){
				ret = searcher.w3AddUid(collection, Integer.parseInt(id), "sc");
			}
		}else {
			ret = searcher.w3AddUid(collection, Integer.parseInt(uid), "sc");			
		}
		
		searcher = getConnection(searcher);
		ret = searcher.w3ReceiveUidResult(3);
		settingErrorCheck(searcher);
		
		if (ret == 0) {
			int resultCount = searcher.w3GetResultCount(collection);
			String scd = getScdDataList(searcher, collection, fields, resultCount);
			searcher.w3CloseServer();
			return scd;
		}
		
		return null;
	}
	
	/**
	 * @param collection
	 * @param fields
	 * @return
	 */
	public List<Map<String, Object>> getJsonDataList(Search searcher, String collection, String[] fields, int resultCount) throws Exception{
		List<Map<String, Object>> searchDataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> data = null;

		for (int rIdx = 0; rIdx < resultCount; rIdx++) {
			data = new HashMap<String, Object>();
			// 개별 검색을 위한 UID 넣기
			data.put("UID", searcher.w3GetUid(collection, rIdx));
			for (int fIdx = 0; fIdx < fields.length; fIdx++) {
				String field = WNUtil.replaceSnippetField(fields[fIdx]);
				String content = WNUtil.replaceHighlight(WNUtil.replaceTagLikeChr(searcher.w3GetField(collection, field, rIdx)));
				data.put(field, content);
			}
			searchDataList.add(data); 
		}
		return searchDataList;
	}
	
	
	public String getScdDataList(Search searcher, String collection, String[] fields, int resultCount) throws Exception{
		StringBuffer sb = new StringBuffer();

		for (int rIdx = 0; rIdx < resultCount; rIdx++) {
			//sb.append("<UID>" + searcher.w3GetUid(collection, rIdx) + "\n");
			
			for (int fIdx = 0; fIdx < fields.length; fIdx++) {
				String field = WNUtil.replaceSnippetField(fields[fIdx]);
				String content = WNUtil.replaceHighlight(WNUtil.replaceTagLikeChr(searcher.w3GetField(collection, field, rIdx)));
				sb.append("<" + field + ">" + content + "\n");
			}
		}
		return sb.toString();
	}
	
	private int setSearchDetail(Search searcher, QueryVo searchQuery) throws Exception {
		int ret;
		String collection = searchQuery.getCollection();
		String docField = getDocumentField(collection);

		ret = searcher.w3SetCodePage(WNDefine.CHARACTOR_SET_UTF8);
		ret = searcher.w3SetQueryLog(WNDefine.QUERY_LOG_ON);
		
		// 1개의 검색결과를 가져오기 위하여 StartCount = 0, listCount = 1로 지정
		ret = searcher.w3AddCollection(collection);
		ret = searcher.w3SetPageInfo(collection, 0, 1);
		
		docField = docField.replaceAll("/[0-9]?[0-9]?[0-9]", "");
		ret = searcher.w3SetDocumentField(collection, docField);

		return ret;
	}
	
	/**
	 * 검색엔진 검색 개별 컬렉션 결과 출력
	 * @param searchQuery
	 * @return 검색 결과 리스트
	 * @throws Exception
	 */
	private Map<String, Object> getSearchResult(QueryVo searchQuery) throws Exception {
		Map<String, Object> map = new HashMap<>();
		Search searcher = initSearch(searchQuery, WNSearchMode.COMMON);

		String collection = searchQuery.getCollection();
		String docField = getDocumentField(collection);
		String[] fields = docField.split(seperator);

		try {
			int totalCount = searcher.w3GetResultTotalCount(collection);
			int resultCount = searcher.w3GetResultCount(collection);
			List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();

			dataList = getJsonDataList(searcher, collection, fields, resultCount);
			
			map.put("totalCount", totalCount);
			map.put("resultCount", resultCount);
			map.put("startDate", searchQuery.getStartDate());
			map.put("endDate", searchQuery.getEndDate());
			map.put("list", dataList);
			
		}catch(Exception e) {
			e.printStackTrace();
			map.put("totalCount", -1);
			map.put("resultCount", -1);
			map.put("list", null);
		}finally {
			searcher.w3CloseServer();
		}
		return map;
	}
	
}
