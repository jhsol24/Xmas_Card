package test.com.wisenut.wnsearch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.ReflectionUtils;

import com.wisenut.common.vo.QueryVo;
import com.wisenut.common.wnsearch.WNDefine;
import com.wisenut.common.wnsearch.WNSearch;
import com.wisenut.common.wnsearch.WNUtil;

import QueryAPI530.Search;

public class SearchTest {

	String searchIp 					= "172.23.244.11";
	String searchPort 					= "7000";
	
	int SERVER_TIMEOUT 					= 10 * 1000;
	
	String COLLECTIONS					= "cf_data_osint,cf_data_humint,cf_data_masint,cf_data_sigint";
	String COLLECTIONS_KO 				= "공개정보,인간정보,계측기호,신호정보";
	
	String SEARCH_FIELD_SIGINT			= "CF_TITLE,CF_CONTENT,CF_SMR_CONTENT,ORG_DOC_NO,R_FOREST_ANAL_RS,XGBOOST_ANAL_RS,SVM_ANAL_RS";
	String SEARCH_FIELD_HUMINT			= "CF_TITLE,HUMAN_REPORT_ATTACHFILE_CONTENT_1,HUMAN_REPORT_ATTACHFILE_CONTENT_2,HUMAN_REPORT_ATTACHFILE_CONTENT_3,HUMAN_REPORT_ATTACHFILE_CONTENT_4,HUMAN_REPORT_ATTACHFILE_CONTENT_5,IM_REPORT_LARGE_CLASS_CD_NM,IM_REPORT_MID_CLASS_CD_NM,IM_REPORT_SMALL_CLASS_NM";
	String SEARCH_FIELD_OSINT			= "CF_TITLE,HUMAN_REPORT_ATTACHFILE_CONTENT_1,HUMAN_REPORT_ATTACHFILE_CONTENT_2,HUMAN_REPORT_ATTACHFILE_CONTENT_3,HUMAN_REPORT_ATTACHFILE_CONTENT_4,HUMAN_REPORT_ATTACHFILE_CONTENT_5,IM_REPORT_LARGE_CLASS_CD_NM,IM_REPORT_MID_CLASS_CD_NM,IM_REPORT_SMALL_CLASS_NM";
	String SEARCH_FIELD_MASINT			= "CF_TITLE,HUMAN_REPORT_ATTACHFILE_CONTENT_1,HUMAN_REPORT_ATTACHFILE_CONTENT_2,HUMAN_REPORT_ATTACHFILE_CONTENT_3,HUMAN_REPORT_ATTACHFILE_CONTENT_4,HUMAN_REPORT_ATTACHFILE_CONTENT_5,IM_REPORT_LARGE_CLASS_CD_NM,IM_REPORT_MID_CLASS_CD_NM,IM_REPORT_SMALL_CLASS_NM";
	
	String DOCUMENT_FIELD_SIGINT 		= "DOCID,ORG_DOC_NO,CF_DATE,CF_TITLE,CF_CONTENT/400,CF_SMR_CONTENT,R_FOREST_CF_ANAL_YN,R_FOREST_ANAL_RS,R_FOREST_ANAL_BIGO,XGBOOST_ANAL_RS,XGBOOST_ANAL_BIGO,SVM_ANAL_RS,SVM_ANAL_BIGO,R_FOREST_CF_ANAL_DT,R_FOREST_CF_ANAL_GBN,CF_ID,CF_TIME,CF_CATEGORY,CF_REG_DT,CF_UPD_DT,ALIAS,TITLE_TERMS,CONTENT_TERMS,TERMS";
	String DOCUMENT_FIELD_HUMINT 		= "DOCID,CF_DATE,HUMAN_REPORT_REG_FORCE_CD,HUMAN_REPORT_SEQ,HUMAN_REPORT_INPUT_YMD,CF_TITLE,HUMAN_REPORT_ATTACHFILE_NM_1,HUMAN_REPORT_ATTACHFILE_CONTENT_1/400,HUMAN_REPORT_ATTACHFILE_NM_2,HUMAN_REPORT_ATTACHFILE_CONTENT_2,HUMAN_REPORT_ATTACHFILE_NM_3,HUMAN_REPORT_ATTACHFILE_CONTENT_3,HUMAN_REPORT_ATTACHFILE_NM_4,HUMAN_REPORT_ATTACHFILE_CONTENT_4,HUMAN_REPORT_ATTACHFILE_NM_5,HUMAN_REPORT_ATTACHFILE_CONTENT_5,HUMAN_REPORT_INPUT_YMD_1,IM_ATTACH_FILE_NM1,IM_ATTACH_FILE_NM2,IM_ATTACH_FILE_NM3,UPDR_ID,VALID_TERM,REGR_ID,ROK_US_YN,LIMIT_PROPG_APPL_TERM,REGR_POS_CD,MC_SEQ,REPORT_MGNT_NO,IM_REPORT_LARGE_CLASS_CD,IM_REPORT_MID_CLASS_CD,IM_REPORT_SMALL_CLASS_CD,SLVL_CD,ALL_PROPG_AUTH,SYT_REG_DTIME,REG_DTIME,INTF_DIV,IM_REPORT_LARGE_CLASS_CD_NM,IM_REPORT_MID_CLASS_CD_NM,IM_REPORT_SMALL_CLASS_NM,WISE_CF_DATA_HUMINT_MENU,ALIAS,TERMS,TOPIC";
	String DOCUMENT_FIELD_OSINT  		= "DOCID,CF_DATE,HUMAN_REPORT_REG_FORCE_CD,HUMAN_REPORT_SEQ,HUMAN_REPORT_INPUT_YMD,CF_TITLE,HUMAN_REPORT_ATTACHFILE_NM_1,HUMAN_REPORT_ATTACHFILE_CONTENT_1/400,HUMAN_REPORT_ATTACHFILE_NM_2,HUMAN_REPORT_ATTACHFILE_CONTENT_2,HUMAN_REPORT_ATTACHFILE_NM_3,HUMAN_REPORT_ATTACHFILE_CONTENT_3,HUMAN_REPORT_ATTACHFILE_NM_4,HUMAN_REPORT_ATTACHFILE_CONTENT_4,HUMAN_REPORT_ATTACHFILE_NM_5,HUMAN_REPORT_ATTACHFILE_CONTENT_5,HUMAN_REPORT_INPUT_YMD_1,IM_ATTACH_FILE_NM1,IM_ATTACH_FILE_NM2,IM_ATTACH_FILE_NM3,UPDR_ID,VALID_TERM,REGR_ID,ROK_US_YN,LIMIT_PROPG_APPL_TERM,REGR_POS_CD,MC_SEQ,REPORT_MGNT_NO,IM_REPORT_LARGE_CLASS_CD,IM_REPORT_MID_CLASS_CD,IM_REPORT_SMALL_CLASS_CD,SLVL_CD,ALL_PROPG_AUTH,SYT_REG_DTIME,REG_DTIME,INTF_DIV,IM_REPORT_LARGE_CLASS_CD_NM,IM_REPORT_MID_CLASS_CD_NM,IM_REPORT_SMALL_CLASS_NM,WISE_CF_DATA_HUMINT_MENU,ALIAS,TERMS,TOPIC";
	String DOCUMENT_FIELD_MASINT 		= "DOCID,CF_DATE,HUMAN_REPORT_REG_FORCE_CD,HUMAN_REPORT_SEQ,HUMAN_REPORT_INPUT_YMD,CF_TITLE,HUMAN_REPORT_ATTACHFILE_NM_1,HUMAN_REPORT_ATTACHFILE_CONTENT_1/400,HUMAN_REPORT_ATTACHFILE_NM_2,HUMAN_REPORT_ATTACHFILE_CONTENT_2,HUMAN_REPORT_ATTACHFILE_NM_3,HUMAN_REPORT_ATTACHFILE_CONTENT_3,HUMAN_REPORT_ATTACHFILE_NM_4,HUMAN_REPORT_ATTACHFILE_CONTENT_4,HUMAN_REPORT_ATTACHFILE_NM_5,HUMAN_REPORT_ATTACHFILE_CONTENT_5,HUMAN_REPORT_INPUT_YMD_1,IM_ATTACH_FILE_NM1,IM_ATTACH_FILE_NM2,IM_ATTACH_FILE_NM3,UPDR_ID,VALID_TERM,REGR_ID,ROK_US_YN,LIMIT_PROPG_APPL_TERM,REGR_POS_CD,MC_SEQ,REPORT_MGNT_NO,IM_REPORT_LARGE_CLASS_CD,IM_REPORT_MID_CLASS_CD,IM_REPORT_SMALL_CLASS_CD,SLVL_CD,ALL_PROPG_AUTH,SYT_REG_DTIME,REG_DTIME,INTF_DIV,IM_REPORT_LARGE_CLASS_CD_NM,IM_REPORT_MID_CLASS_CD_NM,IM_REPORT_SMALL_CLASS_NM,WISE_CF_DATA_HUMINT_MENU,ALIAS,TERMS,TOPIC";
	
	String CHARACTOR_SET_UTF8 			= "UTF-8";
	String CHARACTOR_SET_EUCKR 			= "EUC-KR";
	
	int 	QUERY_LOG_ON				= 1;
	int 	QUERY_LOG_OFF				= 0;
	
	int	USE_HIGHLIGHT_ON				= 1;
	int 	USE_HIGHLIGHT_OFF			= 0;
	
	int	USE_SNIPPET_ON					= 1;
	int 	USE_SNIPPET_OFF				= 0;
	
	int 	PAGE_START					= 0;
	int 	RESULT_COUNT				= 10;
	
	int 	EXTEND_OR_ON				= 1;
	int 	EXTEND_OR_OFF				= 0;
	
	int 	AND_OPERATOR_ON				= 1;
	int 	AND_OPERATOR_OFF			= 0;
	
	int 	USE_LA_ON 					= 1;
	int 	USE_LA_OFF 					= 0; 
	
	int 	IGNORE_CASE_ON 				= 1;
	int 	IGNORE_CASE_OFF				= 0; 
	
	int 	USER_ORIGINAL_ON 			= 1; 
	int 	USER_ORIGINAL_OFF 			= 0; 
		
	int 	USER_SYNONYM_ON 			= 1; 
	int 	USER_SYNONYM_OFF 			= 0; 
	
	String STATE_DATE					= "1970/01/01";
	String END_DATE						= WNUtil.getDate();

	private int REQUEST_FAIL = 1;
	private String seperator = ",";
	
	// 통합검색시 보여줄 문서 개수
	private int TOTAL_LIST_COUNT = 3;

	private Search search = null;	
	
	public static void main(String[] args) {
		SearchTest test = new SearchTest();
		QueryVo searchQuery = new QueryVo();
		searchQuery.setCollection("cf_data_sigint");
		searchQuery.setQuery("");
		searchQuery.setStartCount(0);
		searchQuery.setListCount(30);
		System.out.println(searchQuery.toString());
		try {
			test.initCategorySearch(searchQuery);
			System.out.println(test.getCategoryGroupResultCount(searchQuery));
			System.out.println(test.getCategoryGroupTotalCount(searchQuery));
			//test.getCategoryGroupData(searchQuery);
			
			System.out.println(test.getCategoryGroupGubun(searchQuery).toString());
		} catch (Exception e) {
			e.printStackTrace(); 
		}
	}

	/** 
	 * @param searchQuery
	 * @return
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 */ 
	private int initSearch(QueryVo searchQuery) throws Exception {
		int ret;
		
		String searchField = SEARCH_FIELD_SIGINT;
		String docField = DOCUMENT_FIELD_SIGINT;

		ret = setCollecion(searchQuery, searchField, docField, USE_SNIPPET_ON);
		return ret;
	}
	
	/**
	 * @param searchQuery
	 * @return
	 * @throws Exception
	 */
	private int initCategorySearch(QueryVo searchQuery) throws Exception {
		int ret;
		
		String searchField = SEARCH_FIELD_SIGINT;
		String docField = DOCUMENT_FIELD_SIGINT;

		ret = setCategoryCollection(searchQuery, searchField, docField, USE_SNIPPET_ON);
		return ret;
	}
	
	/**
	 * @param query
	 * @return
	 */
	private int commonSetting(String query) {
		int ret;
		
		// Common Setting
		ret = search.w3SetCodePage(CHARACTOR_SET_UTF8);
		ret = search.w3SetQueryLog(QUERY_LOG_ON);
		ret = search.w3SetCommonQuery(query, EXTEND_OR_OFF);
		
		return ret;
	}
	
	/**
	 * @return
	 */
	private int connectionServer() {
		int ret;
		
		ret = search.w3ConnectServer(searchIp, Integer.parseInt(searchPort), SERVER_TIMEOUT);
		ret = search.w3ReceiveSearchQueryResult(3);
		if (search.w3GetError() != 0) {
			System.out.println("w3GetErrorInfo => " + search.w3GetErrorInfo());
			ret = REQUEST_FAIL;
		}
		
		return ret;
	}

	/**
	 * 검색엔진 설정
	 * @param searchQuery
	 * @param sortField
	 * @param searchField
	 * @param documentField
	 * @param highlight
	 * @param snippet
	 * @return
	 * @throws Exception 
	 */
	private int setCollecion(QueryVo searchQuery, String searchField, String documentField, int snippet) {
		int ret;
		
		if(search == null) search = new Search();
		searchQuery = WNUtil.nullCheckQuery(searchQuery);

		String collection = searchQuery.getCollection();
		int highlight = USE_HIGHLIGHT_OFF;
		if(searchQuery.getHighlight()) highlight = USE_HIGHLIGHT_ON;

		// Common Setting
		ret = commonSetting(searchQuery.getQuery());

		// Collection Setting
		ret = search.w3AddCollection(collection);
		ret = search.w3SetPageInfo(collection, searchQuery.getStartCount(), searchQuery.getListCount());
		ret = search.w3SetSortField(collection, searchQuery.getRange());
		ret = search.w3SetSearchField(collection, searchField); 
		ret = search.w3SetDocumentField(collection, documentField);
		ret = search.w3SetHighlight(collection, highlight, snippet);
		ret = search.w3SetDateRange(collection, searchQuery.getStartDate(), searchQuery.getEndDate());
		ret = search.w3SetQueryAnalyzer(collection, USE_LA_ON, IGNORE_CASE_ON, USER_ORIGINAL_ON, USER_SYNONYM_ON );
		ret = search.w3SetPrefixQuery(collection, searchQuery.getExquery(), AND_OPERATOR_ON);

		// Connection Setting
		ret = connectionServer();

		return ret;
	}
	
	/**
	 * 검색엔진 카테고리 그룹핑
	 * @param searchQuery
	 * @param searchField
	 * @param documentField
	 * @param snippet
	 * @return
	 */
	private int setCategoryCollection(QueryVo searchQuery, String searchField, String documentField, int snippet) {
		int ret;
		
		if(search == null) search = new Search();
		searchQuery = WNUtil.nullCheckQuery(searchQuery);
		
		String collection = searchQuery.getCollection();
		int highlight = USE_HIGHLIGHT_OFF;
		if(searchQuery.getHighlight()) highlight = USE_HIGHLIGHT_ON;
		
		String GROUP_BY_FIELD = "XGBOOST_ANAL_RS";  
		int    GROUP_BY_DOCUMENT_COUNT = 1;
		String GROUP_BY_SORT_FIELD = "CF_DATE/DESC";
		
		// Common Setting
		ret = commonSetting(searchQuery.getQuery());

		// Collection Setting
		ret = search.w3AddCollection(collection);
		ret = search.w3SetPageInfo(collection, searchQuery.getStartCount(), searchQuery.getListCount());
		ret = search.w3SetSortField(collection, searchQuery.getRange());
		ret = search.w3SetSearchField(collection, searchField);
		ret = search.w3SetDocumentField(collection, documentField);
		ret = search.w3SetHighlight(collection, highlight, snippet);
		
		// Categroy grouping Setting
		ret = search.w3SetGroupBy(collection, GROUP_BY_FIELD, GROUP_BY_DOCUMENT_COUNT);
		ret = search.w3SetSortFieldInGroup(collection, GROUP_BY_SORT_FIELD);
		
		ret = search.w3SetDateRange(collection, searchQuery.getStartDate(), searchQuery.getEndDate());

		// Connection
		ret = connectionServer();
		
		return ret;
	}

	/**
	 * @return Collections 영어, 한글
	 */
	public List<Map<String, String>> getCollectionList() {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		Map<String, String> map = null;

		for (int idx = 0; idx < COLLECTIONS.split(seperator).length; idx++) {
			map = new HashMap<String, String>();
			map.put("en", COLLECTIONS.split(seperator)[idx]);
			map.put("ko", COLLECTIONS_KO.split(seperator)[idx]);
			list.add(map);
		}

		return list;
	}
	
	/**
	 * 검색엔진 통합검색
	 * @param searchQuery
	 * @return Map<String, Object> ALL일 경우 컬렉션 그외 list
	 * @throws Exception
	 */
	public Map<String, Object> getTotalSearchList(QueryVo searchQuery) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		String collection = searchQuery.getCollection();
		
		if("ALL".equals(collection)) {
			List<Map<String, String>> list = getCollectionList();
			searchQuery.setListCount(TOTAL_LIST_COUNT);
			
			for(Map<String, String> collectionName : list){
				searchQuery.setCollection(collectionName.get("en"));
				map.put(collectionName.get("en"), getSearchResult(searchQuery));
			}
			
		}else {
			map = getSearchResult(searchQuery);
		}
		
		return map; 
	}

	/**
	 * 검색엔진 검색 개별 컬렉션 결과 출력
	 * @param searchQuery
	 * @return 검색 결과 리스트
	 * @throws Exception
	 */
	private Map<String, Object> getSearchResult(QueryVo searchQuery) throws Exception {
		Map<String, Object> map = new HashMap<>();
		int ret = initSearch(searchQuery);

		String collection = searchQuery.getCollection();

		String docField = getDocField(collection);
		String[] fields = docField.split(seperator);

		if (ret == 0) {
			int totalCount = search.w3GetResultTotalCount(collection);
			int resultCount = search.w3GetResultCount(collection);
			List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();

			dataList = getDataList(collection, fields, resultCount);

			map.put("totalCount", totalCount);
			map.put("resultCount", resultCount);
			map.put("startDate", searchQuery.getStartDate());
			map.put("endDate", searchQuery.getEndDate());
			map.put("list", dataList);
		} else {
			map.put("totalCount", -1);
			map.put("resultCount", -1);
			map.put("list", null);
		}

		return map;
	}
	
	/**
	 * @param searchQuery
	 * @return
	 * @throws Exception
	 */
	public int getCategoryGroupTotalCount(QueryVo searchQuery) throws Exception {
		int ret = initCategorySearch(searchQuery);
		String collection = searchQuery.getCollection();
		int totalGroup = 0;
				
		if (ret == 0) {
			totalGroup = search.w3GetResultTotalGroupCount(collection);
		}
		
		return totalGroup;
	}
	
	/**
	 * @param searchQuery
	 * @return
	 * @throws Exception
	 */
	public int getCategoryGroupResultCount(QueryVo searchQuery) throws Exception {
		int ret = initCategorySearch(searchQuery);
		String collection = searchQuery.getCollection();
		int resultGroup = 0;
		
		if(ret == 0){
			resultGroup = search.w3GetResultGroupCount(collection);
		}
		
		return resultGroup;
	}
	
	public void getCategoryGroupData(QueryVo searchQuery) throws Exception {
		int ret = initCategorySearch(searchQuery);
		String collection = searchQuery.getCollection();
		
		String summary;
		
		int totalGroup  = search.w3GetResultTotalGroupCount(collection); 
		int resultGroup = search.w3GetResultGroupCount(collection); 
		
		for(int i = 0; i < resultGroup; i++ ) {  
			int totalCount = search.w3GetTotalCountInGroup( collection, i );  
			int resultCount = search.w3GetCountInGroup( collection, i ); 
			System.out.println( "그룹내 검색 결과: " + resultCount + " 건 / 전체 " + totalCount + " 건\n" ); 
		 
			for(int j = 0; j < resultCount; j ++ )  {   
				summary = search.w3GetFieldInGroup( collection, "CF_TITLE", i, j );   
				summary = summary.replaceAll("<!HS>", "<b>");   summary = summary.replaceAll("<!HE>", "</b>");   
				System.out.println( (i+1) + "-" + (j+1) + ". " + summary + "\n" ); 
		 
				summary = search.w3GetFieldInGroup( collection, "CF_CONTENT", i, j );   summary = summary.replaceAll("<!HS>", "<b>");
				summary = summary.replaceAll("<!HE>", "</b>");   
				System.out.println( "CONTENT: " + summary ); 
				System.out.println( "XGBOOST_ANAL_RS: " + search.w3GetFieldInGroup( collection, "XGBOOST_ANAL_RS", i, j )); 
				System.out.println( "작성일: " + search.w3GetFieldInGroup( collection, "CF_DATE", i, j ) + "\n");   
			} 
		} 
	}
	
	
	public Map<String, Integer> getCategoryGroupGubun(QueryVo searchQuery) throws Exception {
		Map<String, Integer> totalList = new HashMap<>();
		
		int ret = initCategorySearch(searchQuery);
		String collection = searchQuery.getCollection();
	
		int resultGroup = search.w3GetResultGroupCount(collection); 
		
		for(int i = 0; i < resultGroup; i++ ) {  
			int totalCount = search.w3GetTotalCountInGroup( collection, i );  
			int resultCount = search.w3GetCountInGroup( collection, i );

			for(int j = 0; j < resultCount; j ++ )  {
				totalList.put(search.w3GetFieldInGroup( collection, "XGBOOST_ANAL_RS", i, j ), totalCount);
			} 
		}
		
		return totalList;
	}

	/**
	 * 검색엔진 개별 문서 검색
	 * 
	 * @param searchQuery
	 * @param uid (,)
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getDetail(QueryVo searchQuery, String uid) throws Exception {
		search = new Search();
		int ret;
		String collection = searchQuery.getCollection();
		String docField = getDocField(collection);
		String fields[] = docField.split(seperator);

		ret = search.w3SetCodePage(CHARACTOR_SET_UTF8);
		ret = search.w3SetQueryLog(QUERY_LOG_ON);
		
		// 1개의 검색결과를 가져오기 위하여 StartCount = 0, listCount = 1로 지정
		ret = search.w3AddCollection(collection);
		ret = search.w3SetPageInfo(collection, 0, 1);
		
		//요약 설정 제거
		docField = docField.replaceAll("/[0-9]?[0-9]?[0-9]", "");
		ret = search.w3SetDocumentField(collection, docField);

		// sc라는 아이디를 가진 검색기에서 가져오기
		if(uid.split(seperator).length > 1) {
			for(String id : uid.split(seperator)){
				ret = search.w3AddUid(collection, Integer.parseInt(id), "sc");
			}
		}else {
			ret = search.w3AddUid(collection, Integer.parseInt(uid), "sc");			
		}
		ret = search.w3ConnectServer(searchIp, Integer.parseInt(searchPort), SERVER_TIMEOUT);
		ret = search.w3ReceiveUidResult(3);

		if (ret == 0) {
			List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
			int resultCount = search.w3GetResultCount(collection);
			dataList = getDataList(collection, fields, resultCount);
			
			return dataList;
		}
		return null;
	}
	
	
	/**
	 * @param collection
	 * @param fields
	 * @return
	 */
	public List<Map<String, Object>> getDataList(String collection, String[] fields, int resultCount) throws Exception{
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> data = null;

		// 컬렉션 필드 데이터 입력
		for (int rIdx = 0; rIdx < resultCount; rIdx++) {
			data = new HashMap<String, Object>();
			// 개별 검색을 위한 UID 넣기
			data.put("UID", search.w3GetUid(collection, rIdx));
			for (int fIdx = 0; fIdx < fields.length; fIdx++) {
				String field = WNUtil.replaceSnippetField(fields[fIdx]);
				data.put(field, WNUtil.replaceHighlight(WNUtil.replaceTagLikeChr(search.w3GetField(collection, field, rIdx))));
			}
			dataList.add(data);
		}
		return dataList;
	}
	
	/**
	 * 문서필드 가져오기
	 * @param collection
	 * @return
	 * @throws IllegalArgumentException
	 */
	public String getDocField(String collection) throws Exception {
		String collectionName = collection.split("_")[2].toUpperCase();
		String docFieldName = "DOCUMENT_FIELD_" + collectionName;
		
		String docField = ReflectionUtils.findField(WNDefine.class, docFieldName , String.class).get(WNDefine.class).toString();
		return docField;
	}
}
