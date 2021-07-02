package com.wisenut.superSearch.common;
/*컬렉션 정보 가져오기*/
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
	public String SEARCH_IP="101.101.210.156";
	public int SEARCH_PORT=7000;
//	로컬실행시(윈도우 개발서버)
//	public String SEARCH_IP="106.248.248.2";
//	public int SEARCH_PORT=7000;

	
//	dev
	public String MANAGER_IP="101.101.210.156";
	public int MANAGER_PORT=7800;


	public String[] COLLECTIONS = new String[]{"dctn","doc","info","law"};
	public String[] COLLECTIONS_NAME = new String[]{"dctn","doc","info","law"};
	public String[] COLLECTIONS_BASIC_INFO = new String[]{"collectionCount", "resultCount"}; //?MERGE_COLLECTIONS_js 추측

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
				"dctn", // set index name
				"dctn", // set collection name
				"0,3",  // set pageinfo (start,count)
				"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
				"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
				"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
				"TMNL_DEF,HDWD_NM,SPPT,HDWD",// set search field
				"DOCID,Date,HDWD,HDWD_NM,HDWD_CHCH,SPPT,TMNL_DEF,ANTN,USG,CTGR,SRCE_DCTN,DCTN_STATE,DCTN_OPN_YN,RGST_DTTM,RGSTR_ID,MDFC_DTTM,MDFR_ID,SYST_DTTM,HANGL_ALPHB_SRWD,BLNK_RMV_SRWD,ADD_CN,REF_CN,OPNN_CN,RDCNT,TOPIC,TERMS,ALIAS",// set document field
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
				"CTGR,SRCE_DCTN,DCTN_STATE,DCTN_OPN_YN,ALIAS", // use check prefix query filed
				"", // set use check fast access field
				"", // set multigroupby field
				"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
				"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
				"dctn" // collection display name
				}
	         ,
				{
				"doc", // set index name
				"doc", // set collection name
				"0,3",  // set pageinfo (start,count)
				"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
				"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
				"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
				"DOC_NM,DOC_ENG,HDWD_SRCHWD",// set search field
				"DOCID,Date,STATE,MENU_CLSF_CD,DOC_NM,CN_TAG,RDCNT,ANMT_YN,WRT_STATE,DOC_CHNS,DOC_ENG,DOC_SRCLG_ABR,MDFC_DTTM,MDFR_ID,RGST_DTTM,RGSTR_ID,DVS,HDWD_SRCHWD,ED_MODE,DOC_HNGNM,DCTN_KND,STATUS,ALIAS",// set document field
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
				"DVS,ED_MODE,DCTN_KND,ALIAS", // use check prefix query filed
				"MDFC_DTTM", // set use check fast access field
				"", // set multigroupby field
				"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
				"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
				"doc" // collection display name
				}
	         ,
				{
				"info", // set index name
				"info", // set collection name
				"0,3",  // set pageinfo (start,count)
				"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
				"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
				"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
				"DOC_NM,DOC_ENG,HDWD_SRCHWD",// set search field
				"DOCID,Date,STATE,MENU_CLSF_CD,DOC_NM,CN_TAG,RDCNT,ANMT_YN,WRT_STATE,DOC_CHNS,DOC_ENG,DOC_SRCLG_ABR,MDFC_DTTM,MDFR_ID,RGST_DTTM,RGSTR_ID,DVS,HDWD_SRCHWD,ED_MODE,DOC_HNGNM,DCTN_KND,STATUS,Attachment_No,Attachment_Title,Attachment_Content,ALIAS",// set document field
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
				"DVS,ED_MODE,DCTN_KND,ALIAS", // use check prefix query filed
				"MDFC_DTTM", // set use check fast access field
				"", // set multigroupby field
				"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
				"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
				"info" // collection display name
				}
	         ,
				{
				"law", // set index name
				"law", // set collection name
				"0,3",  // set pageinfo (start,count)
				"1,0,0,0,0", // set query analyzer (useKMA,isCase,useOriginal,useSynonym, duplcated detection)
				"RANK/DESC,DATE/DESC",  // set sort field (field,order) multi sort '/'
				"basic,rpfmo,100",  // set sort field (field,order) multi sort '/'
				"HDWD,SYNNM",// set search field
				"DOCID,EXTSN_NO,DOC_DEPTH,HDWD,LOWRNK_ID,ATTR,SYNNM,LOWRNK_CO,ALIAS",// set document field
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
				"DOC_DEPTH,ATTR,ALIAS", // use check prefix query filed
				"", // set use check fast access field
				"", // set multigroupby field
				"", // set auth query (Auth Target Field, Auth Collection, Auth Reference Field, Authority Query)
				"", // set Duplicate Detection Criterion Field, RANK/DESC,DATE/DESC
				"law" // collection display name
				}
				};
			}
		}
