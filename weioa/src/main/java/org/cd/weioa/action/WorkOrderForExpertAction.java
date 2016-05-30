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
import org.cd.weioa.weinxin.AccessTokenHolder;
import org.cd.weioa.weinxin.UserInfo;
import org.cd.weioa.weinxin.WeixinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("workorder/expert/")
public class WorkOrderForExpertAction {

    @Autowired
    WorkOrderService workOrderService;
    
    @Autowired
    WorkFeedBackService workFeedBackService;

    @RequestMapping("workOrderList")
    public String workOrderList(HttpServletRequest request) {
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        List<String> statusList = new ArrayList<String>();
        statusList.add(WorkOrderStatus.DOING);
        statusList.add(WorkOrderStatus.DONE);
        statusList.add(WorkOrderStatus.REPORT_SUBMIT);
        statusList.add(WorkOrderStatus.OVER);
        List<WorkOrder> list = this.workOrderService.getWorkOrdersByExpertAndStatus(userInfo.getUserId(), statusList);
        request.setAttribute("workOrderList", list);
        request.setAttribute("statusNames", WorkOrderStatus.statusNames);
        return "expert/workOrderList";
    }
    
    @RequestMapping("workOrderDetail")
    public String workOrderDetail(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        WorkOrder workOrder = this.workOrderService.getWorkOrderById(workOrderId);
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
        return "expert/workOrderDetail";
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
        return "expert/viewChart";
    }
    
    @RequestMapping("toAddDailyLog")
    public String toApprovalWorkOrder(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        request.setAttribute("workOrderId", workOrderId);
        return "expert/addDailyLog";
    }
    
    @RequestMapping("addDailyLog")
    public String addDailyLog(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        String dailyLogDate = request.getParameter("dailyLogDate");
        String dailyLogContent = request.getParameter("dailyLogContent");
        String workType = request.getParameter("workType");
        this.workOrderService.addDailyLog(workOrderId, dailyLogDate, dailyLogContent, workType);
        return "redirect:/workorder/expert/workOrderDetail.htm?workOrderId=" + workOrderId;
    }
    
    @RequestMapping("doneWorkOrder")
    public String doneWorkOrder(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        this.workOrderService.doneWorkOrder(workOrderId);
        return "redirect:/workorder/expert/workOrderDetail.htm?workOrderId=" + workOrderId;
    }
    
    @RequestMapping("toSubmitReport")
    public String toSubmitReport(HttpServletRequest request) {
        String workOrderId = request.getParameter("workOrderId");
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        WorkFeedBack feedback = this.workFeedBackService.findByWorkNo(workOrderId);
        if(feedback == null) {
            request.setAttribute("haveFiles", "false");
        } else {
            Set<WorkFeedBackAttacment> files = feedback.getAttacments();
            request.setAttribute("haveFiles", "true");
            request.setAttribute("files", files);
        }
        request.setAttribute("workOrderId", workOrderId);
        request.setAttribute("userInfo", userInfo);
        return "expert/submitReport";
    }
    
    @RequestMapping("submitReport")
    public String submitReport(HttpServletRequest request) {
        // TODO 临时做状态变更，需要提供PC-WEB页面进行上传
        String workOrderId = request.getParameter("workOrderId");
        String approvalContent = request.getParameter("approvalContent");
        UserInfo userInfo = (UserInfo) request.getSession(true).getAttribute("userInfo");
        WorkOrder order = this.workOrderService.submitReport(workOrderId, approvalContent, userInfo);
        
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        StringBuilder sb = new StringBuilder("");
        sb.append(order.getConfirmWorkExpertName()).append("本次下队的工作报告已经提交，请及时作出评价：")
            .append("\\n申请国家队：").append(order.getWorkForTeam())
            .append("\\n下队地点：").append(order.getWorkSpace())
            .append("\\n下队时间：").append(order.getConfirmWorkTimeStart())
            .append("至").append(order.getConfirmWorkTimeEnd())
            .append("\\n下队专家：").append(order.getConfirmWorkExpertName())
            .append("\\n详情：").append(basePath).append("/workorder/team/workOrderDetail.htm?workOrderId=")
            .append(order.getWorkOrderId());
        WeixinUtil.sendMessage("\"touser\":\"" + order.getWorkOrderCreator() + "\"", Configuration.OFFICE_APP_ID, sb.toString());

        StringBuilder sb1 = new StringBuilder("");
        sb1.append(order.getConfirmWorkExpertName()).append("本次下队的工作报告/财务报告已经提交，请及时对工作报告/财务报告进行审批：")
            .append("\\n申请国家队：").append(order.getWorkForTeam())
            .append("\\n下队地点：").append(order.getWorkSpace())
            .append("\\n下队时间：").append(order.getConfirmWorkTimeStart())
            .append("至").append(order.getConfirmWorkTimeEnd())
            .append("\\n下队专家：").append(order.getConfirmWorkExpertName())
            .append("\\n详情：").append(basePath).append("/workorder/office/workOrderDetail.htm?workOrderId=")
            .append(order.getWorkOrderId());
        WeixinUtil.sendMessage(Configuration.OFFICE_MSG_SEND, Configuration.OFFICE_APP_ID, sb1.toString());
        
        return "redirect:/workorder/expert/workOrderDetail.htm?workOrderId=" + workOrderId;
    }
    
    @RequestMapping("toCalendar")
    public String calendar(HttpServletRequest request) {
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

        request.setAttribute("groupId", groupId);
        request.setAttribute("groupSignature", groupSignature);
        request.setAttribute("expertDeptId", Configuration.EXPERT_DEP_ID);
        
        String expertId = request.getParameter("expertId");
        List<WorkOrder> workOrderList = new ArrayList<WorkOrder>();
        if(expertId != null && !expertId.equals("")) {
            List<String> statusList = new ArrayList<String>();
            statusList.add(WorkOrderStatus.DOING);
            workOrderList = this.workOrderService.getWorkOrdersByExpertAndStatus(expertId, statusList);
            request.setAttribute("expertInfo", WeixinUtil.getUserInfoByUserId(expertId));
        }
        request.setAttribute("workOrderList", workOrderList);
        request.setAttribute("expertId", expertId);
        return "expert/calendar";
    }
    
}
