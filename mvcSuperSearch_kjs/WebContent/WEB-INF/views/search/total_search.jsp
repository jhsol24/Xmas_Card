<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta content="IE=Edge" http-equiv="X-UA-Compatible" />
<title>통합검색</title>
 <c:set var="context" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" type="text/css" href="${context }/resources/search/css/style.css">
<link rel="stylesheet" type="text/css" href="${context }/resources/search/css/default.css">
<link rel="stylesheet" type="text/css" href="${context }/resources/search/css/jquery-ui.css" >
<link rel="stylesheet" type="text/css" href="${context }/resources/search/ark/css/ark.css" media="screen" >
<script type="text/javascript" src="${context }/resources/search/js/jquery.min.js"></script>
<script type="text/javascript" src="${context }/resources/search/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${context }/resources/search/ark/js/beta.fix.js"></script>
<script type="text/javascript" src="${context }/resources/search/ark/js/ark.js"></script>
<script type="text/javascript" src="${context }/resources/search/js/datepicker.js"></script>
<script type="text/javascript" src="${context }/resources/search/js/search.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	// 기간 달력 설정
	alert("hi");
	$("#startDate").datepicker({dateFormat: "yy.mm.dd"});
	$("#endDate").datepicker({dateFormat: "yy.mm.dd"});
	alert("hi");
 
	// 내가 찾은 검색어
	getMyKeyword($("#query").value, $("#totalCount").value);
	alert("getmykeyword 돌았따");
});


function popup(content){
	var root=$(".rootPath").value;
	alert(root);
	var startCount=$(".startCount").value;
	var sort=$(".sort").value;
	alert(sort);
	var collection=$(".collection").value;
	var range=$(".range").value;
	var startDate=$(".startDate").value;
	var endDate=$(".endDate").value;
	var searchField=$(".searchField").value;
	var reQuery=$(".reQuery").value;
	var realQuery=$(".realQuery").value;
	var realQuery=$(".query").value;

    var url = "${context}/superSearch/idesk_recco.wn?content="+content;
    var name = "popup test";
    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
    window.open( "${context}/superSearch/idesk_recco.wn?content="+content, "popup test", "width = 500, height = 500, top = 100, left = 200, location = no");
}

</script>

</head>

<body>
    <div class="wrap">
    

  ${colList }
  <br>
       
        <!-- header -->
        <div class="header">
        <form name="search" id="search" action="${context }/superSearch/getSearch.wn" method="get">
		<input type="hidden"   class="startCount" name="startCount" value="0">
		<input type="hidden"   class="sort" name="sort" value="${colList.sort }">
		<input type="hidden"   class="collection"name="collection" value="${colList.collection}">
		<input type="hidden"   class="range"name="range" value="${colList.range}">
		<input type="hidden"   class="startDate" name="startDate" value="${colList.startDate }">
		<input type="hidden"   class="endDate"name="endDate"value="${colList.endDate }">
		<input type="hidden"   class="searchField"name="searchField"value="${colList.searchField }">
		<input type="hidden"   class="reQuery"name="reQuery" />
		<input type="hidden"   class="realQuery"name="realQuery" value="${colList.realQuery}">
		
            <div class="top clearfix"> 
            
				<h1><a href="#"><img src="${context }/resources/search/images/logo.PNG" alt="대한지방행정공제회" /></a></h1>
				
				<div class="sch_wrap">
				<select>
					<option>통합검색</option>
					</select>
						<input name="query" class="query" id="query" type="text" value="${colList.query}" onKeypress="javascript:pressCheck((event),this);" autocomplete="off"/>
	
					 <a href="#"    class="btn_sch"  onClick="javascript:doSearch();" title="검색"> </a>
				</div>
				
				 <a href="#"   class="detail_btn" onClick="javascript:doSearch();" title="상세검색" style="float: left;">상세검색</a></li>
				
				<div class="sch_opt">
					<!-- <input type="checkbox" id="result_chk" checked="checked" /> -->
					<input name="reChk" id="result_chk"   onClick="checkReSearch();" type="checkbox" /><label for="result_chk">결과 내 재검색</label>
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
                
                    <li><a class="on" href="#" onClick="javascript:doCollection('ALL');">통합검색<span>(${colList.totalCount })</span></a></li>
                     <li><a class="on" href="#" onClick="javascript:doCollection('${colList.collections[0] }');">dctn<span>(${colList.dctn.DocumentSet.collectionCount })</span></a></li>
                      <li><a class="on" href="#" onClick="javascript:doCollection('${colList.collections[1]  }');">doc<span>(${colList.doc.DocumentSet.collectionCount })</span></a></li>
                       <li><a class="on" href="#" onClick="javascript:doCollection('${colList.collections[2]  }');">info<span>(${colList.info.DocumentSet.collectionCount })</span></a></li>
                       <li><a class="on" href="#" onClick="javascript:doCollection('${colList.collections[3]  }');">law<span>(${colList.law.DocumentSet.collectionCount })</span></a></li>
            	<%-- <c:forEach begin="0" end="3" var="i">
            	   ${colList.${collections[i]}.DocumentSet.collectionCount  }
            
            	</c:forEach>
             --%>
                </ul>
               
                <div class="optionArea">
                    <dl class="align">
                        <dt>정렬</dt>
                        <c:choose>
                        <c:when test="${colList.condition.sort eq 'RANK' }">
                        <dd  class="divi on" onclick="doSorting('RANK');"><a href="#">정확도</a></dd>
                        <a onclick=""></a>
                        </c:when>
                        <c:otherwise>
                         <dd  class="divi" onclick="doSorting('RANK');"><a href="#">정확도</a></dd>
                        </c:otherwise>
                        </c:choose>
                        
                        <c:choose>
                        <c:when test="${colList.condition.sort eq 'DATE' }">
                        <dd  class="divi on" onclick="doSorting('DATE');"><a class="arr" href="#">최신순</a></dd>
                        </c:when>
                        <c:otherwise>
                         <dd  class="divi" onclick="doSorting('DATE');"><a class="arr" href="#">최신순</a></dd>
                        </c:otherwise>
                        </c:choose>
                       
                    </dl>
                    
                    <dl class="area">
                        <dt>검색범위</dt>
                       
                        <c:choose>
                        <c:when test="${colList.condition.searchField eq 'ALL' }">
                        <dd  class="divi on" onclick="doSearchField('ALL');"><a href="#">전체</a></dd>
                        </c:when>
                        <c:otherwise>
                         <dd  class="divi" onclick="doSearchField('ALL');"><a href="#">전체</a></dd>
                        </c:otherwise>
                        </c:choose>
                        
                       
                         <c:choose>
                        <c:when test="${colList.condition.searchField eq 'TITLE' }">
                        <dd  class="divi on" onclick="doSearchField('TITLE');"><a href="#">제목</a></dd>
                        </c:when>
                        <c:otherwise>
                         <dd  class="divi" onclick="doSearchField('TITLE');"><a href="#">제목</a></dd>
                        </c:otherwise>
                        </c:choose>
                        
                        
                         <c:choose>
                        <c:when test="${colList.condition.searchField eq 'CONTENT' }">
                        <dd  class="divi on" onclick="doSearchField('CONTENT');"><a href="#">내용</a></dd>
                        </c:when>
                        <c:otherwise>
                         <dd  class="divi" onclick="doSearchField('CONTENT');"><a href="#">내용</a></dd>
                        </c:otherwise>
                        </c:choose>
                        
                      
                        <c:choose>
                        <c:when test="${colList.condition.searchField eq 'ATTACHCON' }">
                        <dd  class="divi on" onclick="doSearchField('ATTACHCON');"><a href="#">첨부</a></dd>
                        </c:when>
                        <c:otherwise>
                        <dd  class="divi" onclick="doSearchField('ATTACHCON');"><a href="#">첨부</a></dd>
                        </c:otherwise>
                        </c:choose>
                   
                        
                    </dl>
                    <dl class="date">
                        <dt>검색기간</dt>
                      
                        <c:choose>
                        <c:when test="${colList.condtion.range eq 'A' }">
                         <dd class="divion"><a href="#none" onClick="javascript:setDate('A');">전체</a></dd>
                        </c:when>
                        <c:otherwise>
                          <dd class="divi"><a href="#none" onClick="javascript:setDate('A');">전체</a></dd>
                        </c:otherwise>
                        </c:choose>
                        
                          <c:choose>
                        <c:when test="${colList.condtion.range eq 'W' }">
                         <dd class="divion"><a href="#none" onClick="javascript:setDate('W');">1주</a></dd>
                        </c:when>
                        <c:otherwise>
                          <dd class="divi"><a href="#none" onClick="javascript:setDate('W');">1주</a></dd>
                        </c:otherwise>
                        </c:choose>
                        
                          <c:choose>
                        <c:when test="${colList.condtion.range eq 'M' }">
                         <dd class="divion"><a href="#none" onClick="javascript:setDate('M');">1달</a></dd>
                        </c:when>
                        <c:otherwise>
                          <dd class="divi"><a href="#none" onClick="javascript:setDate('M');">1달</a></dd>
                        </c:otherwise>
                        </c:choose>
                        
                          <c:choose>
                        <c:when test="${colList.condtion.range eq 'Y' }">
                         <dd class="divion"><a href="#none" onClick="javascript:setDate('Y');">1년</a></dd>
                        </c:when>
                        <c:otherwise>
                          <dd class="divi"><a href="#none" onClick="javascript:setDate('Y');">1년</a></dd>
                        </c:otherwise>
                        </c:choose>
                        
                       
                        <dd class="cal_box">
                            <span><input name="startDate" id="startDate" type="text" value="${colList.condtion.startDate}" readonly="true"/><a href="#"><img src="${context }/resources/search/images/icon_day.gif" alt="달력" /></a></span>
                            <span><input name="endDate" id="endDate" type="text" value="${colList.condtion.endDate }" readonly="true"/><a href="#"><img src="${context }/resources/search/images/icon_day.gif" alt="달력" /></a></span>
                        	<input type="hidden"  id="totalCount" name="totalCount" value="${colList.totalCount }">
                        	 <input type="hidden" name="range" id="range" value="${colList.condtion.range}"/>
                      		<dd><a href="#" class="align_btn" onClick="javascript:doRange();">검색</a></dd>
                        </dd>
                          
                    </dl>
                </div>
            </div>
            
            	           
            <!-- //leftArea -->
            <!-- rightArea -->
            <div class="rightArea">
                <div class="rank">
                    <p>인기검색어</p>
                    <ol>
                    <c:forEach items="${colList.popwordWeek }" var="row" >
                        <li><span class="rank_num0">${row.id}</span><a href="">${row.content}</a>
 						
 						<c:choose>
						<c:when test="${row.updown eq 'U'}">
						<span class="rank_up">${row.count}</span>
						</c:when>

						<c:when test="${row.updown eq 'D'}">
						<span class="rank_down">${row.count}</span>
						</c:when>

						<c:when test="${row.updown eq 'N'}">
 						<span class="rank_new">NEW</span>
						</c:when>

						<c:when test="${row.updown eq 'C'}">
 						<span class="rank_stay">-</span>
						</c:when>
						<c:otherwise>-</c:otherwise>
 						</c:choose>
 						
 						</li>
                        </c:forEach>
                    
                     </ol>
                    
                
                   
                    
                </div>
                <div class="my_keyword">
                    <p>내가 찾은 검색어</p>
                    <ul id="mykeyword">
                        
                    </ul>
                </div>
                <div class="my_keyword">
                    <p>최근 본 문서</p>
                    <ul>
                        <li>보류</li>
                    </ul>
                </div>
            </div>
            <!-- //rightArea -->
            <!-- contents -->
            <div class="contents">
                <div class="result_top">
                    <strong>
                    <c:choose>
                    <c:when test="${colList.condition.query ne null }">
                     <strong>${colList.condition.query }</strong>에 대한 검색결과는 총[${colList.totalCount }]건 입니다.
                    </c:when>
                    <c:otherwise>
                      검색결과는 총[${colList.totalCount }]건 입니다.
                    </c:otherwise>
                    </c:choose>
                </div>
                
                
                <!-- dctn컬렉션 들어올 부분. -->
    
                <!-- 이부분에 include하먄 된다. -->
                
                
                <div class="sectit01"> <!-- 이부분을 dctn으로그대로 가져간다. 이양식으로 포문돌려야하니깐. -->
                    <h2>dctn<span>${colList.dctn.DocumentSet.collectionCount}</span></h2>

                     <%@ include file="./result/result_dctn_js.jsp" %>
                     <!--include 말고 c:import 가 있구나! -->
                   <%--   <c:import url="">
                     <c:param name=""></c:param>
                     </c:import> --%>
                </div>
                
                   <div class="sectit01"> <!-- 이부분을 dctn으로그대로 가져간다. 이양식으로 포문돌려야하니깐. -->
                    <h2>doc<span>${colList.doc.DocumentSet.collectionCount}</span></h2>
    				
    				 <%@ include file="./result/result_doc_js.jsp" %>

                </div>
               
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
    </div>
</body>
</html>
