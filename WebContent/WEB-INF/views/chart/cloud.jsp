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

			<div class="row">
				<div id="cloud"></div>
            </div>
            <div class="row">
            	<div id=viz></div>
            </div>
            <!-- row end -->

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      
      <%@ include file="../common/bottom.jsp"%>
      
    <script src="${pageContext.request.contextPath }/resources/js/d3.v3.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/kcloud.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/d3plus.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
		    var url = "";
		    var weight = 3, // 글자크기 가중치
		      width = 900,
		      height = 500;

		    var fill = d3.scale.category20();
		    //var dataList = [];
		    
		    /*
		    $.getJSON(url, function (data) {
		      for (var i = 0; i < data.totalCount; i++) {
		        dataList.push({
		          text: data.text[i],
		          size: (data.size[i] * weight)
		        });
		      }
		      drawChart(dataList);
		    });
		    */
		    
		    var dataList = [
		        {
		            text: "보병",
		            size: 89
		        },
		        {
		            text: "포병",
		            size: 128
		        },
		        {
		            text: "기갑",
		            size: 10
		        },
		        {
		            text: "기계화",
		            size: 19
		        },
		        {
		            text: "특수전",
		            size: 57
		        },
		        {
		            text: "통신",
		            size: 4
		        },
		        {
		            text: "공병",
		            size: 8
		        },
		        {
		            text: "준군사",
		            size: 58
		        },
		        {
		            text: "화학",
		            size: 8
		        },
		        {
		            text: "전투근무지원",
		            size: 5
		        },
		        {
		            text: "불명제대",
		            size: 5
		        },
		        {
		            text: "고사포",
		            size: 56
		        },   
		        {
		            text: "해군",
		            size: 35
		        },
		        {
		            text: "공군",
		            size: 88
		        },
		        {
		            text: "군사지휘기관",
		            size: 15
		        },
		        {
		            text: "중국",
		            size: 84
		        },
		        {
		            text: "러시아",
		            size: 48
		        },
		        {
		            text: "일본",
		            size: 11
		        },
		        {
		            text: "미국",
		            size: 8
		        },
		        {
		            text: "그외",
		            size: 2
		        },
		        {
		            text: "육군",
		            size: 54
		        },
		        {
		            text: "주변국",
		            size: 62
		        },
		        {
		            text: "잠수함",
		            size: 23
		        },
		        {
		            text: "미사일",
		            size: 53
		        },
		        {
		            text: "노동신문",
		            size: 24
		        }
		    ];
		    
		    drawChart(dataList);

		    function drawChart(data) {

		      d3.layout.cloud().size([width, height]).words(data)
		        //.rotate(function() { return ~~(Math.random() * 2) * 90; })
		        .rotate(0)
		        .font("Impact")
		        .fontSize(function (d) {
		          return d.size;
		        })
		        .on("end", draw)
		        .start();

		      function draw(words) {
		        d3.select("#cloud").append("svg")
		          .attr("width", width)
		          .attr("height", height)
		          .append("g")
		          .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")")
		          .selectAll("text")
		          .data(words)
		          .enter().append("text")
		          .style("font-size", function (d) {
		            return d.size + "px";
							})
							.style("font-family", "Impact")
		          .style("fill", function (d, i) {
		            return fill(i);
		          })
		          .attr("text-anchor", "middle")
		          .attr("transform", function (d) {
		            return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
		          })
		          .text(function (d) {
		            return d.text;
		          });
		      }
		    };
	});
	</script>
</body>

</html>
