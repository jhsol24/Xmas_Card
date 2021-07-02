<%@ page contentType="text/html; charset=UTF-8"%><%
/*
* subject: dctn 페이지
* @original author: SearchTool
*/
	thisCollection = "dctn";
	if (collection.equals("ALL") || collection.equals(thisCollection)) {
		int count = wnsearch.getResultCount(thisCollection);
		int thisTotalCount = wnsearch.getResultTotalCount(thisCollection);

		if ( thisTotalCount > 0 ) {
%>
			<div class="sectit">
				<h2><%=wnsearch.getCollectionKorName(thisCollection)%></h2>
				<p>| 검색결과 <%=numberFormat(thisTotalCount)%>건</p>
			</div>
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
                String ALIAS                    = wnsearch.getField(thisCollection,"ALIAS",idx,false);
                
                
               
				HDWD= wnsearch.getKeywordHl(HDWD,"<font color=red>","</font>");
				HDWD_NM= wnsearch.getKeywordHl(HDWD_NM,"<font color=red>","</font>");
				SPPT= wnsearch.getKeywordHl(SPPT,"<font color=red>","</font>");
				TMNL_DEF= wnsearch.getKeywordHl(TMNL_DEF,"<font color=red>","</font>");
            String URL = "URL 정책에 맞게 작성해야 합니다.";

%>
				<dl class="resultsty1">
					<dt>
						<p class="date"><%=DATE%></p>
					</dt>
              <dd class="lh18"> DOCID : <%=DOCID%></dd>
              <dd class="lh18"> Date : <%=DATE%></dd>
              <dd class="lh18"> HDWD : <%=HDWD%></dd>
              <dd class="lh18"> HDWD_NM : <%=HDWD_NM%></dd>
              <dd class="lh18"> HDWD_CHCH : <%=HDWD_CHCH%></dd>
              <dd class="lh18"> SPPT : <%=SPPT%></dd>
              <dd class="lh18"> TMNL_DEF : <%=TMNL_DEF%></dd>
              <dd class="lh18"> ANTN : <%=ANTN%></dd>
              <dd class="lh18"> USG : <%=USG%></dd>
              <dd class="lh18"> CTGR : <%=CTGR%></dd>
              <dd class="lh18"> SRCE_DCTN : <%=SRCE_DCTN%></dd>
              <dd class="lh18"> DCTN_STATE : <%=DCTN_STATE%></dd>
              <dd class="lh18"> DCTN_OPN_YN : <%=DCTN_OPN_YN%></dd>
              <dd class="lh18"> RGST_DTTM : <%=RGST_DTTM%></dd>
              <dd class="lh18"> RGSTR_ID : <%=RGSTR_ID%></dd>
              <dd class="lh18"> MDFC_DTTM : <%=MDFC_DTTM%></dd>
              <dd class="lh18"> MDFR_ID : <%=MDFR_ID%></dd>
              <dd class="lh18"> SYST_DTTM : <%=SYST_DTTM%></dd>
              <dd class="lh18"> HANGL_ALPHB_SRWD : <%=HANGL_ALPHB_SRWD%></dd>
              <dd class="lh18"> BLNK_RMV_SRWD : <%=BLNK_RMV_SRWD%></dd>
              <dd class="lh18"> ADD_CN : <%=ADD_CN%></dd>
              <dd class="lh18"> REF_CN : <%=REF_CN%></dd>
              <dd class="lh18"> OPNN_CN : <%=OPNN_CN%></dd>
              <dd class="lh18"> RDCNT : <%=RDCNT%></dd>
              <dd class="lh18"> ALIAS : <%=ALIAS%></dd>
				</dl>
 <%
			}

			if ( collection.equals("ALL") && thisTotalCount > TOTALVIEWCOUNT ) {
%>
				<div class="moreresult"><a href="#none" onClick="javascript:doCollection('<%=thisCollection%>');">더보기</a></div>
<%
			}
		}
	}
%>