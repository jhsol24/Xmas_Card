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
  
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jsTree/dist/themes/default/style.min.css"/>
  <%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jsTree//assets/bootstrap/css/bootstrap.min.css" /> --%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jsTree//assets/dist/themes/proton/style.css"/>
     
  <title >Classficator Manager</title >

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
        <div class="container-fluid" id="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">분석결과 데이터 관리  </h1>
          </div>
		<div class="row mb-2" >
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-12" >
            
              <!-- Basic Card Example -->
              <div class="card shadow" >
                <div class="card-header py-1">
                	<div class="row" >
	                	
	                	<div class="col-xl-5 mb-0">
	                		<div class="row">
		                		<div class="col-xl-3" >
			                		<h6 class="m-2 font-weight-bold text-primary" style="text-align:right">* 서버선택 </h6>
			                	</div>
				                <div class="col-xl-8">
					                  <select class="form-control" id="slt_server" >
					                  </select>
				                </div>
			                </div>
		                </div>
		               
		                <div class="col-xl-7 mb-0 text-right text-justify">
		                </div>
		                
	                 </div>
                </div>
              </div>
            </div>
          </div>
          <!-- row end -->
          
          <div class="row">
            <!-- TREE -->
            <div class="col-xl-3 mb-1" >
            <form id="frm" name="frm" method="post">
           	<input type="hidden" id="server_id" name="server_id" value=""/>
              <!-- Basic Card Example -->
              <div class="card shadow">
                <div class="card-header py-1 mb-0">
                
                	<div class="row">
						<div class="col-xl-12 mb-0">
			                <input type="text"   id="tree_search" value="" class="form-control border-1 small" onkeypress="if( event.keyCode==13 ){fn_getSearchResults(1);}" placeholder="Search for...">
					     </div>
					</div>
                	
                	<div class="row">
	                	<div class="col-xl-12 py-1  mb-0">
							<button type="button" class="btn btn-info btn-sm"
								onclick="tree_refresh();">
								<i class="glyphicon glyphicon-refresh"></i> 새로고침
							</button>
							<button type="button" class="btn btn-warning btn-sm"
								onclick="tree_create();" title="신규 생성 후 저장을 해주세요."  >
								<i class="glyphicon glyphicon-pencil"></i> 신규
							</button>
							<button type="button" class="btn btn-primary btn-sm"
								onclick="tree_rename();">
								<i class="glyphicon glyphicon-refresh"></i> 이름변경
							</button>
							<button type="button" class="btn btn-danger btn-sm"
								onclick="tree_delete();" title="체크 된 카테고리를 삭제합니다.">
								<i class="glyphicon glyphicon-remove"></i> 삭제
							</button>
							<button type="button" class="btn btn-success btn-sm"
								onclick="tree_save();" title="신규/수정에 대해 저장합니다.">
								<i class="glyphicon glyphicon-refresh"></i > 저장
							</button>
						</div>
					</div>
					
					
                </div>
                <div class="card-body" id="card-tree-body">
                    <!-- JSTREE  -->
					<div class="col-md-3 col-sm-3 col-xs-3">
						<div id="jstree" class="demo"
							style="margin-top:1em; min-height: 200px;"></div >
					</div>
					<!-- JSTREE  -->
                </div>
              </div>
            </form>
            </div>

            <!-- 검색 -->
            <div class="col-xl-9 mb-2"  id="manager_board">
	            <div class="col-xl-12 mb-2" >
			          <div class="row">
				          	<!-- 분석대상 검색 -->
				            <div class="col-xl-12 mb-2"  >
					              <div class="card shadow mb-4">
						                <div class="card-header py-3">
						                	<div class="row">
							                	<div class="col-xl-10">
							                  		<h6 class="m-0 font-weight-bold text-primary" >* 분석결과 관리</h6>
							                  	</div>
											</div>
						                </div>
							             <div class="card-body table-responsive" id="frm_card_body">
							                <div class="dataTables_wrapper" id="dataTable_wrapper" >
							                <form id="frm_search" name="frm_search" method="post">
							                	<div class="row">
							                	 		<input type="hidden" id="startCount" name="startCount" value="0">
														<input type="hidden" id="listCount" name="listCount" value="10">
								                    	<input type="hidden" id="pageNum" name="pageNum" value="1">
								                    	<input type="hidden" id="exquery" name="exquery" value="">
								                    	<input type="hidden" id="range" name="range" value="RANK/DESC">
									             	<div class="col-sm-3 col-md-6">
																	<select class="form-control" id="collection" name="collection" onchange="javascipt:fn_changeCollectionList('1');">
																		<option value='cf_data_sigint'>OO정보</option>
																		<option value='cf_data_humint'>인간정보</option>
																	</select>
													</div>
													<div class="col-sm-3 col-md-6">
														<div class="form-group input-group" >
									                    	<input type="text" id="query" name="query" value="" class="form-control bg-light border-0 small" onkeypress="if( event.keyCode==13 ){fn_getSearchResults(1);}" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
											              	<div class="input-group-append">
											                	<button id="btn_search" class="btn btn-primary" type="button" onClick="javascipt:fn_getSearchResults('1');">
											                  		<i class="fas fa-search fa-sm"></i>
											                	</button>
											              	</div>
											             </div>
													</div>
							                	</div>
							                </form>
							                <div class="row">
							                	<div class="col-xl-12 mb-2" id="checkbox_sentence"></div>
							                </div>
							                	<div class="row">
							                		<div class="col-xl-12">
							                			<table width="100%" draggable="true" class="table table-bordered dataTable" id="dataTable" role="grid" aria-describedby="dataTable_info" style="width: 100%;" cellspacing="0">
									                  		<thead>
																<tr role="row" style="font-size:0.8rem; line-height:10px">
																	<th width="3%" align="center" ><input type="checkbox" name="chkAll" id="chkAll"/></th>
																	<th width="9%">ID</th>
																	<th width="14%">분석결과</th>
																	<th width="*">제목</th>
																	<th width="18%">등록일시</th>
																</tr>
															</thead>
															<tbody id="tb_list">
															</tbody>
														 </table>
							                		</div>
							                	</div>
							                	<div class="row">
							                		<div class="col-xl-11">
							                			<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">total : </div>
							                		</div>
							                		<div class="col-xl-1"  style='float:right;'>
							                  			<input class="btn btn-primary btn-sm m-0" style='float:right;' type="button" value="이동" onclick="javascript:getModalTreeData()">
							                  		</div>
							                		<div class="col-xl-12">
							                			<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
							                				<ul class="pagination" id="pagination" style='font-size:0.8rem; line-height:10px; display: flex; justify-content: center;'>
							                				</ul>
							                			</div>
							                		</div>
							                	</div>
							                </div>
							            </div>
						          </div>
					          </div >
					          
				          </div>
				          <!-- row end -->
		          </div>
          
	       </div>
	        <!-- row end -->
	        </div>
								 
        </div>
        <!-- container-fluid -->
       </div>
      </div>
	</div>
	
      <!-- End of Main Content -->
      <form id="frm_tree" name="frm_tree" method="post">
      	<input type="hidden" name="pItems" id="pItems" value="">
      	<input type="hidden" name="items_text" id="items_text" value="" >
      	<input type="hidden" name="items_depth" id="items_depth" value="" >
      	<input type="hidden" name="u_pItems" id="u_pItems" value="">
      	<input type="hidden" name="u_items" id="u_items" value="">
      	<input type="hidden" name="u_items_text" id="u_items_text" value="">
      	<input type="hidden" name="cfsv_id" id="cfsv_id" value="">
      	<input type="hidden" name="d_items" id="d_items" value="">
      </form>
      
      <form id="frm_study" name="frm_study" method="post">
      	<input type="hidden" name="cfct_id" id="cfct_id" value="" >
      	<input type="hidden" name="checkItems" id="checkItems" value="">
				<input type="hidden" name="std_sentence" id="std_sentence" value="">
      </form>

	  	<form id="frm_del_study" name="frm_del_study" method="post">
      		<input type="hidden" name="delItems" id="delItems" value="">
		</form>
      
      <!-- Modal -->
      
	 <div class="modal-2 fade"  id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog"  >
			<div class="modal-content-lg" >
				<input type="hidden" name="cfst_id" id="cfst_id" value="">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">상세 보기</h4>
				</div>
				<div class="modal-body">
						  <div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
									<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
										  <h6 class="m-0 font-weight-bold text-primary"><strong id="modal_title">제목 : </strong></h6>
									</div>
								<!-- Card Body test -->
								<div class="card-body" id="modal_content">
									  <p>
										<textarea class="form-control w-100"
										rows="17" style='font-size:0.8rem;' readonly></textarea>
									</p>
								</div>
							</div>
						<strong id="modal_category" style='font-size:0.8rem; line-height:10px' ></strong>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div >
			</div >
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
	
	<!-- Modal -->
	 <div class="modal-2 fade"  id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
		<div class="modal-dialog"  >
			<div class="modal-content-lg" >
				<input type="hidden" name="cfst_id" id="cfst_id" value="" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel2">이동하기</h4>
				</div>
				<div class="modal-body">
						  <div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
									<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
										  <h6 class="m-0 font-weight-bold text-primary"><strong id="modal_title">분석데이터 이동</strong></h6>
									</div>
								<!-- Card Body test -->
								<div class="card-body" id="modal_tree" name="modal_tree">
									  
								</div>
							</div>
				</div>
				<div class="modal-footer">
				<button type="button" class="btn btn-primary"  onclick="javascript:fn_moveStudyResult();" data-dismiss="modal">이동</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
			</div >
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
    <%@ include file="../common/bottom.jsp"%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/jsTree/dist/jstree.js"></script>
      	
	<script type="text/javascript">
	
	var tree_data;
	
	$(document).ready(function(){
		
		fn_getServerList();
		fn_getCollectionList();
		fn_showSentence($('#collection').val());
		
		var p_page_num = $('#pageNum').val();
		
		if(p_page_num == ""){
			fn_getSearchResults("1");
		}else{
			fn_getSearchResults(p_page_num);
		}
		
		
	
		$('#query').on("keypress",function(){
			
			if(event.keyCode == '13') event.preventDefault();
			
		});
		
		$('#std_query').on("keypress",function(){
			
			if(event.keyCode == '13') event.preventDefault();
			
		});
		
		
		$("#tree_search").keyup(function() {

			var searchString = $(this).val();
			$('#jstree').jstree('search', searchString);
		});

		
		// 전체 체크
		$('#chkAll').on('click', function(){
			var checked_status = this.checked;
            $("input[name=chk]").each(function()
            {
                this.checked = checked_status;
            });
		});
		
		
		// 학습데이터 검색 전체 체크
		$('#std_chkAll').on('click', function(){
			var checked_status = this.checked;
            $("input[name=std_chk]").each(function()
            {
                this.checked = checked_status;
            });
		});
		
		$('#slt_server').on('change', function(){
			$('#std_tb_list > tr').remove();
			$('#std_pagination > li').remove();
			$('#std_dataTable_info').html("total : 0");
			$('#std_cate_nm').text("");
			$('#server_id').val($('#slt_server').val());
			tree_refresh();
			//getTreeData();
		});
		
	});
	
	
	function fn_doSearch(pageNum) {
		fn_getSearchResults(pageNum);
	}

	
	function fn_std_download() {
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/study/downloadTraining.wn",
			async: true,
			data : {
				cfsv_id: $('#slt_server').val()
			},
			cache: false,
			dataType : "json",
			success: function(data) {
				let actionUrl =  "<%=request.getContextPath()%>" + data.url;
				$('#frm_get_stdData').attr("action", actionUrl);
				$('#frm_get_stdData').submit();
			},
			complete : function(data) {
							
			},
			error : function(request, status, error) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});

	}
	
	// 컬렉션별 체크박스 생성
	function fn_showSentence(collection) {
		let htmlstr = "";
		if(collection === "cf_data_sigint"){
			htmlstr = "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='ORG_DOC_NO' checked='checked'>문서번호"
						+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_TITLE' checked='checked'>제목"
						+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_CONTENT' checked='checked'>본문";
		} else if (collection === "cf_data_imint") {
			htmlstr = "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_TITLE' checked='checked'>제목"
						+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='ATTACHFILE_CONTENT' checked='checked'>본문";
		} else {
			htmlstr = "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_TITLE' checked='checked'>제목"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_1' checked='checked'>첨부1"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_2' checked='checked'>첨부2"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_3' checked='checked'>첨부3"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_4' checked='checked'>첨부4"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_5' checked='checked'>첨부5"
		}
		$('#checkbox_sentence').html(htmlstr);
	}
	

	//학습데이터 문장 입력
	function fn_save_sentence(){
		
        $('#std_sentence').val($('#sentence').val());
        
        if($('#sentence').val() == ''){
        	
        	alert("문장을 입력해 주세요.")
        	return false;
        	
        }
        var txt = $('#std_cate_nm').text();
        
        alertify.confirm("저장 하시겠습니까? " + txt +"에 등록됩니다."
				, function() {
					$.ajax({
						type : "post",
						url : "<%= request.getContextPath()%>/study/saveSentence.wn",
						data : $('#frm_study').serialize(),
						dataType : "json",
			
						success : function(data) {
							
						},
						complete : function(data) {
							
						},
						error : function(request, status, error) {
							 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					});
				}, function() {
					alertify.error('취소 하였습니다.');
				});
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
				getTreeData(true);
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
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


	function fn_changeCollectionList(){
		$('#query').val('');
		fn_getSearchResults('1');
		fn_showSentence($('#collection').val());
	}
	

	//분석대상 검색 데이터 리스트
	function fn_getSearchResults(pageNum) {
		
		$('#manager_board').oLoader({
			backgroundColor:'#4e73df',
			fadeInTime: 500,
			fadeOutTime: 1000,
			fadeLevel: 0.5
		});

	    $('#tb_list > tr').remove();
		$('#pagination > li').remove();
		$('#pageNum').val(pageNum);
		$('#startCount').val(( pageNum - 1 ) * 10);
		//$('#list_cnt').text().remove();
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/search/getSearchResults.wn",
			data : {
				collection: $('#collection').val() ,
				query: $('#query').val(),
				startCount: $('#startCount').val(),
				pageNum: $('#pageNum').val(),
				listCount: $('#listCount').val(),
				range: $('#range').val(),
				exquery: fn_makeExquery($('#exquery').val())
			},
			cache: false,
			dataType : "json",
			success : function(data) {
				console.log(data);
				var list = data.list;
				var table = "";
				var cnt = 0;
				
				//$('#query').val(data.actVo.query);
				
				if(Object.keys(list).length > 0){
					$.each(list, function(key, value) {
						cnt++;
						table += "<tr style='font-size:0.8rem; line-height:10px'>";
						table += "<input type='hidden' name='content' value='" + ($("#collection").val() === "cf_data_sigint" ? this.HUMAN_REPORT_ATTACHFILE_CONTENT_1 : this.CF_CONTENT) + "'>";
						//table += "<td align='center'><input type='checkbox' class='chk' name='chk' value='" + ($("#collection").val() === "cf_data_sigint" ? this.CF_ID : this.DOCID) + "'/></td>";
						table += "<td align='center'><input type='checkbox' class='chk' name='chk' value='" + this.UID + "'/></td>";
						table += "<td>";
						//table +=  ($("#collection").val() === "cf_data_sigint" ? this.CF_ID : this.DOCID) + '</td>'
						table +=  this.UID + '</td><td>';
						table += this.XGBOOST_ANAL_RS + '</td>'
						//+ '<td><span data-toggle="modal" data-target="#myModal">'+ this.cf_title + '</a><span></td>'
						+ '<td style="cursor: pointer;"><a onclick="javascript:fn_getSearchDetail(\'' + this.UID + '\');" data-toggle="modal" data-target="#myModal">'+ this.CF_TITLE + '</a></td>'
						+ '<td>'+ ($("#collection").val() === "cf_data_sigint" ? this.CF_DATE : this.CF_DATE.substr(0, 4) + "-" + this.CF_DATE.substr(4, 2) + "-" 
								+ this.CF_DATE.substr(6, 2) + " " + this.CF_DATE.substr(8, 2) + ":" + this.CF_DATE.substr(10, 2) + ":" + this.CF_DATE.substr(12, 2)) + '</td></tr>';
					})
					
					$('#tb_list').append(table);
					$('#pagination').html(data.pageCode);
					$('#dataTable_info').html("total : " + data.totalCount + "");
					$('#collection').val();
				}else{
					$('#tb_list').append(
					'<tr><td colspan="5" align="center">데이터가 존재 하지 않습니다.</td></tr>');
				}
			},
			complete : function(data) {
				$('#detail_title').text("제목 : ");
				$('#detail_content').text("");
				$('#detail_category').text("* 문서구분 : ");
				
				$('#manager_board').oLoader('hide');
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
	// exquery 만들기 	
	function fn_makeExquery(text) {
		if(text === "") return text;
		
		const splitText = text.split("/");
		const serverText = $('#slt_server').text();
		console.log(serverText);
		
		if(splitText.length > 1) {
			let contains = "";
			for(let i=0; i < splitText.length; i++){
				contains += (splitText[i] ? "<" + "XGBOOST_ANAL_RS:contains:" + splitText[i] +">" : "");
			}
			//console.log(contains);
			return contains;
		}else {
			return "<" + "XGBOOST_ANAL_RS:contains:" + text +">";
		}
	}
	
	// 검색엔진 개별 문서 상세검색
	function fn_getSearchDetail(id){
		let collection = $('#collection').val();
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/search/getSearchDetail.wn",
			data :{
				"collection": collection,
				"uid" : id
			},
			dataType : "json",
			success : function(data) {
				//console.log(data);
				
				var vo = data[data.length-1];
				
				$('#modal_title').text("제목 : " + vo.CF_TITLE);
			
				if(collection === "cf_data_sigint" ){
					let html = "<p><textarea id='detail_content' class='form-control' rows='15' style='font-size:0.8rem;' readonly='readonly'></textarea></p>";
					$('#modal_content').html(html);
					$('#detail_content').text(vo.CF_CONTENT);
				} else if ( collection === "cf_data_imint"){
					let html = "<p><textarea id='detail_content' class='form-control' rows='15' style='font-size:0.8rem;' readonly='readonly'></textarea></p>";
					$('#modal_content').html(html);
					$('#detail_content').text(vo.ATTACHFILE_CONTENT);
				}else {
					let html = "<p><textarea id='detail_content' class='form-control' rows='15' style='font-size:0.8rem;' readonly='readonly'></textarea></p>";
					$('#modal_content').html(html); 
					let str = 1;
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_1){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_1+"</a><textarea id='detail_content1' class='form-control' rows='10' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#modal_content').html(html);
						$('#detail_content1').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_1);
					}
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_2){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_2+"</a><textarea id='detail_content2' class='form-control' rows='10' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#modal_content').append(html);
						$('#detail_content2').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_2);
					}
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_3){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_3+"</a><textarea id='detail_content3' class='form-control' rows='10' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#modal_content').append(html);
						$('#detail_content3').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_3);
					}
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_4){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_4+"</a><textarea id='detail_content4' class='form-control' rows='10' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#modal_content').append(html);
						$('#detail_content4').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_4);
					}
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_5){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_5+"</a><textarea id='detail_content5' class='form-control' rows='10' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#modal_content').append(html);
						$('#detail_content5').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_5);
					}
				}
				let gubunHtml = "* 문서구분 : ";
				if($('#collection').val() === "cf_data_sigint") gubunHtml += vo.CF_CATEGORY;
				else if($('#collection').val() === "cf_data_imint") gubunHtml = "";
				else gubunHtml += vo.WISE_CF_DATA_HUMINT_MENU;

				$('#modal_category').html(gubunHtml);
			},
			complete : function(data) {
			},
			error : function(request, status, error) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}


	
	
	//학습데이터 검색 모달팝업 상세데이터
	function fn_showStdDetail(id){
		
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/study/getStdDetail.wn",
			data :{
				"cfst_id" : id
			},
			dataType : "json",

			success : function(data) {
				
				var vo = data.stdVo;

				$('#modal_title').text("[학습 카테고리]  " + vo.cfct_nm);
				$('#modal_content').val(vo.cf_content);
				if(vo.cf_gubun !== null) $('#modal_category').text("* 문서구분 : " + vo.cf_gubun);
				$('#cfst_id').val(vo.cfst_id);
			},
			complete : function(data) {
				
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
	}
	
	
	//분설결과 데이터 이동 (분석결과 검색에서 체크 된 데이터)
	function fn_moveStudyResult(){
		
		var ref = $("#modal_tree").jstree(true);
		var depthCnt = ref.get_node(ref.get_selected()).parents.length;
		var treeId = ref.get_node(ref.get_selected()).id;
		var treeText = ref.get_node(ref.get_selected()).text;
		var collection = $('#collection').val();
		var parent = ref.get_node(ref.get_selected()).parent;
		var parentText = ref.get_node(parent).text;
		var docField = new Array();
		$('input[name=checked_sentence]:checked').each(function() {docField.push($(this).val());});
		

		if(depthCnt < 2){
			alert("최상위 카테고리에는 이동할 수 없습니다.");
			return false;
		}
		
		var checkItems = new Array();
        $("input[name='chk']:checked").each(function() {checkItems.push($(this).val());});
        checkItems.join(",");
        
        var rs = "";
        
        if(parent == "#" || parent == null) {
        	rs = treeText;
        } else {
        	rs = parentText+"/"+treeText;
        }

        //console.log(parent);
    	//console.log(treeText);
		//console.log(docField.join(","));
		//console.log(collection);
		//console.log(checkItems.join(","));
		

		if(checkItems.length === 0) {
			alert("1개 이상의 분석결과 데이터를 선택해야 합니다.");
			return false;
		}
		
		$('#manager_board').oLoader({
			backgroundColor:'#4e73df',
			fadeInTime: 500,
			fadeOutTime: 1000,
			fadeLevel: 0.5
		});
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/result/moveSearchResults.wn",
			async: true,
			data : {
				cfsv_id: $("#slt_server").val(),
				uid: checkItems.join(","),
				collection: collection,
				docField: docField.join(","),
				gubun: rs
			},
			dataType : "json",
			success: function(data) {
				//console.log(data);
				if(data.status) {
					alertify.success('이동하였습니다.');
					setTimeout(function() {
						fn_getSearchResults(1);
					}, 1000);
				} else {
					alertify.error('실패하였습니다.');
				}
			},
			complete : function(data) {
				// 분석대상 체크박스 전체 해제
				$('#chkAll').each(function(){
					var checked_status = this.c
		            this.checked = false;
		            $("input[name=chk]").each(function()
		            {
		                this.checked = false;
		            });
				});
				$('#manager_board').oLoader('hide');
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
	
	
	function fn_updateStudyData() {
		
		alertify.confirm("저장 하시겠습니까?"
			, function() {
				$.ajax({
					type : "post",
					url : "<%= request.getContextPath()%>/study/updateStudy.wn",
					data : {
						cfst_id: $('#cfst_id').val(),
						cf_content: $('#modal_content').val()
					},
					dataType : "json",
					success : function(data) {
						alertify.success('저장 되었습니다.');
					},
					complete : function(data) {
						$('#myModal').click();
					},
					error : function(request, status, error) {
							alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}, function() {
				alertify.error('취소 하였습니다.');
			});
	}
	
	

	function sent_help_close(){
		
		$('#sent_help').hide();
		
	}
	
	

	//트리 초기 세팅
	function getTreeData(is_close){
		
		if(is_close == ""){
			is_close = false;
		}
		
		$.ajax({
			type : "post",
			async: true,
			url : "<%= request.getContextPath()%>/code/getCodeList.wn",
			data : $('#frm').serialize(),
			dataType : "json",

			success : function(data) {
				
				tree_data = "";
				tree_data = data.trModel;
				
				$('#jstree').jstree(
						{
							'core' : {
								"animation" : 0,
								"check_callback" : true,
								'themes': {
					                'name': 'proton',
					                'responsive': true
					            },
								'data' : tree_data

							},
							"search" : {

								"case_insensitive" : true,
								"show_only_matches" : true

							},
							"types" : {
								"#" : {
									"max_children" : 1,
									"max_depth" : 3,
									"valid_children" : [ "root" ]
								},
								"root" : {
									"icon" : "glyphicon glyphicon-file",
									"valid_children" : [ "file" ]
								},
								"default" : {
									"valid_children" : [
											"default",
											"file" ]
								},
								"file" : {
									"icon" : "glyphicon glyphicon-file",
									"valid_children" : []
								}
							},

							"plugins" : [ "search", "types", "themes",
									"state", "wholerow",
									"json_data" ] 
							/* dnd : 드래그앤드롭 */

						}).bind('loaded.jstree', function(event, data){
				            //트리 로딩 롼료 이벤트
				        })
				        .bind('select_node.jstree', function(event, data){
				        	
								//노드 선택 이벤트
								var code = data.instance.get_node(data.selected).id;      //id 가져오기
						    var type = data.instance.get_node(data.selected).type;    //type 가져오기
						    var path = data.instance.get_node(data.selected).path;    //paht 가져오기
						    //var a = data.instance.get_node(data.selected).data.a;   //data 에서 a 가져오기
						    var parent = data.instance.get_node(data.selected).parent;
						    var text = data.instance.get_node(data.selected).text;
							
							$('#cfct_id').val(code);
							$('#exquery').val(text);
							$('#query').val("");
							console.log(text);
			            	if(parent == "#" || parent == null){
			    				chkVal = false;
			    				$('#exquery').val("");
			    			}
							fn_getSearchResults(1);
							$('#std_cate_nm').text("[" + text + "]");
				        	
				        })
				     
				        
				        .bind("dblclick.jstree", function (event) {

							// node가 더블클릭 될때 처리될 event를 적어줍니다.??
							console.log("dblclick.jstree111");
							tree_rename();
				        	
							
						})
						
				        .bind("open_node.jstree", function (event, data) {
						// node가 open 될때 처리될 event를 적어줍니다.?

							console.log("open_node.jstree");
							
						
						})
						
						
						.bind("create.jstree", function (e, data) {
						// node가 create 될때 처리될 event를 적어줍니다.??
						
							console.log("create.jstree");
							
						
						})
						
						.bind("remove.jstree", function (e, data) {
						// node가 remove 될때 처리될 event를 적어줍니다.??
						l
							console.log("remove.jstree");
						
						})
						
						.bind("rename.jstree", function (e, data) {
						// node가 rename 될때 처리될 event를 적어줍니다.??
						
							console.log("rename.jstree");
						
						});
						

			},
			complete : function(data) {
				if(is_close){
					$('#jstree').jstree(false).close_all();			
				}
				$('#jstree').jstree(true).settings.core.data = tree_data;
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
	}
	
	
	//모달 트리 초기 세팅
	function getModalTreeData(is_close){
		

		var checkItems = new Array();
        $("input[name='chk']:checked").each(function() {checkItems.push($(this).val());});
        var docField = new Array();
		$('input[name=checked_sentence]:checked').each(function() {docField.push($(this).val());});
        
        if(docField.length === 0) {
			alert("1개 이상의 필드를 선택해야 합니다.");
			return false;
		}	 

		if(checkItems.length === 0) {
			alert("1개 이상의 분석결과 데이터를 선택해야 합니다.");
			return false;
		}
		
		console.log("docField : " + docField.join(","));
		console.log("checkItems : " +checkItems.join(","));
		
		$('#myModal2').modal();
		
		if(is_close == ""){
			is_close = false;
		}
		
		$.ajax({
			type : "post",
			async: true,
			url : "<%= request.getContextPath()%>/code/getCodeList.wn",
			data : $('#frm').serialize(),
			dataType : "json",

			success : function(data) {
				
				tree_data = "";
				tree_data = data.trModel;
				
				$('#modal_tree').jstree(
						{
							'core' : {
								"animation" : 0,
								"check_callback" : true,
								'themes': {
					                'name': 'proton',
					                'responsive': true
					            },
								'data' : tree_data

							},
							"search" : {

								"case_insensitive" : true,
								"show_only_matches" : true

							},
							"types" : {
								"#" : {
									"max_children" : 1,
									"max_depth" : 3,
									"valid_children" : [ "root" ]
								},
								"root" : {
									"icon" : "glyphicon glyphicon-file",
									"valid_children" : [ "file" ]
								},
								"default" : {
									"valid_children" : [
											"default",
											"file" ]
								},
								"file" : {
									"icon" : "glyphicon glyphicon-file",
									"valid_children" : []
								}
							},

							"plugins" : [ "search", "types", "themes",
									"state", "wholerow",
									"json_data" ] 
							/* dnd : 드래그앤드롭 */

						}).bind('loaded.jstree', function(event, data){
				            //트리 로딩 롼료 이벤트
				        })
				        .bind('select_node.jstree', function(event, data){
				        	
				        	//노드 선택 이벤트
				            var code = data.instance.get_node(data.selected).id;      //id 가져오기
						    var type = data.instance.get_node(data.selected).type;    //type 가져오기
						    var path = data.instance.get_node(data.selected).path;    //paht 가져오기
						    //var a = data.instance.get_node(data.selected).data.a;   //data 에서 a 가져오기
						    var parent = data.instance.get_node(data.selected).parent;
						    var text = data.instance.get_node(data.selected).text;
						    
							$('#cfct_id').val(code);

			            	if(parent == "#" || parent == null){
			    				chkVal = false;
			    			} 	
			            	
				        });
			},
			complete : function(data) {
				if(is_close){
					$('#modal_tree').jstree(false).close_all();			
				}
				$('#modal_tree').jstree(true).settings.core.data = tree_data;
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
	}
	

	
	//트리매뉴 생성버튼
	function tree_create() {
		
		var ref = $('#jstree').jstree(true);
		
		sel = ref.get_selected();
		
		if (!sel.length) {
			return false;
		}
		
		
		sel = sel[0];
		
		
		if(ref.get_node(ref.get_selected()).parent == "#"){
			sel = ref.create_node(sel, {
				"type" : "default","text" : "new Category", "data" : "new1"
			});
		}else{
			sel = ref.create_node(sel, {
				"type" : "file","text" : "new Code", "data" : "new2"
			});
		}
		
		
		if (sel) {
			//
			var parent = ref.get_node(ref.get_selected()).parent;
			var text = ref.get_node(ref.get_selected()).text;
			var id = ref.get_node(ref.get_selected()).id;
			
		    if(parent == "ROOT"){
		    	$('#code_type').val(id);	
		    	$('#code_desc').val(text);
		    	ref.edit(sel);
		    }else{
		    	ref.edit(sel);
		    }
		    
		}else{
			alertify.error('최하위 노드에서는 신규생성 할 수 없습니다.');
			return false;
		}
		
	}
	
	function tree_rename() {
		var ref = $('#jstree').jstree(true), sel = ref.get_selected();
		if (!sel.length) {
			return false;
		}
		sel = sel[0];
		ref.edit(sel);
	}
	
	//트리매뉴 저장버튼
	function tree_save(){
		
		var pItems = new Array();
		var items_depth = new Array();
		var items_text = new Array();
		var u_pItems = new Array();
		var u_items = new Array();
		var u_items_text = new Array();
		$('#cfsv_id').val($('#slt_server').val());
		
		
		
		//전체 아이디 가져오기
		var _model = $("#jstree").jstree(true)._model.data;
		$.each(_model, function(_idx, _idata){
			
			if(_idata.id != '#'){
				//신규 
				if(_idata.data != null){
					pItems.push(_idata.parent + "");		
					items_text.push(_idata.text + "");
					items_depth.push(_idata.parents.length -1);
				}else{//수정
					if(_idata.text != _idata.original.text){
						
						u_pItems.push(_idata.parent + "");		
						u_items.push(_idata.id + "");
						u_items_text.push(_idata.text + "")
					}
					/* console.log("_idata.original.text  : " + _idata.original.text ); */
				}
				console.log(_idata);
				console.log(_idata.parents.length -1);
			}
           
		});
		
		/*
		items_depth.join(",");
		pItems.join(",");
		items_text.join(",");
		u_pItems.join(",");
		u_items.join(",");
		u_items_text.join(",");
		*/
		console.log("pItems : " + pItems);
		console.log("u_pItems : " + u_pItems);
		console.log("u_items : " + u_items);
		
		$('#pItems').val(pItems);
		$('#items_text').val(items_text);
		$('#items_depth').val(items_depth);
		$('#u_pItems').val(u_pItems);
		$('#u_items').val(u_items);
		$('#u_items_text').val(u_items_text);
		
		alertify.confirm("저장 하시겠습니까?"
				, function() {
					$.ajax({
						type : "post",
						url : "<%= request.getContextPath()%>/study/saveTree.wn",
						data : $('#frm_tree').serialize(),
						dataType : "json",
						
						success : function(data) {
							alertify.success('저장 되었습니다.');
						},
						complete : function(data) {
							tree_refresh();
							
						},
						error : function(request, status, error) {
							 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					});
				}, function() {
					alertify.error('취소 하였습니다.');
				});
		
	}
	
	//트리매뉴 삭제버튼
	function tree_delete() {
	
		var d_items_id = new Array();
		var chkVal = true;
		
		//체크 된 아이디 가져오기		
		var _model = $("#jstree").jstree(true)._model.data;
		$.each(_model, function(_idx, _idata){
            if(_idata.state.checked){
            	if(_idata.parent == "#" || _idata.parent == null){
    				alertify.alert("최상위 노드는 삭제 할 수 없습니다. 서버관리에서 삭제해 주세요.");
    				chkVal = false;
    			}
            	d_items_id.push(_idata.id + "");
            }
		});
		
		d_items_id.join(",");
		console.log(parent);
		
		if(!chkVal) return false;
		
		$('#d_items').val(d_items_id);
		
		alertify.confirm("삭제 하시겠습니까? 삭제되는 카테고리의 학습데이터도 삭제 됩니다."
				, function() {
					$.ajax({
						type : "post",
						url : "<%= request.getContextPath()%>/study/deleteTree.wn",
						data : $('#frm_tree').serialize(),
						dataType : "json",
						
						success : function(data) {
							alertify.success('삭제 되었습니다.');
						},
						complete : function(data) {
							tree_refresh();
						},
						error : function(request, status, error) {
							 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					});
				}, function() {
					alertify.error('취소 하였습니다.');
				});
	}
	
	//트리매뉴 새로고침 버튼
	function tree_refresh(){
		
		$('#jstree').jstree(true).redraw(true);
		$('#jstree').jstree(true).refresh();
		$('#jstree').jstree("destroy");
		$('#tree_search').val('');
		
		getTreeData(true);		
	}
	</script>
      

</body>

</html>
