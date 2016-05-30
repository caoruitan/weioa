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
		<script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
		<title>工作单</title>
	</head>

	<body>

		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>工作单详情<span class="m-option"></span></div>-->

			<div class="m-box-title">抄送附言<span class="m-dropdown"></span></div>
			<div class="m-dropdown-box">
				<div class="m-box">
					<li>
						<pre>${cc.carbonCopyContent}</pre>
					</li>
			</div>
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
					<c:if test='${workOrder.workOrderStatus eq "COFIRM"}'>
						<li>
							<p><img src="${basePath}/res/images/sj.png" />申请下队时间</p>
							<p>${workOrder.workTime}</p>
						</li>
					</c:if>
					<c:if test='${workOrder.workOrderStatus ne "COFIRM"}'>
						<li>
							<p><img src="${basePath}/res/images/sj.png" />申请下队时间</p>
							<p>${workOrder.workTime}</p>
						</li>
						<li>
							<p><img src="${basePath}/res/images/sj.png" />确认下队时间</p>
							<p>${workOrder.confirmWorkTimeStart}&nbsp;&nbsp;至&nbsp;&nbsp;${workOrder.confirmWorkTimeEnd}</p>
						</li>
					</c:if>
					<c:if test='${workOrder.workOrderStatus eq "COFIRM"}'>
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
					<c:if test='${workOrder.workOrderStatus ne "COFIRM"}'>
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
						<pre>${workOrder.workForReason}<img src="${basePath}/res/images/nopic.png" /></pre>
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
				
				<c:if test='${workOrder.workOrderStatus ne "COFIRM"}'>
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
			
			<%--
			<c:if test='${workOrder.workOrderStatus ne "COFIRM" && workOrder.workOrderStatus ne "APPROVAL"}'>
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
				<div class="m-box-title">工作报告<span class="m-dropdown"></span></div>
				<div class="m-dropdown-box">
					<div class="m-box">
						<div class="m-file">
							<img class="m-file-img" src="${basePath}/res/images/file/file_xls.png" width="60" />
							<span class="m-file-title">工作报告2016年6月下队射击队-欧阳冲</span>
						</div>
						<div class="m-file">
							<img class="m-file-img" src="${basePath}/res/images/file/file_pdf.png" width="60" />
							<span class="m-file-title">工作报告2016年6月下队射击队-欧阳冲</span>
						</div>
						<div class="m-file">
							<img class="m-file-img" src="${basePath}/res/images/file/file_doc.png" width="60" />
							<span class="m-file-title">工作报告2016年6月下队射击队-欧阳冲</span>
						</div>
					</div>
				</div>	
			
				<div class="m-box-title">财务报告<span class="m-dropdown"></span></div>
				<div class="m-dropdown-box">
					<div class="m-box">
						<div class="m-file">
							<img class="m-file-img" src="${basePath}/res/images/file/file_ppt.png" width="60" />
							<span class="m-file-title">工作报告2016年6月下队射击队-欧阳冲</span>
						</div>
						<div class="m-file">
							<img class="m-file-img" src="${basePath}/res/images/file/file_doc.png" width="60" />
							<span class="m-file-title">工作报告2016年6月下队射击队-欧阳冲</span>
						</div>
						<div class="m-file">
							<img class="m-file-img" src="${basePath}/res/images/file/file_zip.png" width="60" />
							<span class="m-file-title">工作报告2016年6月下队射击队-欧阳冲</span>
						</div>
					</div>
				</div>
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
			--%>
		</div>
		
		<div class="m-footer">
			<span class="m-btn w-100"><a href="${basePath}/workorder/team/workOrderList.htm" class="bg-gray">返回工作台</a></span>
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