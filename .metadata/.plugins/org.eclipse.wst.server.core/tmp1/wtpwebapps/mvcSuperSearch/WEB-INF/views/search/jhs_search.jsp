<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

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
</head>

<body>
    <div class="wrap">
		${colList}
        <!-- header -->
        <div class="header">
        
        	<form name="search" id="search" action="${pageContext.request.contextPath }/superSearch/getSearchList.wn" method="get">
			<input type="hidden" name="startCount" value="${colList.condition.startCount}" />
			<input type="hidden" name="sort" value="${colList.condition.sort}" />
			<input type="hidden" name="collection" value="${colList.condition.collection}" />
			<input type="hidden" name="range" value="${colList.condition.startCount}" />
			<input type="hidden" name="startDate" value="${colList.condition.startDate}" />
			<input type="hidden" name="endDate" value= "${colList.condition.endDate}"/>			
			<input type="hidden" name="searchField"value="${colList.condition.searchField}" />
			<input type="hidden" name="reQuery" />
			<input type="hidden" name="realQuery" value="${colList.condition.realQuery}" />
        	
        
            <div class="top clearfix">
				<h1><a href="#"><img src="${pageContext.request.contextPath }/resources/search/images/logo.PNG" alt="대한지방행정공제회" /></a></h1>
				<div class="sch_wrap">
					<select>
						<option>통합검색</option>
					</select>
					
					<input name="query" id="query" type="text" value="" onKeypress="javascript:pressCheck((event),this);" autocomplete="off"/>
					
					<!-- 검색 버튼 부분 -->
					<input type="submit" class="btn_sch" title="검색"/>
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
			</form>
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
                    <h2>dctn<span>(${colList.dctn.DocumentSet.collectionCount})</span></h2>
                     <c:forEach items="${colList.dctn.Document }" var="dctn" varStatus="status">
	                     <c:import url="./result/res_dctn.jsp">
		                     <c:param name="HDWD_NM" value="${dctn.HDWD_NM }"></c:param>
		                     <c:param name="DATE" value="${dctn.DATE }"></c:param>
		                     <c:param name="TMNL_DEF" value="${dctn.TMNL_DEF }"></c:param>
                     </c:import>
                     </c:forEach>
                     	
                    
                </div>
                <div class="sectit01">
                    <h2>doc<span>(${colList.doc.DocumentSet.collectionCount})</span></h2>
                    
                    <!-- result_doc 불러오기 -->
                    
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