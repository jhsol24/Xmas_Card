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
          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">시뮬레이터  </h1>
          </div>
			<div class="row mb-2" >
	            <!-- Earnings (Monthly) Card Example -->
	            <div class="col-xl-12" >
	              <!-- Basic Card Example -->
	              <div class="card shadow" >
	                <div class="card-header py-1">
	                	<div class="row" >
		                	<div class="col-xl-6 mb-0">
		                		<div class="row">
			                		<div class="col-xl-4 text-left">
					                		<!-- <h5 class="m-2 font-weight-bold text-primary" style="text-align:right">* 분석서버 선택 : </h6> -->
					                		<h6 class="m-2 font-weight-bold text-primary" style="text-align:left">* 서버선택 </h6>
					                </div>
					                <div class="col-xl-8 text-left" >
						                  <select class="form-control" id="slt_server"  >
						                  </select>
					                </div>
			                	</div>		
			                </div>
			                
			                <div class="col-xl-6 mb-0">
		                		<div class="row">
			                		<div class="col-xl-4 text-left">
					                		<!-- <h5 class="m-2 font-weight-bold text-primary" style="text-align:right">* 분석서버 선택 : </h6> -->
					                		<h6 class="m-2 font-weight-bold text-primary" style="text-align:right"> &nbsp; 분석평가 제한값 : </h6>
					                </div>
					                <div class="col-xl-8 text-left" >
						                  <input class="form-control" id="threshold" name="threshold" value="0.7" minlength="0" maxlength="11" type="text"  placeholder="0.01~0.99 사이의 값을 입력하세요"  oninput="fn_maxLengthCheck(this)" >
					                </div>
			                	</div>		
			                </div>
			                
			               <!--  <div class="col-xl-6 mb-0 text-right">
		                		<div class="row">
			                		<div class="" >
				                		<h5 class="m-2 font-weight-bold text-primary" style="text-align:right"> &nbsp; 분석평가 제한값 : </h6>
				                	</div>
					                <div class="">
										<input class="form-control" id="threshold" name="threshold" value="0.7" minlength="0" maxlength="11" type="text"  placeholder="0.01~0.99 사이의 값을 입력하세요"  oninput="fn_maxLengthCheck(this)" >
					                </div>
					           </div>
					        </div> -->
		                 </div>
	                </div>
	              </div>
	            </div>
	          </div>
          <!-- row end -->
          <div class="row">
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-6 mb-4">
            <form id="frm" name="frm" method="post">
              <input type="hidden" id="cfsv_id" name="cfsv_id" value=""/>
              <!-- Basic Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                	<div class="row">
	                	<div class="col-lg-8">
	                  		<h6 class="m-0 font-weight-bold text-primary">* 분석 문장을 입력해 주세요.</h6>
	                  	</div>
	                  	<div class="col-lg-4" style="text-align:right">
		                  	<a id="btn_act" class="btn btn-success btn-icon-split btn-sm" href="javascript:fn_getActRs();">
		                    <span class="icon text-white-50">
		                      <i class="fas fa-flag"></i>
		                    </span>
		                    <span class="text">시뮬레이터 실행</span>
		                  	</a>
						</div>
					</div>
                </div>
                <div class="card-body">
					<div class="form-group" style="white-space:pre-wrap;">
						<textarea id="sentence" name="sentence" class="form-control" rows="20"></textarea>
					</div>
                </div>
              </div>
              <input class="form-control" id="clthreshold" name="clthreshold" value="" minlength="0" maxlength="11" type="hidden"  placeholder="0.7" >
            </form>
            </div>
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-6 mb-4">
              <!-- Basic Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">* 시뮬레이션(분석) 결과 상세</h6>
                </div>
                <div class="card-body">
                  <div class="col-xl-12 mb-1">
		              <div class="card border-left-primary shadow h-100 py-2">
		                <div class="card-body" >
		                  <div class="p-1 bg-gray-200">
		                  	<p class="m-1 font-weight-bold text-primary fa fa-chevron-circle-right" id="pAnalRs" style='font-size:0.9rem; line-height:10px'> 분석 결과 : </p>
		                  </div>
		                  <table width="100%"
								class="table table-striped table-bordered table-hover" >
								<thead>
									<tr style='font-size:0.8rem; line-height:10pxp; text-align:center;'>
										<th><p class="m-0 font-weight-bold">순위 </p></th>
										<th><p class="m-0 font-weight-bold">분석결과(코드)</p></th>
										<th><p class="m-0 font-weight-bold" style='text-align:center;'>분석결과(명) </p></th>
										<th><p class="m-0 font-weight-bold">점수 </p></th >
									</tr>
								</thead>
								<tbody id="tbAnalRs">
								</tbody>
							</table>
		                </div>
		              </div>
		            </div>
                </div>
              </div>
            </div>
          </div>
          <!-- row end -->
        <!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->
      
      
    <%@ include file="../common/bottom.jsp"%>
	<script type="text/javascript">
	$(document).ready(function(){
		fn_getServerList();
		$('#query').on("keypress",function(){
			if(event.keyCode == '13') event.preventDefault();
		});
		
		
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
        		
        		if( $('#threshold').val() < 0.01 ||  $('#threshold').val() > 0.99){
        			alertify.error( "입력 항목 체크 오류 : <br>" + '0.01 ~ 0.99 사이의 값만 입력 가능합니다. ' + ' ' + ' <br>' + '' );
        			$("#threshold").focus();
        			return false;
        		}
        		
            });
        });
		
	});
	
	/* 입력 항목에 키 입력시 길이 제한 (자동 삭제) */
    function fn_maxLengthCheck(ob) {
    	
		if (ob.value.trim().length > ob.maxLength){
			//ob.value = ob.value.trim()+""
			ob.value = ob.value.slice(0, ob.maxLength);
			ob.value = ob.value.replace(/^\s+|\s+$/g,"");
			ob.value = ob.val().replace(/ /gi, '');
		}
	
	}

	//서버선택 셀렉트박스
	function fn_getServerList(pageNum) {
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/code/getServerList.wn",
			data : $('#frm_search').serialize(),
			dataType : "json",

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
					
				}else{
					$('#slt_server').html(option);
				}

			},
			complete : function(data) {
				$('#server_id').val($('#slt_server').val());
			}
		});
		
	}
	
	

	//시뮬레이터
	function fn_getActRs() {
		
		if( $('#threshold').val() < 0.01 ||  $('#threshold').val() > 0.99){
			alertify.error( "0.01 ~ 0.99 사이의 값만 입력 가능합니다." );
			return false;
		}
		if( $('textarea#sentence').val() == null ||  $('textarea#sentence').val().length < 1){
			alertify.error( "분석 문장을 입력해야 분석 결과가 가능합니다." );
			return false;
		}

		$('#tbAnalRs > tr').remove();
		$('#pAnalRs').text('');
		$('#cfsv_id').val($('#slt_server').val());
        $('#clthreshold').val($('#threshold').val());
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/act/getActRs.wn",
			data : $('#frm').serialize(),
			dataType : "json",
			success : function(data) {
				var list = data.list;
				var cateList = data.listCt;
				var table = "";
				var cnt = 0;
				
				
				
				if(Object.keys(list).length > 0){
					
					$.each(Object.keys(list), function(key, value) {
						cnt++;
						table += "<tr style='font-size:0.9rem; line-height:10px'> ";
						table += '<td style="text-align:center;" > ' +  cnt + ' </td> '
						+ '<td style="text-align:center;" > ' + (list[cnt-1].key)   + ' </td> '
						+ '<td style="text-align:left;" > &emsp;&emsp; ' + fn_getRsltNm(list[cnt-1].key, cateList)   + ' </td> '
						+ '<td style="text-align:center;" > ' + list[cnt-1].value.toFixed(9) + ' </td> '
						+ '</tr>' ;
						
					}) //each list
					
					$('#tbAnalRs').append(table);
					$('#pAnalRs').html(" 분석결과 : <span class='text-danger'>" + fn_getRsltNm(data.analRs, cateList) + "</span>"); /* cdToNm3(data.analRs, data) */
					
				}else{
					console.log(data);
				}
			},
			complete : function(data) {
			}
		})
		
	} //시뮬레이터
	

	//분석명 가져오기
	function fn_getRsltNm(cd, cateList) {
		
		var rtn = "미매칭";
		
		for (var i = 0; i < cateList.length; i++){
			if(cd == cateList[i].CFCT_VALUE){
				rtn = cateList[i].CFCT_NAME;
				break;
			}
		}
		
		return rtn;
	}
	
	
	</script>
</body>
</html>