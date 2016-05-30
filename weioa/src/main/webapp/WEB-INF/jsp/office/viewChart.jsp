<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<title>沟通记录</title>
	</head>

	<body>
	<form id="chartForm" name="chartForm" action="${basePath}/workorder/office/sendMessageInChart.htm" method="post">
		<input type="hidden" name="workOrderId" value="${workOrderId}">
		<input type="hidden" name="sessionId" value="${sessionId}">
		<input type="hidden" name="role" value="${role}">
		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>工作单详情<span class="m-option"></span></div>-->
			<div class="m-box">
				<c:forEach items="${charts}" var="chart">
					<li style="border-bottom:0px;">
						<p><img src="${chart.senderPhoto}"/>${chart.senderName}&nbsp;[<fmt:formatDate value="${chart.time}" type="both" dateStyle="medium" timeStyle="medium"/>]</p>
						<p></p>
					</li>
					<li class="m-auto-height">
						<pre>${chart.content}</pre>
					</li>
				</c:forEach>
			</div>
		</div>
		<c:if test='${!empty edit && edit eq "true"}'>
			<div class="m-footer">
				<span class="m-btn w-80"><input class="m-textarea" style="width:96%;height:38px;" type="text" name="content"/></span>
				<span class="m-btn w-20"><a href="javascript:submit();" class="bg-blue">发送</a></span>
			</div>
		</c:if>
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
			$("#chartForm").submit();
		}
	</script>
	</body>

</html>