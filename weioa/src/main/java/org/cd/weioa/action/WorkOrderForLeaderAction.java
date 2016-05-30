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
import org.cd.weioa.entity.WorkOrderStatus;
import org.cd.weioa.service.WorkFeedBackService;
import org.cd.weioa.service.WorkOrderService;
import org.cd.weioa.weinxin.UserInfo;
import org.cd.weioa.weinxin.WeixinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("workorder/leader/")
public class WorkOrderForLeaderAction {

    @Autowired
    WorkOrderService workOrderService;
    
    @Autowired
    WorkFeedBackService workFeedBackService;

    @RequestMapping("workOrderList")
    public String workOrderList(HttpServletRequest request) {
        List<String> statusList = new ArrayList<String>();
        statusList.add(WorkOrderStatus.APPROVAL);
        statusList.add(WorkOrderStatus.DOING);
        statusList.add(WorkOrderStatus.DONE);
        statusList.add(WorkOrderStatus.REPORT_SUBMIT);
        statusList.add(WorkOrderStatus.OVER);
        List<WorkOrder> list = this.workOrderService.getWorkOrdersByStatus(statusList);
        request.setAttribute("workOrderList", list);
        request.setAttribute("statusNames", WorkOrderStatus.statusNames);
        return "leader/workOrderList";
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
        return "leader/workOrderDetail";
    }
    
    @RequestMapping("viewChart")
    public String toSendMessageInChart(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        String sessionId = request.getParameter("sessionId");
        String role = request.getParameter("role");
        List<WorkOrderChart> charts = this.workOrderService.getChartsBySession(workOrderId, sessionId);
        request.setAttribute("workOrderId", workOrderId);
        request.setAttribute("sessionId", sessionId);
        request.setAttribute("role", role);
        request.setAttribute("charts", charts);
        return "office/viewChart";
    }
    
    @RequestMapping("toApprovalWorkOrder")
    public String toApprovalWorkOrder(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        request.setAttribute("workOrderId", workOrderId);
        return "leader/approvalWorkOrder";
    }
    
    @RequestMapping("approvalWorkOrder")
    public String approvalWorkOrder(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        String approvalResult = request.getParameter("approvalResult");
        String approvalContent = request.getParameter("approvalContent");
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        WorkOrder order = this.workOrderService.approvalWorkOrder(workOrderId, approvalResult, approvalContent, userInfo);
        
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        
        if(approvalResult.equals("1")) {
            StringBuilder sb = new StringBuilder("");
            sb.append("您提交的工作单已经审核通过：")
                .append("\\n下队地点：").append(order.getWorkSpace())
                .append("\\n下队时间：").append(order.getConfirmWorkTimeStart())
                .append("至").append(order.getConfirmWorkTimeEnd())
                .append("\\n下队专家：").append(order.getConfirmWorkExpertName())
                .append("\\n详情：").append(basePath).append("/workorder/team/workOrderDetail.htm?workOrderId=")
                .append(order.getWorkOrderId());
            WeixinUtil.sendMessage("\"touser\":\"" + order.getWorkOrderCreator() + "\"", Configuration.TEAM_APP_ID, sb.toString());
            
            StringBuilder sb1 = new StringBuilder("");
            sb1.append(order.getWorkOrderCreatorName()).append("提交的工作单已经审核通过，请您确认您的行程：")
                .append("\\n申请国家队：").append(order.getWorkForTeam())
                .append("\\n下队地点：").append(order.getWorkSpace())
                .append("\\n下队时间：").append(order.getConfirmWorkTimeStart())
                .append("至").append(order.getConfirmWorkTimeEnd())
                .append("\\n申请人：").append(order.getWorkOrderCreatorName())
                .append("\\n申请人联系电话：").append(order.getWorkOrderCreatorPhone())
                .append("\\n详情：").append(basePath).append("/workorder/expert/workOrderDetail.htm?workOrderId=")
                .append(order.getWorkOrderId());
            WeixinUtil.sendMessage("\"touser\":\"" + order.getConfirmWorkExpert() + "\"", Configuration.EXPERT_APP_ID, sb1.toString());
        } else {
            StringBuilder sb1 = new StringBuilder("");
            sb1.append(order.getWorkOrderCreatorName()).append("提交的工作单审核未通过，请您协助处理：")
                .append("\\n申请国家队：").append(order.getWorkForTeam())
                .append("\\n下队地点：").append(order.getWorkSpace())
                .append("\\n下队时间：").append(order.getConfirmWorkTimeStart())
                .append("至").append(order.getConfirmWorkTimeEnd())
                .append("\\n下队专家：").append(order.getConfirmWorkExpertName())
                .append("\\n申请人：").append(order.getWorkOrderCreatorName())
                .append("\\n申请人联系电话：").append(order.getWorkOrderCreatorPhone())
                .append("\\n审批意见：").append(approvalContent)
                .append("\\n审批人：").append(userInfo.getName())
                .append("\\n审批人联系电话：").append(userInfo.getMobile())
                .append("\\n详情：").append(basePath).append("/workorder/office/workOrderDetail.htm?workOrderId=")
                .append(order.getWorkOrderId());
            WeixinUtil.sendMessage(Configuration.OFFICE_MSG_SEND, Configuration.OFFICE_APP_ID, sb1.toString());
        }
        return "redirect:/workorder/leader/workOrderDetail.htm?workOrderId=" + workOrderId;
    }
}
