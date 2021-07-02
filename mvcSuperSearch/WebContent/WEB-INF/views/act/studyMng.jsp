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
            <h1 class="h5 mb-0 text-gray-800 font-weight-bold">| 학습관리 > 학습데이터  </h1>
          </div>
		<div class="row mb-2" >
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-12" >
            
              <!-- Basic Card Example -->
              <div class="card shadow" >
                <div class="card-header py-1">
                	<div class="row" id="center_content">
	                	
	                	<div class="col-xl-6 mb-0">
	                		<div class="row">
		                		<div class="col-xl-3" >
			                		<h6 class="m-2 font-weight-bold text-primary" style="text-align:left">* 서버선택 </h6>
			                	</div>
				                <div class="col-xl-9 text-left" >
					                  <select class="form-control" id="slt_server"  >
					                  </select>
				                </div>
			                </div>
		                </div>
		               
		                <div class="col-xl-6 mb-0 text-right text-justify">
		                	<div class="row ">
		                		<div class="col-xl-12 mb-0 m-1 my-0">
				                	<a href="#" class="btn btn-secondary btn-icon-split btn-sm" >
					                <span class="icon text-white-50" >
													<i class="fa fa-file-excel"></i>
													</span>									
					                <span class="text" data-toggle="modal" data-target="#fileModal">학습데이터 업로드</span>
					                </a>
				                	<a href="javascript:fn_std_download();" class="btn btn-secondary btn-icon-split btn-sm" >
					                <span class="icon text-white-50" >
					                <i class="fa fa-file-excel"></i>
					                </span>
					                <span class="text">학습데이터 다운로드</span>
					                </a>
				                	<a href="<%= request.getContextPath()%>/download/traningSample/training_sample.xlsx" id="sample_excel" class="btn btn-secondary btn-icon-split btn-sm">
					                <span class="icon text-white-50" >
					                <i class="fa fa-file-excel"></i >
					                </span>
					                <span class="text">학습데이터 양식 다운로드</span>
					                </a>
				                </div>
			                </div>
		                </div>
		                
	                 </div>
                </div>
              </div>
            </div>
          </div>
          <!-- row end -->
          
          <div class="row">
            <!-- TREE -->
            <div class="col-xl-4 mb-1" >
            <form id="frm" name="frm" method="post">
           	<input type="hidden" id="server_id" name="server_id" value=""/>
              <!-- Basic Card Example -->
              <div class="card shadow" style="overflow:scroll; height:1150px;">
                <div class="card-header py-1 mb-0">
                
                	<!-- <div class="row">
						<div class="col-xl-12 mb-0">
			                <input type="text"   id="tree_search" value="" class="form-control border-1 small" onkeypress="if( event.keyCode==13 ){fn_getList(1);}" placeholder="Search for...">
					     </div>
					</div> -->
                	
                	<div class="row">
	                	<div class="col-xl-12 py-1  mb-0">
							<button type="button" class="btn btn-info btn-sm"
								onclick="tree_refresh();">
								<i class="glyphicon glyphicon-refresh"></i> 새로고침
							</button>
							<button type="button" class="btn btn-warning btn-sm"
								onclick="tree_create();">
								<i class="glyphicon glyphicon-pencil"></i> 신규
							</button>
							<button type="button" class="btn btn-primary btn-sm"
								onclick="tree_edit();">
								<i class="glyphicon glyphicon-refresh"></i> 수정
							</button>
							<button type="button" class="btn btn-danger btn-sm"
								onclick="tree_delete();" title="체크 된 카테고리를 삭제합니다.">
								<i class="glyphicon glyphicon-remove"></i> 삭제
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
            <div class="col-xl-8 mb-2" >
	            <div class="col-xl-12 mb-2" >
	            	<div class="row">
	            		<div class="col-xl-12 mb-0" >
			              <div class="card shadow mb-4">
				                <div class="card-header py-3">
				                	<div class="row">
					                	<div class="col-xl-8">
					                  		<h6 class="m-0 font-weight-bold text-primary">* 학습데이터 검색</h6>
					                  	</div>
									</div>
				                 </div>
					             <div class="card-body table-responsive" id="std_card_body">
					                <div class="dataTables_wrapper" id="" >
					                <form id="frm_stdSearch" name="frm_stdSearch" method="post">
					                	<div class="row">
						                    <input type="hidden" id="std_pageNum" name="pageNum" value="">
						                    <input type="hidden" id="std_cfct_id" name="std_cfct_id" value="">
								             	<div class="col-sm-3 col-md-6"  style="float:left" >
								             		<i class="fas fa-angle-right fa-lg"></i><p class="m-1 font-weight-bold text-primary" style="font-size:1.0rem; display:inline-block; " id="std_cate_nm">[카테고리명]</p >
												</div>
												<div class="col-sm-3 col-md-6" >
													<div class="form-group input-group" >
								                    	<input type="text" id="std_query" name="std_query" value="" class="form-control bg-light border-0 small" onkeypress="if( event.keyCode==13 ){fn_getStudyDataList(1);}" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" >
										              	<div class="input-group-append">
										                	<button id="btn_search" class="btn btn-primary" type="button" onClick="javascipt:fn_getStudyDataList('1');">
										                  		<i class="fas fa-search fa-sm"></i>
										                	</button>
										              	</div>
										             </div>
												</div>
						                	</div>
					                 	</form> 
					                	<div class="row" >
					                		<div class="col-xl-12" style="overflow:auto; height:470px;">
					                			<table width="100%" draggable="true" class="table table-bordered dataTable" id="dataTable" role="grid" aria-describedby="dataTable_info" style="width: 100%;" cellspacing="0" cellpadding="24">
							                  		<thead >
														<tr role="row" style="font-size:0.8rem; line-height:10px">
															<th width="3%" align="center" ><input type="checkbox" name="std_chkAll" id="std_chkAll" value=""/></th>
															<th width="14%">구분/ID</th>
															<th width="*">내용</th>
															<th width="23%">등록일시</th>
														</tr>
													</thead>
													<tbody id="std_tb_list">
													</tbody>
												 </table>
					                		</div>
					                	</div>
					                	<div class="row">
					                		<div class="col-xl-2">
					                			<div class="dataTables_info" id="std_dataTable_info" role="status" aria-live="polite">total : </div>
					                		</div>
					                		
					                	</div>
					                	<div class="row">
						                	<div class="col-xl-8">
						                			<div class="dataTables_paginate paging_simple_numbers" >
						                				<ul class="pagination" id="std_pagination" style='font-size:0.8rem; line-height:10px'>
						                				</ul>
						                			</div>
						                	</div>
				                			<div class="col-lg-4" style="text-align:right">
							                  	<!-- <button type="button" class="btn btn-danger btn-sm"
													onclick="fn_deleteStudy();" title="체크 된 학습데이터를 삭제합니다.">
													<i class="glyphicon glyphicon-remove"></i> 삭제
												</button> -->
												<a href="javascript:fn_deleteStudy();" class="btn-sm btn-secondary" style="float: right;" >
								                    <span class="icon text-white-50">
								                      <i class="fas fa-check" ></i>
								                    </span>
								                    <span class="text">삭제</span >
							                    </a>
											</div >
						                		
				                		</div>
					                </div>
					            </div>
					          </div>
				          </div>
				          
				          
			          </div>
			          
			          <div class="row">
			          <!-- 분석 문장 입력 -->
				          <div class="col-xl-12 mb-0" >
				              <div class="card shadow mb-0">
					                <div class="card-header py-2">
					                	<div class="row" >
						                	<div class="col-xl-8">
						                  		<h6 class="m-0 font-weight-bold text-primary">* 학습데이터 문장 입력</h6>
						                  	</div>
						                  	<div class="col-lg-4" style="text-align:right">
							                  	<a id="btn_act" class="btn btn-success btn-icon-split btn-sm" href="javascript:fn_save_sentence();">
							                    <span class="icon text-white-45"  >
							                      <i class="fas fa-flag"></i>
							                    </span>
							                    <span class="text">저장</span >
							                  	</a>
											</div>
										</div>
					                 </div>
						             <div class="card-body table-responsive" id="">
						                <div class="form-group">
											<textarea id="sentence" name="sentence" class="form-control" rows="17" style='font-size:0.8rem;'></textarea>
										</div>
						             </div>
					           </div>
					       </div>
					  </div>
			          <!-- 
			          <div class="row">
			          	<div class="col-xl-3"></div >
						<div class="col-xl-4">
							<a href="#" onclick="fn_setStudy();" title="분석대상 목록에서 체크 된 항목이 선택 된 카테고리의 학습데이터로 등록 됩니다."><p class="fa fa-4x fa-arrow-circle-up"></p></a>
							<a href="#" onclick="fn_deleteStudy();" title="학습데이터 목록에서 체크 된 항목이 학습데이터에서 제거됩니다."><p class="fa fa-4x fa-arrow-circle-down"></p></a>
						</div>
			          </div >
			          
			          <div class="row">
				          	분석대상 검색
				            <div class="col-xl-7 mb-2"  >
					              <div class="card shadow mb-4">
						                <div class="card-header py-3">
						                	<div class="row">
							                	<div class="col-xl-8">
							                  		<h6 class="m-0 font-weight-bold text-primary" >* 분석대상 검색</h6>
							                  	</div>
											</div>
						                </div>
							             <div class="card-body table-responsive" id="frm_card_body">
							                <div class="dataTables_wrapper" id="dataTable_wrapper" >
							                <form id="frm_search" name="frm_search" method="post">
							                	<div class="row">
							                	 		<input type="hidden" id="startCount" name="startCount" value="0">
																		<input type="hidden" id="listCount" name="listCount" value="10">
								                    <input type="hidden" id="pageNum" name="pageNum" value="">
									             	<div class="col-sm-3 col-md-6">
																	<select class="form-control" id="collection" name="collection" onchange="javascipt:fn_changeCollectionList('1');">
																		<option value='cf_data_sigint'>OO정보</option>
																		<option value='cf_data_humint'>인간정보</option>
																	</select>
													</div>
													<div class="col-sm-3 col-md-6">
														<div class="form-group input-group" >
									                    	<input type="text" id="query" name="query" value="" class="form-control bg-light border-0 small" onkeypress="if( event.keyCode==13 ){fn_getList(1);}" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
											              	<div class="input-group-append">
											                	<button id="btn_search" class="btn btn-primary" type="button" onClick="javascipt:fn_getList('1');">
											                  		<i class="fas fa-search fa-sm"></i>
											                	</button>
											              	</div>
											             </div>
													</div>
							                	</div>
							                	<div class="row">
													<div class="col-sm-12 col-md-12 mb-2 justify-content-between" id="checkbox_sentence"></div>
							                	</div>
							                </form>
							                	<div class="row">
							                		<div class="col-xl-12">
							                			<table width="100%" draggable="true" class="table table-bordered dataTable" id="dataTable" role="grid" aria-describedby="dataTable_info" style="width: 100%;" cellspacing="0">
									                  		<thead>
																<tr role="row" style="font-size:0.8rem; line-height:10px">
																	<th width="3%" align="center" ><input type="checkbox" name="chkAll" id="chkAll"/></th>
																	<th width="10%">ID</th>
																	<th width="*">제목</th>
																	<th width="23%">등록일시</th>
																</tr>
															</thead>
															<tbody id="tb_list">
															</tbody>
														 </table>
							                		</div>
							                	</div>
							                	<div class="row">
							                		<div class="col-xl-2">
							                			<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">total : </div>
							                		</div>
							                		<div class="col-xl-12">
							                			<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
							                				<ul class="pagination" id="pagination" style='font-size:0.8rem; line-height:10px'>
							                				</ul>
							                			</div>
							                		</div>
							                	</div>
							                </div>
							            </div>
						          </div>
					          </div >
					          
					          <div class="col-xl-5 mb-4" >
						          <div class="card shadow mb-4">
						                <div class="card-header py-3">
						                  <h6 class="m-0 font-weight-bold text-primary">* 분석대상 상세</h6>
						                </div>
						                <div class="card-body">
							                <div class="card-body">
							                  <div class="card shadow mb-4" >
									                Card Header - Dropdown
										                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
											                  <h6 class="m-0 font-weight-bold text-primary"><strong id="detail_title">제목 : </strong></h6>
											                  <div class="dropdown no-arrow">
												                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
												                    </a>
												                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
													                      <div class="dropdown-header">Dropdown Header:</div>
													                      <a class="dropdown-item" href="#">Action</a>
													                      <a class="dropdown-item" href="#">Another action</a>
													                      <div class="dropdown-divider"></div>
													                      <a class="dropdown-item" href="#">Something else here</a>
												                    </div>
											                  </div>
										                </div>
										                
									                Card Body
										                <div class="card-body" id="detail_card">
									                  		<p>
									                            <textarea id="detail_content" class="form-control" rows="19" style='font-size:0.8rem;'></textarea>
									                        </p>
									                	</div>
									            </div>
									            <strong id="detail_category" style='font-size:0.8rem; line-height:10px' ></strong>
							                </div>
						                  </div>
						              </div>
					              Dropdown Card Example
					          	</div>
					          
					          
					          
				          </div> -->
				          <!-- row end -->
		          </div>
          
	       </div>
	        <!-- row end -->
	        </div>
          
          
          
                            <!-- Modal -->
                            <div class="modal fade"  id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog"  >
                                    <div class="modal-content" >
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
												                  <!-- <div class="dropdown no-arrow">
													                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
													                    </a>
													                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
														                      <div class="dropdown-header">Dropdown Header:</div>
														                      <a class="dropdown-item" href="#">Action</a>
														                      <a class="dropdown-item" href="#">Another action</a>
														                      <div class="dropdown-divider"></div>
														                      <a class="dropdown-item" href="#">Something else here</a>
													                    </div>
												                  </div> -->
											                </div>
										                <!-- Card Body test -->
										                <div class="card-body" >
										                
									                  		<p>
									                            <textarea id="modal_content" class="form-control w-100"
																rows="17" style='font-size:0.8rem;'></textarea>
									                        </p>
									                	</div>
										            </div>
									            <strong id="modal_category" style='font-size:0.8rem; line-height:10px' ></strong >
                                        </div>
                                        <div class="modal-footer ">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                            <button type="button" class="btn btn-primary" onclick="javascript:fn_updateStudyData();">저장</button>
                                        </div >
                                    </div >
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
														<!-- /.modal -->
														

							 <!-- Modal 2 -->
							 <div class="modal fade"  id="fileModal" tabindex="-1" role="dialog" aria-labelledby="fileModalLabel" aria-hidden="true">
                                <div class="modal-dialog"  >
                                    <div class="modal-content" >
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title" id="fileModalLabel">학습데이터 업로드</h4>
											</div>
											<div class="modal-body">
												<%-- <form id="frm_saveStdExcel" action="<%= request.getContextPath()%>/study/saveStdExcel.wn" method="POST" enctype="multipart/form-data"> --%>
												<form id="frm_saveStdExcel" method="POST" enctype="multipart/form-data">
														<span class="icon text-white-50" >
															<i class="fa fa-file-excel"></i>
														</span>
													<input class="btn btn-secondary btn-icon-split btn-sm" type="file" name="fname" id="fname">
												</form>
											</div>
                                        <div class="modal-footer ">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                            <button type="button" class="btn btn-primary" onclick="javascript:fn_std_upload();">업로드</button>
                                        </div >
                                    </div >
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->
                            
                            <!-- Modal 3 -->
                            <div class="modal fade" id="addTreeModal" tabindex="-1" role="dialog" aria-labelledby="addTreeModalLabel" aria-hidden="true">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="addTreeModalLabel"></h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <div class="modal-body">
							        <form>
							          <input type="hidden" id="tree_id" value="">
							          <div class="form-group">
							            <label for="tree_name" class="col-form-label">카테고리명:</label>
							            <input type="text" class="form-control" id="tree_name">
							          </div>
							          <div class="form-group">
							            <label for="tree_code" class="col-form-label">카테고리코드:</label>
							            <input type="text" class="form-control" id="tree_code">
							          </div>
							        </form>
							      </div>
							      <div class="modal-footer">
							      	<button type="button" class="btn btn-primary" onclick="tree_save();">저장</button>
							        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
							      </div>
							    </div>
							  </div>
							</div>
							 <!-- /.modal -->
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->
      <form id="frm_tree" name="frm_tree" method="post">
      	<input type="hidden" name="pItems" id="pItems" value="">
      	<input type="hidden" name="items_text" id="items_text" value="" >
      	<input type="hidden" name="items_depth" id="items_depth" value="" >
      	<input type="hidden" name="items_data" id="items_data" value="" >
      	<input type="hidden" name="u_pItems" id="u_pItems" value="">
      	<input type="hidden" name="u_items" id="u_items" value="">
      	<input type="hidden" name="u_items_text" id="u_items_text" value="">
      	<input type="hidden" name="cfsv_id" id="cfsv_id" value="">
      	<input type="hidden" name="d_items" id="d_items" value="">
      </form>
      
      <form id="frm_study" name="frm_study" method="post">
      	<input type="hidden" name="save_cfsv_id" id="save_cfsv_id" value="">
      	<input type="hidden" name="cfct_id" id="cfct_id" value="" >
      	<input type="hidden" name="checkItems" id="checkItems" value="">
		<input type="hidden" name="std_sentence" id="std_sentence" value="">
      </form>

	  	<form id="frm_del_study" name="frm_del_study" method="post">
      		<input type="hidden" name="delItems" id="delItems" value="">
		</form>

		<form id="frm_get_stdData" name="frm_get_stdData" method="GET">
		</form>
      
      <%@ include file="../common/bottom.jsp"%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/jsTree/dist/jstree.js"></script>
      	
	<script type="text/javascript">
	
	var tree_data;
	
	$(document).ready(function(){
		
		fn_getServerList();
		fn_getCollectionList();
		
		var p_page_num = $('#pageNum').val();
		
		/* if(p_page_num == ""){
			fn_getList("1");
		}else{
			fn_getList(p_page_num);
		}
		 */
	
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
		
		//트리 우클릭메뉴 위치 수정
		$('#jstree').on("show_contextmenu.jstree", function (e, data) {
	        var $node = $('#'+data.node.id),
	            $menu = $('.vakata-context').first(),
	            nodeTop = $node.offset().top, //선택한 트리 node Y좌표
	            menuTop = nodeTop + 25, //우클릭메뉴 Y좌표 설정
	            menuLeft = data.x, //우클릭메뉴 X좌표 설정
	            ctxHeight = $('.vakata-context').height(),
		        dh = $(window).height()+$(window).scrollTop();
	        
	        //하단에 잇는 트리에서는 우클릭메뉴가 위로 보이도록 조정
			if((menuTop+ctxHeight) > dh){
				menuTop = menuTop - ctxHeight - $node.height() - 5;
			}
			
			$menu.offset({left: menuLeft, top: menuTop });
		})
 
	});

	//학습데이터 업로드
	function fn_std_upload(){
		
		$('#content').oLoader({
			backgroundColor:'#4e73df',
			fadeInTime: 500,
			fadeOutTime: 1000,
			fadeLevel: 0.5
		});

		const form = jQuery("#frm_saveStdExcel")[0];
        const formData = new FormData(form);
        formData.append("excel_cfsv_id", $('#slt_server').val());
        formData.append("file", jQuery("#fname")[0].files[0]);

        $('#fileModal').modal("hide");

		$.ajax({
		 	url : "<%= request.getContextPath()%>/study/saveStdExcel.wn",
		 	async: true,
		 	type : "POST" ,
           	processData : false , 
           	contentType : false ,
           	data : formData ,

		 	success: function(data) {
		 		
		 		alert("카테고리[" + data.cateCnt + "]건 | 학습데이터[" + data.studyCnt + "]건이 저장되었습니다.");
		 		tree_refresh();
		 	},
		 	
		 	complete : function(data) {
		 		$('#content').oLoader('hide');				
		 	}
		})
		
	}

	function fn_std_download() {
		
		$('#content').oLoader({
			backgroundColor:'#4e73df',
			fadeInTime: 500,
			fadeOutTime: 1000,
			fadeLevel: 0.5
		});
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/study/downloadStudyData.wn",
			async: true,
			data : {
				cfsv_id: $('#slt_server').val()
			},
			cache: false,
			dataType : "json",
			success: function(data) {
				
				if(data.retVo.response){
		 			
		 			alertify.confirm("다운로드 하시겠습니까?", function() {
		 				
		 				window.location.href = "<%= request.getContextPath()%>/download/trainingData/" + data.retVo.downExcelFileName;
		 				
		 			});
		 			
		 			return;
		 			
		 		}else{
		 			
		 			alert(data.retVo.message);
		 			
		 		}
				
				
				
			},
			complete : function(data) {
				$('#content').oLoader('hide');					
			}
		});

	}
	
	//학습데이터 문장 입력
	function fn_save_sentence(){
		
        $('#std_sentence').val($('#sentence').val());
        $('#save_cfsv_id').val($('#slt_server').val());
        
        if($('#sentence').val() == ''){
        	
        	alert("문장을 입력해 주세요.");
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
							
							
							alertify.success('저장 되었습니다.');
							$('#sentence').val('');
							fn_getStudyDataList();
							
						},
						complete : function(data) {
							
						}
					});
				}, function() {
					alertify.error('취소 하였습니다.');
				});
	}
	
	
	
	//학습데이터 추가(분석대상 검색에서 체크 된 데이터)
	function fn_setStudy(){
		
		var ref = $("#jstree").jstree(true);
		var depthCnt = ref.get_node(ref.get_selected()).parents.length;
		var treeId = ref.get_node(ref.get_selected()).id;
		var collection = $('#collection').val();
		var docField = new Array();
			$('input[name=checked_sentence]:checked').each(function() {docField.push($(this).val());});
		
		if(depthCnt < 2){
			alert("최상위 카테고리에는 학습데이터를 넣을 수 없습니다.");
			return false;
		}
		
		var checkItems = new Array();
        $("input[name='chk']:checked").each(function() {checkItems.push($(this).val());});
        checkItems.join(",");
		
		console.log(docField.join(","));
		console.log(collection);
		console.log(checkItems.join(","));
		

		if(checkItems.length === 0) {
			alert("1개 이상의 학습데이터를 선택해야 합니다.");
			return false;
		}

		if(docField.length === 0) {
			alert("1개 이상의 필드를 선택해야 합니다.");
			return false;
		}

		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/study/setStudy.wn",
			data : {
				cfct_id: treeId,
				checkItems: checkItems.join(","),
				collection: collection,
				docField: docField.join(",")
			},
			dataType : "json",

			success: function(data) {
				fn_getStudyDataList();
				
			},
			complete : function(data) {
				// 분석대상 체크박스 전체 해제
				$('#chkAll').each(function(){
					var checked_status = this.checked;
		            this.checked = false;
		            
		            $("input[name=chk]").each(function()
		            {
		                this.checked = false;
		            });
				});
				
			}
		});
	}
	
	
	//학습데이터 삭제
	function fn_deleteStudy(){
		alertify.confirm("삭제 하시겠습니까?"
				, function() {
			var checkItems = new Array();
	        $("input[name='std_chk']:checked").each(function() {checkItems.push($(this).val());});
	        checkItems.join(",");
	        console.log(checkItems);
			
	        $('#delItems').val(checkItems);
			
			$.ajax({
				type : "post",
				url : "<%= request.getContextPath()%>/study/deleteStudy.wn",
				data : $('#frm_del_study').serialize(),
				dataType : "json",
	
				success : function(data) {
					
					alertify.success('삭제 되었습니다.');
					fn_getStudyDataList();
					
				},
				complete : function(data) {
					
					// 학습데이터 검색 전체 체크
					$('#std_chkAll').each(function(){
						var checked_status = this.checked;
			            
			            this.checked = false;
					});
	
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
			}
		});
		
	}
	

	//학습데이터 리스트 조회
	function fn_getStudyDataList(pageNum){
		$('#container-fluid').oLoader({
		      backgroundColor:'#4e73df',
		      fadeInTime: 500,
		      fadeOutTime: 1000,
		      fadeLevel: 0.5
		    });
		
	    $('#std_tb_list > tr').remove();
		$('#std_pagination > li').remove();
		$('#std_pageNum').val(pageNum);
		//$('#list_cnt').text().remove();
		$('#std_dataTable_info').html("total : 0");
		
		$('#std_cfct_id').val($('#cfct_id').val());
		
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/study/getStudyDataList.wn",
			data : $('#frm_stdSearch').serialize(),
			dataType : "json",

			success : function(data) {

				var list = data.list;
				var table = "";
				var cnt = 0;
				
				$('#std_query').val(data.std_query);
				
				if(Object.keys(list).length > 0){
					$.each(list, function(key, value) {
						cnt++;
						table += "<tr style='font-size:0.8rem; line-height:17px'>";
						table += "<input type='hidden' name='content' value='" + this.cfst_content.substring(0,5) + "'>";
						table += "<td align='center'><input type='checkbox' class='std_chk' name='std_chk' value='" + this.cfst_id + "'/></td>";
						//+ '<td><span data-toggle="modal" data-target="#myModal"><a href="javascript:fn_showDetail(\'' + this.cf_id + '\');" >'+ this.cf_title + '</a><span></td>'
						table += "<td>" + (this.cf_id ? this.cf_id.substr(0, 6) : "수동입력") + '</td>';
						table += '<td><span data-toggle="modal" data-target="#myModal"><a href="javascript:fn_showStdDetail(\'' + this.cfst_id + '\');" >'+ this.cfst_content.substr(0, 35) + '</a><span></td>'
						table += '<td>'+ this.cfst_upd_dt + '</td></tr>';
					});
					
					$('#std_tb_list').append(table);
					$('#std_pagination').html(data.pageCode);
					$('#std_dataTable_info').html("total : " + data.totalCount + "");
					
				}else{
					$('#std_tb_list > tr').remove();
					$('#std_tb_list').append(
					'<tr><td colspan="4" align="center">등록 된 학습 데이터가 존재 하지 않습니다.</td></tr>');
				}
				

			},
			complete : function(data) {
				
				$('#container-fluid').oLoader('hide');
				
				
			}
		});
		
		
	}
	
	// 검색엔진 개별 문서 상세검색
	function fn_getDetail(id){
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/act/getSearchDetail.wn",
			data :{
				"collection": $('#collection').val(),
				"uid" : id
			},
			dataType : "json",

			success : function(data) {
				console.log(data);
				var vo = data[data.length-1];
				
				$('#detail_title').text("제목 : " + vo.CF_TITLE);
				
				if($('#collection').val() === "cf_data_sigint"){
					let html = "<p><textarea id='detail_content' class='form-control' rows='19' style='font-size:0.8rem;' readonly='readonly'></textarea></p>";
					$('#detail_card').html(html);
					$('#detail_content').text(vo.CF_CONTENT);
				}else if($('#collection').val() === "cf_data_imint") {
					let html = "<p><textarea id='detail_content' class='form-control' rows='17' style='font-size:0.8rem;' readonly='readonly'></textarea></p>";
					$('#detail_card').html(html);
					$('#detail_content').text(vo.ATTACHFILE_CONTENT);
				}else {
					// 차후 리펙토링 
					let html = "<p><textarea id='detail_content' class='form-control' rows='19' style='font-size:0.8rem;' readonly='readonly'></textarea></p>";
					$('#detail_card').html(html); 
					let str = 1;
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_1){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_1+"</a><textarea id='detail_content1' class='form-control' rows='7' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#detail_card').html(html);
						$('#detail_content1').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_1);
					}
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_2){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_2+"</a><textarea id='detail_content2' class='form-control' rows='7' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#detail_card').append(html);
						$('#detail_content2').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_2);
					}
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_3){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_3+"</a><textarea id='detail_content3' class='form-control' rows='7' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#detail_card').append(html);
						$('#detail_content3').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_3);
					}
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_4){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_4+"</a><textarea id='detail_content4' class='form-control' rows='7' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#detail_card').append(html);
						$('#detail_content4').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_4);
					}
					if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_5){
						html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_5+"</a><textarea id='detail_content5' class='form-control' rows='7' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
						$('#detail_card').append(html);
						$('#detail_content5').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_5);
					}
				}

				let gubunHtml = "* 문서구분 : ";
				if($('#collection').val() === "cf_data_sigint") gubunHtml += vo.CF_CATEGORY;
				else if($('#collection').val() === "cf_data_imint") gubunHtml = "";
				else gubunHtml += vo.WISE_CF_DATA_HUMINT_MENU;

				$('#detail_category').html(gubunHtml);
				
			},
			
			complete : function(data) {
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
		})
	}


	// 컬렉션별 체크박스 생성
	function fn_showSentence(collection) {
		let htmlstr = "";
		if(collection === "cf_data_sigint"){
			htmlstr = "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='ORG_DOC_NO'>문서번호"
						+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_TITLE' checked>제목"
						+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_CONTENT'>본문";
		} else if (collection === "cf_data_imint") {
			htmlstr = "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_TITLE' checked>제목"
						+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='ATTACHFILE_CONTENT'>본문";
		} else {
			htmlstr = "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='CF_TITLE' checked>제목"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_1'>첨부1"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_2'>첨부2"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_3'>첨부3"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_4'>첨부4"
							+ "<input class='col-sm-1' type='checkbox' name='checked_sentence' value='HUMAN_REPORT_ATTACHFILE_CONTENT_5'>첨부5"
		}
		$('#checkbox_sentence').html(htmlstr);
	}

	function fn_changeCollectionList(){
		$('#query').val('');
		fn_getList('1');
	}
	

	//분석대상 검색 데이터 리스트
	function fn_getList(pageNum) {
		
		$('#frm_card_body').oLoader({
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
			url : "<%= request.getContextPath()%>/act/getSearchList.wn",
			data : $('#frm_search').serialize(),
			cache: false,
			dataType : "json",
			success : function(data) {
				
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
						table +=  this.UID + '</td>'
						//+ '<td><span data-toggle="modal" data-target="#myModal"><a href="javascript:fn_showDetail(\'' + this.cf_id + '\');" >'+ this.cf_title + '</a><span></td>'
						+ '<td><a href="javascript:fn_getDetail(\'' + this.UID + '\');" >'+ this.CF_TITLE + '</a></td>'
						+ '<td>'+ ($("#collection").val() === "cf_data_sigint" ? this.CF_DATE : this.CF_DATE.substr(0, 4) + "-" + this.CF_DATE.substr(4, 2) + "-" 
								+ this.CF_DATE.substr(6, 2) + " " + this.CF_DATE.substr(8, 2) + ":" + this.CF_DATE.substr(10, 2) + ":" + this.CF_DATE.substr(12, 2)) + '</td></tr>';
					})
					
					$('#tb_list').append(table);
					$('#pagination').html(data.pageCode);
					$('#dataTable_info').html("total : " + data.totalCount + "");
					fn_showSentence($('#collection').val());
				}else{
					$('#tb_list').append(
					'<tr><td colspan="4" align="center">데이터가 존재 하지 않습니다.</td></tr>');
				}
			},
			complete : function(data) {
				$('#frm_card_body').oLoader('hide');
				$('#detail_title').text("제목 : ");
				$('#detail_content').text("");
				$('#detail_category').text("* 문서구분 : ");
			}
		});
		
	}
	

	//분석대상 검색 상세데이터
	function fn_showDetail(id){
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/act/getDetail.wn",
			data :{
				"cf_id" : id
			},
			dataType : "json",

			success : function(data) {
				$('#detail_title').text('');
				$('#detail_content').text('');
				$('#detail_category').text('');
				
				//console.log(data);
				var vo = data.dtVo;
				
				$('#detail_title').text("[제목]  " + vo.cf_title);
				$('#detail_content').text(vo.cf_content);
				$('#detail_category').text("* 문서구분 : " + vo.cf_category );
				
			},
			
			complete : function(data) {
			}
		});
		
	}
	
	
	//
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
				$('#modal_content').val(vo.cfst_content);
				//if(vo.cf_gubun !== null) $('#modal_category').text("* 문서구분 : " + vo.cf_gubun);
				$('#cfst_id').val(vo.cfst_id);
			},
			
			complete : function(data) {
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
						fn_getStudyDataList();
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
	function getTreeData(is_close, select_node_id){
		
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
				console.log("tree_data : " + JSON.stringify(tree_data));
				
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
									"max_depth" : 2,
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

							
							"plugins" : [ "search", "types", "themes", "checkbox",
									"state", "wholerow", "contextmenu",
									"json_data" ] 
							
							,
							"contextmenu":{         
							    "items": function($node) {
							        var tree = $("#jstree").jstree(true);
							        return {
							            "Create": {
							                "separator_before": false,
							                "separator_after": false,
							                "label": "신규",
							                "action": function (obj) {
							                	tree_create();
							                }
							            },
							            "Rename": {
							                "separator_before": false,
							                "separator_after": false,
							                "label": "수정",
							                "action": function (obj) { 
							                	tree_edit();
							                }
							            },                         
							            "Remove": {
							                "separator_before": false,
							                "separator_after": false,
							                "label": "삭제",
							                "action": function (obj) {
							                	tree_delete("selected");
							                }
							            }
							        };
							    }
							}
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
							fn_getStudyDataList('1');	
							$('#std_cate_nm').text("카테고리 : [" + text + "]");
				        	
				        })
				     
				        
				        .bind("dblclick.jstree", function (event) {

							// node가 더블클릭 될때 처리될 event를 적어줍니다.??
							console.log("dblclick.jstree111");
							tree_edit();
				        	
							
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
				if(select_node_id){
					setTimeout(getTreeDataCallback, 200, select_node_id);
				}
			}
		});
		
	}
	
	//신규 추가 시, 추가된 노드가 선택되는 콜백함수
	var getTreeDataCallback = function (node_id) { 
			$('#jstree').jstree(true).deselect_all();
			$('#jstree').jstree(true).select_node(node_id); 
		}
	
	//트리매뉴 생성버튼
	function tree_create() {
		$('#addTreeModalLabel').html('카테고리 신규');
		$('#tree_id').val('');
		$('#tree_name').val('');
		$('#tree_code').val('');
    	$('#addTreeModal').modal('show');
	}
	
	//트리매뉴 수정버튼
	function tree_edit() {
		var ref = $('#jstree').jstree(true);
		var sel = sel = ref.get_selected();
		$('#addTreeModalLabel').html('카테고리 수정');
		$('#tree_id').val(sel[0]);
		$('#tree_name').val(ref.get_node(sel[0]).text);
		$('#tree_code').val(ref.get_node(sel[0]).data);
    	$('#addTreeModal').modal('show');
	}
	
	//트리 저장
	function tree_save() {
		
		var ref = $('#jstree').jstree(true);
		var treeId = $('#tree_id').val();
		var treeName = $('#tree_name').val();
		var treeCode = $('#tree_code').val();
		var parentId = "0";
		var itemDepth = "1";
		
		if (treeId != "") {
			parentId = ref.get_node(treeId).parent;
			itemDepth = ref.get_node(treeId).parents.length -1;
		}

		if(treeName == "" || treeCode == ""){
			alert("카테고리명과 카테고리코드 모두 입력하세요.");
			return false;
		}else{
			//파라미터 세팅
			$('#cfsv_id').val($('#slt_server').val());
			$('#u_items').val(treeId);
			$('#pItems').val(parentId);
			$('#items_text').val(treeName);
			$('#items_data').val(treeCode);
			$('#items_depth').val(itemDepth);
			
			alertify.confirm("저장 하시겠습니까?"
					, function() {
						$.ajax({
							type : "post",
							url : "<%= request.getContextPath()%>/study/saveTree.wn",
							data : $('#frm_tree').serialize(),
							dataType : "json",
							
							success : function(data) {
								var result = data.result;
								if(result == "D"){
									alertify.alert("카테고리 코드가 중복되었습니다.");
									return false;
								}else if(result == "I"){
									tree_refresh(false, data.id);
									alertify.alert("카테고리가 추가되었습니다.");
									$('#addTreeModal').modal('hide');
								}else if(result == "U"){
									alertify.alert("카테고리가 수정되었습니다.");
									tree_refresh();
									$('#addTreeModal').modal('hide');
								}
							}
						});
					}, function() {
						alertify.error('취소 하였습니다.');
			});
		}
	}
	
	//트리매뉴 삭제버튼
	function tree_delete(state) {
	
		var d_items_id = new Array();
		var chkVal = false;
		
		if(state === "selected"){
			//우클릭 시 선택되어 있는 노트만 삭제하기
			d_items_id.push($("#jstree").jstree(true).get_selected()+"");
			chkVal = true;
		}else{
			//체크 된 아이디 가져오기		
			var _model = $("#jstree").jstree(true)._model.data;
			$.each(_model, function(_idx, _idata){
	            if(_idata.state.checked){
	            	if(_idata.parent == "#" || _idata.parent == null){
	    				alertify.alert("최상위 노드는 삭제 할 수 없습니다. 서버관리에서 삭제해 주세요.");
	    				chkVal = false;
	    			}
	            	d_items_id.push(_idata.id + "");
	            	chkVal = true;
	            }
			});
		}
		
		d_items_id.join(",");
		
		if(!chkVal){
			alertify.alert("삭제할 카테고리를 체크하세요.");
			return false;
		}
		
		$('#d_items').val(d_items_id);
		$('#cfsv_id').val($('#slt_server').val());

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
							tree_refresh(true);
							fn_getStudyDataList();
						}
					});
				}, function() {
					alertify.error('취소 하였습니다.');
				});
		
	}
	
	
	
	
	//트리매뉴 새로고침 버튼
	function tree_refresh(clear, id){
		//화면 초기화 필요시 tree_refresh(true)
		if(clear){
			location.reload();
			localStorage.removeItem('jstree'); //현재 jstree내에 체크 및 선택 정보 삭제
		}
		
		$('#jstree').jstree(true).redraw(true);
		$('#jstree').jstree(true).refresh();
		$('#jstree').jstree("destroy");
		$('#tree_search').val('');
		
		getTreeData(true, id);	
		
	}
	
	</script>
      

</body>

</html>
