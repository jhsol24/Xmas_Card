<%@ page pageEncoding = "UTF-8" %>
<%@ include file="./api/WNDefine.jsp" %>
<%!

	static String SEARCH_IP="211.39.140.162";
	static int SEARCH_PORT=7000;
	static String MANAGER_IP="211.39.140.162";
	static int MANAGER_PORT=7800;

	public String[] COLLECTIONS = new String[]{"dctn","doc","low"};
	public String[] COLLECTIONS_NAME = new String[]{"dctn","doc","low"};
	public String[] MERGE_COLLECTIONS = new String[]{""};
	public class WNCollection{
	public String[][] MERGE_COLLECTION_INFO = null;
	public String[][] COLLECTION_INFO = null;
		WNCollection(){
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
			"low", // set index name
			"low", // set collection name
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
			"low" // collection display name
			}
			};
		}
	}
%>