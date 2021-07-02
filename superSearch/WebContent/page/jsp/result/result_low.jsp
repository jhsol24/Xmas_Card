<%@ page contentType="text/html; charset=UTF-8"%><%
/*
* subject: low 페이지
* @original author: SearchTool
*/
	thisCollection = "low";
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
                String EXTSN_NO                 = wnsearch.getField(thisCollection,"EXTSN_NO",idx,false);
                String DOC_DEPTH                = wnsearch.getField(thisCollection,"DOC_DEPTH",idx,false);
                String HDWD                     = wnsearch.getField(thisCollection,"HDWD",idx,false);
                String LOWRNK_ID                = wnsearch.getField(thisCollection,"LOWRNK_ID",idx,false);
                String ATTR                     = wnsearch.getField(thisCollection,"ATTR",idx,false);
                String SYNNM                    = wnsearch.getField(thisCollection,"SYNNM",idx,false);
                String LOWRNK_CO                = wnsearch.getField(thisCollection,"LOWRNK_CO",idx,false);
                String ALIAS                    = wnsearch.getField(thisCollection,"ALIAS",idx,false);
				HDWD= wnsearch.getKeywordHl(HDWD,"<font color=red>","</font>");
				SYNNM= wnsearch.getKeywordHl(SYNNM,"<font color=red>","</font>");
            String URL = "URL 정책에 맞게 작성해야 합니다.";

%>
				<dl class="resultsty1">
					<dt>
					</dt>
              <dd class="lh18"> DOCID : <%=DOCID%></dd>
              <dd class="lh18"> EXTSN_NO : <%=EXTSN_NO%></dd>
              <dd class="lh18"> DOC_DEPTH : <%=DOC_DEPTH%></dd>
              <dd class="lh18"> HDWD : <%=HDWD%></dd>
              <dd class="lh18"> LOWRNK_ID : <%=LOWRNK_ID%></dd>
              <dd class="lh18"> ATTR : <%=ATTR%></dd>
              <dd class="lh18"> SYNNM : <%=SYNNM%></dd>
              <dd class="lh18"> LOWRNK_CO : <%=LOWRNK_CO%></dd>
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