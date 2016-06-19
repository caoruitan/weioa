<%@ page language="java" pageEncoding="UTF-8"%>
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
		<title>专家下队申请</title>
	</head>

	<body>
	<!--<div class="m-header"><a href="#"><span class="m-return"></span></a>专家下队申请<span class="m-option"></span></div>-->
	<form id="workOrderForm" name="workOrderForm" action="${basePath}/workorder/team/createWorkOrder.htm" method="post">
		<!-- B 内容信息 -->
		<div class="m-layout">
			<div class="m-box">
				<li>
					<p><img src="${basePath}/res/images/qz.png" />申请国家队</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<input type="text" class="m-textarea" name="workForTeam"></input>
				</li>
				<li>
					<p><img src="${basePath}/res/images/sj.png" />下队时间</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<input type="text" class="m-textarea" name="workTime"></input>
				</li>
				<li>
					<p><img src="${basePath}/res/images/dd.png" />下队地点</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<input type="text" class="m-textarea" name="workSpace"></input>
				</li>
				<a href="javascript:chooseWorkExpert()">
					<li>
						<p><img src="${basePath}/res/images/zj.png" />申请专家</p>
						<p><span class="m-right"></span></p>
					</li>
				</a>
				<li class="m-auto-height">
					<input style="border:0px;" type="text" class="m-textarea" readonly="readonly" name="workExpertName" id="workExpertName"></input>
					<input type="hidden" name="workExpert" id="workExpert"></input>
				</li>
				<a href="javascript:chooseWorkOpertionalExpert()">
					<li>
						<p><img src="${basePath}/res/images/tx.png" />备选专家</p>
						<p><span class="m-right"></span></p>
					</li>
				</a>
				<li class="m-auto-height">
					<input style="border:0px;" type="text" class="m-textarea" readonly="readonly" name="workExpertOpertionalName" id="workExpertOpertionalName"></input>
					<input type="hidden" name="workExpertOpertional" id="workExpertOpertional"></input>
				</li>
			</div>
			<div class="m-box">
				<li >
					<p><img src="${basePath}/res/images/wt.png" />拟重点解决问题</p>
					<p></p>
				</li>
				<li class="m-auto-height">
					<textarea class="m-textarea" name="workForReason" rows="" cols=""></textarea>
				</li>
				<li>
					<span class="m-btn m-small-btn w-40 m-left"><a href="javascript:chooseImage()" class="bg-blue">拍照/上传图片</a></span>
					<input type="hidden" id="workForReasonImages" name="workForReasonImages"/>
				</li>
				<li class="m-auto-height">
					<pre id="imageContainer"></pre>
				</li>
			</div>
			<div class="m-box">
				<li >
					<p><img src="${basePath}/res/images/txl.png" />申请人</p>
					<p>${userInfo.name }</p>
				</li>
				<li >
					<p><img src="${basePath}/res/images/dh.png" />电话</p>
					<p>${userInfo.mobile }</p>
				</li>
			</div>
		</div>

		<div class="m-footer">
			<span class="m-btn w-100"><a href="javascript:submit()" class="bg-blue">提交</a></span>
		</div>
	</form>
	
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.1.0.js"></script>
	<script type="text/javascript" src="${basePath}/js/jquery183.js"></script>
	<script type="text/javascript" src="${basePath}/js/jquery.validate.min.js"></script>
	<script type="text/javascript">
		var basePath = '${basePath}';
		wx.config({
			debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			appId: 'wx12bfbc7b7f11c4ee', // 必填，企业号的唯一标识，此处填写企业号corpid
			timestamp: '${timestamp}', // 必填，生成签名的时间戳
			nonceStr: '123qweasdzxc', // 必填，生成签名的随机串
			signature: '${signature}',// 必填，签名，见附录1
			jsApiList: ['openEnterpriseContact','chooseImage','uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});
		wx.ready(function(){
			// config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
		});
		wx.error(function(res){
		});
		function chooseImage() {
			wx.chooseImage({
				count: 1,
				sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
				sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
				success: function (res) {
					var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
					wx.uploadImage({
						localId: localIds.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
						isShowProgressTips: 1, // 默认为1，显示进度提示
						success: function (res) {
							var serverId = res.serverId;
							$.ajax({
								type: 'GET',
								url: '${basePath}/workorder/team/getImage.action?serverId=' + serverId,
								dataType: 'json',
								success: function(obj) {
									if(obj.success == true) {
										$("#imageContainer").append($("<img width='200' height='150' style='margin-right:10px;' src='" + basePath + "/" + obj.url + "'/>"));
										var images = $('#workForReasonImages').val();
										$('#workForReasonImages').val(images + "|" + obj.url);
									} else {
										
									}
								}
							});
						},
						fail:function(res) {
							alert(res.errMsg);
						}
					});
				}
			});
		}
		
		var evalWXjsApi = function(jsApiFun) {
			if (typeof WeixinJSBridge == "object" && typeof WeixinJSBridge.invoke == "function") {
				jsApiFun();
			} else {
				document.attachEvent && document.attachEvent("WeixinJSBridgeReady", jsApiFun);
				document.addEventListener && document.addEventListener("WeixinJSBridgeReady", jsApiFun);
			}
		}
		
		function chooseWorkExpert() {
			evalWXjsApi(function() {
				var selectedUsers = $('#workExpert').val().split(",");
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
						'selectedUserIds' : selectedUsers, // 非必填，已选用户ID列表
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
						for (var i = 0; i < selectedUserList.length; i++) {
							var user = selectedUserList[i];
							var userId = user.id; // 已选的单个成员ID
							var userName = user.name; // 已选的单个成员名称
							$('#workExpert').val(userId);
							$('#workExpertName').val(userName);
						}
					}
				})
			});
		}
		
		function chooseWorkOpertionalExpert() {
			evalWXjsApi(function() {
				var selectedUsers = $('#workExpertOpertional').val().split(",");
				WeixinJSBridge.invoke("openEnterpriseContact", {
					"groupId": '${groupId}', // 必填，管理组权限验证步骤1返回的group_id
					"timestamp": '${timestamp}', // 必填，管理组权限验证步骤2使用的时间戳
					"nonceStr": "123qweasdzxc", // 必填，管理组权限验证步骤2使用的随机字符串
					"signature": '${groupSignature}', // 必填，管理组权限验证步骤2生成的签名
					"params" : {
						'departmentIds' : ["${expertDeptId}"], // 非必填，可选部门ID列表（如果ID为0，表示可选管理组权限下所有部门）
						//'tagIds' : [1], // 非必填，可选标签ID列表（如果ID为0，表示可选所有标签）
						//'userIds' : ['zhangsan','lisi'], // 非必填，可选用户ID列表
						'mode' : 'multi', // 必填，选择模式，single表示单选，multi表示多选
						'type' : [/*'department','tag',*/'user'], // 必填，选择限制类型，指定department、tag、user中的一个或者多个
						'selectedDepartmentIds' : [], // 非必填，已选部门ID列表
						'selectedTagIds' : [], // 非必填，已选标签ID列表
						'selectedUserIds' : selectedUsers, // 非必填，已选用户ID列表
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
							var userIds = "";
							var userNames = "";
							for (var i = 0; i < selectedUserList.length; i++) {
								var user = selectedUserList[i];
								var userId = user.id; // 已选的单个成员ID
								var userName = user.name; // 已选的单个成员名称
								userIds += userId + ",";
								userNames += userName + ",";
							}
							userIds = userIds.substring(0, userIds.length - 1);
							userNames = userNames.substring(0, userNames.length - 1);
							$('#workExpertOpertional').val(userIds);
							$('#workExpertOpertionalName').val(userNames);
						}
					}
				})
			});
		}
		
		function submit() {
			$("#workOrderForm").submit();
		}

		$(document).ready(function(){
			$('#workOrderForm').validate({
				errorClass: "validate-error",
				rules: {
					workForTeam: {
						required: true,
						maxlength : 30
					},
					workTime: {
						required: true,
						maxlength : 30
					},
					workSpace: {
						required: true,
						maxlength : 30
					},
					workExpertName: {
						required: true
					},
					workForReason: {
						required: true,
						maxlength : 500
					}
				},
				messages: {
					workForTeam: {
						required: "请输入申请国家队",
						maxlength : "不能超过30个字符"
					},
					workTime: {
						required: "请输入申请下队时间",
						maxlength : "不能超过30个字符"
					},
					workSpace: {
						required: "请输入申请下队地点",
						maxlength : "不能超过30个字符"
					},
					workExpertName: {
						required: "请选择下队专家"
					},
					workForReason: {
						required: "请输入待解决问题",
						maxlength : "不能超过500个字符"
					}
				}
			});
		});
	</script>
	</body>

</html>