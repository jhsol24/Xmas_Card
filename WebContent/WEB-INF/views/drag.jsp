<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta charset="UTF-8">
		<meta name="Generator" content="EditPlus®">
		<meta name="Author" content="">
		<meta name="Keywords" content="">
		<meta name="Description" content="">
		<link rel="shortcut icon" href="../resources/img/favicon.ico">

		<script src="/resources/vendor/jquery/jquery.js"></script>
		<script src="/resources/vendor/jquery/jquery-ui-1.12.1/jquery-ui.js"></script>

		<style type="text/css">
			.draggable-wrap {
				padding: 50px;
				background: #ccc;
			}
			.draggable {
				display: inline-block;
				*display: inline;
				*zoom: 1;
				border: 1px solid #ddd;
				padding: 30px ;
				cursor: move;
				font-weight: 600;
				color: #fff;
				background: #e17a21;
			}
			.browser {
				width: 1000px;
				margin: 100px auto 0 auto;
			}
			.header {
				height: 100px;
				border: 1px solid #ddd;
			}
			.body {
				height: 300px;
				border: 1px solid #ddd;
				margin-top: 20px;
			}
			.footer {
				height: 100px;
				border: 1px solid #ddd;
				margin-top: 20px;
			}
		</style>
	</head>
	<body>
		<div class="draggable-wrap">
			<div class="draggable">Draggable Div1</div>
			<div class="draggable">Draggable Div2</div>
			<div class="draggable">Draggable Div3</div>
			<div class="draggable in-parent">Draggable Div4</div>
		</div>

		<div class="browser">
			<div class="header">
				HEADER
			</div>
			<div class="body">
				BODY
			</div>
			<div class="footer">
				FOOTER
			</div>
		</div>

		<script type="text/javascript">
			var css_zidx = 10;
			$( function() {
				$(".draggable").draggable( {
					create: function( event, ui ) {
						if( $(this).hasClass("in-parent")) {
							$(this).draggable( "option", "containment", "parent");
						}
					},
					start: function( event, ui ) {
						css_zidx++;
						$(this).css({
							"z-index":css_zidx,
							"box-shadow":"0 1px 2px 0 rgba(0,0,0,0.1), 0 4px 8px 0 rgba(0,0,0,0.2)"
						}).draggable( "option", "revert", true );
					},
					stop: function( event, ui ) {
						$(this).css({
							"box-shadow":""
						});
					}
				});

				$(".browser div").droppable( {
					drop: function( event, ui ) {
						ui.draggable.draggable( "option", "revert", false);
					}
				});

				$(".draggable-wrap").droppable( {
					drop: function( event, ui ) {
						ui.draggable.draggable( "option", "revert", false);
					}
				});
			})
		</script>
	</body>
</html>


