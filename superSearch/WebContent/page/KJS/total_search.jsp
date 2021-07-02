<%@ page contentType="text/html; charset=UTF-8"%><%@ include file="./common/api/WNSearch.jsp" %><% request.setCharacterEncoding("UTF-8");%><%
    /*
     * subject: 검색 메인 페이지
     * @original author: SearchTool
     */

    //실시간 검색어 화면 출력 여부 체크
    boolean isRealTimeKeyword = false;
    //오타 후 추천 검색어 화면 출력 여부 체크
    boolean useSuggestedQuery = true;
    String suggestQuery = "";

    //디버깅 보기 설정
    boolean isDebug = false;

    int TOTALVIEWCOUNT = 3;    //통합검색시 출력건수
    int COLLECTIONVIEWCOUNT = 10;    //더보기시 출력건수

	String START_DATE = "1970.01.01";	// 기본 시작일

	// 결과 시작 넘버
    int startCount = parseInt(getCheckReqXSS(request, "startCount", "0"), 0);	//시작 번호
    String query = getCheckReqXSS(request, "query", "");						//검색어
    String collection = getCheckReqXSS(request, "collection", "ALL");			//컬렉션이름
    String rt = getCheckReqXSS(request, "rt", "");								//결과내 재검색 체크필드
    String rt2 = getCheckReqXSS(request, "rt2", "");							//결과내 재검색 체크필드
	String reQuery = getCheckReqXSS(request, "reQuery", "");					//결과내 재검색 체크필드
    String realQuery = getCheckReqXSS(request, "realQuery", "");				//결과내 검색어
    String sort = getCheckReqXSS(request, "sort", "RANK");						//정렬필드
    String range = getCheckReqXSS(request, "range", "A");						//기간관련필드
    String startDate = getCheckReqXSS(request, "startDate", START_DATE);		//시작날짜
    String endDate = getCheckReqXSS(request, "endDate", getCurrentDate());		//끝날짜
	String writer = getCheckReqXSS(request, "writer", "");						//작성자
	String searchField = getCheckReqXSS(request, "searchField", "");			//검색필드
	String strOperation  = "" ;												//operation 조건 필드
    String exquery = "" ;													//exquery 조건 필드
    int totalCount = 0;
    

    String[] searchFields = null;

	// 상세검색 검색 필드 설정이 되었을때
	// 이부분지운다.
	// <exquery로 <CTRG:contains:??>
	
    if (searchField.equals("")) {
		searchField = "ALL";
	} 

    String[] collections = null;
    if(collection.equals("ALL")) { //통합검색인 경우
        collections = COLLECTIONS;
    } else {                        //개별검색인 경우
    	// WNSearch객체에 넣어주려면 여기에 넣어줘야 WNSearch에 들어가야 조회를 돈다.
        collections = new String[] { "dctn","doc", collection };
    }

	if (reQuery.equals("1")) {
		realQuery = query + " " + realQuery;
	} else if (!reQuery.equals("2")) {
		realQuery = query;
	}

	// 이부분에
    WNSearch wnsearch = new WNSearch(isDebug,false, collections, searchFields);

    int viewResultCount = COLLECTIONVIEWCOUNT;
    if ( collection.equals("ALL") ||  collection.equals("") )
        viewResultCount = TOTALVIEWCOUNT;

    for (int i = 0; i < collections.length; i++) {

        //출력건수
        wnsearch.setCollectionInfoValue(collections[i], PAGE_INFO, startCount+","+viewResultCount);

        //검색어가 없으면 DATE_RANGE 로 전체 데이터 출력
        if (!query.equals("") ) {
              wnsearch.setCollectionInfoValue(collections[i], SORT_FIELD, sort + "/DESC");
        } else {
              wnsearch.setCollectionInfoValue(collections[i], DATE_RANGE, START_DATE.replaceAll("[.]","/") + ",2030/12/31,-");
              wnsearch.setCollectionInfoValue(collections[i], SORT_FIELD, "RANK/DESC,DATE/DESC");
        }

        //searchField 값이 있으면 설정, 없으면 기본검색필드
        //검색범위 제목, 내용 검색할내용.
        if (!"".equals(searchField) && !"ALL".equals(searchField) ) {
        	if("TITLE".equals(searchField)){
        		if("doc".equals(collections[i])){
        			//exquery = "<DOC_NM:contains:" + query + ">";
            		searchField = "DOC_NM";
            	} else {
            		//exquery = "<HDWD_NM:contains:" + query + ">";
        			searchField = "HDWD_NM";
            	}
        	} else if ("CONTENT".equals(searchField)){
        		if("dctn".equals(collections[i])){
            		//exquery = "<HDWD:contains:" + query + ">";
            		searchField = "TMNL_DEF";
            	} else {
            		//exquery = "<HDWD_SRCHWD:contains" + query + ">";
            		searchField = "HDWD_SRCHWD";
            	}
        	} 
			wnsearch.setCollectionInfoValue(collections[i], SEARCH_FIELD, searchField);
			
			//searchField 기준 TITLE, CONTENT로 바꿔주기.
			searchField = ("DOC_NM".equals(searchField) || "HDWD_NM".equals(searchField)) ? "TITLE" : "CONTENT";
			
		} 

        //operation 설정
        if (!strOperation.equals("")) {
			wnsearch.setCollectionInfoValue(collections[i], FILTER_OPERATION, strOperation);
		}

        //exquery 설정
        if (!exquery.equals("")) {
			wnsearch.setCollectionInfoValue(collections[i], EXQUERY_FIELD, exquery);
		}

        //기간 설정 , 날짜가 모두 있을때
        if (!startDate.equals("")  && !endDate.equals("") ) {
             wnsearch.setCollectionInfoValue(collections[i], DATE_RANGE, startDate.replaceAll("[.]","/") + "," + endDate.replaceAll("[.]","/") + ",-");
        }
    };

    wnsearch.search(realQuery, isRealTimeKeyword, CONNECTION_CLOSE, useSuggestedQuery);

     // 디버그 메시지 출력
    String debugMsg = wnsearch.printDebug() != null ? wnsearch.printDebug().trim() : "";
    if ( !debugMsg.trim().equals("")) {
         out.println(debugMsg);
    }

     // 전체건수 구하기
    if ( collection.equals("ALL") ) {
        for (int i = 0; i < collections.length; i++) {
           totalCount += wnsearch.getResultTotalCount(collections[i]);
        }
    } else {
      //개별건수 구하기
        totalCount = wnsearch.getResultTotalCount(collection);
      	
    }
     
     int dctnCount = wnsearch.getResultTotalCount("dctn");
     int docCount = wnsearch.getResultTotalCount("doc");
     

    String thisCollection = "";
    if(useSuggestedQuery) {
       suggestQuery = wnsearch.suggestedQuery;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta content="IE=Edge" http-equiv="X-UA-Compatible" />
<title>통합검색</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" >
<link rel="stylesheet" type="text/css" href="ark/css/ark.css" media="screen" >
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="ark/js/beta.fix.js"></script>
<script type="text/javascript" src="ark/js/ark.js"></script>
<script type="text/javascript" src="js/datepicker.js"></script>
<script type="text/javascript" src="js/search.js"></script><!--  검색관련 js -->
<script type="text/javascript">
<!--
$(document).ready(function() {
	// 기간 달력 설정
	$("#startDate").datepicker({dateFormat: "yy.mm.dd"});
	$("#endDate").datepicker({dateFormat: "yy.mm.dd"});

    getPopkeyword();
	// 내가 찾은 검색어
	getMyKeyword("<%=query%>", <%=totalCount%>);
});


function getPopkeyword() {

	var target		= "popword";
	var range		= "m"; //D면 일간이라 안나옴 M는 월간
	var collection  = "POP"; //_ALL_
    var datatype   = "text";
	$.ajax({
	  type: "POST",
	  url: "./popword/popword.jsp",
	  dataType: datatype,
	  data: { "target" : target, "range" : range, "collection" : collection , "datatype" : datatype },
	  success: function(text) {
     text = trim(text);
     var xml = $.parseXML(text);
		var str = "";
		var num = 0;
		
		$(xml).find("Query").each(function(){
			/*
			<li><span class="rank_num0">1</span><a href="">기획재정부</a><span class="rank_stay"> -</span></li>
	        <li><span class="rank_num0">2</span><a href="">기획재정부기획재정부</a><span class="rank_stay"> -</span></li>
	        <li><span class="rank_num0">3</span><a href="">기획재정부</a><span class="rank_up">1</span></li>
	        <li><span class="rank_num">4</span><a href="">기획재정부</a><span class="rank_up">1</span></li>
	        <li><span class="rank_num">5</span><a href="">기획재정부</a><span class="rank_down">2</span></li>
	        <li><span class="rank_num">6</span><a href="">기획재정부</a><span class="rank_new">NEW</span></li>
	        <li><span class="rank_num">7</span><a href="">기획재정부</a><span class="rank_stay"> -</span></li>
	        <li><span class="rank_num">8</span><a href="">기획재정부</a><span class="rank_up">1</span></li>
	        <li><span class="rank_num">9</span><a href="">기획재정부</a><span class="rank_up">1</span></li>
	        <li><span class="rank_num">10</span><a href="">기획재정부</a><span class="rank_new">NEW</span></li>
			*/
			num++;
 			str += "<li><span class='rank_num0'>" + num;
			str += "</span>";
			str += "<a href=''>";
			str += $(this).text();
			str += "</a>";
			
			/*str += "		<li class='ranktxt'><img src='images/"+ $(this).attr("id")+".gif' alt='' /> <a href='#none' onclick=\"javascript:doKeyword('" + $(this).text() + "');\">" + $(this).text() + "</a></li>";
			str += "		<li class='rankico'>";*/

			if ($(this).attr("updown") == "U") {
				str += "<span class='rank_up'>";
			} else if ($(this).attr("updown") == "D") {
				str += "<span class='rank_down'>";
			} else if ($(this).attr("updown") == "N") {
				str += "<span class='rank_new'>";
			} else if ($(this).attr("updown") == "C") {
				str += "<span class='rank_stay'>";
			}
			
			str += "</li>"

			/*
			str += "		</li>";
			str += "		<li class='rankstep'>" + $(this).attr("count") + "</li>";
			str += "		";
			str += "	</ul>";
			str += "</li>";*/
		});
		
		//var poptest = "<li><span class='rank_num0'>1</span><a href=''>기획재정부</a><span class='rank_stay'> -</span></li>";
		$("#popword").html(str);
	  }
	});

}

//-->

</script>

</head>

<body>
    <div class="wrap">
        <!-- header -->
        <div class="header">
	        <form name="search" id="search" action="<%=request.getRequestURI()%>" method="POST">
			<input type="hidden" name="startCount" value="0" />
			<input type="hidden" name="sort" value="<%=sort%>" />
			<input type="hidden" name="collection" value="<%=collection%>" />
			<input type="hidden" name="range" value="<%=range%>" />
			<input type="hidden" name="startDate" value="<%=startDate%>" />
			<input type="hidden" name="endDate"value="<%=endDate%>" />
			<input type="hidden" name="searchField"value="<%=searchField%>" />
			<input type="hidden" name="reQuery" />
			<input type="hidden" name="realQuery" value="<%=realQuery%>" />
       	
            <div class="top clearfix">
				<h1><a href="" onClick="javascript:location.reload()"><img src="images/logo.PNG" alt="대한지방행정공제회" /></a></h1>
				<div class="sch_wrap">
					<select>
						<option>통합검색</option>
					</select>
					<input name="query" id="query" type="text" value="<%=query%>" onKeypress="javascript:pressCheck((event),this);" autocomplete="off"/>
                    <a href="#" class="btn_sch" onClick="javascript:doSearch();" title="검색"></a>
                
				</div>
				<a href="#" class="detail_btn">상세검색</a>
				<div class="sch_opt">
					<input type="checkbox" id="reChk" name="reChk" onClick="checkReSearch();"/>
					<label for="reChk"><span></span>결과 내 재검색</label>
				</div>
                <dl class="related_keyword">
                    <dt>연관검색어</dt>
                    <dd><a href="#">검색어</a></dd>
                    <dd><a href="#">검색어</a></dd>
                    <dd><a href="#">검색어</a></dd>
                    <dd><a href="#">검색어</a></dd>
                    <dd><a href="#">검색어</a></dd>
                    <dd><a href="#">검색어</a></dd>
                    <dd><a href="#">검색어</a></dd>
                    <dd><a href="#">검색어</a></dd>
                    <dd><a href="#">검색어</a></dd>
                </dl>

				<!-- 자동완성 -->
				<div class="auto_keyword" style="display:none">
					<ul>
						<li><a href="#"><span>제주</span>도교육청</a></li>
						<li><a href="#"><span>제주</span>도연구대회</a></li>
						<li><a href="#"><span>제주</span>도교육감</a></li>
						<li><a href="#"><span>제주</span>어말하기대회</a></li>
						<li><a href="#"><span>제주</span>학생문화원</a></li>
						<li><a href="#"><span>제주</span>시교육지원청</a></li>
						<li><a href="#"><span>제주</span>도서관</a></li>
						<li><a href="#"><span>제주</span>교육과학연구원</a></li>
						<li><a href="#"><span>제주</span>교육박물관제</a></li>
						<li><a href="#"><span>제주</span>영어교육도시</a></li>
					</ul>
					<p><a href="#">자동완성 기능 끄기</a></p>
				</div>
				<!-- //자동완성 -->
			</div>
		</form>
        </div>
        <!-- //header -->

        <!-- container -->
        <div class="container">
            <!-- leftArea -->
            <div class="leftArea">
                <ul class="lnb">
                	<% if( collection.equals("ALL")) {%>
                	<li class="lefttap lefttapsty selleft2"><a href="#none" onClick="javascript:doCollection('ALL');">통합검색 (<%=numberFormat(totalCount) %>)</a></li>
                	<!-- 왼쪽 검색결과 -->
					<% for (int i = 0; i < COLLECTIONS.length; i++) {%>
						<li class="lefttap lefttapsty selleft2"><a href="#none" onClick="javascript:doCollection('<%=COLLECTIONS[i]%>');"><%=wnsearch.getCollectionKorName(COLLECTIONS[i])%> (<%=numberFormat(wnsearch.getResultTotalCount(COLLECTIONS[i])) %>)</a></li>
					<% } %>
					<% } else { %>
						<li class="lefttap lefttapsty selleft2"><a href="#none" onClick="javascript:doCollection('ALL');">통합검색 (<%=numberFormat(dctnCount+docCount) %>)</a></li>
						<li class="lefttap lefttapsty selleft2"><a href="#none" onClick="javascript:doCollection('<%=COLLECTIONS[0]%>');"> dctn (<%=numberFormat(dctnCount) %>)</a></li>
						<li class="lefttap lefttapsty selleft2"><a href="#none" onClick="javascript:doCollection('<%=COLLECTIONS[1]%>');"> doc (<%=numberFormat(docCount) %>)</a></li>
					<% } %>
					
                </ul>
                <div class="optionArea">
                    <dl class="align">
                        <dt>정렬</dt>
                        <dd class="divi <%= sort.equals("RANK") ? "on" : "" %>" ><a onclick="doSorting('RANK');">정확도</a></dd>
                        <dd class="divi <%= sort.equals("DATE") ? "on" : "" %>"><a onclick="doSorting('DATE');">최신순</a></dd>
                    </dl>
                    <dl class="area">
                        <dt>검색범위</dt>
                        <dd class="divi <%=searchField.equals("ALL") ? "on" : ""%>"><a  onClick="doSearchField('ALL');">전체</a></dd>
                       	<dd class="divi <%=searchField.equals("TITLE") ? "on" : ""%>"><a onClick="doSearchField('TITLE');">제목</a></dd>
                        <dd class="divi <%=searchField.equals("CONTENT") ? "on" : ""%>"><a onClick="doSearchField('CONTENT');">내용</a></dd>
                        <dd class="divi <%=searchField.equals("ATTACHCON") ? "on" : ""%>"><a onClick="doSearchField('ATTACHCON');">첨부</a></dd>
                   </dl>
                    <dl class="date">
                        <dt>검색기간</dt>
                        <dd class="divi <%=range.equals("A") ? "on" : ""%>"><a href="#none" onClick="javascript:setDate('A');">전체</a></dd>
                        <dd class="divi <%=range.equals("W") ? "on" : ""%>"><a href="#none" onClick="javascript:setDate('W');">1주</a></dd>
                        <dd class="divi <%=range.equals("M") ? "on" : ""%>"><a href="#none" onClick="javascript:setDate('M');">1달</a></dd>
                        <dd class="divi <%=range.equals("Y") ? "on" : ""%>"><a href="#none" onClick="javascript:setDate('Y');">1년</a></dd>
                        <input type="hidden" name="range" id="range" value="<%=range%>"/>
                        <dd class="cal_box">
                            <span><input name="startDate" id="startDate" type="text" value="<%=startDate %>" readonly="true"/><a href="#"><img src="images/icon_day.gif" alt="달력" /></a></span>
                            <span><input name="endDate" id="endDate" type="text" value="<%=endDate%>" readonly="true"/><a href="#"><img src="images/icon_day.gif" alt="달력" /></a></span>
                        	<input type="hidden" name="range" id="range" value="<%=range%>">
                        </dd>
                        <dd><a href="#" class="align_btn">검색</a></dd>
                    </dl>
                </div>
                
            </div>
            
            <!-- //leftArea -->
            <!-- rightArea -->
            <div class="rightArea">
                <div class="rank">
                    <p>인기검색어</p>
                    <ol class="popu" id="popword">
                    </ol>
                </div>
                <div class="my_keyword">
                    <p>내가 찾은 검색어</p>
                    <ul>
                        <li><a href="">&middot; 전시</a>
                            <a class="btn_close" href="#"><img src="images/icon_close.gif" alt="close"></a>
                        </li>
                        <li><a href="">&middot; 특별전</a>
                            <a class="btn_close" href="#"><img src="images/icon_close.gif" alt="close"></a>
                        </li>
                    </ul>
                </div>
                <div class="my_keyword">
                    <p>최근 본 문서</p>
                    <ul>
                        <li><a href="" class="tit">&middot; 전시전시전시전시전시전시전시전시전시</a>
                            <a class="btn_close" href="#"><img src="images/icon_close.gif" alt="close"></a>
                        </li>
                        <li><a href="" class="tit">&middot; 특별전</a>
                            <a class="btn_close" href="#"><img src="images/icon_close.gif" alt="close"></a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- //rightArea -->
            <!-- contents -->
            <div class="contents">
                <div class="result_top">
                    ‘<%=query%>’에 대한 검색결과는 총[<%=numberFormat(totalCount)%>]건 입니다.
                </div>
                
                <!-- dnctn start -->
                <%@ include file="./result/result_dctn.jsp" %>
                
                <!-- /dctn end -->
                
                
                <!-- doc start -->
                <%@ include file="./result/result_doc.jsp" %>
                <!-- /doc end -->
                
		 		<!-- wnsearch.getPageLinks -->
		 		<!-- 
		 		 * 검색 결과 페이징 번호를 출력한다.
				 * @param startCount 검색 결과 시작 offset
				 * @param totalCount 검색 결과의 총 개수
				 * @param viewListCount 검색결과로 요청된 offset의 -더보기 할때 출력될 건수로 맞춘다.
				 * @param bundleCount 페이지 이동할 개수 -10다음눌렀을때 넘어갈 개수
				 * @return 페이징 문자열 반환
		 		 -->
                <% if (!collection.equals("ALL")) { %>
					<div class="btn_num">
							<%=wnsearch.getPageLinks(startCount , totalCount, COLLECTIONVIEWCOUNT, 10)%>
					</div>
				<% } %>
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
    </div>
</body>
</html>
<%
	if ( wnsearch != null ) {
		wnsearch.closeServer();
	}
%>