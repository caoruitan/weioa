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
		<title>工作单确认</title>
	</head>

	<body>
	<form id="confirmForm" name="confirmForm" action="${basePath}/workorder/office/confirmWorkOrder.htm" method="post">
		<input type="hidden" name="workOrderId" value="${workOrder.workOrderId}"/>
		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>工作单详情<span class="m-option"></span></div>-->
			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/qz.png" />申请国家队</p>
					<p>${workOrder.workForTeam}</p>
				</li>
				<li>
					<p><img src="${basePath}/res/images/sj.png" />确认下队时间</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<input class="m-comm-input" type="date" name="confirmWorkTimeStart"/>
				</li>
				<li>
					<p>至</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<input class="m-comm-input" type="date" name="confirmWorkTimeEnd"/>
				</li>
				<li>
					<p><img src="${basePath}/res/images/dd.png" />下队地点</p>
					<p>${workOrder.workSpace}</p>
				</li>
				<li>
					<p><img src="${basePath}/res/images/zj.png" />确认专家</p>
					<p></p>
				</li>
				<c:forEach items="${expertList}" var="expert">
					<li>
						<p><img src="${expert.photo}" />${expert.name }</p>
						<p><input type="radio" name="confirmWorkExpert" value="${expert.userId}"></p>
					</li>
				</c:forEach>
			</div>
			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/wt.png" />拟重点解决问题</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<pre>${workOrder.workForReason}<img src="${basePath}/res/images/nopic.png" /></pre>
				</li>
			</div>
			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/txl.png" />申请人</p>
					<p>${workOrder.workOrderCreator}</p>
				</li>
				<li>
					<p><img src="${basePath}/res/images/dh.png" />电话</p>
					<p>${workOrder.workOrderCreatorPhone}</p>
				</li>
			</div>
			<div class="m-box">
				<li >
					<p><img src="${basePath}/res/images/wt.png" />送审附言</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<textarea class="m-textarea" name="recordContent" rows="3" cols=""></textarea>
				</li>
			</div>

		</div>
		<div class="m-footer">
			<span class="m-btn w-60"><a href="javascript:submit()" class="bg-blue">确认并提交科教司</a></span>
			<span class="m-btn w-40"><a href="javascript:history.go(-1)" class="bg-gray">返回</a></span>
		</div>
	</form>
	
	<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${basePath}/js/jquery.validate.min.js"></script>
	<script type="text/javascript">
		window.onload = function() {
			$(".m-dropdown").on('touchstart mousedown', function(e) {
				e.preventDefault();
				var i = $(".m-dropdown").index(this);
				$(".m-dropdown-box:eq(" + i + ")").toggle();
				$(".m-dropdown:eq(" + i + ")").toggleClass('up');
				
			});
		}
		
		function submit() {
			$("#confirmForm").submit();
		}
		
		$(document).ready(function(){
			$('#confirmForm').validate({
				errorClass: "validate-error",
				rules: {
					confirmWorkTimeStart: {
						required: true
					},
					confirmWorkTimeEnd: {
						required: true
					},
					confirmWorkExpert: {
						required: true
					},
					recordContent : {
						required: true,
						maxlength : 500
					}
				},
				messages: {
					confirmWorkTimeStart: {
						required: "请选择下队开始时间"
					},
					confirmWorkTimeEnd: {
						required: "请选择下队结束时间"
					},
					confirmWorkExpert: {
						required: "请选择下队专家"
					},
					recordContent : {
						required: "请填写送审附言",
						maxlength : "不能超过500个字符"
					}
				}
			});
		});
	</script>
	</body>

</html>