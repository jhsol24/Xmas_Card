<%@ page contentType="text/html; charset=UTF-8"%>

<%
    /*
     * subject: 검색 메인 페이지
     * @original author: SearchTool
     */

    /*
    
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
    if (!searchField.equals("")) {
		// 작성자
		if (!writer.equals("")) {
			exquery = "<WRITER:" + writer + ">";
		}
	} else {
		searchField = "ALL";
	}

    String[] collections = null;
    if(collection.equals("ALL")) { //통합검색인 경우
        collections = COLLECTIONS;
    } else {                        //개별검색인 경우
        collections = new String[] { collection };
    }

	if (reQuery.equals("1")) {
		realQuery = query + " " + realQuery;
	} else if (!reQuery.equals("2")) {
		realQuery = query;
	}

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
        if (!searchField.equals("") && !searchField.equals("WRITER") && searchField.indexOf("ALL") == -1 ) {
			wnsearch.setCollectionInfoValue(collections[i], SEARCH_FIELD, searchField);
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

    String thisCollection = "";
    if(useSuggestedQuery) {
       suggestQuery = wnsearch.suggestedQuery;
    } 
    
    */
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta content="IE=Edge" http-equiv="X-UA-Compatible" />
<title>통합검색</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/search/css/style.css" >
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/search/css/default.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/search/css/jquery-ui.css" >
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/search/ark/css/ark.css" media="screen" >
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/search/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/search/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/search/ark/js/beta.fix.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/search/ark/js/ark.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/search/js/datepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/search/js/search.js"></script><!--  검색관련 js -->
<script type="text/javascript">
<!--
$(document).ready(function() {
	// 기간 달력 설정
	$("#startDate").datepicker({dateFormat: "yy.mm.dd"});
	$("#endDate").datepicker({dateFormat: "yy.mm.dd"});

    getPopkeyword();
	// 내가 찾은 검색어
	<%-- getMyKeyword("<%=query%>", <%=totalCount%>); --%>
});


/* function getPopkeyword() {

	var target		= "popword";
	var range		= "D";
	var collection  = "_ALL_";
    var datatype   = "text";
	$.ajax({
	  type: "POST",
	  url: "./popword/popword.jsp",
	  dataType: datatype,
	  data: { "target" : target, "range" : range, "collection" : collection , "datatype" : datatype },
	  success: function(text) {
     text = trim(text);
     var xml = $.parseXML(text);
		var str = "<li class='tit'>";
		str += "<div class='timg'><img src='images/tit_popu.gif' alt='인기검색어' /></div>";
		str += "</li>";

		$(xml).find("Query").each(function(){
 			str += "<li class='ranking'>";
			str += "	<ul>";
			str += "		<li class='ranktxt'><img src='images/"+ $(this).attr("id")+".gif' alt='' /> <a href='#none' onclick=\"javascript:doKeyword('" + $(this).text() + "');\">" + $(this).text() + "</a></li>";
			str += "		<li class='rankico'>";

			if ($(this).attr("updown") == "U") {
				str += "<img src='images/ico_up.gif' alt='상승' />";
			} else if ($(this).attr("updown") == "D") {
				str += "<img src='images/ico_down.gif' alt='하락' />";
			} else if ($(this).attr("updown") == "N") {
				str += "<img src='images/ico_new.gif' alt='신규' />";
			} else if ($(this).attr("updown") == "C") {
				str += "-";
			}

			str += "		</li>";
			str += "		<li class='rankstep'>" + $(this).attr("count") + "</li>";
			str += "		";
			str += "	</ul>";
			str += "</li>";
		});

		$("#popword").html(str);
	  }
	});

} */

//-->

</script>

</head>
<body>
${colList}
    <div class="wrap">

        <!-- header -->
        <div class="header">
        
        	<form name="search" id="search" action="<%= request.getContextPath()%>/superSearch/getSearchList.wn" method="post">
			<input type="hidden" name="startCount" value="0" />
			<input type="hidden" name="sort" value="" />
			<input type="hidden" name="collection" value="" />
			<input type="hidden" name="range" value="" />
			<input type="hidden" name="startDate" value="" />
			<input type="hidden" name="endDate" value= ""/>			
			<input type="hidden" name="searchField"value="" />
			<input type="hidden" name="reQuery" />
			<input type="hidden" name="realQuery" value="" />
        	
            <div class="top clearfix">
				<h1><a href="" onClick="javascript:location.reload()"><img src="${pageContext.request.contextPath }/resources/search/images/logo.PNG" alt="대한지방행정공제회" /></a></h1>
				<div class="sch_wrap">
					<select>
						<option>통합검색</option>
					</select>
					<!-- <input type="text" value="제주"> -->
					<input name="query" id="query" type="text" value="" onKeypress="javascript:pressCheck((event),this);" autocomplete="off"/>
					<a href="#" class="btn_sch" onClick="javascript:doSearch();" title="검색"></a>
				</div>
				<a href="#" class="detail_btn">상세검색</a>
				<div class="sch_opt">
					<input type="checkbox" id="result_chk" checked="checked" />
					<label for="result_chk"><span></span>결과 내 재검색</label>
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
        </div>
        <!-- //header -->

        <!-- container -->
        <div class="container">
            <!-- leftArea -->
            <div class="leftArea">
                <ul class="lnb">
                    <li><a class="on" href="#">통합검색<span>(3,482)</span></a></li>
                    <li><a href="#">전자결재<span>(100)</span></a></li>
                    <li><a href="#">게시판<span>(100)</span></a></li>
                    <li><a href="#">지식<span>(100)</span></a></li>
                </ul>
                <div class="optionArea">
                    <dl class="align">
                        <dt>정렬</dt>
                        <dd class="divi on"><a href="">정확도</a></dd>
                        <dd class="divi"><a class="arr" href="">최신순</a></dd>
                    </dl>
                    <dl class="area">
                        <dt>검색범위</dt>
                        <dd class="divi on"><a href="">전체</a></dd>
                        <dd class="divi"><a href="">제목</a></dd>
                        <dd class="divi"><a href="">내용</a></dd>
                        <dd class="divi"><a href="">첨부</a></dd>
                    </dl>
                    <dl class="date">
                        <dt>검색기간</dt>
                        <dd class="divi on"><a href="">전체</a></dd>
                        <dd class="divi"><a href="">1주</a></dd>
                        <dd class="divi"><a href="">1달</a></dd>
                        <dd class="divi"><a href="">1년</a></dd>
                        <dd class="cal_box">
                            <span><input type="text" /><a href="#"><img src="${pageContext.request.contextPath }/resources/search/images/icon_day.gif" alt="달력" /></a></span>
                            <span><input type="text" /><a href="#"><img src="${pageContext.request.contextPath }/resources/search/images/icon_day.gif" alt="달력" /></a></span>
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
                    <ol>
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
                    </ol>
                </div>
                <div class="my_keyword">
                    <p>내가 찾은 검색어</p>
                    <ul>
                        <li><a href="">&middot; 전시</a>
                            <a class="btn_close" href="#"><img src="${pageContext.request.contextPath }/resources/search/images/icon_close.gif" alt="close"></a>
                        </li>
                        <li><a href="">&middot; 특별전</a>
                            <a class="btn_close" href="#"><img src="${pageContext.request.contextPath }/resources/search/images/icon_close.gif" alt="close"></a>
                        </li>
                    </ul>
                </div>
                <div class="my_keyword">
                    <p>최근 본 문서</p>
                    <ul>
                        <li><a href="" class="tit">&middot; 전시전시전시전시전시전시전시전시전시</a>
                            <a class="btn_close" href="#"><img src="${pageContext.request.contextPath }/resources/search/images/icon_close.gif" alt="close"></a>
                        </li>
                        <li><a href="" class="tit">&middot; 특별전</a>
                            <a class="btn_close" href="#"><img src="${pageContext.request.contextPath }/resources/search/images/icon_close.gif" alt="close"></a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- //rightArea -->
            <!-- contents -->
            <div class="contents">
                <div class="result_top">
                    <strong>'검색어'</strong>에 대한 검색결과는 총[3,482]건 입니다.
                </div>
                <div class="sectit01">
                    <h2>전자결재<span>(100)</span></h2>
                    <dl class="resultsty_1">
                        <dt>
							<a class="tit" href="#"><strong>전시</strong>실 정규해설</a>
                            <span>2017.08.20</span>
						</dt>
                        <dd>국립고궁박물관은 2008. 6. 1(일)부터 전시실 정규해설을 실시하고 있습니다. 상설<strong>전시</strong> 중인 조선의 국왕, 조선의 궁궐, 왕실의 생활 등 품격있는 왕실 문화 유물의 설명을 들으실 수 있습니다. 해설시작 시간 후 10분까지 참여 인원이 없을 경우 자동으로 취소됩니다. 한국어 전시해설 서비스는 2인 이상이어야</dd>
                        <dd class="cate">이용안내 &gt; 전시실</dd>
                    </dl>
                    <dl class="resultsty_1">
                        <dt>
							<a class="tit" href="#"><strong>전시</strong>실 정규해설</a>
                            <span>2017.08.20</span>
						</dt>
                        <dd>국립고궁박물관은 2008. 6. 1(일)부터 전시실 정규해설을 실시하고 있습니다. 상설<strong>전시</strong> 중인 조선의 국왕, 조선의 궁궐, 왕실의 생활 등 품격있는 왕실 문화 유물의 설명을 들으실 수 있습니다. 해설시작 시간 후 10분까지 참여 인원이 없을 경우 자동으로 취소됩니다. 한국어 전시해설 서비스는 2인 이상이어야</dd>
                        <dd class="cate">이용안내 &gt; 전시실</dd>
                    </dl>
                    <dl class="resultsty_1">
                        <dt>
							<a class="tit" href="#"><strong>전시</strong>실 정규해설</a>
                            <span>2017.08.20</span>
						</dt>
                        <dd>국립고궁박물관은 2008. 6. 1(일)부터 전시실 정규해설을 실시하고 있습니다. 상설<strong>전시</strong> 중인 조선의 국왕, 조선의 궁궐, 왕실의 생활 등 품격있는 왕실 문화 유물의 설명을 들으실 수 있습니다. 해설시작 시간 후 10분까지 참여 인원이 없을 경우 자동으로 취소됩니다. 한국어 전시해설 서비스는 2인 이상이어야</dd>
                        <dd class="cate">이용안내 &gt; 전시실</dd>
                    </dl>
                    <a class="section_more" href="#">더보기</a>
                </div>
                <div class="sectit01">
                    <h2>게시판<span>(100)</span></h2>
                    <dl class="resultsty_1">
                        <dt>
							<a class="tit" href="#"><strong>전시</strong>실 정규해설</a>
                            <span>2017.08.20</span>
						</dt>
                        <dd>국립고궁박물관은 2008. 6. 1(일)부터 전시실 정규해설을 실시하고 있습니다. 상설<strong>전시</strong> 중인 조선의 국왕, 조선의 궁궐, 왕실의 생활 등 품격있는 왕실 문화 유물의 설명을 들으실 수 있습니다. 해설시작 시간 후 10분까지 참여 인원이 없을 경우 자동으로 취소됩니다. 한국어 전시해설 서비스는 2인 이상이어야</dd>
                        <dd class="cate">이용안내 &gt; 전시실</dd>
                    </dl>
                    <dl class="resultsty_1">
                        <dt>
							<a class="tit" href="#"><strong>전시</strong>실 정규해설</a>
                            <span>2017.08.20</span>
						</dt>
                        
                        <dd class="cate">이용안내 &gt; 전시실</dd>
                    </dl>
                    <dl class="resultsty_1">
                        <dt>
							<a class="tit" href="#"><strong>전시</strong>실 정규해설</a>
                            <span>2017.08.20</span>
						</dt>
                        <dd>국립고궁박물관은 2008. 6. 1(일)부터 전시실 정규해설을 실시하고 있습니다. 상설<strong>전시</strong> 중인 조선의 국왕, 조선의 궁궐, 왕실의 생활 등 품격있는 왕실 문화 유물의 설명을 들으실 수 있습니다. 해설시작 시간 후 10분까지 참여 인원이 없을 경우 자동으로 취소됩니다. 한국어 전시해설 서비스는 2인 이상이어야</dd>
                        <dd class="cate">이용안내 &gt; 전시실</dd>
                    </dl>
                    <a class="section_more" href="#">더보기</a>
                </div>
                <div class="btn_num">
                    <a class="num" href="#">&lt;&lt;</a>
                    <a class="num" href="#">&lt;</a>
                    <a class="num click " href="#">1</a>
                    <a class="num" href="#">2</a>
                    <a class="num" href="#">3</a>
                    <a class="num" href="#">4</a>
                    <a class="num" href="#">5</a>
                    <a class="num" href="#">6</a>
                    <a class="num" href="#">7</a>
                    <a class="num" href="#">8</a>
                    <a class="num" href="#">9</a>
                    <a class="num" href="#">10</a>
                    <a class="num" href="#">&gt;</a>
                    <a class="num" href="#">&gt;&gt;</a>
                </div>
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
    </div>
</body>
</html>
<%-- <%
	if ( wnsearch != null ) {
		wnsearch.closeServer();
	}
%> --%>