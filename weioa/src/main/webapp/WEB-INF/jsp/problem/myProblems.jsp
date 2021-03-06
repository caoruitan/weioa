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
		<title>我的问题</title>
		<link href="${basePath}/css/base.css" rel="stylesheet" type="text/css" />
		<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
	</head>

	<body>

		<!-- B 内容信息 -->
		<div class="m-layout">
			<div class="m-tabs"><a href="#" class="active">未处理的问题</a> <a href="#">已处理的问题</a> </div>
			
			<div class="m-tabs-page m-tabs-page-actived">
				<c:forEach items="${problems}" var="problem">
					<c:if test='${problem.status eq "PROCESSING"}'>
						<a href="${basePath}/problem/problemDetail.htm?problemId=${problem.problemId}&re=false">
							<div class="m-box">
								<li>
									<p><img src="${basePath}/res/images/ydbh.png" />提交时间</p>
									<p><fmt:formatDate value="${problem.createTime}" type="both" dateStyle="medium" timeStyle="medium"/></p>
								</li>
								<li>
									<p>问题摘要</p>
									<p>${problem.title}</p>
								</li>
								<li>
									<p>提交人</p>
									<p>${problem.creatorName}</p>
								</li>
								<li>
									<p class="red">${statusNames[problem.status]}</p>
									<p><span class="m-right"></span></p>
								</li>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
			<div class="m-tabs-page">
				<c:forEach items="${problems}" var="problem">
					<c:if test='${problem.status eq "PROCESSED"}'>
						<a href="${basePath}/problem/problemDetail.htm?problemId=${problem.problemId}&re=false">
							<div class="m-box">
								<li>
									<p><img src="${basePath}/res/images/ydbh.png" />提交时间</p>
									<p><fmt:formatDate value="${problem.createTime}" type="both" dateStyle="medium" timeStyle="medium"/></p>
								</li>
								<li>
									<p>问题摘要</p>
									<p>${problem.title}</p>
								</li>
								<li>
									<p>提交人</p>
									<p>${problem.creatorName}</p>
								</li>
								<li>
									<p class="red">${statusNames[problem.status]}</p>
									<p><span class="m-right"></span></p>
								</li>
							</div>
						</a>
					</c:if>
				</c:forEach>
			</div>
			
			<div class="m-footer">
				<span class="m-btn w-100"><a href="${basePath}/problem/toSubmitProblem.htm" class="bg-blue">反馈问题</a></span>
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