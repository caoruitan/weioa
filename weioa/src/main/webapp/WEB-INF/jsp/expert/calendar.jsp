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
		<title>专家日程</title>
		<style type="text/css">
			html {
				background: #ffffff;
			}
		</style>
	</head>

	<body>

		<!-- B 内容信息 -->
		<div class="m-layout">
			<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>专家日程<span class="m-option"></span></div>-->

			<!--flow 开始-->
			<div class="m-flow">
				<!--头部-->
				<div class="m-flow-header">
					<img src="${expertInfo.photo}" class="m-flow-avatar"/>
					<p>${expertInfo.name }</p>
					<p>${expertInfo.mobile }</p>
				</div>
				<!--头部-->
				<div class="m-flow-box">
					<c:forEach items="${workOrderList}" var="workOrder">
						<li>
							<a class="dot"></a>
							<p>
								<a class="arrow"></a>
								<!--内容-->
								<span>工作单号：${workOrder.workOrderId }</span>
								<span>国家队：${workOrder.workForTeam }</span>
								<span>下队时间：${workOrder.confirmWorkTimeStart } 至 ${workOrder.confirmWorkTimeEnd }</span>
								<span>下队地点：${workOrder.workSpace }</span>
							</p>
						</li>
					</c:forEach>
				</div>
			</div>

			<!--flow 结束-->
		</div>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.1.0.js"></script>
	<script type="text/javascript" src="${basePath}/js/jquery183.js"></script>
	<script type="text/javascript">
		wx.config({
			debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			appId: 'wx12bfbc7b7f11c4ee', // 必填，企业号的唯一标识，此处填写企业号corpid
			timestamp: '${timestamp}', // 必填，生成签名的时间戳
			nonceStr: '123qweasdzxc', // 必填，生成签名的随机串
			signature: '${signature}',// 必填，签名，见附录1
			jsApiList: ['openEnterpriseContact'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});
		wx.ready(function(){
			if("${expertId}" == null || "${expertId}" == "") {
				chooseExpert();
			}
			// config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
		});
		wx.error(function(res){
		});
		
		var evalWXjsApi = function(jsApiFun) {
			if (typeof WeixinJSBridge == "object" && typeof WeixinJSBridge.invoke == "function") {
				jsApiFun();
			} else {
				document.attachEvent && document.attachEvent("WeixinJSBridgeReady", jsApiFun);
				document.addEventListener && document.addEventListener("WeixinJSBridgeReady", jsApiFun);
			}
		}
		
		function chooseExpert() {
			evalWXjsApi(function() {
				WeixinJSBridge.invoke("openEnterpriseContact", {
					"groupId": '${groupId}', // 必填，管理组权限验证步骤1返回的group_id
					"timestamp": '${timestamp}', // 必填，管理组权限验证步骤2使用的时间戳
					"nonceStr": "123qweasdzxc", // 必填，管理组权限验证步骤2使用的随机字符串
					"signature": '${groupSignature}', // 必填，管理组权限验证步骤2生成的签名
					"params" : {
						'departmentIds' : ["${expertDeptId}"], // 非必填，可选部门ID列表（如果ID为0，表示可选管理组权限下所有部门）
						//'tagIds' : [1], // 非必填，可选标签ID列表（如果ID为0，表示可选所有标签）
						//'userIds' : ['zhangsan','lisi'], // 非必填，可选用户ID列表
						'mode' : 'single', // 必填，选择模式，single表示单选，multi表示多选
						'type' : [/*'department','tag',*/'user'], // 必填，选择限制类型，指定department、tag、user中的一个或者多个
						'selectedDepartmentIds' : [], // 非必填，已选部门ID列表
						'selectedTagIds' : [], // 非必填，已选标签ID列表
						'selectedUserIds' : [], // 非必填，已选用户ID列表
					},
				}, function(res) {
					if (res.err_msg.indexOf('function_not_exist') > 0) {
						alert('版本过低请升级');
					} else if (res.err_msg.indexOf('openEnterpriseContact:fail') > 0) {
						return;
					}
					var result = JSON.parse(res.result); // 返回字符串，开发者需自行调用JSON.parse解析
					var selectAll = result.selectAll; // 是否全选（如果是，其余结果不再填充）
					if (!selectAll) {
						var selectedUserList = result.userList; // 已选的成员列表
						if(selectedUserList.length > 0) {
							var userId = selectedUserList[0].id;
							window.location.href="${basePath}/workorder/expert/toCalendar.htm?expertId=" + userId;
						}
					}
				})
			});
		}
	</script>
	</body>

</html>