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
			<div class="sectit">
				<h2><%=wnsearch.getCollectionKorName(thisCollection)%></h2>
				<p>| 검색결과 <%=numberFormat(thisTotalCount)%>건</p>
			</div>
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
				DOC_NM= wnsearch.getKeywordHl(DOC_NM,"<font color=red>","</font>");
				DOC_ENG= wnsearch.getKeywordHl(DOC_ENG,"<font color=red>","</font>");
				HDWD_SRCHWD= wnsearch.getKeywordHl(HDWD_SRCHWD,"<font color=red>","</font>");
            String URL = "URL 정책에 맞게 작성해야 합니다.";

%>
				<dl class="resultsty1">
					<dt>
						<p class="date"><%=DATE%></p>
					</dt>
              <dd class="lh18"> DOCID : <%=DOCID%></dd>
              <dd class="lh18"> Date : <%=DATE%></dd>
              <dd class="lh18"> STATE : <%=STATE%></dd>
              <dd class="lh18"> MENU_CLSF_CD : <%=MENU_CLSF_CD%></dd>
              <dd class="lh18"> DOC_NM : <%=DOC_NM%></dd>
              <dd class="lh18"> CN_TAG : <%=CN_TAG%></dd>
              <dd class="lh18"> RDCNT : <%=RDCNT%></dd>
              <dd class="lh18"> ANMT_YN : <%=ANMT_YN%></dd>
              <dd class="lh18"> WRT_STATE : <%=WRT_STATE%></dd>
              <dd class="lh18"> DOC_CHNS : <%=DOC_CHNS%></dd>
              <dd class="lh18"> DOC_ENG : <%=DOC_ENG%></dd>
              <dd class="lh18"> DOC_SRCLG_ABR : <%=DOC_SRCLG_ABR%></dd>
              <dd class="lh18"> MDFC_DTTM : <%=MDFC_DTTM%></dd>
              <dd class="lh18"> MDFR_ID : <%=MDFR_ID%></dd>
              <dd class="lh18"> RGST_DTTM : <%=RGST_DTTM%></dd>
              <dd class="lh18"> RGSTR_ID : <%=RGSTR_ID%></dd>
              <dd class="lh18"> DVS : <%=DVS%></dd>
              <dd class="lh18"> HDWD_SRCHWD : <%=HDWD_SRCHWD%></dd>
              <dd class="lh18"> ED_MODE : <%=ED_MODE%></dd>
              <dd class="lh18"> DOC_HNGNM : <%=DOC_HNGNM%></dd>
              <dd class="lh18"> DCTN_KND : <%=DCTN_KND%></dd>
              <dd class="lh18"> STATUS : <%=STATUS%></dd>
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