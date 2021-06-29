package com.wisenut.superSearch.common;

public class WNCollection {

	public final static int CONNECTION_TIMEOUT = 20000;
	public final static String CHARSET = "UTF-8";
	public final static int REALTIME_COUNT=100;
	public final static int PAGE_SCALE = 10; //view page list count

	public final static int CONNECTION_KEEP = 0; //recevive mode
	public final static int CONNECTION_REUSE = 2;
	public final static int CONNECTION_CLOSE = 3;

	public final static int ASC = 0; //order
	public final static int DESC = 1; //order

	public final static int USE_KMA_OFFOFF = 0; //synonym, morpheme
	public final static int USE_KMA_ONON = 1;
	public final static int USE_KMA_ONOFF = 2;

	public final static int USE_RESULT_STRING = 0; //result data type
	public final static int USE_RESULT_XML = 1;
	public final static int USE_RESULT_JSON = 2;
	public final static int USE_RESULT_DUPLICATE_STRING = 3; //uid result data type
	public final static int USE_RESULT_DUPLICATE_XML = 4;
	public final static int USE_RESULT_DUPLICATE_JSON = 5;

	public final static int IS_CASE_ON = 1; //case on, off
	public final static int IS_CASE_OFF = 0;

	public final static int HI_SUM_OFFOFF = 0; //summarizing, highlighting
	public final static int HI_SUM_OFFON = 1;
	public final static int HI_SUM_ONOFF = 2;
	public final static int HI_SUM_ONON = 3;

	public final static int COMMON_OR_WHEN_NORESULT_OFF = 0;
	public final static int COMMON_OR_WHEN_NORESULT_ON = 1;

	public final static int INDEX_NAME = 0;
	public final static int COLLECTION_NAME = 1;
	public final static int PAGE_INFO = 2;
	public final static int ANALYZER = 3;
	public final static int SORT_FIELD = 4;
	public final static int RANKING_OPTION = 5;
	public final static int SEARCH_FIELD = 6;
	public final static int RESULT_FIELD = 7;
	public final static int DATE_RANGE = 8;
	public final static int RANK_RANGE = 9;
	public final static int EXQUERY_FIELD = 10;
	public final static int COLLECTION_QUERY =11;
	public final static int BOOST_QUERY =12;
	public final static int FILTER_OPERATION = 13;
	public final static int GROUP_BY = 14;
	public final static int GROUP_SORT_FIELD = 15;
	public final static int CATEGORY_BOOST = 16;
	public final static int CATEGORY_GROUPBY = 17;
	public final static int CATEGORY_QUERY = 18;
	public final static int PROPERTY_GROUP = 19;
	public final static int PREFIX_FIELD = 20;
	public final static int FAST_ACCESS = 21;
	public final static int MULTI_GROUP_BY = 22;
	public final static int AUTH_QUERY = 23;
	public final static int DEDUP_SORT_FIELD = 24;
	public final static int COLLECTION_KOR = 25;

	public final static int MERGE_COLLECTION_NAME = 0;
	public final static int MERGE_MAPPING_COLLECTION_NAME = 1;
	public final static int MERGE_PAGE_INFO = 2;
	public final static int MERGE_RESULT_FIELD = 3;
	
	public final static int MERGE_MAPPING_RESULT_FIELD = 4;
	public final static int MERGE_MULTI_GROUP_BY_FIELD = 5;
	public final static int MERGE_MAPPING_MULTI_GROUP_BY_FIELD = 6;
	public final static int MERGE_CATEGORY_GROUPBY_FIELD = 7;
	public final static int MERGE_MAPPING_CATEGORY_GROUPBY_FIELD = 8;

	public final static int COLLECTION_COUNT = 0;
	public final static int RESULT_COUNT = 1;

//	dev,act
	public String SEARCH_IP="127.0.0.1";
	public int SEARCH_PORT=7000;
//	로컬실행시(윈도우 개발서버)
//	public String SEARCH_IP="106.248.248.2";
//	public int SEARCH_PORT=7000;

	
//	dev
	public String MANAGER_IP="127.0.0.1";
	public int MANAGER_PORT=7800;



	public String[] COLLECTIONS = new String[]{"board_new","board_new_notice","board_new_press","budget","admin_member","member_info","duty","bill_list","board_article","menu_new","minutes_new","movie_new"};
	public String[] COLLECTIONS_NAME = new String[]{"board_new","board_new_notice","board_new_press","budget","admin_member","member_info","duty","bill_list","board_article","menu_new","minutes_new","movie_new"};
	public String[] COLLECTIONS_BASIC_INFO = new String[]{"collectionCount", "resultCount"};

	//가상 통합 컬렉션을 사용할 경우 아래와 같이MERGE_COLLECTIONS에 정의한다.
	public String[] MERGE_COLLECTIONS = new String[]{""};

	public String[][] COLLECTION_INFO = null;

	public String[][] MERGE_COLLECTION_INFO = null;

	public WNCollection(){

		//가상 통합 컬렉션을 사용할 경우, mapping되는 collection들의 정보를 정의한다.
		/*
		MERGE_COLLECTION_INFO = new String[][]
		{
			{
				"merge_sample_bbs", // set merge collection name
				"sample_bbs/sample_edu", // set collection name, delimiter: /
				"0,3",  // set merge collection pageinfo (start,count)
				"DOCID,TITLE,WRITER,CONTENT",// set merge document field
				"DOCID,TITLE,WRITER,CONTENT/DOCID,TITLE,WRITER,CONTENT", // set document field, delimiter: /
				"", // set merge collection multi-group-by field
				"", // set merge collection multi-group-by field, delimiter: /
				"", // set merge collection category-group-by field
				""  // set collection multi-group-by field, delimiter: /
			}
		};
		 */
		COLLECTION_INFO = new String[][]
				{
					{
						"board_new", // set index name
						"board_new", // set collection name
						"0,3",  // set pageinfo (start,count)
						"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
						"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
						"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
						"BA_TITLE,BA_CONTENT_PLAIN,FILE_ORIGINAL_NAME",// set search field
						"DOCID,Date,SITE_DISPLAY_ID,BA_ID,BC_ID,BC_NAME,BA_TITLE,BA_CONTENT_PLAIN/300,REG_DATE,LINKURL,FILE_ID,FILE_ORIGINAL_NAME,FILE_SIZE,FILE_ALT_TEXT,FILE_UUID,FILE_ATTACHMENT_TYPE,FILE_SERVLET_URL,VIEWURL,ALIAS",// set document field
						"", // set date range
						"", // set rank range
						"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
						"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
						"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
						"", // set filter operation (<fieldname:operator:value>)
						"", // set groupby field(field, count)
						"", // set sort field group(field/order,field/order,...)
						"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
						"", // set categoryGroupBy (fieldname:value)
						"", // set categoryQuery (fieldname:value)
						"", // set property group (fieldname,min,max, groupcount)
						"ALIAS", // use check prefix query filed
						"", // set use check fast access field
						"", // set multigroupby field
						"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
						"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
						"board_new" // collection display name
					}
			        ,
			        {
						"board_new_notice", // set index name
						"board_new_notice", // set collection name
						"0,3",  // set pageinfo (start,count)
						"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
						"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
						"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
						"BA_TITLE,BA_CONTENT_PLAIN,FILE_ORIGINAL_NAME",// set search field
						"DOCID,Date,SITE_DISPLAY_ID,BA_ID,BC_ID,BC_NAME,BA_TITLE,BA_CONTENT_PLAIN/300,REG_DATE,LINKURL,FILE_ID,FILE_ORIGINAL_NAME,FILE_SIZE,FILE_ALT_TEXT,FILE_UUID,FILE_ATTACHMENT_TYPE,FILE_SERVLET_URL,VIEWURL,ALIAS",// set document field
						"", // set date range
						"", // set rank range
						"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
						"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
						"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
						"", // set filter operation (<fieldname:operator:value>)
						"", // set groupby field(field, count)
						"", // set sort field group(field/order,field/order,...)
						"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
						"", // set categoryGroupBy (fieldname:value)
						"", // set categoryQuery (fieldname:value)
						"", // set property group (fieldname,min,max, groupcount)
						"ALIAS", // use check prefix query filed
						"", // set use check fast access field
						"", // set multigroupby field
						"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
						"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
						"board_new_notice" // collection display name
					}
				    ,
				    {
						"board_new_press", // set index name
						"board_new_press", // set collection name
						"0,3",  // set pageinfo (start,count)
						"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
						"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
						"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
						"BA_TITLE,BA_CONTENT_PLAIN,FILE_ORIGINAL_NAME",// set search field
						"DOCID,Date,SITE_DISPLAY_ID,BA_ID,BC_ID,BC_NAME,BA_TITLE,BA_CONTENT_PLAIN/300,REG_DATE,LINKURL,FILE_ID,FILE_ORIGINAL_NAME,FILE_SIZE,FILE_ALT_TEXT,FILE_UUID,FILE_ATTACHMENT_TYPE,FILE_SERVLET_URL,VIEWURL,ALIAS",// set document field
						"", // set date range
						"", // set rank range
						"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
						"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
						"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
						"", // set filter operation (<fieldname:operator:value>)
						"", // set groupby field(field, count)
						"", // set sort field group(field/order,field/order,...)
						"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
						"", // set categoryGroupBy (fieldname:value)
						"", // set categoryQuery (fieldname:value)
						"", // set property group (fieldname,min,max, groupcount)
						"ALIAS", // use check prefix query filed
						"", // set use check fast access field
						"", // set multigroupby field
						"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
						"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
						"board_new_press" // collection display name
					}
			        ,
					{
						"budget", // set index name
						"budget", // set collection name
						"0,3",  // set pageinfo (start,count)
						"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
						"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
						"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
						"BG_TITLE,BG_FILE_TITLE1,BG_FILE_TITLE2,BG_FILE_TITLE3,BG_FILE_TITLE4,BG_FILE_TITLE5,FILE_ORIGINAL_NAME",// set search field
						"DOCID,Date,BG_ID,BG_DIVISION,BG_TITLE,BG_FILE_TITLE1,BG_FILE_TITLE2,BG_FILE_TITLE3,BG_FILE_TITLE4,BG_FILE_TITLE5,BG_REG_DT,LINKURL,FILE_ID,FILE_ORIGINAL_NAME,FILE_SIZE,FILE_ALT_TEXT,FILE_UUID,FILE_ATTACHMENT_TYPE,FILE_SERVLET_URL,VIEWURL,ALIAS",// set document field
						"", // set date range
						"", // set rank range
						"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
						"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
						"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
						"", // set filter operation (<fieldname:operator:value>)
						"", // set groupby field(field, count)
						"", // set sort field group(field/order,field/order,...)
						"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
						"", // set categoryGroupBy (fieldname:value)
						"", // set categoryQuery (fieldname:value)
						"", // set property group (fieldname,min,max, groupcount)
						"ALIAS", // use check prefix query filed
						"", // set use check fast access field
						"", // set multigroupby field
						"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
						"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
						"budget" // collection display name
						}
			         ,
						{
						"admin_member", // set index name
						"admin_member", // set collection name
						"0,3",  // set pageinfo (start,count)
						"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
						"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
						"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
						"ADMIN_NAME,ADMIN_POSITION,ORG_NAME,ADMIN_SRCH_TEL,JOBTITLE",// set search field
						"DOCID,Date,ADMIN_NAME,ADMIN_POSITION,ORG_NAME,DEP_NAME,ADMIN_SRCH_TEL,ADMIN_TEL,JOBTITLE/300,LINKURL,ALIAS",// set document field
						"", // set date range
						"", // set rank range
						"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
						"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
						"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
						"", // set filter operation (<fieldname:operator:value>)
						"", // set groupby field(field, count)
						"", // set sort field group(field/order,field/order,...)
						"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
						"", // set categoryGroupBy (fieldname:value)
						"", // set categoryQuery (fieldname:value)
						"", // set property group (fieldname,min,max, groupcount)
						"ALIAS", // use check prefix query filed
						"", // set use check fast access field
						"", // set multigroupby field
						"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
						"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
						"admin_member" // collection display name
						}
			         ,
						{
						"member_info", // set index name
						"member_info", // set collection name
						"0,3",  // set pageinfo (start,count)
						"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
						"MI_ALGEBRA/DESC",  // set sort field (field,order) multi sort '/'
						"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
						"MI_NAME,MI_DISTRICT_NAME,MI_JUNGDANG_NAME",// set search field
						"DOCID,Date,MI_ALGEBRA,MI_NAME,MI_CODE,MI_DISTRICT_NAME/300,MI_JUNGDANG_NAME,MI_CAREER,MI_WEAK_FORCE,MI_PHONE,MI_LOCAL_ADDR,MI_EMAIL,MI_FACEBOOK_URL,MI_BLOG_URL,MI_TWITTER_URL,LINKURL,MI_PROFILE_IMAGE,FILE_SERVLET_URL,MI_COMMITTEE_CODE,CODE_NAME1,CODE_NAME2,MI_NAME_NONH,ALIAS",// set document field
						"", // set date range
						"", // set rank range
						"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
						"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
						"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
						"", // set filter operation (<fieldname:operator:value>)
						"", // set groupby field(field, count)
						"", // set sort field group(field/order,field/order,...)
						"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
						"", // set categoryGroupBy (fieldname:value)
						"", // set categoryQuery (fieldname:value)
						"", // set property group (fieldname,min,max, groupcount)
						"ALIAS", // use check prefix query filed
						"MI_ALGEBRA", // set use check fast access field
						"", // set multigroupby field
						"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
						"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
						"member_info" // collection display name
						}
			         ,
						{
						"duty", // set index name
						"duty", // set collection name
						"0,3",  // set pageinfo (start,count)
						"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
						"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
						"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
						"DT_DIVISION,DT_TITLE,FILE_ORIGINAL_NAME",// set search field
						"DOCID,Date,DT_DIVISION,DT_TITLE,DT_USE_DT,LINKURL,FILE_ID,FILE_ORIGINAL_NAME,FILE_SIZE,FILE_ALT_TEXT,FILE_UUID,FILE_ATTACHMENT_TYPE,FILE_SERVLET_URL,ALIAS",// set document field
						"", // set date range
						"", // set rank range
						"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
						"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
						"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
						"", // set filter operation (<fieldname:operator:value>)
						"", // set groupby field(field, count)
						"", // set sort field group(field/order,field/order,...)
						"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
						"", // set categoryGroupBy (fieldname:value)
						"", // set categoryQuery (fieldname:value)
						"", // set property group (fieldname,min,max, groupcount)
						"ALIAS", // use check prefix query filed
						"", // set use check fast access field
						"", // set multigroupby field
						"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
						"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
						"duty" // collection display name
						}
			         ,
						{
						"bill_list", // set index name
						"bill_list", // set collection name
						"0,3",  // set pageinfo (start,count)
						"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
						"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
						"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
						"BL_TITLE,BL_BRIEF,BP_COUNCILOR,FILE_ORIGINAL_NAME",// set search field
						"DOCID,Date,BL_BILL_NO,BL_ALGEBRA,BL_TITLE,BL_BRIEF/300,BL_PROPOSER_MAIN_CODE,BL_PROPOSER_MAIN_NAME,LINKURL,BL_THID_FK,BP_COUNCILOR_CODE,BP_COUNCILOR,URL,POP_URL,FILE_ID,FILE_ORIGINAL_NAME,FILE_SIZE,FILE_ALT_TEXT,FILE_UUID,FILE_ATTACHMENT_TYPE,FILE_SERVLET_URL,FILE_MODULE_SUB,FILE_MODULE_SUB_NAME,VIEWURL,ALIAS",// set document field
						"", // set date range
						"", // set rank range
						"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
						"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
						"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
						"", // set filter operation (<fieldname:operator:value>)
						"", // set groupby field(field, count)
						"", // set sort field group(field/order,field/order,...)
						"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
						"", // set categoryGroupBy (fieldname:value)
						"", // set categoryQuery (fieldname:value)
						"", // set property group (fieldname,min,max, groupcount)
						"ALIAS", // use check prefix query filed
						"", // set use check fast access field
						"", // set multigroupby field
						"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
						"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
						"bill_list" // collection display name
						}
			         ,
						{
						"board_article", // set index name
						"board_article", // set collection name
						"0,3",  // set pageinfo (start,count)
						"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
						"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
						"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
						"BA_TITLE,BA_CONTENT_PLAIN,FILE_ORIGINAL_NAME",// set search field
						"DOCID,Date,BC_ID,BC_NAME,BA_TITLE,BA_CONTENT_PLAIN/300,BA_REGDATE,BA_USE,LINKURL,FILE_ID,FILE_ORIGINAL_NAME,FILE_SIZE,FILE_ALT_TEXT,FILE_UUID,FILE_ATTACHMENT_TYPE,FILE_SERVLET_URL,VIEWURL,ALIAS",// set document field
						"", // set date range
						"", // set rank range
						"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
						"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
						"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
						"", // set filter operation (<fieldname:operator:value>)
						"", // set groupby field(field, count)
						"", // set sort field group(field/order,field/order,...)
						"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
						"", // set categoryGroupBy (fieldname:value)
						"", // set categoryQuery (fieldname:value)
						"", // set property group (fieldname,min,max, groupcount)
						"ALIAS", // use check prefix query filed
						"", // set use check fast access field
						"", // set multigroupby field
						"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
						"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
						"board_article" // collection display name
						}
			         ,
			         	{
			 			"menu_new", // set index name
			 			"menu_new", // set collection name
			 			"0,3",  // set pageinfo (start,count)
			 			"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
			 			"MENU_DEPTH/DESC,MENU_ORDER/DESC",  // set sort field (field,order) multi sort '/'
			 			"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
			 			"MENU_NAME,MENU_LOCATION",// set search field
			 			"DOCID,Date,MENU_NAME,MENU_LOCATION,LINKURL,MENU_DEPTH,MENU_ORDER,ALIAS",// set document field
			 			"", // set date range
			 			"", // set rank range
			 			"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
			 			"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
			 			"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
			 			"", // set filter operation (<fieldname:operator:value>)
			 			"", // set groupby field(field, count)
			 			"", // set sort field group(field/order,field/order,...)
			 			"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
			 			"", // set categoryGroupBy (fieldname:value)
			 			"", // set categoryQuery (fieldname:value)
			 			"", // set property group (fieldname,min,max, groupcount)
			 			"ALIAS", // use check prefix query filed
			 			"MENU_DEPTH,MENU_ORDER", // set use check fast access field
			 			"", // set multigroupby field
			 			"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
			 			"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
			 			"menu_new" // collection display name
			         	}
			         ,
			         	{
			 			"minutes_new", // set index name
			 			"minutes_new", // set collection name
			 			"0,3",  // set pageinfo (start,count)
			 			"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
			 			"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
			 			"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
			 			"TITLE,CONTENT",// set search field
			 			"DOCID,Date,TITLE,CONTENT/300,DAESU,PAGEURL,CATEGORY,ALIAS",// set document field
			 			"", // set date range
			 			"", // set rank range
			 			"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
			 			"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
			 			"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
			 			"", // set filter operation (<fieldname:operator:value>)
			 			"", // set groupby field(field, count)
			 			"", // set sort field group(field/order,field/order,...)
			 			"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
			 			"", // set categoryGroupBy (fieldname:value)
			 			"", // set categoryQuery (fieldname:value)
			 			"", // set property group (fieldname,min,max, groupcount)
			 			"ALIAS", // use check prefix query filed
			 			"", // set use check fast access field
			 			"", // set multigroupby field
			 			"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
			 			"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
			 			"minutes_new" // collection display name
			 			}
			         ,
			         	{
			 			"movie_new", // set index name
			 			"movie_new", // set collection name
			 			"0,3",  // set pageinfo (start,count)
			 			"1,1,1,1,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
			 			"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
			 			"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
			 			"TITLE,CONTENT",// set search field
			 			"DOCID,Date,TITLE,CONTENT/300,MNAME,DAESU,BIRTHDAY,PAGEURL,CATEGORY,ALIAS",// set document field
			 			"", // set date range
			 			"", // set rank range
			 			"", // set prefix query, example: <fieldname:contains:value1>|<fieldname:contains:value2>/1,  (fieldname:contains:value) and ' ', or '|', not '!' / operator (AND:1, OR:0)
			 			"", // set collection query (<fieldname:contains:value^weight | value^weight>/option...) and ' ', or '|'
			 			"", // set boost query (<fieldname:contains:value> | <field3:contains:value>...) and ' ', or '|'
			 			"", // set filter operation (<fieldname:operator:value>)
			 			"", // set groupby field(field, count)
			 			"", // set sort field group(field/order,field/order,...)
			 			"", // set categoryBoost(fieldname,matchType,boostID,boostKeyword)
			 			"", // set categoryGroupBy (fieldname:value)
			 			"", // set categoryQuery (fieldname:value)
			 			"", // set property group (fieldname,min,max, groupcount)
			 			"ALIAS", // use check prefix query filed
			 			"", // set use check fast access field
			 			"", // set multigroupby field
			 			"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
			 			"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
			 			"movie_new" // collection display name
			 			}
				};
	}
}
