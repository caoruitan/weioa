package org.cd.weioa.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.cd.weioa.entity.Configuration;
import org.cd.weioa.entity.WorkFeedBack;
import org.cd.weioa.entity.WorkFeedBackAttacment;
import org.cd.weioa.entity.WorkOrder;
import org.cd.weioa.entity.WorkOrderCarbonCopy;
import org.cd.weioa.entity.WorkOrderStatus;
import org.cd.weioa.service.WorkFeedBackService;
import org.cd.weioa.service.WorkOrderService;
import org.cd.weioa.weinxin.AccessTokenHolder;
import org.cd.weioa.weinxin.UserInfo;
import org.cd.weioa.weinxin.WeixinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("workorder/team/")
public class WorkOrderForTeamAction {

    @Autowired
    WorkOrderService workOrderService;
    
    @Autowired
    WorkFeedBackService workFeedBackService;
    
    @RequestMapping("toCreateWorkOrder")
    public String toCreateWorkOrder(HttpServletRequest request) {
        StringBuffer url = request.getRequestURL();
        if (request.getQueryString() != null) {
            url.append('?');
            url.append(request.getQueryString());
        }
        String timestamp = String.valueOf(System.currentTimeMillis()).substring(0, 10);
        request.setAttribute("timestamp", timestamp);
        String signature = WeixinUtil.getJsapiSignature(AccessTokenHolder.getJsapiTicket(), "123qweasdzxc", timestamp, url.toString());
        request.setAttribute("signature", signature);
        
        String groupTicket = AccessTokenHolder.greGroupTicket();
        String groupId = AccessTokenHolder.getGroupId();
        String groupSignature = WeixinUtil.getGroupSignature(groupTicket, "123qweasdzxc", timestamp, url.toString());

        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        request.setAttribute("userInfo", userInfo);
        request.setAttribute("groupId", groupId);
        request.setAttribute("groupSignature", groupSignature);
        request.setAttribute("expertDeptId", Configuration.EXPERT_DEP_ID);
        return "team/createWorkOrder";
    }
    
    @RequestMapping("createWorkOrder")
    public String createWorkOrder(HttpServletRequest request) {
        String workTime = request.getParameter("workTime");
        String workSpace = request.getParameter("workSpace");
        String workForTeam = request.getParameter("workForTeam");
        String workForReason = request.getParameter("workForReason");
        String workExpert = request.getParameter("workExpert");
        String workExpertName = request.getParameter("workExpertName");
        String workExpertOpertional = request.getParameter("workExpertOpertional");
        String workExpertOpertionalName = request.getParameter("workExpertOpertionalName");
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        WorkOrder order = workOrderService.createWorkOrder(workSpace, workTime, workForTeam, workForReason, workExpert, workExpertName, workExpertOpertional, workExpertOpertionalName, userInfo);

        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        StringBuilder sb = new StringBuilder("");
        sb.append("有一条新的工作单需要您确认协调：")
            .append("\\n申请国家队：").append(order.getWorkForTeam())
            .append("\\n申请下队地点：").append(order.getWorkSpace())
            .append("\\n申请下队时间：").append(order.getWorkTime())
            .append("\\n申请专家：").append(order.getWorkExpertName())
            .append("\\n备选专家：").append(order.getWorkExpertOptionalName())
            .append("\\n申请人：").append(order.getWorkOrderCreatorName())
            .append("\\n申请人联系电话：").append(order.getWorkOrderCreatorPhone())
            .append("\\n详情：").append(basePath).append("/workorder/office/workOrderDetail.htm?workOrderId=")
            .append(order.getWorkOrderId());
        WeixinUtil.sendMessage(Configuration.OFFICE_MSG_SEND, Configuration.OFFICE_APP_ID, sb.toString());
        return "redirect:/workorder/team/workOrderDetail.htm?workOrderId=" + order.getWorkOrderId();
    }

    @RequestMapping("workOrderList")
    public String workOrderList(HttpServletRequest request) {
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        List<WorkOrder> list = this.workOrderService.getWorkOrderByCreator(userInfo.getUserId());
        request.setAttribute("workOrderList", list);
        List<Object[]> ccWorkOrderList = this.workOrderService.getWorkOrdersByCC(userInfo.getUserId());
        request.setAttribute("ccWorkOrderList", ccWorkOrderList);
        request.setAttribute("statusNames", WorkOrderStatus.statusNames);
        return "team/workOrderList";
    }
    
    @RequestMapping("workOrderDetail")
    public String workOrderDetail(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        WorkOrder workOrder = this.workOrderService.getWorkOrderById(workOrderId);
        
        String workExpert = workOrder.getWorkExpert();
        UserInfo userInfo = WeixinUtil.getUserInfoByUserId(workExpert);
        request.setAttribute("workExpert", userInfo);
        
        String workExpertOperational = workOrder.getWorkExpertOptional();
        if(workExpertOperational != null && !workExpertOperational.equals("")) {
            List<UserInfo> workExpertOperationalList = new ArrayList<UserInfo>();
            for(String userId : workExpertOperational.split(",")) {
                UserInfo info = WeixinUtil.getUserInfoByUserId(userId);
                workExpertOperationalList.add(info);
            }
            request.setAttribute("workExpertOperationalList", workExpertOperationalList);
        }

        request.setAttribute("approvalRecordList", this.workOrderService.getRecordsByOrderId(workOrderId));
        request.setAttribute("dailyLogList", this.workOrderService.getDailyLogByOrderId(workOrderId));
        request.setAttribute("reportApprovalRecordList", this.workOrderService.getReportRecordsByOrderId(workOrderId));
        request.setAttribute("workOrder", workOrder);

        WorkFeedBack feedback = this.workFeedBackService.findByWorkNo(workOrderId);
        if(feedback == null) {
            request.setAttribute("haveFiles", "false");
        } else {
            Set<WorkFeedBackAttacment> files = feedback.getAttacments();
            request.setAttribute("haveFiles", "true");
            request.setAttribute("files", files);
        }
        request.setAttribute("workOrderId", workOrderId);
        return "team/workOrderDetail";
    }
    
    @RequestMapping("ccWorkOrderDetail")
    public String ccWorkOrderDetail(HttpServletRequest request) {
        String carbonCopyId = request.getParameter("carbonCopyId");
        WorkOrderCarbonCopy cc = this.workOrderService.getWorkOrderCarbonCopyById(carbonCopyId);
        WorkOrder workOrder = this.workOrderService.getWorkOrderById(cc.getWorkOrderId());
        
        String workExpert = workOrder.getWorkExpert();
        UserInfo userInfo = WeixinUtil.getUserInfoByUserId(workExpert);
        request.setAttribute("workExpert", userInfo);
        
        String workExpertOperational = workOrder.getWorkExpertOptional();
        if(workExpertOperational != null && !workExpertOperational.equals("")) {
            List<UserInfo> workExpertOperationalList = new ArrayList<UserInfo>();
            for(String userId : workExpertOperational.split(",")) {
                UserInfo info = WeixinUtil.getUserInfoByUserId(userId);
                workExpertOperationalList.add(info);
            }
            request.setAttribute("workExpertOperationalList", workExpertOperationalList);
        }

        request.setAttribute("approvalRecordList", this.workOrderService.getRecordsByOrderId(cc.getWorkOrderId()));
        request.setAttribute("dailyLogList", this.workOrderService.getDailyLogByOrderId(cc.getWorkOrderId()));
        request.setAttribute("reportApprovalRecordList", this.workOrderService.getReportRecordsByOrderId(cc.getWorkOrderId()));
        request.setAttribute("cc", cc);
        request.setAttribute("workOrder", workOrder);
        return "team/ccWorkOrderDetail";
    }

    @RequestMapping("toEvaluate")
    public String toEvaluate(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        request.setAttribute("workOrderId", workOrderId);
        return "team/evaluateWorkOrder";
    }

    @RequestMapping("evaluateWorkOrder")
    public String evaluateWorkOrder(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        String evaluationPoint = request.getParameter("evaluationPoint");
        String evaluationContent = request.getParameter("evaluationContent");
        WorkOrder order = this.workOrderService.evaluateWorkOrder(workOrderId, evaluationPoint, evaluationContent);
        
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        StringBuilder sb = new StringBuilder("");
        sb.append(order.getWorkOrderCreatorName()).append("已经对您的工作报告作出评价：")
            .append("\\n国家队：").append(order.getWorkForTeam())
            .append("\\n下队地点：").append(order.getWorkSpace())
            .append("\\n下队时间：").append(order.getConfirmWorkTimeStart())
            .append("至").append(order.getConfirmWorkTimeEnd())
            .append("\\n申请人：").append(order.getWorkOrderCreatorName())
            .append("\\n申请人联系电话：").append(order.getWorkOrderCreatorPhone())
            .append("\\n工作评分：").append(order.getEvaluationPoint())
            .append("\\n工作评语：").append(order.getEvaluationContent())
            .append("\\n详情：").append(basePath).append("/workorder/expert/workOrderDetail.htm?workOrderId=")
            .append(order.getWorkOrderId());
        WeixinUtil.sendMessage("\"touser\":\"" + order.getConfirmWorkExpert() + "\"", Configuration.EXPERT_APP_ID, sb.toString());
        return "redirect:/workorder/team/workOrderDetail.htm?workOrderId=" + workOrderId;
    }

    @RequestMapping("toCarbonCopy")
    public String toCarbonCopy(HttpServletRequest request) {
        StringBuffer url = request.getRequestURL();
        if (request.getQueryString() != null) {
            url.append('?');
            url.append(request.getQueryString());
        }
        String timestamp = String.valueOf(System.currentTimeMillis()).substring(0, 10);
        String signature = WeixinUtil.getJsapiSignature(AccessTokenHolder.getJsapiTicket(), "123qweasdzxc", timestamp, url.toString());
        request.setAttribute("timestamp", timestamp);
        request.setAttribute("signature", signature);
        
        String groupTicket = AccessTokenHolder.greGroupTicket();
        String groupId = AccessTokenHolder.getGroupId();
        String groupSignature = WeixinUtil.getGroupSignature(groupTicket, "123qweasdzxc", timestamp, url.toString());
        request.setAttribute("groupId", groupId);
        request.setAttribute("groupSignature", groupSignature);

        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        request.setAttribute("userDepartments", userInfo.getDepartments());
        
        String workOrderId = request.getParameter("workOrderId");
        request.setAttribute("workOrderId", workOrderId);
        return "team/carbonCopy";
    }

    @RequestMapping("carbonCopy")
    public String carbonCopy(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        String carbonCopyUser = request.getParameter("carbonCopyUser");
        String carbonCopyContent = request.getParameter("carbonCopyContent");
        List<String> users = new ArrayList<String>();
        if(carbonCopyUser != null && !carbonCopyUser.equals("")) {
            String[] userIds = carbonCopyUser.split(",");
            for(String userId : userIds) {
                users.add(userId);
            }
        }
        this.workOrderService.carbonCopyWorkOrder(workOrderId, users, carbonCopyContent);
        WorkOrder order = this.workOrderService.getWorkOrderById(workOrderId);

        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        StringBuilder sb = new StringBuilder("");
        sb.append(order.getWorkOrderCreatorName()).append("向您抄送了工作单，请您查看：")
            .append("\\n申请国家队：").append(order.getWorkForTeam())
            .append("\\n申请下队地点：").append(order.getWorkSpace())
            .append("\\n申请下队时间：").append(order.getWorkTime())
            .append("\\n申请专家：").append(order.getWorkExpertName())
            .append("\\n备选专家：").append(order.getWorkExpertOptionalName())
            .append("\\n申请人：").append(order.getWorkOrderCreatorName())
            .append("\\n申请人联系电话：").append(order.getWorkOrderCreatorPhone())
            .append("\\n详情：").append(basePath).append("/workorder/team/ccWorkOrderDetail.htm?workOrderId=")
            .append(order.getWorkOrderId());
        WeixinUtil.sendMessage("\"touser\":\"" + carbonCopyUser.replace(",", "|") + "\"", Configuration.TEAM_APP_ID, sb.toString());
        return "redirect:/workorder/team/workOrderDetail.htm?workOrderId=" + workOrderId;
    }
}
