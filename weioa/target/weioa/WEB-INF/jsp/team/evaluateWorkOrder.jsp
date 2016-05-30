<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
	request.setAttribute("basePath", basePath);
%>
<!doctype html>
<html>

	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,height=device-height,initial-scale=1, user-scalable=false">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-touch-fullscreen" content="yes">
		<meta name="format-detection" content="telephone=no" />
		<link href="${basePath}/css/base.css" rel="stylesheet" type="text/css" />
		<title>工作单评价</title>
		<style type="text/css">
			#pf{font-size: 18px; margin-right: 4px;}
		</style>
	</head>

	<body>
	
	<form id="evaluateForm" name="evaluateForm" action="${basePath}/workorder/team/evaluateWorkOrder.htm" method="post">
		<input type="hidden" name="workOrderId" value="${workOrderId}"/>
		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>工作单评价<span class="m-option"></span></div>-->

			<div class="m-box">
				<a href="#">
					<li>
						<p><img src="${basePath}/res/images/pf.png" />请为本次工作评分</p>
						<p><span class="red" id="pf">1</span>分
						<input type="hidden" id="evaluationPoint" name="evaluationPoint" value="1"/>
					</li>
				</a>
				<li>
					<p class="m-star">
						<span class="selected"></span>
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
						<span class=""></span>
					</p>
					<p></p>
				</li>
			</div>

			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/wt.png" />请输入对本次工作的评价</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<textarea class="m-textarea" name="evaluationContent" rows="3"></textarea>
				</li>
			</div>

			<div class="m-footer">
				<span class="m-btn w-60"><a href="javascript:submit()" class="bg-blue">提交</a></span>
				<span class="m-btn w-40"><a href="javascript:history.go(-1)" class="bg-gray">返回</a></span>
			</div>
		</div>
		
		<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.validate.min.js"></script>
		<script type="text/javascript">
			window.onload = function() {
				$(".m-star span").on('touchstart mousedown', function(e) {
					e.preventDefault();
					var i = $(".m-star span").index(this) +1;
					$(".m-star span").removeClass('selected');
					$(".m-star span:lt('"+i+"')").addClass('selected');
					$("#pf").html(i)
					$("#evaluationPoint").val(i);
				});
			}
			
			function submit() {
				$("#evaluateForm").submit();
			}
			
			$(document).ready(function(){
				$('#evaluateForm').validate({
					errorClass: "validate-error",
					rules: {
						evaluationContent: {
							required: true,
							maxlength : 500
						}
					},
					messages: {
						evaluationContent: {
							required: "请输入评价信息",
							maxlength : "不能超过500个字符"
						}
					}
				});
			});
		</script>
	</body>

</html>