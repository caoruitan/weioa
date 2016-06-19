<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
		<title>工作单</title>
	</head>

	<body>

		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>工作单详情<span class="m-option"></span></div>-->

			<div class="m-box-title">工单详情<span class="m-dropdown"></span></div>
			<div class="m-dropdown-box">
				<div class="m-box">
					<li>
						<p><img src="${basePath}/res/images/qz.png" />申请国家队</p>
						<p>${workOrder.workForTeam}</p>
					</li>
					<li>
						<p><img src="${basePath}/res/images/dd.png" />下队地点</p>
						<p>${workOrder.workSpace}</p>
					</li>
					<c:if test='${workOrder.workOrderStatus eq "COFIRM" || workOrder.workOrderStatus eq "CANCEL"}'>
						<li>
							<p><img src="${basePath}/res/images/sj.png" />申请下队时间</p>
							<p>${workOrder.workTime}</p>
						</li>
					</c:if>
					<c:if test='${workOrder.workOrderStatus ne "COFIRM" && workOrder.workOrderStatus ne "CANCEL"}'>
						<li>
							<p><img src="${basePath}/res/images/sj.png" />申请下队时间</p>
							<p>${workOrder.workTime}</p>
						</li>
						<li>
							<p><img src="${basePath}/res/images/sj.png" />确认下队时间</p>
							<p>${workOrder.confirmWorkTimeStart}&nbsp;&nbsp;至&nbsp;&nbsp;${workOrder.confirmWorkTimeEnd}</p>
						</li>
					</c:if>
					<c:if test='${workOrder.workOrderStatus eq "COFIRM" || workOrder.workOrderStatus eq "CANCEL"}'>
						<li>
							<p><img src="${basePath}/res/images/zj.png" />申请专家</p>
							<p></p>
						</li>
						<li>
							<p><img src="${workExpert.photo}" />${workExpert.name }</p>
							<p></p>
						</li>
						<li>
							<p><img src="${basePath}/res/images/tx.png" />备选专家</p>
							<p></p>
						</li>
						<c:forEach items="${workExpertOperationalList}" var="expert">
							<li>
								<p><img src="${expert.photo}" />${expert.name }</p>
								<p></p>
							</li>
						</c:forEach>
					</c:if>
					<c:if test='${workOrder.workOrderStatus ne "COFIRM" && workOrder.workOrderStatus ne "CANCEL"}'>
						<li>
							<p><img src="${basePath}/res/images/zj.png" />申请专家</p>
							<p></p>
						</li>
						<li>
							<p>
								<img src="${workExpert.photo}" />${workExpert.name }
								<c:if test="${workExpert.userId eq workOrder.confirmWorkExpert}">（确认下队）</c:if>
							</p>
							<p></p>
						</li>
						<li>
							<p><img src="${basePath}/res/images/tx.png" />备选专家</p>
							<p></p>
						</li>
						<c:forEach items="${workExpertOperationalList}" var="expert">
							<li>
								<p>
									<img src="${expert.photo}" />${expert.name }
									<c:if test="${expert.userId eq workOrder.confirmWorkExpert}">（确认下队）</c:if>	
								</p>
								<p></p>
							</li>
						</c:forEach>
					</c:if>
				</div>
				
				<div class="m-box">
					<li>
						<p><img src="${basePath}/res/images/wt.png" />拟重点解决问题</p>
						<p></p>
					</li>
					<li class="m-auto-height">
						<pre>${workOrder.workForReason}<!-- <img src="${basePath}/res/images/nopic.png" /> --></pre>
					</li>
					<li class="m-auto-height">
						<pre>
							<c:forEach items="${images}" var="image">
								<img style='max-width:100%;width:90%;margin-left:5%;' src="${basePath}/${image}" />
							</c:forEach>
						</pre>
					</li>
				</div>
				
				<div class="m-box">
					<li>
						<p><img src="${basePath}/res/images/txl.png" />申请人</p>
						<p>${workOrder.workOrderCreator}</p>
					</li>
					<li>
						<p><img src="${basePath}/res/images/dh.png" />申请人电话</p>
						<p>${workOrder.workOrderCreatorPhone}</p>
					</li>
					<li>
						<p><img src="${basePath}/res/images/sj.png" />申请时间</p>
						<p><fmt:formatDate value="${workOrder.workOrderCreateTime}" type="both" dateStyle="medium" timeStyle="medium"/></p>
					</li>
				</div>
				
				<c:if test='${workOrder.workOrderStatus ne "COFIRM" && workOrder.workOrderStatus ne "CANCEL"}'>
					<div class="m-box">
						<li>
							<p><img src="${basePath}/res/images/txl.png" />确认人（办公室）</p>
							<p>${workOrder.workOrderReviewerName}</p>
						</li>
						<li>
							<p><img src="${basePath}/res/images/dh.png" />确认人电话</p>
							<p>${workOrder.workOrderReviewerPhone}</p>
						</li>
					</div>
				</c:if>
			</div>
				
			<c:if test='${workOrder.workOrderStatus ne "COFIRM" && workOrder.workOrderStatus ne "APPROVAL" && workOrder.workOrderStatus ne "CANCEL"}'>
				<%--
				<div class="m-box-title">审批记录<span class="m-dropdown"></span></div>
				<div class="m-dropdown-box">
					<div class="m-box">
						<c:forEach items="${approvalRecordList}" var="record">
							<li class="m-auto-height">
								<p>${record.recordContent}&nbsp;&nbsp;</p>
								<a class="zong">[${record.recordUserName}]&nbsp;<fmt:formatDate value="${record.recordTime}" type="both" dateStyle="medium" timeStyle="medium"/></a>
							</li>
						</c:forEach>
					</div>
				</div>
				--%>
			
				<div class="m-box-title">专家工作日志<span class="m-dropdown"></span></div>
				<div class="m-dropdown-box">
					<div class="m-flow m-t-10">
						<div class="m-flow-box">
							<c:forEach items="${dailyLogList}" var="log">
								<li class="active">
									<a class="dot"></a>
									<p>
										<a class="arrow" ></a>
										<span>${log.dailyLogDate}&nbsp;${log.workTypeName}</span>
										<span>${log.dailyLogContent}</span>
									</p>
								</li>
							</c:forEach>
						</div>
					</div>
				</div>
			</c:if>
			
			<c:if test='${workOrder.workOrderStatus eq "REPORT_SUBMIT" || workOrder.workOrderStatus eq "OVER"}'>
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
				</c:if>
			</c:if>
			
			<c:if test='${(workOrder.workOrderStatus eq "REPORT_SUBMIT" && workOrder.workOrderDoneEvaluateStatus eq "EVALUATED") || workOrder.workOrderStatus eq "OVER"}'>
				<div class="m-box-title">工作评价<span class="m-dropdown"></span></div>
				<div class="m-dropdown-box">
					<div class="m-box">
						<li>
							<p class="m-star">
								<c:forEach begin="1" end="${workOrder.evaluationPoint}">
									<span class="selected"></span>
								</c:forEach>
								<c:forEach begin="${workOrder.evaluationPoint + 1}" end="10">
									<span></span>
								</c:forEach>
							</p>
							<p>${workOrder.evaluationPoint}分</p>
						</li>
						<li class="m-auto-height">
							<pre>${workOrder.evaluationContent}</pre>
						</li>
					</div>
				</div>
			</c:if>
		</div>
		
		<div class="m-footer">
			<c:if test='${workOrder.workOrderStatus eq "CANCEL"}'>
				<span class="m-btn w-100"><a href="${basePath}/workorder/team/workOrderList.htm" class="bg-gray">返回工作台</a></span>
			</c:if>
			<c:if test='${workOrder.workOrderStatus eq "COFIRM"}'>
				<span class="m-btn w-60"><a href="${basePath}/workorder/team/toCarbonCopy.htm?workOrderId=${workOrder.workOrderId}" class="bg-blue">抄送</a></span>
				<span class="m-btn w-40"><a href="${basePath}/workorder/team/workOrderList.htm" class="bg-gray">返回工作台</a></span>
			</c:if>
			<c:if test='${workOrder.workOrderStatus eq "APPROVAL"}'>
				<span class="m-btn w-60"><a href="${basePath}/workorder/team/toCarbonCopy.htm?workOrderId=${workOrder.workOrderId}" class="bg-blue">抄送</a></span>
				<span class="m-btn w-40"><a href="${basePath}/workorder/team/workOrderList.htm" class="bg-gray">返回工作台</a></span>
			</c:if>
			<c:if test='${workOrder.workOrderStatus eq "DOING"}'>
				<span class="m-btn w-60"><a href="${basePath}/workorder/team/toCarbonCopy.htm?workOrderId=${workOrder.workOrderId}" class="bg-blue">抄送</a></span>
				<span class="m-btn w-40"><a href="${basePath}/workorder/team/workOrderList.htm" class="bg-gray">返回工作台</a></span>
			</c:if>
			<c:if test='${workOrder.workOrderStatus eq "DONE"}'>
				<span class="m-btn w-60"><a href="${basePath}/workorder/team/toCarbonCopy.htm?workOrderId=${workOrder.workOrderId}" class="bg-blue">抄送</a></span>
				<span class="m-btn w-40"><a href="${basePath}/workorder/team/workOrderList.htm" class="bg-gray">返回工作台</a></span>
			</c:if>
			<c:if test='${workOrder.workOrderStatus eq "REPORT_SUBMIT" && workOrder.workOrderDoneEvaluateStatus eq "EVALUATING"}'>
				<span class="m-btn w-30"><a href="${basePath}/workorder/team/toEvaluate.htm?workOrderId=${workOrder.workOrderId}" class="bg-blue">评价</a></span>
				<span class="m-btn w-30"><a href="${basePath}/workorder/team/toCarbonCopy.htm?workOrderId=${workOrder.workOrderId}" class="bg-blue">抄送</a></span>
				<span class="m-btn w-40"><a href="${basePath}/workorder/team/workOrderList.htm" class="bg-gray">返回工作台</a></span>
			</c:if>
			<c:if test='${workOrder.workOrderStatus eq "REPORT_SUBMIT" && workOrder.workOrderDoneEvaluateStatus ne "EVALUATING"}'>
				<span class="m-btn w-60"><a href="${basePath}/workorder/team/toCarbonCopy.htm?workOrderId=${workOrder.workOrderId}" class="bg-blue">抄送</a></span>
				<span class="m-btn w-40"><a href="${basePath}/workorder/team/workOrderList.htm" class="bg-gray">返回工作台</a></span>
			</c:if>
			<c:if test='${workOrder.workOrderStatus eq "OVER"}'>
				<span class="m-btn w-60"><a href="${basePath}/workorder/team/toCarbonCopy.htm?workOrderId=${workOrder.workOrderId}" class="bg-blue">抄送</a></span>
				<span class="m-btn w-40"><a href="${basePath}/workorder/team/workOrderList.htm" class="bg-gray">返回工作台</a></span>
			</c:if>
		</div>
		
		<script type="text/javascript">
			window.onload = function() {
				$(".m-dropdown").on('touchstart mousedown', function(e) {
					e.preventDefault();
					var i = $(".m-dropdown").index(this);
					$(".m-dropdown-box:eq(" + i + ")").toggle();
					$(".m-dropdown:eq(" + i + ")").toggleClass('up');
					
				});
			}
		</script>
	</body>

</html>