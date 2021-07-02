<%@ page contentType="text/html; charset=UTF-8"%><%
/*
* subject: dctn 페이지
* @original author: SearchTool
*/
	thisCollection = "dctn";
	if (collection.equals("ALL") || collection.equals(thisCollection)) {
		int count = wnsearch.getResultCount(thisCollection);
		int thisTotalCount = wnsearch.getResultTotalCount(thisCollection);
		/* test */
		int otherCount = wnsearch.getResultTotalCount("doc");
		otherCount += thisTotalCount;

		if ( thisTotalCount > 0 ) {
%>
			
			<div class="sectit01">
                    <h2>DCTN<span>(<%=numberFormat(thisTotalCount)%>)</span></h2>
<%
			for(int idx = 0; idx < count; idx ++) {
                String DOCID                    = wnsearch.getField(thisCollection,"DOCID",idx,false);
                String DATE                     = wnsearch.getField(thisCollection,"Date",idx,false);
                String HDWD                     = wnsearch.getField(thisCollection,"HDWD",idx,false);
                String HDWD_NM                  = wnsearch.getField(thisCollection,"HDWD_NM",idx,false);
                String HDWD_CHCH                = wnsearch.getField(thisCollection,"HDWD_CHCH",idx,false);
                String SPPT                     = wnsearch.getField(thisCollection,"SPPT",idx,false);
                String TMNL_DEF                 = wnsearch.getField(thisCollection,"TMNL_DEF",idx,false);
                String ANTN                     = wnsearch.getField(thisCollection,"ANTN",idx,false);
                String USG                      = wnsearch.getField(thisCollection,"USG",idx,false);
                String CTGR                     = wnsearch.getField(thisCollection,"CTGR",idx,false);
                String SRCE_DCTN                = wnsearch.getField(thisCollection,"SRCE_DCTN",idx,false);
                String DCTN_STATE               = wnsearch.getField(thisCollection,"DCTN_STATE",idx,false);
                String DCTN_OPN_YN              = wnsearch.getField(thisCollection,"DCTN_OPN_YN",idx,false);
                String RGST_DTTM                = wnsearch.getField(thisCollection,"RGST_DTTM",idx,false);
                String RGSTR_ID                 = wnsearch.getField(thisCollection,"RGSTR_ID",idx,false);
                String MDFC_DTTM                = wnsearch.getField(thisCollection,"MDFC_DTTM",idx,false);
                String MDFR_ID                  = wnsearch.getField(thisCollection,"MDFR_ID",idx,false);
                String SYST_DTTM                = wnsearch.getField(thisCollection,"SYST_DTTM",idx,false);
                String HANGL_ALPHB_SRWD         = wnsearch.getField(thisCollection,"HANGL_ALPHB_SRWD",idx,false);
                String BLNK_RMV_SRWD            = wnsearch.getField(thisCollection,"BLNK_RMV_SRWD",idx,false);
                String ADD_CN                   = wnsearch.getField(thisCollection,"ADD_CN",idx,false);
                String REF_CN                   = wnsearch.getField(thisCollection,"REF_CN",idx,false);
                String OPNN_CN                  = wnsearch.getField(thisCollection,"OPNN_CN",idx,false);
                String RDCNT                    = wnsearch.getField(thisCollection,"RDCNT",idx,false);
                String TOPIC                    = wnsearch.getField(thisCollection,"TOPIC",idx,false);
                String TERMS                    = wnsearch.getField(thisCollection,"TERMS",idx,false);
                String ALIAS                    = wnsearch.getField(thisCollection,"ALIAS",idx,false);
				HDWD= wnsearch.getKeywordHl(HDWD,"<strong>","</strong>");
				HDWD_NM= wnsearch.getKeywordHl(HDWD_NM,"<strong>","</strong>");
				SPPT= wnsearch.getKeywordHl(SPPT,"<strong>","</strong>");
				TMNL_DEF= wnsearch.getKeywordHl(TMNL_DEF,"<strong>","</strong>");
            String URL = "URL 정책에 맞게 작성해야 합니다.";

%>
                   <dl class="resultsty_1">
                       <dt>
						<a class="tit" href="#"><%=HDWD_NM %></a>
                           <span><%=DATE %></span>
					</dt>
                       <dd><%=TMNL_DEF %></dd>
                       <dd><%=TERMS %></dd>
                       <dd class="cate"><%=RGST_DTTM %> &gt; <%=RGSTR_ID %></dd>
                   </dl>
 <%
			}

			if ( collection.equals("ALL") && thisTotalCount > TOTALVIEWCOUNT ) {
%>
				<a class="section_more" href="#none" onClick="javascript:doCollection('<%=thisCollection%>');">더보기</a>
               </div>
<%
			} 
		}
	}
%>