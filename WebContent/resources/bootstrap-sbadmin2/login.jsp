<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

 <!DOCTYPE html>
<!-- <html lang="ko"> -->
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  <title>Classficator Manager - Login</title>
  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin-2.min.css" rel="stylesheet">
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
              <!-- <div class="col-lg-6 d-none d-lg-block bg-login-image"></div> -->
              <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 27rem;" src="img/wisenutcla.jpg" alt="안전생활불편통합신고시스템 관리도구 로그인">
              
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">login</h1>
                  </div>
                  <form class="user">
                    <div class="form-group">
                      <input type="email" class="form-control form-control-user" id="exampleInputEmail" aria-describedby="emailHelp" placeholder="Enter your login id...">
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" id="exampleInputPassword" placeholder="Password">
                    </div>
                    <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck">
                        <label class="custom-control-label" for="customCheck">Remember Me</label>
                      </div>
                    </div>
                    <a href="index.html" class="btn btn-primary btn-user btn-block">
                      Login
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

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>











  <!-- Page Wrapper -->
      <!-- End of Main Content -->
	<script src="${pageContext.request.contextPath }/resources/vendor/jquery/jquery-ui-1.12.1/jquery.maskip-1.1.1.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
		var p_page_num = $('#pageNum').val();		
		if(p_page_num == ""){
			fn_getList("1");
		}else{
			fn_getList(p_page_num);
		}
		
		$('#query').on("keypress",function(){
			if(event.keyCode == '13') event.preventDefault();
		})
		
		$('#cfsv_ip').maskip({"type":"ip"});
		
	});
	
	
	function fn_init(){
		$('#cfsv_id').val(''); //서버ID
		$('#cfsv_nm').val(''); //서버명
		$('#cfsv_ip').val(''); //서버IP
		$('#cfsv_port').val(''); //서버PORT
		$('#cfsv_std_indir').val(''); //학습파일 경로
		$('#cfsv_desc').val(''); //서버설명
		$('#cfsv_stat').val('C');//C/U
		$('#th_checkAll').prop("checked",false); //서버 목록(dataTable).헤더
	}
	
	function fn_saveServer() {
		
		if (!fn_saveCheck($('#cfsv_ip'))||!fn_saveCheck($('#cfsv_port'))||!fn_saveCheck($('#cfsv_nm'))||!fn_saveCheck($('#cfsv_std_indir'))||!fn_saveCheck($('#cfsv_desc')) ) return false;
		alertify.confirm("저장 하시겠습니까?"
		, function() {
			$.ajax({
				type : "post",
				url : "<%= request.getContextPath()%>/server/saveServer.wn",
				data : $('#frm').serialize(),
				dataType : "json",

				success : function(data) {
					alertify.success('저장 되었습니다.');
				},
				complete : function(data) {
					fn_getList("1");
				},
				error : function(request, status, error) {
					alertify.error("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});
		}, function() {
			alertify.error('취소 하였습니다.');
		});
	}

	function fn_deleteServer(){
		
		var checkItems = new Array();
        $("input[name='checkbox']:checked").each(function() {checkItems.push($(this).val());});
        
 		$('#d_cfsv_id').val(checkItems.join(","));
		
		alertify.confirm("삭제 하시겠습니까?"
				, function() {
					$.ajax({
						type : "post",
						url : "<%= request.getContextPath()%>/server/deleteServer.wn",
						data : $('#frm').serialize(),
						dataType : "json",

						success : function(data) {
							alertify.success('삭제 되었습니다.');	
						},
						complete : function(data) {
							fn_getList("1");
						},
						error : function(request, status, error) {
							alertify.error("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
						
					});
				}, function() {
					alertify.error('취소 하였습니다.');
				}
		);

	};
	
	function fn_showDetail(id){
		
		$('#p_cfsv_id').val(id);
		$('#cfsv_stat').val('U');
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/server/getDetail.wn",
			data : $('#frm_search').serialize(),
			dataType : "json",

			success : function(data) {
				
				var vo = data.serverVo;
				
				$('#cfsv_id').val(vo.cfsv_id);
				$('#cfsv_nm').val(vo.cfsv_nm);
				$('#cfsv_ip').val(vo.cfsv_ip);
				$('#cfsv_port').val(vo.cfsv_port);
				$('#cfsv_std_indir').val(vo.cfsv_std_indir);
				$('#cfsv_anal_indir').val(vo.cfsv_anal_indir);
				$('#cfsv_anal_outdir').val(vo.cfsv_anal_outdir);

				$('#cfsv_desc').val(vo.cfsv_desc);
				
			},
			
			complete : function(data) {
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
	}
	
	
	function fn_getList(pageNum) {
		
		$('#frm_card_body').oLoader({
		      backgroundColor:'#4e73df',
		      fadeInTime: 500,
		      fadeOutTime: 1000,
		      fadeLevel: 0.5
		});
		
		$('#pagination > li').remove();
		$('#pageNum').val(pageNum);

		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/server/getList.wn",
			data : $('#frm_search').serialize(),
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType : "json",

			success : function(data) {

				var list = data.list;
				var table = "";
				var cnt = 0;
				
				if(Object.keys(list).length > 0){
					$.each(list, function(key, value) {
						cnt++;
						table += '<tr style="font-size:0.8rem; line-height:10px">';
						table += '<td align="center"><input type="checkbox" name="checkbox" value=\'' + this.cfsv_id + '\' /></td>'
						table += '<td><a href="javascript:fn_showDetail(\'' + this.cfsv_id + '\');" >';
						table += this.cfsv_id;
						table += "</a></td>";
						table += '<td><a href="javascript:fn_showDetail(\'' + this.cfsv_id + '\');" >';
						table +=  this.cfsv_ip + '</a></td>'
						+ '<td><a href="javascript:fn_showDetail(\'' + this.cfsv_id + '\');" >'+ this.cfsv_port + '</a></td>'
						+ '<td><a href="javascript:fn_showDetail(\'' + this.cfsv_id + '\');" >'+ this.cfsv_nm + '</a></td></tr>';
					})
					
					$('#tb_list').html(table);
					$('#pagination').html(data.pageCode);
					$('#dataTable_info').html("total : " + data.totalCount + "");
					
				}else{
					$('#tb_list').html('<tr><td colspan="4" align="center">데이터가 존재 하지 않습니다.</td></tr>');
				}

				fn_init();
				
			},
			complete : function(data) {
				
				fn_showDetail($('input[name=checkbox]:eq(0)').val());
				$('#frm_card_body').oLoader('hide');
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		
		});
		
	}
	
	
	/* 저장 진전에 입력 항목의 길이 체크 알림*/
	function fn_saveCheck(ob) {
		if ( ob.val().length < ob.attr('minlength') || ob.val().length > ob.attr('maxlength') ) {
			alertify.error( "입력 항목 길이 체크 오류 : <br>" + ob.attr('minlength') + '자 이상 ' + ob.attr('maxlength') + '자 이하로 입력해야 합니다. <br>' + ob.attr('placeholder') );
			ob.focus();
			return false;
		}
		return true;
	}
	
	/* 입력 항목에 키 입력시 길이 제한 (자동 삭제) */
    function fn_maxLengthCheck(ob) {
		
		if (ob.value.trim().length > ob.maxLength){
			ob.value = ob.value.slice(0, ob.maxLength);
			ob.value = ob.value.replace(/^\s+|\s+$/g,"");
			ob.value = ob.val().replace(/ /gi, '');
		}
	
	}

	/* 입력 항목에 키 입력시 2Bytes(한글) 고려하여 글자수 계산. */
	function fn_inputLengthCheck2B(eventInput){
		var inputText = $(eventInput).val();
		var inputMaxLength = $(eventInput).prop("maxlength");
		var j = 0;
		var count = 0;
		for(var i =0; i < inputText.length; i++){
			val = escape(inputText.charAt(i)).length;
			if(val == 6){ j++;//2B
			}
			j++;
			if(j <= inputMaxLength){
				count++;
			}
		}
		if(j > inputMaxLength){
				$(eventInput).val(inputText.substr(0, count));	//count:273 j:501 i:274 
		}
	}
	

  </script>
</body>
</html>