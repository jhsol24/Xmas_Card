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

          <div class="row">
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-6 mb-4">
            <form id="frm" name="frm" method="post">
              <!-- Basic Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                	<div class="row">
	                	<div class="col-lg-8">
	                  		<h6 class="m-0 font-weight-bold text-primary">* 테스트 문장을 입력해 주세요.</h6>
	                  	</div>
	                  	<div class="col-lg-4" style="text-align:right">
		                  	<a id="btn_act" class="btn btn-success btn-icon-split btn-sm" href="javascript:getActRs();">
		                    <span class="icon text-white-50">
		                      <i class="fas fa-flag"></i>
		                    </span>
		                    <span class="text">시뮬레이터 실행</span>
		                  	</a>
								<!-- <div class="btn-group">
									<button type="button" id="btn_act" onClick="getActRs();"
										class="btn btn-outline btn-primary btn-xs">시뮬레이터 실행
									</button>
								</div> -->
						</div>
					</div>
                </div>
                <div class="card-body">
                  <div class="form-group">
						<textarea id="sentence" name="sentence" class="form-control" rows="15"></textarea>
					</div>
                </div>
              </div>
            </form>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-6 mb-4">
              <!-- Basic Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">* 시뮬레이션 결과</h6>
                </div>
                <div class="card-body">
                  <div class="col-xl-12 mb-1">
		              <div class="card border-left-primary shadow h-100 py-2">
		                <div class="card-body" >
		                  <div class="p-1 bg-gray-200">
		                  	<p class="m-1 font-weight-bold text-primary fa fa-chevron-circle-right" id="pAnalRs" style='font-size:0.9rem; line-height:10px'> 분석결과 : </p>
		                  </div>
		                  <table width="100%"
								class="table table-striped table-bordered table-hover" >
								<thead>
									<tr style='font-size:0.8rem; line-height:10px'>
										<th><p class="m-0 font-weight-bold">순위 </p></th>
										<th><p class="m-0 font-weight-bold">결과 </p></th>
										<th><p class="m-0 font-weight-bold">점수 </p></th>
									</tr>
								</thead>
								<tbody id="tbAnalRs">
									<%-- <c:forEach var="training" items="${list }">
	                                    <tr class="odd gradeX">
	                                        <td>${training.response }</td>
	                                        <td>${training.question }</td>
	                                    </tr>
                                	</c:forEach> --%>
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

          <div class="row">
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-6 mb-4" >
              <!-- Basic Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                	<div class="row">
	                	<div class="col-xl-8">
	                  		<h6 class="m-0 font-weight-bold text-primary">* 분석대상 검색</h6>
	                  	</div>
	                  	
					</div>
                </div>
	             <div class="card-body table-responsive" id="ajax-example-1">
	                <div class="dataTables_wrapper" id="dataTable_wrapper" >
	                <form id="frm_search" name="frm_search" method="post">
	                	<div class="row">
	                	
	                    <input type="hidden" id="pageNum" name="pageNum" value="">
	                    <!-- <div class="form-group input-group" >
	                    <input type="text" id="query" name="query" value="" class="form-control bg-light border-0 small" onkeypress="if( event.keyCode==13 ){getList(1);}" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
			              	<div class="input-group-append">
			                	<button id="btn_search" class="btn btn-primary" type="button" onClick="javascipt:getList('1');">
			                  		<i class="fas fa-search fa-sm"></i>
			                	</button>
			              	</div>
			             </div>
			             </form> -->
			             	<div class="col-sm-3 col-md-6">
								
							</div>
							<div class="col-sm-3 col-md-6">
								<div class="form-group input-group" >
			                    	<input type="text" id="query" name="query" value="" class="form-control bg-light border-0 small" onkeypress="if( event.keyCode==13 ){getList(1);}" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
					              	<div class="input-group-append">
					                	<button id="btn_search" class="btn btn-primary" type="button" onClick="javascipt:getList('1');">
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
										<tr role="row" style="font-size:0.8rem; line-height:10px">
											<th width="10%">ID</th>
											<th width="*">제목</th>
											<th width="30%">등록일시</th>
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
	                		<div class="col-xl-10">
	                			<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
	                				<ul class="pagination" id="pagination" style='font-size:0.8rem; line-height:10px'>
	                				</ul>
	                			</div>
	                		</div>
	                	</div>
	                </div>
	            </div>
	          </div>
	        </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-6 mb-4">
              <!-- Basic Card Example -->
	              <!-- <div class="card shadow mb-4">
		                <div class="card-header py-3">
		                  <h6 class="m-0 font-weight-bold text-primary">* 분석대상 상세</h6>
		                </div>
		                <div class="card-body">
		                  <div class="col-xl-12 mb-1">
					              <div class="card border-left-primary shadow h-100 py-2">
						                <div class="card-body">
						                  <div class="col-lg-14">
							                    <div class="panel panel-warning">
							                        <div class="panel-heading"><strong id="detail_title">제목 : </strong></div>
							                        <div class="panel-body" >
							                            <p>
							                            <textarea id="detail_content" class="form-control"
														rows="15"></textarea>
							                            </p>
							                        </div>
							                        <div class="panel-footer" ><strong id="detail_category"></strong></div>
							                    </div>
							                </div>
						                </div>
					              </div>
				            </div>
		                </div>
	              </div> -->
	              <!-- Basic Card Example -->
	              <div class="card shadow mb-4">
		                <div class="card-header py-3">
		                  <h6 class="m-0 font-weight-bold text-primary">* 분석대상 상세</h6>
		                </div>
		                <div class="card-body">
		                  <div class="col-xl-12 mb-1">
					              <div class="card border-left-primary shadow h-80 py-2 ">
						                <div class="card-body">
						                  <div class="card shadow mb-4" >
								                <!-- Card Header - Dropdown -->
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
									                
								                <!-- Card Body -->
									                <div class="card-body">
								                  		<p>
								                            <textarea id="detail_content" class="form-control"
															rows="15" style='font-size:0.8rem;'></textarea>
								                        </p>
								                	</div>
								            </div>
								            <strong id="detail_category" style='font-size:0.8rem; line-height:10px'></strong>
						                </div>
					              </div>
				            </div>
		                </div>
	              </div>
	              <!-- Dropdown Card Example -->
	              
          </div>
          <!-- row end -->

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      
      <%@ include file="../common/bottom.jsp"%>
      
      	
	<script type="text/javascript">
	$(document).ready(function(){
		
		var p_page_num = $('#pageNum').val();
		
		if(p_page_num == ""){
			getList("1");
		}else{
			getList(p_page_num);
		}
		
		$('#query').on("keypress",function(){
			
			if(event.keyCode == '13') event.preventDefault();
			
		});

	});
	
	
	function showDetail(id){
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/act/getDetail.wn",
			data :{
				"cf_id" : id
			},
			dataType : "json",

			success : function(data) {

				var vo = data.dtVo;
				
				$('#detail_title').text("제목 : " + vo.cf_title);
				$('#detail_content').text(vo.cf_content);
				$('#detail_category').text("문서구분 : " + vo.cf_category);
				
			},
			
			complete : function(data) {
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
	}
	
	
	
	function getList(pageNum) {
		
		
		/* var $btn = $('#btn_search').button('loading'); */
		/* $('#ajax-example-1').oLoader(); */
		/* $('#btn_search').oLoader('show'); */
		$('#ajax-example-1').oLoader({
		      backgroundColor:'#4e73df',
		      fadeInTime: 500,
		      fadeOutTime: 1000,
		      fadeLevel: 0.5
		    });
		
	    $('#tb_list > tr').remove();
		$('#pagination > li').remove();
		$('#pageNum').val(pageNum);
		//$('#list_cnt').text().remove();

		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/act/getList.wn",
			data : $('#frm_search').serialize(),
			dataType : "json",

			success : function(data) {

				var list = data.list;
				var table = "";
				var cnt = 0;
				
				$('#query').val(data.actVo.query);
				
				if(Object.keys(list).length > 0){
					$.each(list, function(key, value) {
						cnt++;
						table += "<tr style='font-size:0.8rem; line-height:10px'>";
						table += "<input type='hidden' name='content' value='" + this.cf_content + "'>";
						table += "<td>";
						table +=  this.cf_id + '</td>'
						+ '<td><a href="javascript:showDetail(\'' + this.cf_id + '\');" >'+ this.cf_title + '</a></td>'
						+ '<td>'+ this.cf_upd_dt + '</td></tr>';
					})
					
					$('#tb_list').append(table);
					$('#pagination').html(data.pageCode);
					$('#dataTable_info').html("total : " + data.totalCount + "");
					
					/* $('a[name=a_title').on('click',function(){
						
						alert($(this).parent().parent().find('input[name=content]').val());
						var dt_content = $(this).parent().parent().find('input[name=content]').val();
						$('#detail_list > a').text(dt_content);
						
					}); */
					
					
				}else{
					$('#tb_list').append(
					'<tr><td colspan="3" align="center">데이터가 존재 하지 않습니다.</td></tr>');
				}
				

			},
			complete : function(data) {
				/* $btn.button('reset'); */
				$('#ajax-example-1').oLoader('hide');
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
		
	}
	
	
	
	
	
	function getActRs() {
		
		/* var $btn = $('#btn_act').button('loading'); */
	    

		$('#tbAnalRs > tr').remove();
		$('#pAnalRs').text('');
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/act/getActRs.wn",
			data : $('#frm').serialize(),
			dataType : "json",

			success : function(data) {

				var list = data.list;
				var table = "";
				var cnt = 0;
				
				if(Object.keys(list).length > 0){
					$.each(list, function(key, value) {
						cnt++;
						table += "<tr style='font-size:0.9rem; line-height:10px'><td>";
						table +=  cnt + '</td>'
						+ '<td>'+ this.analLabel + '</td>'
						+ '<td>'+ this.analConfidence + '</td></tr>';
					
				})
					
				$('#tbAnalRs').append(table);
				$('#pAnalRs').html(" 분석결과 : <span class='text-danger'>" + data.analRs + "</span>");
				
				}else{
					
				}
				

			},
			complete : function(data) {
				/* $btn.button('reset'); */
			},
			error : function(request, status, error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});

	}
	
	
	
	</script>
      

</body>

</html>
