<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<title>填写工作日志</title>
	</head>

	<body>
	<form id="dailyLogForm" name="dailyLogForm" action="${basePath}/workorder/expert/addDailyLog.htm" method="post">
		<input type="hidden" name="workOrderId" value="${workOrderId}"/>
		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>工作说明<span class="m-option"></span></div>-->

			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/sj.png"/>工作日期</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<input class="m-comm-input" type="date" name="dailyLogDate"/>
				</li>
			</div>
			<div class="m-box">
				<a href="#">
					<li>
						<p><img src="${basePath}/res/images/pf.png" />请选择工作类型</p>
						<p><input id="workTypeInput" type="hidden" name="workType"/></p>
					</li>
				</a>
				<li class="m-auto-height clearfix" >
					<div class="m-select">
						<a href="#"><span id="type1" class="w-50 selected">差旅</span></a>
						<a href="#"><span id="type2" class="w-50 ">技术服务</span></a>
						<a href="#"><span id="type3" class="w-50 ">讲课</span></a>
						<a href="#"><span id="type4" class="w-50 ">休息</span></a>
					</div>
				</li>
			</div>

			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/wt.png" />工作说明</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<textarea class="m-textarea" name="dailyLogContent" rows="3" cols=""></textarea>
				</li>
			</div>

			<div class="m-footer">
				<span class="m-btn w-100"><a href="javascript:submit()" class="bg-blue">提交</a></span>
			</div>
		</div>
	</form>
		
	<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${basePath}/js/jquery.validate.min.js"></script>
	<script type="text/javascript">
		window.onload = function() {
			$(".m-select a span").on('touchstart mousedown', function(e) {
				e.preventDefault();
				$(this).toggleClass('selected');
			});
		}
		
		function submit() {
			var selectedType = ""
			for(var i = 1; i < 5; i ++) {
				if($("#type" + i).hasClass("selected")) {
					selectedType += i + ",";
				}
			}
			if(selectedType.length > 0) {
				selectedType = selectedType.substring(0, selectedType.length - 1);
			}
			
			if(selectedType == "") {
				alert("请选择工作类型（至少选择一个）");
				return;
			}
			
			$("#workTypeInput").val(selectedType);
			$("#dailyLogForm").submit();
		}
		
		$(document).ready(function(){
			$('#dailyLogForm').validate({
				errorClass: "validate-error",
				rules: {
					dailyLogDate : {
						required: true
					},
					dailyLogContent : {
						required: true,
						maxlength : 500
					}
				},
				messages: {
					dailyLogDate : {
						required: "请选择工作时间"
					},
					dailyLogContent : {
						required: "请填写工作说明",
						maxlength : "不能超过500个字符"
					}
				}
			});
		});
	</script>
	</body>

</html>