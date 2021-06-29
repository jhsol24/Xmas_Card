<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Classficator Manager</title>

<!-- alertify -->
<link
	href="${pageContext.request.contextPath }/resources/alertifyjs/css/alertify.min.css"
	rel="stylesheet">

<!-- alertify -->
<script
	src="${pageContext.request.contextPath }/resources/alertifyjs/alertify.min.js"></script>

<!-- Bootstrap Core CSS -->
<link
	href="${pageContext.request.contextPath }/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link
	href="${pageContext.request.contextPath }/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link
	href="${pageContext.request.contextPath }/resources/dist/css/sb-admin-2.css"
	rel="stylesheet">

<!-- Morris Charts CSS -->
<link
	href="${pageContext.request.contextPath }/resources/vendor/morrisjs/morris.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="${pageContext.request.contextPath }/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

	<div class="navbar-default sidebar" role="navigation">
		<div class="sidebar-nav navbar-collapse">
			<ul class="nav" id="side-menu">
				<li><a href="<c:url value="/main.wn" />"><i
						class="fa fa-dashboard fa-fw"></i> Dashboard</a></li>
				<li><a href="#"><i class="fa fa-tasks fa-fw"></i>서버<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="<c:url value="/server/serverMove.wn" />">서버관리</a>
						</li>
						<%-- <li><a href="<c:url value="/training?classificatorNum=1" />">학습데이터</a>
						</li> --%>
					</ul>
				</li>
				<li><a href="#"><i class="fa fa-list-alt fa-fw"></i>자동분류 관리<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="<c:url value="/act/actMove.wn" />">시뮬레이터</a>
						</li>
						<%-- <li><a href="<c:url value="/training?classificatorNum=1" />">학습데이터</a>
						</li> --%>
					</ul>
				</li>
				<%-- <li><a href="#"><i class="fa fa-table fa-fw"></i> 웹뉴스<span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a
							href="<c:url value="/config/bicanalyzer?classificatorNum=2" />">분석기 관리</a></li>
						<li><a href="#" />분석기 설정정보<span class="fa arrow"></span></a>
							<ul class="nav nav-third-level">
								<li><a
									href="<c:url value="/configData/usernoun?classificatorNum=2" />">형태소분석사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/stopwords?classificatorNum=2" />">배제어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/wordSynonyms?classificatorNum=2" />">형태소동의어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/stringSynonyms?classificatorNum=2" />">동의어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/concepts?classificatorNum=2" />">단어개념</a>
								</li>
								<li><a
									href="<c:url value="/configData/combination?classificatorNum=2" />">분석결과
										문자조합</a></li>
								<li><a
									href="<c:url value="/configData/partialOrder?classificatorNum=2" />">분석결과
										문자열 순서</a></li>
								<li><a
									href="<c:url value="/configData/parameters?classificatorNum=2" />">파라미터</a>
								</li>
							</ul></li>
						<li><a href="<c:url value="/training?classificatorNum=2" />">학습데이터</a>
						</li>
					</ul></li>
				<li><a href="#"><i class="fa fa-table fa-fw"></i> 연합뉴스<span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a
							href="<c:url value="/config/bicanalyzer?classificatorNum=3" />">분석기
								관리</a></li>
						<li><a href="#">분석기 설정정보<span class="fa arrow"></span></a>
							<ul class="nav nav-third-level">
								<li><a
									href="<c:url value="/configData/usernoun?classificatorNum=3" />">형태소분석사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/stopwords?classificatorNum=3" />">배제어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/wordSynonyms?classificatorNum=3" />">형태소동의어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/stringSynonyms?classificatorNum=3" />">동의어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/concepts?classificatorNum=3" />">단어개념</a>
								</li>
								<li><a
									href="<c:url value="/configData/combination?classificatorNum=3" />">분석결과
										문자조합</a></li>
								<li><a
									href="<c:url value="/configData/partialOrder?classificatorNum=3" />">분석결과
										문자열 순서</a></li>
								<li><a
									href="<c:url value="/configData/parameters?classificatorNum=3" />">파라미터</a>
								</li>
							</ul></li>
						<li><a href="<c:url value="/training?classificatorNum=3" />">학습데이터</a>
						</li>
					</ul></li>
				<li><a href="#"><i class="fa fa-table fa-fw"></i> 웹감정분석<span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a
							href="<c:url value="/config/bicanalyzer?classificatorNum=4" />">분석기
								관리</a></li>
						<li><a href="#">분석기 설정정보<span class="fa arrow"></span></a>
							<ul class="nav nav-third-level">
								<li><a
									href="<c:url value="/configData/usernoun?classificatorNum=4" />">형태소분석사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/stopwords?classificatorNum=4" />">배제어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/wordSynonyms?classificatorNum=4" />">형태소동의어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/stringSynonyms?classificatorNum=4" />">동의어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/concepts?classificatorNum=4" />">단어개념</a>
								</li>
								<li><a
									href="<c:url value="/configData/combination?classificatorNum=4" />">분석결과
										문자조합</a></li>
								<li><a
									href="<c:url value="/configData/partialOrder?classificatorNum=4" />">분석결과
										문자열 순서</a></li>
								<li><a
									href="<c:url value="/configData/parameters?classificatorNum=4" />">파라미터</a>
								</li>
							</ul></li>
						<li><a href="<c:url value="/training?classificatorNum=4" />">학습데이터</a>
						</li>
					</ul></li>
				<li><a href="#"><i class="fa fa-table fa-fw"></i> 연합감정분석<span
						class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a
							href="<c:url value="/config/bicanalyzer?classificatorNum=5" />">분석기
								관리</a></li>
						<li><a href="#">분석기 설정정보<span class="fa arrow"></span></a>
							<ul class="nav nav-third-level">
								<li><a
									href="<c:url value="/configData/usernoun?classificatorNum=5" />">형태소분석사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/stopwords?classificatorNum=5" />">배제어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/wordSynonyms?classificatorNum=5" />">형태소동의어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/stringSynonyms?classificatorNum=5" />">동의어사전</a>
								</li>
								<li><a
									href="<c:url value="/configData/concepts?classificatorNum=5" />">단어개념</a>
								</li>
								<li><a
									href="<c:url value="/configData/combination?classificatorNum=5" />">분석결과
										문자조합</a></li>
								<li><a
									href="<c:url value="/configData/partialOrder?classificatorNum=5" />">분석결과
										문자열 순서</a></li>
								<li><a
									href="<c:url value="/configData/parameters?classificatorNum=5" />">파라미터</a>
								</li>
							</ul></li>
						<li><a href="<c:url value="/training?classificatorNum=5" />">학습데이터</a>
						</li>
					</ul></li> --%>
			</ul>
		</div>
		<!-- /.sidebar-collapse -->
	</div>

	<!-- jQuery -->
	<script
		src="${pageContext.request.contextPath }/resources/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script
		src="${pageContext.request.contextPath }/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script
		src="${pageContext.request.contextPath }/resources/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Morris Charts JavaScript -->
	<script
		src="${pageContext.request.contextPath }/resources/vendor/raphael/raphael.min.js"></script>
	<%--     <script src="${pageContext.request.contextPath }/resources/vendor/morrisjs/morris.min.js"></script> --%>
	<%--     <script src="${pageContext.request.contextPath }/resources/data/morris-data.js"></script> --%>

	<!-- Custom Theme JavaScript -->
	<script
		src="${pageContext.request.contextPath }/resources/dist/js/sb-admin-2.js"></script>

</body>

</html>
