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
		<title>问题详情</title>
	</head>

	<body>
	<form id="problemForm" name="problemForm" action="${basePath}/problem/submitProblem.htm" method="post">
		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>抄送<span class="m-option"></span></div>-->

			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/wt.png" />问题摘要</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<pre>${problem.title}</pre>
				</li>
				<li>
					<p><img src="${basePath}/res/images/wt.png" />问题描述</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<pre>${problem.content}</pre>
				</li>
				<li>
					<p><img src="${basePath}/res/images/txl.png" />反馈人</p>
					<p>${problem.creatorName}</p>
				</li>
				<li>
					<p><img src="${basePath}/res/images/dh.png" />反馈人电话</p>
					<p>${problem.creatorPhone}</p>
				</li>
				<li>
					<p><img src="${basePath}/res/images/sj.png" />申请时间</p>
					<p><fmt:formatDate value="${problem.createTime}" type="both" dateStyle="medium" timeStyle="medium"/></p>
				</li>
			</div>
			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/wt.png" />回复</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<textarea class="m-textarea" name="re" rows="5" cols=""></textarea>
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
			$("#problemForm").submit();
		}
		
		$(document).ready(function(){
			$('#problemForm').validate({
				errorClass: "validate-error",
				rules: {
					title : {
						required: true,
						maxlength : 30
					},
					content : {
						required: true,
						maxlength : 500
					}
				},
				messages: {
					title : {
						required: "请填写问题摘要",
						maxlength : "不能超过30个字符"
					},
					content : {
						required: "请填写问题描述",
						maxlength : "不能超过500个字符"
					}
				}
			});
		});
	</script>
	</body>

</html>