package com.wisenut.common.wnsearch;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.ReflectionUtils;

import com.wisenut.common.vo.QueryVo;

import QueryAPI530.Search;

public class WNSearchBase {
	 	private Logger logger = Logger.getLogger(WNSearchBase.class);

		@Value("#{common['search.ip']}")
		private String SEARCH_IP;

		@Value("#{common['search.port']}")
		private String SEARCH_PORT;

	    public Search initSearch(QueryVo queryVo, WNSearchMode mode) throws Exception {
	    	queryVo.update();
	        Search search = new Search();
	        
	        switch (mode) {
	            case COMMON:
	                search = setCommonSearch(search, queryVo);
	                break;
	            case CATEGORY:
	                search = setCategorySearch(search, queryVo);
	                break;
	            case GROUP:
	                search = setGroupSearch(search, queryVo);
	                break;
	            case MERGED:
	                search = setMergedSearch(search, queryVo);
	                break;
	        }
	        return search;
	    }

	    private Search setMergedSearch(Search search, QueryVo queryVo) throws Exception {

	        search = commonSetting(search, queryVo);

	        String[] collections = splitCollections();

	        for (String coll : collections) {
	            queryVo.setCollection(coll);
	            search = collectionSetting(search, queryVo);
	        }

	        for (String coll : collections) {
	            search.w3AddMergeCollection(WNDefine.MERGED_COLLECTION, coll);
	        }

	        search.w3SetMergePageInfo(WNDefine.MERGED_COLLECTION, queryVo.getStartCount(), queryVo.getListCount());

	        // Merge Setting
	        // To do

	        return search;
	    }

	    private Search setGroupSearch(Search search, QueryVo queryVo) throws Exception {
	        String coll = queryVo.getCollection();

	        search = commonSetting(search, queryVo);
	        search = collectionSetting(search, queryVo);

	        // Grouping Setting
	        String GROUP_FILED = "TERMS";
	        search.w3AddCategoryGroupBy(coll, GROUP_FILED , "1/SC");
	        search.w3SetCategoryQuery(coll, GROUP_FILED);

	        search = getConnection(search);
	        search.w3ReceiveSearchQueryResult(3);

	        settingErrorCheck(search);
	        return search;
	    }

	    private Search setCategorySearch(Search search, QueryVo queryVo) throws Exception {
	        String coll = queryVo.getCollection();

	        search = commonSetting(search, queryVo);
	        search = collectionSetting(search, queryVo);

	        // Category Setting
	        search.w3SetGroupBy(coll, queryVo.getGroupField(), WNDefine.GROUP_BY_DOCUMENT_COUNT);
	        search.w3SetSortFieldInGroup(coll, WNDefine.GROUP_BY_SORT_FIELD);

	        search = getConnection(search);
	        search.w3ReceiveSearchQueryResult(3);

	        settingErrorCheck(search);
	        return search;
	    }

	    private Search setCommonSearch(Search search, QueryVo queryVo) throws Exception {
	        String coll = queryVo.getCollection();

	        search = commonSetting(search, queryVo);
	        search = collectionSetting(search, queryVo);

	        search.w3SetQueryAnalyzer(coll, WNDefine.USE_LA_ON, WNDefine.IGNORE_CASE_ON, WNDefine.USER_ORIGINAL_ON, WNDefine.USER_SYNONYM_ON);
	        search.w3SetPrefixQuery(coll, queryVo.getExquery(), WNDefine.AND_OPERATOR_ON);

	        search = getConnection(search);
	        search.w3ReceiveSearchQueryResult(3);

	        settingErrorCheck(search);
	        return search;
	    }

	    private Search collectionSetting(Search search, QueryVo queryVo) throws Exception {
	        String coll = queryVo.getCollection();
	        search.w3AddCollection(coll);
	        search.w3SetPageInfo(coll, queryVo.getStartCount(), queryVo.getListCount());
	        search.w3SetSortField(coll, queryVo.getRange());
	        search.w3SetSearchField(coll, getSearchField(coll));
	        search.w3SetDocumentField(coll, getDocumentField(coll));
	        search.w3SetDateRange(coll, queryVo.getStartDate(), queryVo.getEndDate());
	        search.w3SetHighlight(coll, getHighlight(queryVo), getSnipet(queryVo));
	        search.w3SetFilterQuery(coll, makeFilterDate(queryVo));

	        settingErrorCheck(search);
	        return search;
	    }

	    public String[] splitCollections() {
	        return WNDefine.COLLECTIONS.split(",");
	    }

	    private Search commonSetting(Search search, QueryVo queryVo) {
	        search.w3SetCodePage(WNDefine.CHARACTOR_SET_UTF8);
	        search.w3SetQueryLog(WNDefine.QUERY_LOG_ON);
	        search.w3SetCommonQuery(queryVo.getQuery(), WNDefine.EXTEND_OR_OFF);

	        settingErrorCheck(search);
	        return search;
	    }

	    public void settingErrorCheck(Search search) {
	        if (search.w3GetError() != 0) {
	            logger.error("w3GetErrorInfo => " + search.w3GetErrorInfo());
	        }
	    }

	    public Search getConnection(Search search) {
	        search.w3ConnectServer(SEARCH_IP, Integer.parseInt(SEARCH_PORT), WNDefine.SERVER_TIMEOUT);
	        return search;
	    }
	    
	    private String makeFilterDate(QueryVo queryVo) {
	        return "<CF_DATE:gte:" + queryVo.getStartDate() + "> <CF_DATE:lte:" + queryVo.getEndDate() + ">";
	    }

	    public int getSnipet(QueryVo queryVo) {
	        return queryVo.getSnipet() ? WNDefine.USE_SNIPPET_ON : WNDefine.USE_SNIPPET_OFF;
	    }

	    public int getHighlight(QueryVo queryVo) {
	        return queryVo.getHighlight() ? WNDefine.USE_HIGHLIGHT_ON : WNDefine.USE_HIGHLIGHT_OFF;
	    }

	    public String getDocumentField(String collection) throws Exception {
	        String collectionName = collection.split("_")[2].toUpperCase();
	        String docFieldName = "DOCUMENT_FIELD_" + collectionName;
	        String docField = ReflectionUtils.findField(WNDefine.class, docFieldName , String.class).get(WNDefine.class).toString();
	        return docField;
	    }

	    public String getSearchField(String collection) throws Exception {
	        String collectionName = collection.split("_")[2].toUpperCase();
	        String searchField = ReflectionUtils.findField(WNDefine.class, "SEARCH_FIELD_" + collectionName, String.class).get(WNDefine.class).toString();
	        return searchField;
	    }
}
