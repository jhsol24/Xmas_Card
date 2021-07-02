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
  <script src="http://code.jquery.com/jquery-latest.js"></script>
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
            <h1 class="h5 mb-0 text-gray-800 font-weight-bold">| 서버관리 > 서버 목록 (등록/수정)  </h1>
          </div>
          <div class="row" >
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-6 mb-4" >
              <!-- Basic Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-2">
                	<div class="row">
	                	<div class="col-xl-8">
	                  		<h6 class="m-2 font-weight-bold text-primary">* 서버 목록</h6>
	                  	</div>
					</div>
                </div>
	             <div class="card-body table-responsive" id="frm_card_body">
	                <div class="dataTables_wrapper" id="dataTable_wrapper" >
	                <form id="frm_search" name="frm_search" method="post">
	                	<div class="row">
	                	<input type="hidden" id="p_cfsv_id" name="p_cfsv_id" value="" />
	                    <input type="hidden" id="pageNum" name="pageNum" value="">
			             	<div class="col-sm-3 col-md-6">
							</div>
							<div class="col-sm-3 col-md-6">
								<div class="form-group input-group" >
			                    	<input type="text" id="query" name="query" value="" class="form-control bg-light border-0 small" onkeypress="if( event.keyCode==13 ){fn_getList(1);}" placeholder=" &emsp; Search for..." aria-label="Search" aria-describedby="basic-addon2">
					              	<div class="input-group-append">
					                	<button id="btn_search" class="btn btn-primary" type="button" onClick="fn_getList('1');">
					                  		<i class="fas fa-search fa-sm"></i>
					                	</button>
					              	</div>
					             </div>
							</div>
	                	</div>
	                </form>
	                	<div class="row">
	                		<div class="col-xl-12">
	                			<table width="100%" class="table table-bordered dataTable" id="dataTable" role="grid" aria-describedby="dataTable_info" style="width: 100%;" cellspacing="0">
			                  		<thead>
										<tr role="row" style="font-size:0.8rem; line-height:10px; text-align:center"> <!-- 서버 목록(dataTable).헤더 -->
											<th style="text-align:center"><input type="checkbox" id="th_checkAll" name="checkboxAll" onclick="$('input[type=checkbox]').prop('checked', ($('#th_checkAll').is(':checked')));"/></th>
											<th>ID</th>
											<th>IP</th>
											<th>PORT</th>
											<th>서버명</th>
										</tr>
									</thead>
									<tbody id="tb_list" style="text-align:center">
									</tbody>
								 </table>
	                		</div>
	                	</div>
	                	<div class="row">
	                		<div class="col-sm-10">
	                			<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
	                				<ul  class="pagination push-right" id="pagination" style='font-size:0.8rem; line-height:10px;'>
	                				</ul>
	                			</div>
	                		</div>
	                		<div class="col-sm-2">
	                		<a href="javascript:fn_deleteServer();" class="btn-sm btn-secondary" style="float: right;" >
			                    <span class="icon text-white-50">
			                      <i class="fas fa-check" ></i>
			                    </span>
			                    <span class="text">삭제</span >
		                    </a>
		                    </div>
	                	</div>
	                </div>
	            </div>
	          </div>
	        </div>
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-6 mb-4" >
	              <!-- Basic Card Example -->
	              <div class="card shadow mb-4">
		                <div class="card-header py-2">
		                  	<div class="row" >
			                	<!-- <div class="col-xl-8">
			                  		<h6 class="m-0 font-weight-bold text-primary">* 서버 등록/수정</h6>
			                  	</div> -->
			                  	<div class="col-xl-8">
			                  		<h6 class="m-2 font-weight-bold text-primary" >* 서버 등록/수정</h6 >
			                  	</div>
			                  	<div class="col-xl-4" style="text-align:right">
				                  	<a id="btn_act" class="btn btn-success btn-icon-split btn-sm" href="javascript:fn_init();">
				                    <span class="icon text-white-50">
				                      <i class="fas fa-flag"></i>
				                    </span>
				                    <span class="text">신규 등록</span>
				                  	</a>
								</div>
							</div>
		                </div>
            			<!-- Earnings (Monthly) Card Example card-header py-3 -->

 		                <form id="frm" name="frm" method="post">
		                	<input type="hidden" id="cfsv_stat" name="cfsv_stat" value="C" >
		                	<input type="hidden" id="d_cfsv_id" name="d_cfsv_id" value="" />
		                <div class="card-body">
		                	<div class="form-group has-error row">
                                 <div class="col-lg-3" ><p class="font-weight-bold text-uppercase mb-1" > 서버ID : </p></div>
                                 <div class="col-lg-9"><input class="form-control" id="cfsv_id" name="cfsv_id" minlength="0" maxlength="11" type="text" placeholder="ID는 자동발급 됩니다." readonly="readonly"></div>
                             </div>
							<div class="form-group has-error row">
                                 <div class="col-lg-3"><p class="font-weight-bold text-uppercase mb-1"> 서버명 : </p></div>
                                 <div class="col-lg-9" alt="[1 ~ 500 Bytes]"><input type="text" class="form-control" id="cfsv_nm" name="cfsv_nm" minlength="1" maxlength="500" placeholder="검색엔진 서버의 한글명칭입니다. &emsp;&emsp; &emsp;&emsp; &emsp;&emsp;  [1 ~ 500 Bytes]" oninput="fn_inputLengthCheck2B(this)"></div>
                             </div>
                             <div class="form-group has-error row">
                                 <div class="col-lg-3"><p class="font-weight-bold text-uppercase mb-1"> 서버IP : </p></div> 						
                                 <div class="col-lg-9"><input type="text" class="form-control" id="cfsv_ip" name="cfsv_ip" minlength="7" maxlength="15" placeholder="검색엔진 서버의 IP입니다. &emsp;&emsp; &emsp;&emsp; &emsp;&emsp; &emsp;&emsp; &emsp; [필수, 7 ~ 15 Bytes]" oninput="fn_maxLengthCheck(this)" required></div>
                             </div>
                             <div class="form-group has-error row">
                                 <div class="col-lg-3"><p class="font-weight-bold text-uppercase mb-1"> 서버PORT : </p></div> 					
                                 <div class="col-lg-9"><input type="text" class="form-control" id="cfsv_port" name="cfsv_port" minlength="2" maxlength="5" placeholder="검색엔진 서버의 PORT입니다. &emsp;&emsp; &emsp;&emsp; &emsp;&emsp; &emsp;&emsp;[필수, 2 ~ 5 Bytes]" onblur="fn_maxLengthCheck(this)" oninput="this.value = this.value.replace(/[^0-9.]/g,'').replace(/(\..*)\./g, '$1')" required></div>
                             </div>
                             <div class="form-group has-error row">
                                 <div class="col-lg-3"><p class="font-weight-bold text-uppercase mb-1"> 학습파일 경로 : </p></div>
                                 <div class="col-lg-9"><input type="text" class="form-control" id="cfsv_std_indir" name="cfsv_std_indir" minlength="1" maxlength="500" placeholder="검색엔진 학습파일.json의 서버 Full Path입니다. &emsp; [1 ~ 500 Bytes]" oninput="fn_maxLengthCheck(this)"></div>
                             </div>
                             <div class="form-group has-error row" style="display:none;"> 신고에서 미사용
                                 <div class="col-lg-3"><p class="font-weight-bold text-uppercase mb-1"> 분석대상파일 경로 : </p></div>
                                 <div class="col-lg-9"><input type="text" class="form-control" id="cfsv_anal_indir" name="cfsv_anal_indir" minlength="0" maxlength="500" onblur="return fn_inputLengthCheck2B(this);" oninput="fn_maxLengthCheck(this)" value=" . "></div>
                             </div>
                             <div class="form-group has-error row" style="display:none;"> 신고에서 미사용
                                 <div class="col-lg-3"><p class="font-weight-bold text-uppercase mb-1"> 분석결과파일 경로 : </p></div>
                                 <div class="col-lg-9"><input type="text" class="form-control" id="cfsv_anal_outdir" name="cfsv_anal_outdir" minlength="0" maxlength="500" oninput="fn_maxLengthCheck(this)" value=" . "></div>
                             </div>
                             <div class="form-group has-error row">
                                 <div class="col-lg-3"><p class="font-weight-bold text-uppercase mb-1"> 서버설명 : </p></div>
                                 <div class="col-lg-9"><div class="form-group" >
									<textarea id="cfsv_desc" name="cfsv_desc"  placeholder="검색엔진 서버의 &#13;&#10;&emsp;&emsp; 설명입니다. &#13;&#10;&emsp;&emsp;  &#13;&#10;&emsp;&emsp;  &#13;&#10; [0 ~ 2000 Bytes]"
										class="form-control" rows="10" minlength="0" maxlength="2000" oninput="fn_maxLengthCheck(this)"></textarea  >
								</div></div>
                             </div>
                             <div class="my-2">
                             <a href="javascript:fn_saveServer();" class="btn btn-primary btn-user btn-block" >
			                    <span class="icon text-white-50">
			                      <i class="fas fa-check" ></i>
			                    </span>
			                    <span class="text">저장</span >
			                  </a>
			                  </div>
		                </div>
		                </form>
	              </div>
	              <!-- Dropdown Card Example -->
          </div>
          <!-- row end -->
        </div>
        <!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->
	<%@ include file="../common/bottom.jsp"%>
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
				
				if( $('input:checkbox[name=checkbox]').length > 0 ) fn_showDetail($('input[name=checkbox]:eq(0)').val());
				$('#frm_card_body').oLoader('hide');
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
