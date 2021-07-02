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
<style>

.link {
  fill: none;
  stroke: #666;
  stroke-width: 1.5px;
}

#licensing {
  fill: green;
}

.link.licensing {
  stroke: green;
}

.link.resolved {
  stroke-dasharray: 0,2 1;
}

#network circle {
  fill: #ccc;
  stroke: #333;
  stroke-width: 1.5px;
}

#network text {
  font: 10px sans-serif;
  pointer-events: none;
  text-shadow: 0 1px 0 #fff, 1px 0 0 #fff, 0 -1px 0 #fff, -1px 0 0 #fff;
}

</style>
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
			<div class="col-md-6">
				<!-- Begin Page Content -->
		        <div class="container-fluid">
		            <!-- DataTales Example -->
		            <div class="card shadow mb-4">
		              <div class="card-header py-3">
                    <div class="row">
                        <div class="col-md-10">
                            <h6 class="m-0 font-weight-bold text-primary">주제어 리스트</h6>
                          </div>
                          <div class="col-md-2">
                            <select class="form-control" id="listCount" onchange="javascript:getTopicList($('#listCount').val())">
                              <option>10</option>
                              <option>30</option>
                              <option>50</option>
                              <option>100</option>
                            </select>
                          </div>
                    </div>
		              </div>
		              <div class="card-body">
		                <div class="table-responsive">
		                  <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		                    <thead>
		                      <tr>
		                        <th width="15%">주제</th>
		                        <th>주제어</th>
		                        <th width="9%">문서수</th>
		                      </tr>
		                    </thead>
		                    <tbody id="teaList">
		                    </tbody>
		                  </table>
		                </div>
		              </div>
		            </div>
		  
		          </div>
		     </div>
		     <div class="col-md-6">
		     	<div class="container-fluid">
		            <!-- DataTales Example -->
		            <div class="card shadow mb-4">
		              <div class="card-header py-3">
                    <div class="row">
                        <div class="col-md-10">
                            <h6 class="m-0 font-weight-bold text-primary">워드클라우드</h6>
                          </div>
                      
                    </div>
		              </div>
		              <div class="card-body">
				     	<div id="cloud"></div>
				     </div>
		            </div>
		  
		          </div>
		     </div>
	      </div>
            <!-- row end -->
            
            <div class="row">
            	<div class="col-md-6">
            		<div class="container-fluid">
		            <!-- DataTales Example -->
		            <div class="card shadow mb-4">
		              <div class="card-header py-3">
                    <div class="row">
                        <div class="col-md-8">
                            <h6 class="m-0 font-weight-bold text-primary">주제어 리스트 2</h6>
                          </div>
                          <div class="col-md-4">
                            <input class="form-control" id="query" value="" onkeypress="if( event.keyCode==13 ){getTermsList()}">
                          </div>
                    </div>
		              </div>
		              <div class="card-body">
		                <div class="table-responsive">
		                  <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
		                    <thead>
		                      <tr>
		                        <th width="15%">주제</th>
		                        <th>주제어</th>
		                        <th width="9%">문서수</th>
		                      </tr>
		                    </thead>
		                    <tbody id="termsList">
		                    </tbody>
		                  </table>
		                </div>
		              </div>
		            </div>
		          </div>
            	</div>
            	<div class="col-md-6">
		     	<div class="container-fluid">
		            <!-- DataTales Example -->
		            <div class="card shadow mb-4">
		              <div class="card-header py-3">
                    <div class="row">
                        <div class="col-md-10">
                            <h6 class="m-0 font-weight-bold text-primary">네트워크</h6>
                          </div>
                      
                    </div>
		              </div>
		              <div class="card-body">
				     	<div id="network"></div>
				     </div>
		            </div>
		  
		          </div>
		     </div>
            </div>
            
            

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      
      <%@ include file="../common/bottom.jsp"%>
    
    <script src="${pageContext.request.contextPath }/resources/js/d3.v3.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/kcloud.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/d3plus.js"></script>
	<script type="text/javascript">
	let dataList = [];
	let topList = [];
	
	$(document).ready(function(){
      event.preventDefault();

      getTopicCloud(70);
      getTopicList(10);
      getTermsList();
      drawNetwork();
    });
  
  
  function getTopicList(count) {
    $.ajax({
      type: "post",
      url : "<%= request.getContextPath()%>/topic/topiclist.wn",
      success: function(data) {
        //console.log(data);
        let htmlstr = "";
        let keywordCount = 10;
        $.each(data.Topics[0].topic, function(key, value) {
          if(key < count){
            htmlstr += "<tr><td>" + this.label + "</td><td>";
            let keywordlist = [];
            $.each(this.keywords[0], function(key, value) {
              for(let i = 0; i < keywordCount; i++){
                keywordlist.push(this[i].value);
              }
            });
            htmlstr += keywordlist.join(",");
            htmlstr +="</td><td>" + this.docCount + "</td><tr>"
          }
        });

        $('#teaList').html(htmlstr);
      },
      complete : function(data) {

      },
      error : function(request, status, error) {
        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      }
    })
  }


  function getTermsList() {
    topList = [];
    $.ajax({
      type: "post",
      url : "<%= request.getContextPath()%>/topic/termslist.wn",
      async: true,
      data : {
          collection: "cf_data_sigint",
          query: $("#query").val(),
					startCount: 0,
					listCount: 10,
					highlight: false
      },
      success: function(data) {
        for(let i=0; i<data.data.length; i++) {
        	topList.push({
            name:data.data[i].name,
            count: data.data[i].count,
            terms: ""
          });
        }
        console.log(topList)
      },
      complete : function(data) {
        for(let i=0; i<topList.length; i++){
          getTermsDeptList(topList[i].name);
        }
      },
      error : function(request, status, error) {
        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      }
    })
  }


  function getTermsDeptList(query) {
	    $.ajax({
	      type: "post",
	      url : "<%= request.getContextPath()%>/topic/termslist.wn",
	      async: true,
	      data : { 
	          collection: "cf_data_sigint",
						query: query,
						startCount: 0,
						listCount: 11,
						highlight: false
	      },
	      success: function(data) {
          const topWord = topList.find(function(list){
            return list.name === query
          })
          topWord.terms = data.data.map(function(word){
            if(word.name === query) return null;
            return word.name 
          });
          topWord.terms = topWord.terms.filter(function(word){
            return word !== null
          })
	      },
	      complete : function(data) {
          	drawTopList();
	      },
	      error : function(request, status, error) {
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	    })
    }  

  
  function getTopicCloud(count) {
	  $.ajax({
        type: "post",
	      url : "<%= request.getContextPath()%>/topic/topiclist.wn",
        async: true,
        cache: false,
	      success: function(data) {
	        //console.log(data);
	        let htmlstr = "";
            dataList = [];

	        $.each(data.Topics[0].topic, function(key, value) {
	          if(key < count){
	            dataList.push({
                text: this.label,
                size: this.docCount / 40
              });
	          }
          });

	      },
	      complete : function(data) {
          	drawChart(dataList);
	      },
	      error : function(request, status, error) {
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
	    })
  }

    
  function drawTopList() {
		let htmlStr = "";
		try{
			for(let i=0; i<topList.length; i++){
				htmlStr += "<tr><td>" + topList[i].name + "</td>";
				htmlStr += "<td>"+ topList[i].terms.join(",") +"</td>";
				htmlStr += "<td>" + topList[i].count + "</td><tr>"
			}
		}catch(error) {
			//console.log(error);
		}
    $('#termsList').html(htmlStr);
  }


  function drawChart(data) {
	  //console.log(JSON.stringify(data));
	  var url = "";
	  var weight = 3, // 글자크기 가중치
	    width =  700,
	    height = 500;

	  var fill = d3.scale.category20();

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
				.style("cursor", "pointer")
				.attr("onclick", function (d) {
          return "find('" + d.text + "')";
        })
        .text(function (d) {
          return d.text;
        });
    }
  };
	
	function find(text) {
		//console.log(text);
		$("#query").val(text);
		getTermsList();
	}
  
  function drawNetwork() {
	  var links = [
		  {source: "Microsoft", target: "Amazon", type: "licensing"},
		  {source: "Microsoft", target: "HTC", type: "licensing"},
		  {source: "Samsung", target: "Apple", type: "suit"},
		  {source: "Motorola", target: "Apple", type: "suit"},
		  {source: "Nokia", target: "Apple", type: "resolved"},
		  {source: "HTC", target: "Apple", type: "suit"},
		  {source: "Kodak", target: "Apple", type: "suit"},
		  {source: "Microsoft", target: "Barnes & Noble", type: "suit"},
		  {source: "Microsoft", target: "Foxconn", type: "suit"},
		  {source: "Oracle", target: "Google", type: "suit"},
		  {source: "Apple", target: "HTC", type: "suit"},
		  {source: "Microsoft", target: "Inventec", type: "suit"},
		  {source: "Samsung", target: "Kodak", type: "resolved"},
		  {source: "LG", target: "Kodak", type: "resolved"},
		  {source: "RIM", target: "Kodak", type: "suit"},
		  {source: "Sony", target: "LG", type: "suit"},
		  {source: "Kodak", target: "LG", type: "resolved"},
		  {source: "Apple", target: "Nokia", type: "resolved"},
		  {source: "Qualcomm", target: "Nokia", type: "resolved"},
		  {source: "Apple", target: "Motorola", type: "suit"},
		  {source: "Microsoft", target: "Motorola", type: "suit"},
		  {source: "Motorola", target: "Microsoft", type: "suit"},
		  {source: "Huawei", target: "ZTE", type: "suit"},
		  {source: "Ericsson", target: "ZTE", type: "suit"},
		  {source: "Kodak", target: "Samsung", type: "resolved"},
		  {source: "Apple", target: "Samsung", type: "suit"},
		  {source: "Kodak", target: "RIM", type: "suit"},
		  {source: "Nokia", target: "Qualcomm", type: "suit"}
		];

		var nodes = {};

		// Compute the distinct nodes from the links.
		links.forEach(function(link) {
		  link.source = nodes[link.source] || (nodes[link.source] = {name: link.source});
		  link.target = nodes[link.target] || (nodes[link.target] = {name: link.target});
		});

		var width = 700,
		    height = 500;

		var force = d3.layout.force()
		    .nodes(d3.values(nodes))
		    .links(links)
		    .size([width, height])
		    .linkDistance(60)
		    .charge(-300)
		    .on("tick", tick)
		    .start();

		var svg = d3.select("#network").append("svg")
		    .attr("width", width)
		    .attr("height", height);

		// Per-type markers, as they don't inherit styles.
		svg.append("defs").selectAll("marker")
		    .data(["suit", "licensing", "resolved"])
		  .enter().append("marker")
		    .attr("id", function(d) { return d; })
		    .attr("viewBox", "0 -5 10 10")
		    .attr("refX", 15)
		    .attr("refY", -1.5)
		    .attr("markerWidth", 6)
		    .attr("markerHeight", 6)
		    .attr("orient", "auto")
		  .append("path")
		    .attr("d", "M0,-5L10,0L0,5");

		var path = svg.append("g").selectAll("path")
		    .data(force.links())
		  .enter().append("path")
		    .attr("class", function(d) { return "link " + d.type; })
		    .attr("marker-end", function(d) { return "url(#" + d.type + ")"; });

		var circle = svg.append("g").selectAll("circle")
		    .data(force.nodes())
		  .enter().append("circle")
		    .attr("r", 6)
		    .call(force.drag);

		var text = svg.append("g").selectAll("text")
		    .data(force.nodes())
		  .enter().append("text")
		    .attr("x", 8)
		    .attr("y", ".31em")
		    .text(function(d) { return d.name; });

		// Use elliptical arc path segments to doubly-encode directionality.
		function tick() {
		  path.attr("d", linkArc);
		  circle.attr("transform", transform);
		  text.attr("transform", transform);
		}

		function linkArc(d) {
		  var dx = d.target.x - d.source.x,
		      dy = d.target.y - d.source.y,
		      dr = Math.sqrt(dx * dx + dy * dy);
		  return "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y;
		}

		function transform(d) {
		  return "translate(" + d.x + "," + d.y + ")";
		}
  }
	</script>

</body>

</html>
