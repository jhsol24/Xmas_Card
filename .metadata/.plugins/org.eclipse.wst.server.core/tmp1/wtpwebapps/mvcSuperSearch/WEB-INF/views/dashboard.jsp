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
            <h1 class="h3 mb-0 text-gray-800">현황판</h1>
           	<div class="col-xl-3 text-right" >
               <select class="form-control" id="slt_server"  >
               </select >
            </div  >
            <!-- <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a> -->
          </div>

          <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-4 mb-4">
              <div class="card border-left-primary shadow h-100 py-2" >
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">서버상태</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" id="dv_server_status">100%</div>
                        </div >
                        <div class="col" id="dv_server_status_text">
                          <!-- <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 100%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div> -->
                          정상 가동
                        </div>
                        	
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-4 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">학습진행상태 </div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" id="dv_progress_bar">100%</div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" id="progress_bar" style="width: 100%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-4 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">모델정보</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold">Model : </div>
                        </div>
                        <div class="col font-weight-bold" id="dv_model_nm">
                          확인 중
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <!-- <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">학습데이터</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">100%</div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div class="progress-bar bg-info" role="progressbar" style="width: 100%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300" ></i>
                    </div>
                  </div>
                </div>
              </div>
            </div> -->
          </div>

          <!-- Content Row -->

          <div class="row">

            <!-- Area Chart -->
            <div class="col-xl-12 col-lg-7">

              <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">학습데이터 등록현황</h6 >
                </div>
                <div class="card-body">
                  <div class="chart-bar">
                    <canvas id="myBarChart"></canvas >
                  </div>
                </div>
              </div> 
            </div>

  <!-- Bootstrap core JavaScript-->
  <script src="${pageContext.request.contextPath }/resources/bootstrap-sbadmin2//vendor/jquery/jquery.min.js"></script >
  <script src="${pageContext.request.contextPath }/resources/bootstrap-sbadmin2//vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <script src="${pageContext.request.contextPath }/resources/bootstrap-sbadmin2//vendor/jquery-easing/jquery.easing.min.js"></script>

  <script src="${pageContext.request.contextPath }/resources/bootstrap-sbadmin2//vendor/chart.js/Chart.min.js"></script>

  
  <script src="${pageContext.request.contextPath }/resources/bootstrap-sbadmin2//js/demo/chart-pie-demo.js"></script >
  
  
  <script type="text/javascript" >
  
//Set new default font family and font color to mimic Bootstrap's default styling
	Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#858796';
	 
	var timerId = null;
	
	$(document).ready(function(){
	 
		fn_getServerList();
	 
	});

	$('#slt_server').change(function(){
		
		fn_initDash();
		
	});
	  


  	function fn_initDash(){

		fn_get_barchart_data();
		fn_getServerSatatus();
		fn_getModelInfo();
		timerId = setInterval(fn_getStudyStatus, 1000);

	}
  
  	
  	
  	function fn_getModelInfo() {
  		
  		$.ajax({
  			type: "post",
  			url : "<%= request.getContextPath()%>/run/getModelInfo.wn",
  			data: {
  				cfsv_id: $('#slt_server').val()
  			},
  			success: function(data) {
  				
  				//data.modelNm
  				
  				$('#dv_model_nm').text(data.modelNm);
  				
  				
  			},
			complete : function(data) {
			}
  		
  		})
  	}
  	
  	

	//서버상태조회
	function fn_getServerSatatus(){
		
		$('#dv_server_status').text("0%");
		$('#dv_server_status_text').text("상태 체크 중");
    
		$.ajax({
			type: "post",
			url : "<%= request.getContextPath()%>/run/getServerSatatus.wn",
			data: {
				cfsv_id: $('#slt_server').val()
			},
			success: function(data) {
				var status = data.status;
				if(status == "BREAK"){
					$('#dv_server_status_text').text("서버 정지상태");
					$('#dv_server_status').text("0%");
				}else{
					$('#dv_server_status').text("100%");
					$('#dv_server_status_text').text("정상");
				}
			},
			complete : function(data) {
			}
		})
		
	}
	

  
  
  

	//학습 상태 체크
	function fn_getStudyStatus(){
		
		$('#progress_bar').attr("style" , "width:0%;");
		$('#progress_bar').text("0% Complete");
		
		$.ajax({
			type: "post",
			url : "<%= request.getContextPath()%>/run/getStudyStatus.wn",
			data: {
				cfsv_id: $('#slt_server').val()
			},
			success: function(data) {
				if(data.response) {
					var setPer = data.progress;
					var status = data.status;
					
					if(status == "READY"){
						
						//if(isNewCheck) alertify.success('이전 학습이 완료 되었습니다.');
						//else alert('학습이 완료 되었습니다.');
						
						$('#progress_bar').attr("style" , "width:100%;");
						$('#progress_bar').text("100% Complete");
						$('#dv_progress_bar').text("100%");
						if(timerId != null) {
					        clearInterval(timerId);
					    }
						
					}else{
						
						$('#progress_bar').attr("style" , "width:" + setPer + ";");
						$('#progress_bar').text(status + " " + setPer);
						$('#dv_progress_bar').text(setPer + "%");
					}
					
					
				}
				
				
			},
			complete : function(data) {
			}
		})
		
		
		
		
	}
	
  
  
  

  function number_format(number, decimals, dec_point, thousands_sep) {
    // *     example: number_format(1234.56, 2, ',', ' ');
    // *     return: '1 234,56'
    number = (number + '').replace(',', '').replace(' ', '');
    var n = !isFinite(+number) ? 0 : +number,
      prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
      sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
      dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
      s = '',
      toFixedFix = function(n, prec) {
        var k = Math.pow(10, prec);
        return '' + Math.round(n * k) / k;
      };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
      s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
      s[1] = s[1] || '';
      s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
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
		        fn_initDash();
			}
		});
		
	}
	

	function fn_get_barchart_data(){
		
		$.ajax({
			type : "post",
			url : "<%= request.getContextPath()%>/code/getBarChartData.wn",
			data :{
				"cfsv_id" : $('#slt_server').val()
			},
			dataType : "json",

			success : function(data) {
				var kvArray = data.barChartDataList;
				var cfctNmArray = kvArray.map(function(obj){
					   return obj.CFCT_NAME;
					});
				var cfctCntArray = kvArray.map(function(obj){
					   return obj.CNT;
					});
				fn_draw_chart(cfctNmArray, cfctCntArray);
			},
			
			complete : function(data) {
			}
		});
		
	}
	
  
	function fn_draw_chart(labels, datas){
	  
	  
	// Bar Chart Example
	  var ctx = document.getElementById("myBarChart");
	  var myBarChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	      labels: labels,
	      datasets: [{
	        label: "Revenue",
	        backgroundColor: "#4e73df",
	        hoverBackgroundColor: "#2e59d9",
	        borderColor: "#4e73df",
	        data: datas,
	      }],
	    },
	    options: {
	      maintainAspectRatio: false,
	      layout: {
	        padding: {
	          left: 10,
	          right: 25,
	          top: 25,
	          bottom: 0
	        }
	      },
	      scales: {
	        xAxes: [{
	          time: {
	            unit: 'month'
	          },
	          gridLines: {
	            display: false,
	            drawBorder: false
	          },
	          ticks: {
	            maxTicksLimit: 20
	          },
	          maxBarThickness: 25,
	        }],
	        yAxes: [{
	          ticks: {
	            min: 0,
	            max: 10000,
	            maxTicksLimit: 20,
	            padding: 10,
	            // Include a dollar sign in the ticks
	            callback: function(value, index, values) {
	              return number_format(value);
	            }
	          },
	          gridLines: {
	            color: "rgb(234, 236, 244)",
	            zeroLineColor: "rgb(234, 236, 244)",
	            drawBorder: false,
	            borderDash: [2],
	            zeroLineBorderDash: [2]
	          }
	        }],
	      },
	      legend: {
	        display: false
	      },
	      tooltips: {
	        titleMarginBottom: 10,
	        titleFontColor: '#6e707e',
	        titleFontSize: 14,
	        backgroundColor: "rgb(255,255,255)",
	        bodyFontColor: "#858796",
	        borderColor: '#dddfeb',
	        borderWidth: 1,
	        xPadding: 15,
	        yPadding: 15,
	        displayColors: false,
	        caretPadding: 10,
	        callbacks: {
	          label: function(tooltipItem, chart) {
	            var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
	            return number_format(tooltipItem.yLabel);
	          }
	        }
	      },
	    }
	  });
	  
  }

  

  
  
  </script>
  
  
 
</body>

</html>
