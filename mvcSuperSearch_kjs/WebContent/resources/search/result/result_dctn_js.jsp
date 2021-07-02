<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html >
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>result_dcnt_js</title>
</head>
<body>
<input type="hidden" name="collection" value="dctn">
   <c:choose>
				  <c:when test="${colList.moresee eq false}">
				  hi:${colList.TOTAL_VIEW_COUNT }
				       <c:forEach items="${colList.dctn.Document }" var="row" begin="0" end="${colList.TOTAL_VIEW_COUNT }">
                      
                        <dl class="resultsty_1">
                            <dt>
				    			<a class="tit" href="#">${row.HDWD_NM }</a>
                                <span>${date }</span>
				    		</dt>
                            <dd>${row.TMNL_DEF }</dd>
                            <dd class="cate">${row.TERMS }</dd>
                        </dl>
                        </c:forEach>
    
                 
                      <fmt:parseNumber var = "i" integerOnly = "true"   type = "number" value = "${colList.dctn.DocumentSet.collectionCount}" />
                      <fmt:parseNumber var = "j" integerOnly = "true"   type = "number" value = "${colList.condition.TOTAL_VIEW_COUNT  }" />
                     
                      
                      
                       <c:choose>
                       <c:when test="${colList.condition.collection eq 'ALL'     && i gt j }">
                       <a class="section_more" href="#" onClick="javascript:doCollection('dctn','moresee');">더보기</a>
                       </c:when>
                       
                       </c:choose>
				      
				  </c:when>
				  <c:otherwise>
				  여기 ,${colList.COLLECTION_VIEW_COUNT }
				  ${colList.dctn.Document }
                      <c:forEach items="${colList.dctn.Document }" var="row" begin="0" end="${colList.COLLECTION_VIEW_COUNT }">
                    
                       <dl class="resultsty_1">
                          <dt>
				      		<a class="tit" href="#">${row.HDWD_NM }</a>
                              <span>${date }</span>
				      	</dt>
                          <dd>${row.TMNL_DEF }</dd>
                          <dd class="cate">${row.TERMS }</dd>
                       </dl>
                       </c:forEach>
                   	  
                   	  <!--변수설정  -->
                   	   <fmt:parseNumber var = "i" integerOnly = "true"   type = "number" value = "${colList.dctn.DocumentSet.collectionCount}" />
                       <fmt:parseNumber var = "j" integerOnly = "true"   type = "number" value = "${colList.condition.TOTAL_VIEW_COUNT  }" />
                  
    					<c:if test="${colList.condition.collection ne 'ALL' && i gt j }">
                         <div >
                            ${colList.pageLink}
                          
					     </div>
                        </c:if>
                  </c:otherwise>
				  </c:choose>
</body>
</html>