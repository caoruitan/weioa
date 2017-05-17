package org.cd.weioa.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.cd.weioa.entity.Configuration;
import org.cd.weioa.entity.WorkFeedBack;
import org.cd.weioa.entity.WorkFeedBackAttacment;
import org.cd.weioa.entity.WorkOrder;
import org.cd.weioa.entity.WorkOrderChart;
import org.cd.weioa.entity.WorkOrderChartRole;
import org.cd.weioa.entity.WorkOrderStatus;
import org.cd.weioa.service.WorkFeedBackService;
import org.cd.weioa.service.WorkOrderService;
import org.cd.weioa.weinxin.UserInfo;
import org.cd.weioa.weinxin.WeixinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("workorder/office/")
public class WorkOrderForOfficeAction {

    @Autowired
    WorkOrderService workOrderService;
    
    @Autowired
    WorkFeedBackService workFeedBackService;

    @RequestMapping("workOrderList")
    public String workOrderList(HttpServletRequest request) {
        List<WorkOrder> list = this.workOrderService.getWorkOrders();
        request.setAttribute("workOrderList", list);
        request.setAttribute("statusNames", WorkOrderStatus.statusNames);
        return "office/workOrderList";
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
        
        String workForReasonImages = workOrder.getWorkForReasonImages();
        List<String> images = new ArrayList<String>();
        if(workForReasonImages != null && !workForReasonImages.equals("")) {
            String[] urls = workForReasonImages.split("\\|");
            for(String url : urls) {
                if(!url.trim().equals("")) {
                    images.add(url);
                }
            }
        }

        request.setAttribute("approvalRecordList", this.workOrderService.getRecordsByOrderId(workOrderId));
        request.setAttribute("dailyLogList", this.workOrderService.getDailyLogByOrderId(workOrderId));
        request.setAttribute("reportApprovalRecordList", this.workOrderService.getReportRecordsByOrderId(workOrderId));
        request.setAttribute("workOrder", workOrder);
        request.setAttribute("images", images);

        WorkFeedBack feedback = this.workFeedBackService.findByWorkNo(workOrderId);
        if(feedback == null) {
            request.setAttribute("haveFiles", "false");
        } else {
            Set<WorkFeedBackAttacment> files = feedback.getAttacments();
            request.setAttribute("haveFiles", "true");
            request.setAttribute("files", files);
        }
        request.setAttribute("workOrderId", workOrderId);
        return "office/workOrderDetail";
    }
    
    @RequestMapping("viewChart")
    public String toSendMessageInChart(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        WorkOrder order = this.workOrderService.getWorkOrderById(workOrderId);
        String sessionId = request.getParameter("sessionId");
        String role = request.getParameter("role");
        String edit = request.getParameter("edit");
        List<WorkOrderChart> charts = this.workOrderService.getChartsBySession(workOrderId, sessionId);
        request.setAttribute("workOrderId", workOrderId);
        request.setAttribute("workOrder", order);
        request.setAttribute("sessionId", sessionId);
        request.setAttribute("role", role);
        request.setAttribute("edit", edit);
        request.setAttribute("charts", charts);
        return "office/viewChart";
    }
    
    @RequestMapping("sendMessageInChart")
    public String sendMessageInChart(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        String sessionId = request.getParameter("sessionId");
        String role = request.getParameter("role");
        String content = request.getParameter("content");
        UserInfo sender = (UserInfo) request.getSession(true).getAttribute("userInfo");
        this.workOrderService.sendMessageInChart(workOrderId, sessionId, role, content, sender);
        
        WorkOrder order = this.workOrderService.getWorkOrderById(workOrderId);

        if(!sender.getUserId().equals(sessionId)) {
            if(role.equals(WorkOrderChartRole.TEAM)) {
                String path = request.getContextPath();
                String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
                StringBuilder sb = new StringBuilder("");
                sb.append("您有一条新的消息：")
                    .append("\\n发送人：").append(sender.getName())
                    .append("\\n消息内容：").append(content)
                    .append("\\n回复：").append(basePath).append("/workorder/office/viewChart.htm?workOrderId=").append(workOrderId)
                    .append("&sessionId=").append(sessionId)
                    .append("&role=").append(role);
                if(order.getWorkOrderStatus().equals(WorkOrderStatus.COFIRM) || (order.getWorkOrderStatus().equals(WorkOrderStatus.APPROVAL) && order.getWorkOrderApprovalStatus().equals(WorkOrderStatus.APPROVAL_STATUS.UNPASS))) {
                    sb.append("&edit=true");
                }
                WeixinUtil.sendMessage("\"touser\":\"" + sessionId + "\"", Configuration.TEAM_APP_ID, sb.toString());
            }
            if(role.equals(WorkOrderChartRole.EXPERT)) {
                String path = request.getContextPath();
                String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
                StringBuilder sb = new StringBuilder("");
                sb.append("您有一条新的消息：")
                    .append("\\n发送人：").append(sender.getName())
                    .append("\\n消息内容：").append(content)
                    .append("\\n回复：").append(basePath).append("/workorder/office/viewChart.htm?workOrderId=").append(workOrderId)
                    .append("&sessionId=").append(sessionId)
                    .append("&role=").append(role);
                if(order.getWorkOrderStatus().equals(WorkOrderStatus.COFIRM) || (order.getWorkOrderStatus().equals(WorkOrderStatus.APPROVAL) && order.getWorkOrderApprovalStatus().equals(WorkOrderStatus.APPROVAL_STATUS.UNPASS))) {
                    sb.append("&edit=true");
                }
                WeixinUtil.sendMessage("\"touser\":\"" + sessionId + "\"", Configuration.EXPERT_APP_ID, sb.toString());
            }
        }
        return "redirect:/workorder/office/viewChart.htm?workOrderId=" + workOrderId + "&sessionId=" + sessionId + "&role=" + role;
    }
    
    @RequestMapping("toConfirmWorkOrder")
    public String toConfirmWorkOrder(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        WorkOrder workOrder = this.workOrderService.getWorkOrderById(workOrderId);
        String workExpert = workOrder.getWorkExpert();
        String workExpertOperational = workOrder.getWorkExpertOptional();
        List<UserInfo> workExpertOperationalList = new ArrayList<UserInfo>();
        UserInfo WorkExpertUser = WeixinUtil.getUserInfoByUserId(workExpert);
        workExpertOperationalList.add(WorkExpertUser);

        if(workExpertOperational != null && !workExpertOperational.equals("")) {
            for(String expert : workExpertOperational.split(",")) {
                UserInfo info = WeixinUtil.getUserInfoByUserId(expert);
                workExpertOperationalList.add(info);
            }
        }
        
        String workForReasonImages = workOrder.getWorkForReasonImages();
        List<String> images = new ArrayList<String>();
        if(workForReasonImages != null && !workForReasonImages.equals("")) {
            String[] urls = workForReasonImages.split("\\|");
            for(String url : urls) {
                if(!url.trim().equals("")) {
                    images.add(url);
                }
            }
        }
        request.setAttribute("workOrder", workOrder);
        request.setAttribute("expertList", workExpertOperationalList);
        request.setAttribute("images", images);
        
        return "office/confirmWorkOrder";
    }

    @RequestMapping("cancelWorkOrder")
    public String cancelWorkOrder(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        WorkOrder order = this.workOrderService.cancelWorkOrder(workOrderId);
        
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        StringBuilder sb = new StringBuilder("");
        sb.append("您提交的工作单申请已经被取消，请关注：")
            .append("\\n申请下队地点：").append(order.getWorkSpace())
            .append("\\n申请下队时间：").append(order.getWorkTime())
            .append("\\n申请专家：").append(order.getWorkExpertName())
            .append("\\n备选专家：").append(order.getWorkExpertOptionalName())
            .append("\\n详情：").append(basePath).append("/workorder/team/workOrderDetail.htm?workOrderId=")
            .append(order.getWorkOrderId());
        WeixinUtil.sendMessage("\"touser\":\"" + order.getWorkOrderCreator() + "\"", Configuration.TEAM_APP_ID, sb.toString());
        return "redirect:/workorder/office/workOrderDetail.htm?workOrderId=" + workOrderId;
    }
    
    @RequestMapping("confirmWorkOrder")
    public String confirmWorkOrder(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        String confirmWorkTimeStart = request.getParameter("confirmWorkTimeStart");
        String confirmWorkTimeEnd = request.getParameter("confirmWorkTimeEnd");
        String confirmWorkExpert = request.getParameter("confirmWorkExpert");
        String recordContent = request.getParameter("recordContent");
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        WorkOrder order = this.workOrderService.confirmWorkOrder(workOrderId, confirmWorkTimeStart, confirmWorkTimeEnd, confirmWorkExpert, recordContent, userInfo);
        
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        StringBuilder sb = new StringBuilder("");
        sb.append("有一条新的工作单需要您审批：")
            .append("\\n申请国家队：").append(order.getWorkForTeam())
            .append("\\n下队地点：").append(order.getWorkSpace())
            .append("\\n下队时间：").append(order.getConfirmWorkTimeStart())
            .append("至").append(order.getConfirmWorkTimeEnd())
            .append("\\n下队专家：").append(order.getConfirmWorkExpertName())
            .append("\\n申请人：").append(order.getWorkOrderCreatorName())
            .append("\\n申请人联系电话：").append(order.getWorkOrderCreatorPhone())
            .append("\\n确认人（办公室）：").append(order.getWorkOrderCreatorName())
            .append("\\n确认人（办公室）联系电话：").append(order.getWorkOrderCreatorPhone())
            .append("\\n详情：").append(basePath).append("/workorder/leader/workOrderDetail.htm?workOrderId=")
            .append(order.getWorkOrderId());
        WeixinUtil.sendMessage(Configuration.LEADER_MSG_SEND, Configuration.LEADER_APP_ID, sb.toString());
        return "redirect:/workorder/office/workOrderDetail.htm?workOrderId=" + workOrderId;
    }
    
    @RequestMapping("toApprovalReport")
    public String toApprovalReport(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        request.setAttribute("workOrderId", workOrderId);
        return "office/approvalReport";
    }
    
    @RequestMapping("approvalReport")
    public String approvalReport(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        String approvalResult = request.getParameter("approvalResult");
        String approvalContent = request.getParameter("approvalContent");
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        WorkOrder order = this.workOrderService.approvalReport(workOrderId, approvalResult, approvalContent, userInfo);
        
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        if(approvalResult.equals("1")) {
            StringBuilder sb = new StringBuilder("");
            sb.append("您提交的工作报告/财务报告已经审核通过，请及时进行报销：")
                .append("\\n申请国家队：").append(order.getWorkForTeam())
                .append("\\n下队地点：").append(order.getWorkSpace())
                .append("\\n下队时间：").append(order.getConfirmWorkTimeStart())
                .append("至").append(order.getConfirmWorkTimeEnd())
                .append("\\n下队专家：").append(order.getConfirmWorkExpertName())
                .append("\\n审批意见：").append(approvalContent)
                .append("\\n审批人：").append(userInfo.getName())
                .append("\\n审批人联系电话：").append(userInfo.getMobile())
                .append("\\n详情：").append(basePath).append("/workorder/expert/workOrderDetail.htm?workOrderId=")
                .append(order.getWorkOrderId());
            WeixinUtil.sendMessage("\"touser\":\"" + order.getConfirmWorkExpert() + "\"", Configuration.EXPERT_APP_ID, sb.toString());
        } else {
            StringBuilder sb1 = new StringBuilder("");
            sb1.append("您提交的工作报告/财务报告审核未通过：")
                .append("\\n申请国家队：").append(order.getWorkForTeam())
                .append("\\n下队地点：").append(order.getWorkSpace())
                .append("\\n下队时间：").append(order.getConfirmWorkTimeStart())
                .append("至").append(order.getConfirmWorkTimeEnd())
                .append("\\n下队专家：").append(order.getConfirmWorkExpertName())
                .append("\\n审批意见：").append(approvalContent)
                .append("\\n审批人：").append(userInfo.getName())
                .append("\\n审批人联系电话：").append(userInfo.getMobile())
                .append("\\n详情：").append(basePath).append("/workorder/expert/workOrderDetail.htm?workOrderId=")
                .append(order.getWorkOrderId());
            WeixinUtil.sendMessage("\"touser\":\"" + order.getConfirmWorkExpert() + "\"", Configuration.EXPERT_APP_ID, sb1.toString());
        }
        return "redirect:/workorder/office/workOrderDetail.htm?workOrderId=" + workOrderId;
    }
}
