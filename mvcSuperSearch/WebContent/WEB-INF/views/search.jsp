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

<%@ include file="./common/sideBar.jsp"%>


    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">
      
<%@ include file="./common/top.jsp"%>
  

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">분석결과조회</h1>
					</div>

					<div class="row">
						<div class="col-lg-12 mb-3 align-items-center" >
						
							<!-- Basic Card Example -->
							<div class="card shadow" >
								<div class="card-header py-2">
									<!-- row start-->
									<div class="row" >

										<div class="col-md-6 m-auto ml-0 d-flex">
												<div class="col-md-4">
														<select class="form-control" id="select_collection" onchange="javascript:fn_changeCollectionList();">
															<option value="cf_data_humint,cf_data_sigint,cf_data_osint,cf_data_masint,cf_data_imint">전체</option>
														</select>
												</div>
												<div class="col-md-8">
													<form id="frm_search" name="frm_search" method="POST">
														<input type="hidden" name="collection" id="collection" value="">
														<input type="hidden" name="listCount" id="listCount" value="10">
														<input type="hidden" name="startCount" id="startCount" value="">
														<input type="hidden" name="startDate" id="startDate" value="">
														<input type="hidden" name="endDate" id="endDate" value="">
														<input type="hidden" name="pageNum" id="pageNum" value="">
														<input type="hidden" name="exquery" id="exquery" value="">
														<input type="hidden" name="range" id="range" value="RANK/DESC">
														<div class="input-group">
															<input type="text" class="form-control bg-light border-1" id="query" onkeypress="if( event.keyCode==13 ){fn_doSearch(1);}" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2">
															<div class="input-group-append">
																<button class="btn btn-primary" onclick="event.preventDefault(); fn_doSearch(1);">
																	<i class="fas fa-search fa-sm"></i>
																</button>
															</div>
														</div>
													</form>
													</div>
											</div>
											
											<div class="col-md-3"></div>

											<div class="col-md-3">
												<div class="col-md-12 text-right">
													<div class="mb-0 font-weight-bold">
														<button class="btn btn-primary mr-1" value="RANK" onclick="fn_clickRange('RANK/DESC');">정확도순</button>
														<button class="btn btn-primary" value="DATE" onclick="fn_clickRange('CF_DATE/DESC');">날짜순</button>
													</div>
												</div>
												<!-- 
												<div class="col-md-8 m-auto">
														<div class="h6 mb-0 text-gray-800">
															<input class="bg-light col-sm-3" style="border: 1px solid #d1d3e2; border-radius: 5px; padding: 1.2%;" type="text" name="start_date" id="start_date" readonly> ~
															<input class="bg-light col-sm-3" style="border: 1px solid #d1d3e2; border-radius: 5px; padding: 1.2%;" type="text" name="end_date" id="end_date" readonly>
															<input class="btn-sm btn-primary" type="button" value="적용">
														</div>
												</div>
												 -->
											</div>

										</div>
										<!-- row end-->

								</div>
							</div>
						</div>
					</div>
					<!-- row end-->
					
          <!-- Content Row -->
					<div class="row" id="searchContent">
						<div class="col-md-2">
							<div class="card shadow mb-2">
									<div class="card-header py-3">
											<div class="row">
												<div class="col-lg-12">
													<select class="form-control" id="select_group" onchange="javascript:fn_getCategoryGubun($('#select_collection').val());">
														<option value="XGBOOST_ANAL_RS">군별병〮종별</option>
														<option value="PMESII_ANAL_RS">PMESII</option>
													</select>
												</div>
										</div>
									</div>
									<!-- card-header-->
									<!-- card-body-->
									<div class="card-body">
										<div class="font-weight-normal" id="gubun_tree">
										</div>
									</div>
							</div>
						</div>
						
							<div class="col-md-10">
								<div class="card shadow mb-4">

									<div class="card-header py-3">
											<div class="row">
												<div class="col-lg-8">
													<h6 class="m-0 font-weight-bold text-primary" id="totalCount">검색결과 총 0건</h6>
												</div>
											<div class="col-lg-4" style="text-align:right" id='download'></div>
										</div>
									</div>
									<!-- card-header-->
									<!-- card-body-->
									<div class="card-body" id="contentBody">
									</div> <!-- card-body end -->

								</div>
							</div>
						</div>
						<!-- row end-->
							
					</div>

        </div>
        <!-- /.container-fluid -->
			
			<%@ include file="./common/bottom.jsp"%>
      </div>
			<!-- End of Main Content -->

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

	<form id="frm_get_searchData" name="frm_get_searchData" method="GET">
	</form>

	<script type="text/javascript">

		const collectionAll = "cf_data_humint,cf_data_sigint,cf_data_osint,cf_data_masint,cf_data_imint";
		
		$(document).ready(function(){
			//$("#start_date").datepicker({dateFormat: "yyyy/mm/dd"});
			//$("#end_date").datepicker({dateFormat: "yyyy/mm/dd"});

			fn_getCategoryGubun(collectionAll);
			fn_getCollectionList();
			fn_getTotalSearchList();

			$('#query').on("keypress",function(){
				if(event.keyCode == '13') event.preventDefault();
			})

			var p_page_num = $('#pageNum').val();

		});

		function fn_doSearch(pageNum) {

			fn_getCategoryGubun($('#select_collection').val());
			if($('#select_collection').val() === collectionAll){
				fn_getTotalSearchList();
			}else {
				fn_getList(pageNum)
			}
		}

		// 컬렉션 이동
		function fn_changeCollectionList(){
			$('#query').val('');
			$('#exquery').val('');

			if($('#select_collection').val() === collectionAll) {
				fn_getTotalSearchList();
				fn_getCategoryGubun(collectionAll)
			}else {
				fn_getList('1');
				fn_getCategoryGubun($('#select_collection').val())
			}
		}

		// 더보기 버튼
		function fn_moreBtn(collection) {
			$('#select_collection').val(collection);
			$('#query').focus();
			fn_getList('1');
			fn_getCategoryGubun(collection);
		}

		// 정렬버튼 기능
		function fn_clickRange(range) {
			$('#range').val(range);
 
			if($('#select_collection').val() === collectionAll) {
				fn_getTotalSearchList();
			}else {
				fn_getList('1');
			}	
		}

		// 군별병〮종별, PMESI 클릭
		function fn_clickGubun(text) {
			$('#exquery').val(text);

			$('#gubun_tree > p').parent().find('p').attr('style', 'color:#858796; cursor:pointer;');
			
			event.target.style.fontWeight = '700';
			
			if($('#select_collection').val() === collectionAll) {
				fn_getTotalSearchList();
			} else {
				fn_getList('1');
			}
		}

		// exquery 만들기 	
		function fn_makeExquery(text) {
			if(text === "") return text;
			const splitText = text.split("/");

			if(splitText.length > 1) {
				let contains = "";
				for(let i=0; i < splitText.length; i++){
					contains += (splitText[i] ? "<" + $('#select_group').val() + ":contains:" + splitText[i] +">" : "");
				}
				//console.log(contains);
				return contains;
			}else {
				return "<"+$('#select_group').val()+":contains:" + text +">";
			}
		}

		function fn_commaNumber(number) {
			return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}


		function fn_search_download() {

			$('#searchContent').oLoader({
				backgroundColor:'#4e73df',
				fadeInTime: 500,
				fadeOutTime: 1000,
				fadeLevel: 0.5
			});
			
			$.ajax({
				type : "post",
				url : "<%= request.getContextPath()%>/search/downloadSearchResult.wn",
				async: true,
				data : {
					collection: $('#select_collection').val(),
					query: $('#query').val(),
					startCount: $('#startCount').val(),
					listCount: 10000,
					pageNum: $('#pageNum').val(),
					range: $('#range').val(),
					highlight: false,
					exquery: fn_makeExquery($('#exquery').val()),
					gubun: $('#exquery').val()
				},
				cache: false,
				dataType : "json",
				success: function(data) {
					console.log(data);
					let actionUrl =  "<%=request.getContextPath()%>" + data.url;
					$('#frm_get_searchData').attr("action", actionUrl);
					$('#frm_get_searchData').submit();
				},
				complete : function(data) {
					$('#searchContent').oLoader('hide');			
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
	
		}

		function fn_getCategoryGubun(collection) {
			$('#searchContent').oLoader({
				backgroundColor:'#4e73df',
				fadeInTime: 500,
				fadeOutTime: 1000,
				fadeLevel: 0.5
			});

			$.ajax({
				type: "post",
				url: "<%= request.getContextPath()%>/search/getCategoryGubun.wn",
				data: {
					collection: collection,
					query: $('#query').val(),
					startCount: 0,
					listCount: 20,
					groupField: $("#select_group").val()
				},
				success: function(data) {
					//console.log(data);

					let str = "";
					let nameTemp = "";
					
					let cnt = 0;
					let cntArr = [];

					if(Object.keys(data).length > 0) {
						$.each(data, function(key, value) {
							let titleArr = this.title.split("/");
							if(nameTemp.split("/")[0] === titleArr[0]) {
								str += "<p class='ml-2' style='cursor:pointer;' onclick='fn_clickGubun(\"" + this.title + "\")'> - "+ (titleArr.length > 1 ? titleArr[1] : this.title) + " (" + fn_commaNumber(this.cnt) + ")</p>";
								cnt += this.cnt;
							}else {
								cntArr.push(cnt);
								cnt = 0;
								if(titleArr.length > 1) {
									str += "<p class='font-weight-bold text-primary' style='cursor:pointer;' name='nameGubun_title' onclick='fn_clickGubun(\"" + titleArr[0] + "\")'>"+ titleArr[0] + "</p>";
									str += "<p class='ml-2' style='cursor:pointer;' onclick='fn_clickGubun(\"" + this.title + "\")'> - " +  titleArr[1] + " (" + fn_commaNumber(this.cnt) + ")</p>";
									cnt += this.cnt;
								}else {
									str += "<p class='font-weight-bold text-primary' style='cursor:pointer;' name='nameGubun_title' onclick='fn_clickGubun(\"" + this.title + "\")'>"+ this.title +"</p>";
									cnt += this.cnt;
								}
								nameTemp = this.title;
							}
						})
					}
					cntArr.push(cnt);

					$('#gubun_tree').html(str);

					for(let i=0; i<$('p[name=nameGubun_title]').length; i++){
						let text = $('p[name=nameGubun_title]')[i].innerText;
						$('p[name=nameGubun_title]')[i].innerText = text + " (" + fn_commaNumber(cntArr[i+1]) + ")";
					}
				},
				complete: function(data) {
					$('#searchContent').oLoader('hide');
				},
				error: function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
		}

		// 통합검색 ALL
		function fn_getTotalSearchList() {

			$.ajax({
				type: "post",
				url : "<%= request.getContextPath()%>/search/getSearchResults.wn",
				data : {
					collection: collectionAll,
					query: $('#query').val(),
					startCount: 0,
					listCount: 3,
					range: $('#range').val(),
					highlight: true,
					exquery: fn_makeExquery($('#exquery').val())
				},
				success: function(data) {
					//console.log(data);

					const cf_data_humint = data.cf_data_humint;
					const cf_data_sigint = data.cf_data_sigint;
					const cf_data_osint = data.cf_data_osint;
					const cf_data_masint = data.cf_data_masint;
					const cf_data_imint = data.cf_data_imint;

					let allTotalCount = cf_data_sigint.totalCount + cf_data_humint.totalCount + cf_data_osint.totalCount + cf_data_masint.totalCount + cf_data_imint.totalCount;
					let str = "";

					// OO정보 cf_data_sigint
					str += "<div class='content'><h5 class='mb-3 font-weight-bold text-primary' style='display:flex; justify-content:space-between;'><span>OO정보 " + fn_commaNumber(cf_data_sigint.totalCount) + "건</span>";
					str += "<span style='cursor:pointer; font-size:0.6em;' onclick='fn_moreBtn(\"cf_data_sigint\")'>"+ (cf_data_sigint.totalCount !== 0 ? "+더보기" : "" ) + "</span></h5>";
					if(cf_data_sigint.totalCount === 0) str += "<hr>";
					for(let i=0; i < cf_data_sigint.list.length; i++) {
						str += "<div class='row'><div class='h6 col-md-12 font-weight-bold d-flex justify-content-between'>";
						str += "<span data-toggle='modal' data-target='#myModal' style='cursor:pointer' onclick='fn_getDetail(" + cf_data_sigint.list[i].UID + ", \"cf_data_sigint\")'>" + cf_data_sigint.list[i].CF_TITLE + "</span><span class='text-gray-500' style='font-size:0.75em'>";
						str += cf_data_sigint.list[i].CF_DATE + "</span></div>";
						str += "<div class='col-sm-2' style='border: 1px solid;'>";
						str += "<div class='col-md-12 m-2 font-weight-bold'>[분석결과]<br> 군별병〮종별 &gt; </span><span class='text-warning'>"+ cf_data_sigint.list[i].XGBOOST_ANAL_RS + "</span>";
						str += "<br> PMESII &gt; </span><span class='text-warning'>" + cf_data_sigint.list[i].PMESII_ANAL_RS + "</span></div></div>";
						str += "<div class='col-md-10'>"+ cf_data_sigint.list[i].CF_CONTENT + "</div>";
						str += "<div class='col-md-12 text-gray-500 mt-2'>" + cf_data_sigint.list[i].CF_CATEGORY + "</div>";
						str += "</div><hr>";
					}
					str += "</div>";

					// 영상정보 cf_data_imint
					str += "<div class='content'><h5 class='mb-3 font-weight-bold text-primary' style='display:flex; justify-content:space-between;'><span>영상정보 " + fn_commaNumber(cf_data_imint.totalCount) + "건</span>";
					str += "<span style='cursor:pointer; font-size:0.6em;' onclick='fn_moreBtn(\"cf_data_imint\")'>"+ (cf_data_imint.totalCount !== 0 ? "+더보기" : "" ) + "</span></h5>";
					if(cf_data_imint.totalCount === 0) str += "<hr>";
					for(let i=0; i < cf_data_imint.list.length; i++) {
						str += "<div class='row'><div class='h6 col-md-12 font-weight-bold d-flex justify-content-between'>";
						str += "<span data-toggle='modal' data-target='#myModal' style='cursor:pointer' onclick='fn_getDetail(" + cf_data_imint.list[i].UID + ", \"cf_data_imint\")'>" + cf_data_imint.list[i].CF_TITLE + "</span><span class='text-gray-500' style='font-size:0.75em'>";
						str += cf_data_imint.list[i].CF_DATE.substr(0, 4) + "-" + cf_data_imint.list[i].CF_DATE.substr(4, 2) + "-" + cf_data_imint.list[i].CF_DATE.substr(6, 2) + " " + cf_data_imint.list[i].CF_DATE.substr(8, 2) + ":" + cf_data_imint.list[i].CF_DATE.substr(10, 2) + ":" + cf_data_imint.list[i].CF_DATE.substr(12, 2) + "</span></div>";
						str += "<div class='col-sm-2' style='border: 1px solid;'>";
						str += "<div class='col-md-12 m-2 font-weight-bold'>[분석결과]<br> 군별병〮종별 &gt; </span><span class='text-warning'>"+ cf_data_imint.list[i].XGBOOST_ANAL_RS + "</span>";
						str += "<br> PMESII &gt; </span><span class='text-warning'>" + cf_data_imint.list[i].PMESII_ANAL_RS + "</span></div></div>";
						str += "<div class='col-md-10'>"+ cf_data_imint.list[i].ATTACHFILE_CONTENT + "</div>";
						str += "<div class='col-md-12 text-gray-500 mt-2'>" + (cf_data_imint.list[i].CF_CATEGORY ? cf_data_imint.list[i].CF_CATEGORY : "") + "</div>";
						str += "</div><hr>";
					}
					str += "</div>";
						
					
					//인간정보 cf_data_humint
					str += "<div class='content'><h5 class='mb-3 font-weight-bold text-primary' style='display:flex; justify-content:space-between;'><span>인간정보 " + fn_commaNumber(cf_data_humint.totalCount) + "건</span>";
					str += "<span style='cursor:pointer; font-size:0.6em;' onclick='fn_moreBtn(\"cf_data_humint\")'>" + (cf_data_humint.totalCount !== 0 ? "+더보기" : "" ) + "</span></h5>";
					if(cf_data_humint.totalCount === 0) str += "<hr>";
					for(let i=0; i < cf_data_humint.list.length; i++) {
						str += "<div class='row'><div class='h6 col-md-12 font-weight-bold d-flex justify-content-between'>";
						str += "<span data-toggle='modal' data-target='#myModal' style='cursor:pointer' onclick='fn_getDetail(" + cf_data_humint.list[i].UID + ", \"cf_data_humint\")'>" + cf_data_humint.list[i].CF_TITLE + "</span><span class='text-gray-500' style='font-size:0.75em'>";
						str += cf_data_humint.list[i].CF_DATE.substr(0, 4) + "-" + cf_data_humint.list[i].CF_DATE.substr(4, 2) + "-" + cf_data_humint.list[i].CF_DATE.substr(6, 2) + " " + cf_data_humint.list[i].CF_DATE.substr(8, 2) + ":" + cf_data_humint.list[i].CF_DATE.substr(10, 2) + ":" + cf_data_humint.list[i].CF_DATE.substr(12, 2) + "</span></div>";
						str += "<div class='col-sm-2' style='border: 1px solid;'>";
						str += "<div class='col-md-12 m-2 font-weight-bold'>[분석결과]<br> 군별병〮종별 &gt; </span><span class='text-warning'>"+ cf_data_humint.list[i].XGBOOST_ANAL_RS + "</span>";
						str += "<br> PMESII &gt; </span><span class='text-warning'>" + cf_data_humint.list[i].PMESII_ANAL_RS + "</span></div></div>";
						str += "<div class='col-md-10'>" + (cf_data_humint.list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_1 !== "||" ? cf_data_humint.list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_1 : cf_data_humint.list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_2) + "</div>";
						str += "<div class='col-md-12 text-gray-500 mt-2'>" + cf_data_humint.list[i].WISE_CF_DATA_HUMINT_MENU + "</div>";
						str += "</div><hr>";
					}
					str += "</div>";
						
					//공개정보 cf_data_osint
					str += "<div class='content'><h5 class='mb-3 font-weight-bold text-primary' style='display:flex; justify-content:space-between;'><span>공개정보 " + fn_commaNumber(cf_data_osint.totalCount) + "건</span>";
					str += "<span style='cursor:pointer; font-size:0.6em;' onclick='fn_moreBtn(\"cf_data_osint\")'>"+ (cf_data_osint.totalCount !== 0 ? "+더보기" : "" ) + "</span></h5>";
					if(cf_data_osint.totalCount === 0) str += "<hr>";
					for(let i=0; i < cf_data_osint.list.length; i++) {
						str += "<div class='row'><div class='h6 col-sm-12 mb-2 font-weight-bold d-flex justify-content-between'>";
						str += "<span data-toggle='modal' data-target='#myModal' style='cursor:pointer' onclick='fn_getDetail(" + cf_data_osint.list[i].UID + ", \"cf_data_osint\")'>" + cf_data_osint.list[i].CF_TITLE + "</span><span class='text-gray-500' style='font-size:0.75em'>";
						str += cf_data_osint.list[i].CF_DATE.substr(0, 4) + "-" + cf_data_osint.list[i].CF_DATE.substr(4, 2) + "-" + cf_data_osint.list[i].CF_DATE.substr(6, 2) + " " + cf_data_osint.list[i].CF_DATE.substr(8, 2) + ":" + cf_data_osint.list[i].CF_DATE.substr(10, 2) + ":" + cf_data_osint.list[i].CF_DATE.substr(12, 2) + "</span></div>";
						str += "<div class='col-sm-2' style='border: 1px solid;'>";
						str += "<div class='col-md-12 m-2 font-weight-bold'>[분석결과]<br> 군별병〮종별 &gt; </span><span class='text-warning'>"+ cf_data_osint.list[i].XGBOOST_ANAL_RS + "</span>";
						str += "<br> PMESII &gt; </span><span class='text-warning'>" + cf_data_osint.list[i].PMESII_ANAL_RS + "</span></div></div>";
						str += "<div class='col-sm-10'>" + (cf_data_osint.list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_1 !== "||" ? cf_data_osint.list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_1 : cf_data_osint.list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_2) + "</div>";
						str += "<div class='col-md-12 text-gray-500 mt-2'>" + cf_data_osint.list[i].WISE_CF_DATA_HUMINT_MENU + "</div>";
						str += "</div><hr>";
					}
					str += "</div>";

					//계측기호 cf_data_masint
					str += "<div class='content'><h5 class='mb-3 font-weight-bold text-primary' style='display:flex; justify-content:space-between;'><span>계측기호 " + fn_commaNumber(cf_data_masint.totalCount) + "건</span>";
					str += "<span style='cursor:pointer; font-size:0.6em;' onclick='fn_moreBtn(\"cf_data_masint\")'>"+ (cf_data_masint.totalCount !== 0 ? "+더보기" : "" ) + "</span></h5>";
					if(cf_data_masint.totalCount === 0) str += "<hr>";
					for(let i=0; i < cf_data_masint.list.length; i++) {
						str += "<div class='row'><div class='h6 col-md-12 font-weight-bold d-flex justify-content-between'>";
						str += "<span data-toggle='modal' data-target='#myModal' style='cursor:pointer' onclick='fn_getDetail(" + cf_data_masint.list[i].UID + ", \"cf_data_masint\")'>" + cf_data_masint.list[i].CF_TITLE + "</span><span class='text-gray-500' style='font-size:0.75em'>";
						str += cf_data_masint.list[i].CF_DATE.substr(0, 4) + "-" + cf_data_masint.list[i].CF_DATE.substr(4, 2) + "-" + cf_data_masint.list[i].CF_DATE.substr(6, 2) + " " + cf_data_masint.list[i].CF_DATE.substr(8, 2) + ":" + cf_data_masint.list[i].CF_DATE.substr(10, 2) + ":" + cf_data_masint.list[i].CF_DATE.substr(12, 2) + "</span></div>";
						str += "<div class='col-sm-2' style='border: 1px solid;'>";
						str += "<div class='col-md-12 m-2 font-weight-bold'>[분석결과]<br> 군별병〮종별 &gt; </span><span class='text-warning'>"+ cf_data_masint.list[i].XGBOOST_ANAL_RS + "</span>";
						str += "<br> PMESII &gt; </span><span class='text-warning'>" + cf_data_masint.list[i].PMESII_ANAL_RS + "</span></div></div>";
						str += "<div class='col-md-10'>" + (cf_data_masint.list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_1 !== "||" ? cf_data_masint.list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_1 : cf_data_masint.list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_2) + "</div>";
						str += "<div class='col-md-12 text-gray-500 mt-2'>" + cf_data_masint.list[i].WISE_CF_DATA_HUMINT_MENU + "</div>";
						str += "</div><hr>";
					}
					str += "</div>";

					$('#totalCount').text("검색결과 총 " + fn_commaNumber(allTotalCount) + "건");
					$('#download').html("");
					$('#contentBody').html(str);
					$('#start_date').val(cf_data_sigint.startDate);
					$('#end_date').val(cf_data_sigint.endDate);
				},
				complete : function(data) {

				},
				error: function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
		}

		// 컬렉션별 검색 결과 리스트 출력
		function fn_getList(pageNum) {
			//$('#pagination > li').remove();
			$('#pageNum').val(pageNum);
			$('#startCount').val(( pageNum - 1 ) * 10);
			//$('#list_cnt').text().remove();

			//console.log(fn_makeExquery($('#exquery').val()));

			$.ajax({
				type : "post",
				url : "<%= request.getContextPath()%>/search/getSearchResults.wn",
				data : {
					collection: $('#select_collection').val(),
					query: $('#query').val(),
					startCount: $('#startCount').val(),
					listCount: $('#listCount').val(),
					pageNum: $('#pageNum').val(),
					range: $('#range').val(),
					highlight: true,
					exquery: fn_makeExquery($('#exquery').val())
				},
				cache: false,
				success : function(data) {
					console.log(data);

					let cName = "";	
					let htmlStr = "";
					const list = data.list;

					if($('#select_collection').val() === "cf_data_sigint") cName="OO정보";
					else if($('#select_collection').val() === "cf_data_imint") cName="영상정보";
					else if($('#select_collection').val() === "cf_data_humint") cName="인간정보";
					else if($('#select_collection').val() === "cf_data_masint") cName="계측기호";
					else if($('#select_collection').val() === "cf_data_osint") cName="공개정보";

					if(data.totalCount !== 0){
						htmlStr += "<div class='content'><h5 class='mb-3 font-weight-bold text-primary'>"+ cName + " " + fn_commaNumber(data.totalCount) + "건</h5>";

						for(let i=0; i < list.length; i++) {
							htmlStr += "<div class='row'><div class='h6 col-md-12 font-weight-bold d-flex justify-content-between'>";
							htmlStr += "<span data-toggle='modal' data-target='#myModal' style='cursor:pointer' onclick='fn_getDetail(" + list[i].UID + ", \"" + $('#select_collection').val() +"\")'>" + list[i].CF_TITLE + "</span><span class='text-gray-500' style='font-size:0.75em'>";
							htmlStr += ($('#select_collection').val() === "cf_data_sigint" ? list[i].CF_DATE : list[i].CF_DATE.substr(0, 4) + "-" + list[i].CF_DATE.substr(4, 2) + "-" 
										+ list[i].CF_DATE.substr(6, 2) + " " + list[i].CF_DATE.substr(8, 2) + ":" + list[i].CF_DATE.substr(10, 2) + ":" + list[i].CF_DATE.substr(12, 2)) + "</span></div>";
							htmlStr += "<div class='col-sm-2' style='border: 1px solid;'>";
							htmlStr += "<div class='col-md-12 m-2 font-weight-bold'>[분석결과]<br> 군별병〮종별 &gt; </span><span class='text-warning'>"+ list[i].XGBOOST_ANAL_RS + "</span>";
							htmlStr += "<br> PMESII &gt; </span><span class='text-warning'>" + list[i].PMESII_ANAL_RS + "</span></div></div>";
							htmlStr += "<div class='col-md-10'>";
							if($('#select_collection').val() === "cf_data_sigint") htmlStr += list[i].CF_CONTENT;
							else if($('#select_collection').val() === "cf_data_imint") htmlStr += list[i].ATTACHFILE_CONTENT;
							else htmlStr += list[i].HUMAN_REPORT_ATTACHFILE_CONTENT_1;
							htmlStr += "</div>";
							htmlStr += "<div class='col-md-12 text-gray-500 mt-2'>";
							
							if($('#select_collection').val() === "cf_data_sigint" ) htmlStr += list[i].CF_CATEGORY;
							else if($('#select_collection').val() === "cf_data_imint") htmlStr += "";
							else htmlStr += list[i].WISE_CF_DATA_HUMINT_MENU;
							htmlStr += "</div></div><hr>";
						}

						htmlStr += "</div><div class='col-md-12' id='dataTable_paginate'><ul class='pagination justify-content-center'>";
						htmlStr += data.pageCode;
						htmlStr += "</ul></div>";
					}else {
						htmlStr += "<div class='content text-center'><h5 class='mb-3 font-weight-bold text-primary'>검색결과가 없습니다.</h5></div>";
					}

					$('#contentBody').html(htmlStr);
					$('#totalCount').html("검색결과 총 " + data.totalCount + "건");
					$('#download').html("<input class='btn btn-primary' onClick='fn_search_download()' type='button' value='검색결과 다운로드'>");
					$('#start_date').val(data.startDate);
					$('#end_date').val(data.endDate);
				},
				complete : function(data) {

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
					let strHtml = "<option value='cf_data_humint,cf_data_sigint,cf_data_osint,cf_data_masint,cf_data_imint'>전체</option>";
					
					data.map(function(collection){
						strHtml += "<option value='"+collection.en+"'>"+collection.ko+"</option>";
					});

					$('#select_collection').html(strHtml);
					$('#select_collection').val("cf_data_humint,cf_data_sigint,cf_data_osint,cf_data_masint,cf_data_imint");				 
				},
				error: function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
		}
		

		// 검색엔진 개별 문서 상세검색
		function fn_getDetail(id, collection){
			
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
							html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_1+"</a><textarea id='detail_content1' class='form-control' rows='13' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
							$('#modal_content').html(html);
							$('#detail_content1').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_1);
						}
						if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_2){
							html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_2+"</a><textarea id='detail_content2' class='form-control' rows='13' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
							$('#modal_content').append(html);
							$('#detail_content2').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_2);
						}
						if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_3){
							html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_3+"</a><textarea id='detail_content3' class='form-control' rows='13' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
							$('#modal_content').append(html);
							$('#detail_content3').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_3);
						}
						if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_4){
							html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_4+"</a><textarea id='detail_content4' class='form-control' rows='13' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
							$('#modal_content').append(html);
							$('#detail_content4').text(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_4);
						}
						if(vo.HUMAN_REPORT_ATTACHFILE_CONTENT_5){
							html = "<p><a>첨부파일 : "+vo.HUMAN_REPORT_ATTACHFILE_NM_5+"</a><textarea id='detail_content5' class='form-control' rows='13' style='font-size:0.8rem; margin-top: 5px;' readonly='readonly'></textarea></p>";
							$('#modal_content').append(html);
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
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
	</script>

</body>

</html>
