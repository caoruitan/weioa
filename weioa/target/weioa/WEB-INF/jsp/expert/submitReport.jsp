<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		<title>上传工作报告</title>
	</head>

	<body>
	<form id="reportForm" name="reportForm" action="${basePath}/workorder/expert/submitReport.htm" method="post">
		<input type="hidden" name="workOrderId" value="${workOrderId}"/>
		<!-- B 内容信息 -->
		<div class="m-layout">
			<c:if test='${haveFiles eq "false"}'>
				<div class="m-box">
					<li>
						<p><img src="${basePath}/res/images/qz.png" />上传报告</p>
						<p></p>
					</li>
					<li class="m-auto-height">
						<pre>请用PC浏览器访问以下地址进行报告上传，上传成功后再到此页面进行提交：${basePath}/workorder/feedback<br/>您的工作单号为：${workOrderId}<br/>您的企业号用户ID为：${userInfo.userId}</pre>
					</li>
				</div>
			</c:if>
			<c:if test='${haveFiles eq "true"}'>
				<div class="m-box-title">专家工作报告<span class="m-dropdown"></span></div>
				<div class="m-dropdown-box">
					<div class="m-box">
						<c:forEach items="${files}" var="file">
							<c:if test="${file.attrType eq 0}">
								<div class="m-file">
									<c:if test='${fn:endsWith(file.fileName, ".xls")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_xls.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".xlsx")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_xls.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".doc")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_doc.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".docx")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_doc.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".ppt")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_ppt.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".pptx")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_ppt.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".pdf")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_pdf.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".zip")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_zip.png" width="60" /></a>
									</c:if>
									<span class="m-file-title">${file.fileName}</span>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
		
				<div class="m-box-title">财务报告<span class="m-dropdown"></span></div>
				<div class="m-dropdown-box">
					<div class="m-box">
						<c:forEach items="${files}" var="file">
							<c:if test="${file.attrType eq 1}">
								<div class="m-file">
									<c:if test='${fn:endsWith(file.fileName, ".xls")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_xls.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".xlsx")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_xls.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".doc")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_doc.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".docx")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_doc.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".ppt")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_ppt.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".pptx")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_ppt.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".pdf")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_pdf.png" width="60" /></a>
									</c:if>
									<c:if test='${fn:endsWith(file.fileName, ".zip")}'>
										<a href="${basePath}/${file.url}"><img class="m-file-img" src="${basePath}/res/images/file/file_zip.png" width="60" /></a>
									</c:if>
									<span class="m-file-title">${file.fileName}</span>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			
				<div class="m-box-title">提交报告<span class="m-dropdown"></span></div>
				<div class="m-dropdown-box">
					<div class="m-box">
						<li>
							<p><img src="${basePath}/res/images/qz.png" />上传报告</p>
							<p></p>
						</li>
						<li class="m-auto-height">
							<pre>请用PC浏览器访问以下地址进行报告文件修改，上传成功后再到此页面进行提交：${basePath}/workorder/feedback<br/>您的工作单号为：${workOrderId}<br/>您的企业号用户ID为：${userInfo.userId}</pre>
						</li>
					</div>
					<div class="m-box">
						<li>
							<p><img src="${basePath}/res/images/wt.png" />送审附言</p>
							<p></p>
						</li>
						<li class="m-auto-height">
							<textarea class="m-textarea" name="approvalContent" rows="3" cols=""></textarea>
						</li>
					</div>
				</div>
	
				<div class="m-footer">
					<span class="m-btn w-100"><a href="javascript:submit()" class="bg-blue">提交</a></span>
				</div>
			</c:if>
		</div>
	</form>
		
	<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${basePath}/js/jquery.validate.min.js"></script>
	<script type="text/javascript">
		function submit() {
			$("#reportForm").submit();
		}
		
		$(document).ready(function(){
			$('#reportForm').validate({
				errorClass: "validate-error",
				rules: {
					approvalContent : {
						required: true,
						maxlength : 500
					}
				},
				messages: {
					approvalContent : {
						required: "请填写送审附言",
						maxlength : "不能超过500个字符"
					}
				}
			});
		});
	</script>
	</body>

</html>