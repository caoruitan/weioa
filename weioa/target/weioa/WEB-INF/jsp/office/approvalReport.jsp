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
		<title>工作报告/财务报告审批</title>
	</head>

	<body>
	<form id="approvalForm" name="approvalForm" action="${basePath}/workorder/office/approvalReport.htm" method="post">
		<input type="hidden" name="workOrderId" value="${workOrderId}"/>
		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>抄送<span class="m-option"></span></div>-->

			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/wt.png" />审批意见</p>
					<p></p>
				</li>
				<li>
					<p>通过</p>
					<p><input type="radio" name="approvalResult" checked="checked" value="1"/></p>
				</li>
				<li>
					<p>不通过</p>
					<p><input type="radio" name="approvalResult" value="0"/></p>
				</li>
				<li class="m-auto-height">
					<textarea class="m-textarea" name="approvalContent" rows="3" cols=""></textarea>
				</li>
			</div>
			
			<div class="m-footer">
				<span class="m-btn w-60"><a href="javascript:submit()" class="bg-blue">提交</a></span>
				<span class="m-btn w-40"><a href="javascript:history.go(-1)" class="bg-gray">返回</a></span>
			</div>
			
		</div>
	</form>
	
	<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${basePath}/js/jquery.validate.min.js"></script>
	<script type="text/javascript">
		function submit() {
			$("#approvalForm").submit();
		}
		
		$(document).ready(function(){
			$('#approvalForm').validate({
				errorClass: "validate-error",
				rules: {
					approvalContent : {
						required: true,
						maxlength : 500
					}
				},
				messages: {
					approvalContent : {
						required: "请填写审批意见",
						maxlength : "不能超过500个字符"
					}
				}
			});
		});
	</script>
	</body>

</html>