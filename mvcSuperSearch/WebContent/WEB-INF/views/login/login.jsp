<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<!-- TEST 임시 URL http://localhost:8080/classificatorManager/login/login.wn -->
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/bootstrap-sbadmin2/vendor/jquery/jquery.js"></script><!-- jquery load -->
  <script type="text/javascript" src="<%=request.getContextPath()%>/resources/alertifyjs/alertify.js"></script>
  <script src="<%=request.getContextPath()%>/resources/bootstrap-sbadmin2/vendor/jquery/jquery.min.js"></script><!-- Bootstrap core JavaScript-->
  <script src="<%=request.getContextPath()%>/resources/bootstrap-sbadmin2/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="<%=request.getContextPath()%>/resources/bootstrap-sbadmin2/vendor/jquery-easing/jquery.easing.min.js"></script><!-- Core plugin JavaScript-->
  <script src="<%=request.getContextPath()%>/resources/bootstrap-sbadmin2/js/sb-admin-2.min.js"></script><!-- Custom scripts for all pages-->
  <title>Classficator Manager - Login</title>
  <!-- Custom fonts, styles for this template-->
  <link href="<%=request.getContextPath()%>/resources/bootstrap-sbadmin2/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <link href="<%=request.getContextPath()%>/resources/bootstrap-sbadmin2/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">
  <div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 27rem;" src="<%= request.getContextPath()%>/resources/bootstrap-sbadmin2/img/wisenutcla.jpg" alt="Classficator Manage 로그인">
              
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Login</h1>
                  </div>
                  <form id="frm" name="frm" method="post">
                    <div class="form-group">
                      <input id="id" name="id" type="text" value="wisenut" class="form-control form-control-user" aria-describedby="emailHelp"  onkeypress="if( event.keyCode==13 ){fn_loginCheck(1);}" placeholder="Enter your login id...">
                    </div>
                    <div class="form-group">
                      <input id="pw" name="pw" type="password" value="wisenut1!" class="form-control form-control-user"  onkeypress="if( event.keyCode==13 ){fn_loginCheck(1);}" placeholder="Password">
                    </div>

                   	<a href="javascript:fn_loginCheck();" class="btn btn-primary btn-user btn-block" >
	                    <span class="text">Login</span>
                  	</a>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>

    </div>

  </div>



  <!-- Page Wrapper -->
      <!-- End of Main Content -->
	<script type="text/javascript">
		$(document).ready(function(){
			sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
		});
	
	//입력 초기화
	function fn_init(){
		$('#id').val(''); //ID
		$('#pw').val(''); //비번
		};

	//login Check
	function fn_loginCheck() {
		
		if ( $('#id').val().trim().length < 1 ) $('#id').focus();
		if ( $('#pw').val().trim().length < 1 ) $('#pw').focus();
		
		if( ($('#id').val().trim().length === 0) || ($('#pw').val().trim().length === 0) ) {
			alert("로그인 ID 또는 Password를 입력해야 합니다. \n "+ $('#id').val().trim()); /* alertify.error("로그인 ID를 입력해야 합니다."); */
			$('#pw').focus();
			return;
		}
		
		var sRedirectUrl = "<%=request.getContextPath()%>/login/login.wn";

		$.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/login/authLogin.wn",
			data : {	data: $('#frm').serialize(),
						id: $('#id').val(),
						pw: $('#pw').val(),
					}, 
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType : "json",

			success: function(data) {
				if(data.ok){

					/* alert(data.id + "님께서 로그인 하셨습니다. data.id"); */
					<%-- alert("<%=session.getAttribute("id")%>님께서 로그인 하셨습니다.  session.getAttribute loginUserId"); --%>
					location.href="'<%=request.getContextPath()%>'" + data.redirectUrl + "";
				}else {
					if(data.loginUserId==null || data.loginUserId.equals("")){                     // id가 Null 이거나 없을 경우
					}
					
					alert("ID 또는 비밀번호를 다시 한 번 더 확인 하시고 재 시도해 주시기 바랍니다."); /* alertify.error("문제가 발생하였습니다.") */
					location.href="<%=request.getContextPath()%>" + data.redirectUrl + "";
				}
				sRedirectUrl="<%=request.getContextPath()%>" + data.redirectUrl + "";
				//fn_init();

				
			},
			complete : function(data) {
				location.href=sRedirectUrl; //react...
			}
		})//ajax

	};//fn_loginCheck


  </script>
</body>
</html>