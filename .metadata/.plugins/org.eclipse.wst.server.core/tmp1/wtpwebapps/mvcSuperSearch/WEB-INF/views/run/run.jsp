<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">


<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Classficator Manager</title>

  
  
</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

<%@ include file="../common/sideBar.jsp"%>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        
        <%@ include file="../common/top.jsp"%>
        
        <!-- Begin Page Content -->
        <div class="container-fluid">
		  	<div class="d-sm-flex align-items-center justify-content-between mb-4">
            	<h1 class="h5 mb-0 text-gray-800 font-weight-bold">| 실행관리 > 학습실행/분석실행  </h1>
          	</div>
			<div class="row">
	            <!-- Earnings (Monthly) Card Example -->
	            <div class="col-xl-6 mb-4" id="frm_body">
		              <!-- Basic Card Example -->
		              <div class="card shadow mb-4">
			                <div class="card-header py-3">
			                  	<div class="row">
				                	<div class="col-lg-8">
				                  		<h6 class="m-0 font-weight-bold text-primary">* 대용량 엑셀 분석 실행</h6>
				                  	</div>
													<div class="col-lg-4" style="text-align:right">
									</div>
								</div>
			                </div>
			                <form id="frm" name="frm" method="post">
			                	<input type="hidden" id="cfsv_stat" name="cfsv_stat" value="C" >
			                <div class="card-body">
									<div class="form-group has-error row">
											<div class="col-lg-3 mb-2 m-auto" ><p class="font-weight-bold text-uppercase" >분석서버 선택 : </p></div>
											<div class="col-lg-9 mb-2">
													<select class="form-control" id="slt_server" >
													</select>
											</div> 
											
									</div>
									<div class="form-group has-error row">
											<div class="col-lg-3 mb-2 m-auto" ><p class="font-weight-bold text-uppercase" >분석평가 제한값 : </p></div >
											<div class="col-lg-9 mb-2">
													<input class="form-control" id="threshold" name="threshold" value="0.7" minlength="0" maxlength="11" type="text"  placeholder="0.01~0.99 사이의 값을 입력하세요" >
											</div > 
											
									</div>
									<div class="row ">
				                		<div class="col-xl-12 mb-0 m-1 my-0" style="text-align:right">
						                	<a href="javascript:fn_initUpload();" class="btn btn-secondary btn-icon-split btn-sm" >
							                <span class="icon text-white-50" >
															<i class="fa fa-file-excel"></i>
															</span>									
							                <span class="text" data-toggle="modal" data-target="#fileModal">대용량 엑셀 분석</span>
							                </a>
						                	
						                	<a href="<%= request.getContextPath()%>/download/analySample/analy_sample.xlsx" id="sample_excel" class="btn btn-secondary btn-icon-split btn-sm">
							                <span class="icon text-white-50" >
							                <i class="fa fa-file-excel"></i >
							                </span>
							                <span class="text">분석양식 다운로드</span>
							                </a>
						                </div>
					                </div>
									<div class="col-sm-12 col-md-12 mb-2 justify-content-between" id="checkbox_sentence">
									</div>
								</div>
			           		</form>
	                      </div>
	                           <!-- <button type="button" class="btn btn-info pull-right" onClick="javascript:saveServer();">등록</button> -->
	                     <!-- <div class="my-2">
			                  <a href="javascript:fn_runAnalData();" class="btn btn-primary btn-user btn-block" >
			                    <span class="icon text-white-50">
			                      <i class="fas fa-check" ></i>
			                    </span>
			                    <span class="text">실행</span >
			                  </a>
		                  </div> -->
			          </div>
		          
		          <!-- Earnings (Monthly) Card Example -->
			            <div class="col-xl-6 mb-4" id="frm_std_body">
				              <!-- Basic Card Example -->
				              <div class="card shadow mb-4">
					                <div class="card-header py-3">
					                  	<div class="row">
						                	<div class="col-lg-8">
						                  		<h6 class="m-0 font-weight-bold text-primary">* 학습 실행</h6  >
						                  	</div>
											<div class="col-lg-4" style="text-align:right">
											</div>
										</div>
					                </div>
					                <form id="frm" name="frm" method="post">
					                	<input type="hidden" id="cfsv_stat" name="cfsv_stat" value="C" >
					                <div class="card-body">
													<div class="form-group has-error row">
															<div class="col-lg-3 mb-2 m-auto" ><p class="font-weight-bold text-uppercase" >학습서버 선택 : </p></div>
															<div class="col-lg-9 mb-2">
																	<select class="form-control" id="slt_std_server" >
																	</select>
															</div>
													</div>
													<div class="col-sm-12 col-md-12 mb-2 justify-content-between" id="checkbox_sentence">
													</div>
										</div>
					           		</form>
			                      </div>
			                           <!-- <button type="button" class="btn btn-info pull-right" onClick="javascript:saveServer();">등록</button> -->
			                    <div class="my-2">
			                    	<a href="javascript:fn_createTrainingData();" class="btn btn-primary btn-user btn-block" >
				                    <span class="icon text-white-50">
				                      <i class="fas fa-check" ></i>
				                    </span>
				                    <span class="text">학습실행</span>
				                  	</a>
		                           
				               </div>
				                <div class="progress" style="height:30px" >
								  <div id="progress_bar" class="progress-bar progress-bar-success progress-bar-striped active" role="progressbar"
								  aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:0%; " >
								    0%
								  </div>
								</div>
				          </div>
		          
		          </div>
		          
	          </div>
	          
	          <!-- Modal 2 -->
					 <div class="modal fade"  id="fileModal" tabindex="-1" role="dialog" aria-labelledby="fileModalLabel" aria-hidden="true">
                              <div class="modal-dialog"  >
                                  <div class="modal-content" >
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
										<h4 class="modal-title" id="fileModalLabel">대용량 분석 엑셀 업로드</h4>
									</div>
									<div class="modal-body">
										<form id="frm_analyExcel" method="POST">
												<span class="icon text-white-50" >
													<i class="fa fa-file-excel"></i>
												</span>
											<input class="btn btn-secondary btn-icon-split btn-sm" type="file" name="fname" id="fname">
										</form>
									</div>
                                      <div class="modal-footer ">
                                          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                          <button type="button" class="btn btn-primary" onclick="javascript:fn_analyUpload();">분석실행</button>
                                      </div>
                                  </div>
                                  <!-- /.modal-content -->
                              </div>
                              <!-- /.modal-dialog -->
                          </div>
                          <!-- /.modal -->
	              
          </div>
          <!-- row end -->

        </div >
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      
      <%@ include file="../common/bottom.jsp"%>
      
	<script type="text/javascript">
	
	var timerId = null;
	var isNewCheck = true;
	
	$(document).ready(function(){

		fn_getServerList();
		fn_getCollectionList();
		
		$("#threshold").each(function(){
            $(this).keyup(function(){
                if( $(this).val() != null && $(this).val() != '' ) {
                    var tmps = $(this).val().replace(/[^\.|^0(0)+|^0-9\.]/g, '');
                    /* 소수점은 하나만 입력되도록*/
                    var arr = tmps.split(".");
                    if(arr.length > 2) {
                        tmps = arr[0] + '.' + arr[1];
                    }
                    $(this).val(tmps);
                }
            });
            $(this).focusout(function() {
                if( $(this).val() != null && $(this).val() != '' ) {
                    var tmps = $(this).val().replace(/[^\.|^0(0)+|^0-9\.]/g, '');

                    /* 소수점은 하나만 입력되도록*/
                    var arr = tmps.split(".");
                    if(arr.length > 2) {
                        tmps = arr[0] + '.' + arr[1];
                    }
                    $(this).val(tmps);
                }
            });
        });
		
		timerId = setInterval(fn_getStudyStatus, 1000);
		
	});

	function fn_changeCollection() {
		fn_showSentence($('#collection').val());
	}

	// 컬렉션별 체크박스 생성
	function fn_showSentence(collection) {
		let htmlstr = "";
		if(collection === "cf_data_sigint"){
			htmlstr = "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='ORG_DOC_NO'>문서번호"
						+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_TITLE'>제목"
						+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_CONTENT'>본문";
		} else if(collection === "cf_data_imint") {
			htmlstr = "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_TITLE'>제목"
					+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='ATTACHFILE_CONTENT'>첨부"
		} else {
			htmlstr = "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_TITLE'>제목"
					+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_1'>첨부1"
					+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_2'>첨부2"
					+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_3'>첨부3"
					+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_4'>첨부4"
					+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_5'>첨부5"
		}
		$('#checkbox_sentence').html(htmlstr);
	}


	// 컬렉션 리스트 목록 호출
	function fn_getCollectionList() {
		$.ajax({
			type : "GET",
			url : "<%= request.getContextPath()%>/act/getCollectionList.wn",
			success: function(data) {
				let strHtml = "";
				data.map(function(collection){
					strHtml += "<option value='"+collection.en+"'>"+collection.ko+"</option>";
				});
				$('#collection').html(strHtml);				 
			},
			error: function(request, status, error) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
	}
	
	
	//////////////////////////////////////////////////////
	//
	//	* event
	//
	//////////////////////////////////////////////////////
	
	
	// 분석실행
	function fn_runAnalData() {
		alertify.confirm("분석을 실행하시겠습니까?"
				, function() {
					
					$('#frm_body').oLoader({
						backgroundColor:'#4e73df',
						fadeInTime: 500,
						fadeOutTime: 1000,
						fadeLevel: 0.5
					});

					$.ajax({
						type : "post",
						url : "<%= request.getContextPath()%>/run/runTarget.wn",
						data : {
							cfsv_id: $('#slt_server').val()
						},
						dataType : "json",
						success: function(data) {
							if(data.ok){
								alertify.success('실행 되었습니다.');
							}else {
								alertify.error("문제가 발생하였습니다.")
							}
						},
						complete : function(data) {
							$('#frm_body').oLoader('hide');
						}
					})
				}, function() {
					alertify.error('취소 하였습니다.');
				});
	}


	// 분석데이터 생성
	function fn_createAnalData() {
		var collection = $('#collection').val();
		var docField = new Array();
			$('input[name=checked_sentence]:checked').each(function() {docField.push($(this).val());});
		//console.log(docField);

		if(docField.length === 0) {
			alert("1개 이상의 필드를 선택해야 합니다.");
			return;
		}

		alertify.confirm("분석대상 데이터를 생성하시겠습니까?"
				, function() {
					
					$('#frm_body').oLoader({
						backgroundColor:'#4e73df',
						fadeInTime: 500,
						fadeOutTime: 1000,
						fadeLevel: 0.5
					});

					$.ajax({
						type : "post",
						url : "<%= request.getContextPath()%>/run/createTarget.wn",
						data : {
							collection: collection,
							docField: docField.join(","),
							cfsv_id: $('#slt_server').val()
						},
						dataType : "json",

						success: function(data) {
							if(data.ok){
								alertify.success('실행 되었습니다.');
							}else {
								alertify.error("문제가 발생하였습니다.")
							}
						},
						complete : function(data) {
							$('#frm_body').oLoader('hide');
						}
					})
				}, function() {
					alertify.error('취소 하였습니다.');
				});
		
	}
	
	// 학습실행
	function fn_createTrainingData() {
		alertify.confirm("학습실행 하시겠습니까?"
				, function() {

					$('#content').oLoader({
						backgroundColor:'#4e73df',
						fadeInTime: 500,
						fadeOutTime: 1000,
						fadeLevel: 0.5
					});

					$.ajax({
						type: "post",
						url : "<%= request.getContextPath()%>/run/createTraining.wn",
						data: {
							cfsv_id: $('#slt_std_server').val()
						},
						success: function(data) {
							if(data.ok){
								alertify.success('학습이 실행되었습니다. 학습 진행 중');
								isNewCheck = false;
								timerId = setInterval(fn_getStudyStatus, 1000);
							}else {
								alertify.error("문제가 발생하였습니다.")
							}		
						},
						complete : function(data) {
							$('#content').oLoader('hide');
						}
					})
				}, function() {
					alertify.error('취소 하였습니다.');
				});
	}
	
	//학습 상태 체크
	function fn_getStudyStatus(){
		
		$.ajax({
			type: "post",
			url : "<%= request.getContextPath()%>/run/getStudyStatus.wn",
			data: {
				cfsv_id: $('#slt_std_server').val()
			},
			success: function(data) {
				if(data.response) {
					
					var setPer = data.progress;
					var status = data.status;
					
					if(status == "READY"){
						
						$('#progress_bar').attr("style" , "width:100%;");
						$('#progress_bar').text("100% Complete");
						
						if(isNewCheck) alertify.success('이전 학습이 완료 되었습니다.');
						else alert('학습이 완료 되었습니다.');
						
						$('#progress_bar').attr("style" , "width:0%;");
						$('#progress_bar').text("0% Complete");
						
						
						if(timerId != null) {
					        clearInterval(timerId);
					    }
						
					}else{
						
						$('#progress_bar').attr("style" , "width:" + setPer + ";");
						$('#progress_bar').text(status + " " + setPer + " Complete");
						
					}
					
					
				}
				
				
			},
			complete : function(data) {
				$('#content').oLoader('hide');
			}
		})
		
		
		
		
	}


	//서버선택 셀렉트박스
	function fn_getServerList(pageNum) {
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/code/getServerList.wn",
			success : function(data) {

				var list = data.serverList;
				var option = "";
				var cnt = 0;
				if(Object.keys(list).length > 0){
					
					$.each(list, function(key, value) {
						cnt++;
						option += '<option value="' + this.cfsv_id + '">' + this.cfsv_nm + '</option>';
					})
					
					$('#slt_server').html(option);
					$('#slt_std_server').html(option);
				}else{
					
					$('#slt_server').html(option);
					$('#slt_std_server').html(option);
					
				}

			},
			complete : function(data) {

			}
		});
		
	}

	
	// 엑셀 업로드 팝업 초기화
	function fn_initUpload(){
		
		$('#fname').val('');
		
	}
	
	// 분석 업로드 
	function fn_analyUpload(){
		
		if( $('#threshold').val() < 0.01 ||  $('#threshold').val() > 0.99){
			alert("0.01 ~ 0.99 사이의 값만 입력 가능합니다.");
			return false;
		}
		
		
		$('#content').oLoader({
			backgroundColor:'#4e73df',
			fadeInTime: 500,
			fadeOutTime: 1000,
			fadeLevel: 0.5
		});
		
		const form = jQuery("#frm_analyExcel")[0];
        const formData = new FormData(form);
        formData.append("message", "ajax로 파일 전송하기");
        formData.append("excel_cfsv_id", $('#slt_server').val());
        formData.append("anal_threshold", $('#threshold').val());
        formData.append("file", jQuery("#fname")[0].files[0]);
        
        $('#fileModal').modal("hide");
        
		$.ajax({
		 	url : "<%= request.getContextPath()%>/run/analyExcelRun.wn",
		 	async: true,
		 	type : "POST" ,
           	processData : false , 
           	contentType : false ,
           	data : formData ,

		 	success: function(data) {
		 		
		 		if(data.analyExcelRunVo.response){
		 			
		 			alertify.confirm("분석이 완료 되었습니다. 다운로드 하시겠습니까?", function() {
		 				
		 				window.location.href = "<%= request.getContextPath()%>/download/analyExcel/" + data.analyExcelRunVo.analyExcelFileName;
		 				
		 			});
		 			
		 			return;
		 			
		 		}else{
		 			
		 			alert(data.analyExcelRunVo.message);
		 			
		 		}
		 		
		 	},
		 	complete : function(data) {
		 		$('#content').oLoader('hide');				
		 	}
		})
		
		
	}
	
	
	</script>
      

</body>

</html>
