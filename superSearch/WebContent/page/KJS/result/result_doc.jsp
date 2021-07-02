<%@ page contentType="text/html; charset=UTF-8"%><%
/*
* subject: doc 페이지
* @original author: SearchTool
*/
	thisCollection = "doc";
	if (collection.equals("ALL") || collection.equals(thisCollection)) {
		int count = wnsearch.getResultCount(thisCollection);
		int thisTotalCount = wnsearch.getResultTotalCount(thisCollection);

		if ( thisTotalCount > 0 ) {
%>
		<div class="sectit01">
	    	<h2>DOC<span>(<%=numberFormat(thisTotalCount)%>)</span></h2>
<%
			for(int idx = 0; idx < count; idx ++) {
                String DOCID                    = wnsearch.getField(thisCollection,"DOCID",idx,false);
                String DATE                     = wnsearch.getField(thisCollection,"Date",idx,false);
                String STATE                    = wnsearch.getField(thisCollection,"STATE",idx,false);
                String MENU_CLSF_CD             = wnsearch.getField(thisCollection,"MENU_CLSF_CD",idx,false);
                String DOC_NM                   = wnsearch.getField(thisCollection,"DOC_NM",idx,false);
                String CN_TAG                   = wnsearch.getField(thisCollection,"CN_TAG",idx,false);
                String RDCNT                    = wnsearch.getField(thisCollection,"RDCNT",idx,false);
                String ANMT_YN                  = wnsearch.getField(thisCollection,"ANMT_YN",idx,false);
                String WRT_STATE                = wnsearch.getField(thisCollection,"WRT_STATE",idx,false);
                String DOC_CHNS                 = wnsearch.getField(thisCollection,"DOC_CHNS",idx,false);
                String DOC_ENG                  = wnsearch.getField(thisCollection,"DOC_ENG",idx,false);
                String DOC_SRCLG_ABR            = wnsearch.getField(thisCollection,"DOC_SRCLG_ABR",idx,false);
                String MDFC_DTTM                = wnsearch.getField(thisCollection,"MDFC_DTTM",idx,false);
                String MDFR_ID                  = wnsearch.getField(thisCollection,"MDFR_ID",idx,false);
                String RGST_DTTM                = wnsearch.getField(thisCollection,"RGST_DTTM",idx,false);
                String RGSTR_ID                 = wnsearch.getField(thisCollection,"RGSTR_ID",idx,false);
                String DVS                      = wnsearch.getField(thisCollection,"DVS",idx,false);
                String HDWD_SRCHWD              = wnsearch.getField(thisCollection,"HDWD_SRCHWD",idx,false);
                String ED_MODE                  = wnsearch.getField(thisCollection,"ED_MODE",idx,false);
                String DOC_HNGNM                = wnsearch.getField(thisCollection,"DOC_HNGNM",idx,false);
                String DCTN_KND                 = wnsearch.getField(thisCollection,"DCTN_KND",idx,false);
                String STATUS                   = wnsearch.getField(thisCollection,"STATUS",idx,false);
                String ALIAS                    = wnsearch.getField(thisCollection,"ALIAS",idx,false);
				DOC_NM= wnsearch.getKeywordHl(DOC_NM,"<strong>","</strong>");
				DOC_ENG= wnsearch.getKeywordHl(DOC_ENG,"<strong>","</strong>");
				HDWD_SRCHWD= wnsearch.getKeywordHl(HDWD_SRCHWD,"<strong>","</strong>");
            String URL = "URL 정책에 맞게 작성해야 합니다.";

%>
				
               <dl class="resultsty_1">
             	<dt>
				<a class="tit" href="#"><%=DOC_NM  %></a>
                <span><%=DATE %></span>
				</dt>
                <dd><%=HDWD_SRCHWD %></dd>
                <dd><%=DVS %></dd>
                <dd class="cate"><%=RGST_DTTM  %>&gt; <%=RGSTR_ID  %></dd>
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