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
		<title>工作台</title>
		<link href="${basePath}/css/base.css" rel="stylesheet" type="text/css" />
		<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body>

		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>我的工作台<span class="m-option"></span></div>-->

			<div class="m-tabs"> <a href="#" class="active">当前工作单</a> <a href="#">全部工作单</a> </div>
			
			<div class="m-tabs-page m-tabs-page-actived">
				<c:forEach items="${workOrderList}" var="workOrder">
					<c:if test='${workOrder.workOrderStatus ne "OVER"}'>
						<a href="${basePath}/workorder/expert/workOrderDetail.htm?workOrderId=${workOrder.workOrderId}">
							<div class="m-box">
								<li>
									<p><img src="${basePath}/res/images/ydbh.png" />工作单号</p>
									<p>${workOrder.workOrderId}</p>
								</li>
								<li>
									<p>申请国家队</p>
									<p>${workOrder.workForTeam}</p>
								</li>
								<li>
									<p>下队地点</p>
									<p>${workOrder.workSpace}</p>
								</li>
								<li>
									<p>下队时间</p>
									<p>${workOrder.workTime}</p>
								</li>
								<li>
									<p>申请人</p>
									<p>${workOrder.workOrderCreatorName}</p>
								</li>
								<li>
									<p class="red">${statusNames[workOrder.workOrderStatus]}</p>
									<p><span class="m-right"></span></p>
								</li>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
			<div class="m-tabs-page">
				<c:forEach items="${workOrderList}" var="workOrder">
					<c:if test='${workOrder.workOrderStatus eq "OVER" }'>
						<a href="${basePath}/workorder/expert/workOrderDetail.htm?workOrderId=${workOrder.workOrderId}">
							<div class="m-box">
								<li>
									<p><img src="${basePath}/res/images/ydbh.png" />工作单号</p>
									<p>${workOrder.workOrderId}</p>
								</li>
								<li>
									<p>申请国家队</p>
									<p>${workOrder.workForTeam}</p>
								</li>
								<li>
									<p>下队地点</p>
									<p>${workOrder.workSpace}</p>
								</li>
								<li>
									<p>下队时间</p>
									<p>${workOrder.workTime}</p>
								</li>
								<li>
									<p>申请人</p>
									<p>${workOrder.workOrderCreatorName}</p>
								</li>
								<li>
									<p class="red">${statusNames[workOrder.workOrderStatus]}</p>
									<p><span class="m-right"></span></p>
								</li>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
		</div>

		</div>

		<script type="text/javascript">
			window.onload = function() {
				$(".m-tabs a").on('touchstart mousedown', function(e) {
					e.preventDefault();
					$(".m-tabs .active").removeClass('active');
					$(this).addClass('active');
					$(".m-tabs-page").removeClass('m-tabs-page-actived'); //$(this).index()
					$(".m-tabs-page:eq(" + $(this).index() + ")").addClass('m-tabs-page-actived');
				});
			}
		</script>

	</body>

</html>