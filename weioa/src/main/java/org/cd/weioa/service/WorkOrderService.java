package org.cd.weioa.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.cd.weioa.dao.ExpertDailyLogDao;
import org.cd.weioa.dao.ReportApprovalRecordDao;
import org.cd.weioa.dao.WorkOrderApprovalRecordDao;
import org.cd.weioa.dao.WorkOrderCarbonCopyDao;
import org.cd.weioa.dao.WorkOrderChartDao;
import org.cd.weioa.dao.WorkOrderDao;
import org.cd.weioa.entity.ExpertDailyLog;
import org.cd.weioa.entity.ReportApprovalRecord;
import org.cd.weioa.entity.WorkOrder;
import org.cd.weioa.entity.WorkOrderApprovalRecord;
import org.cd.weioa.entity.WorkOrderCarbonCopy;
import org.cd.weioa.entity.WorkOrderChart;
import org.cd.weioa.entity.WorkOrderStatus;
import org.cd.weioa.entity.WorkType;
import org.cd.weioa.weinxin.UserInfo;
import org.cd.weioa.weinxin.WeixinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class WorkOrderService {
    
    @Autowired
    private WorkOrderDao workOrderDao;
    
    @Autowired
    private WorkOrderChartDao workOrderChartDao;
    
    @Autowired
    private ExpertDailyLogDao expertDailyLogDao;
    
    @Autowired
    private WorkOrderApprovalRecordDao workOrderApprovalRecordDao;
    
    @Autowired
    private ReportApprovalRecordDao reportApprovalRecordDao;
    
    @Autowired
    private WorkOrderCarbonCopyDao workOrderCarbonCopyDao;
    
    public WorkOrder createWorkOrder(String workSpace, String workTime, String workForTeam, String workForReason, String workExpert, String workExpertName, String workExpertOpertional, String workExpertOpertionalName, UserInfo userInfo) {
        WorkOrder order = new WorkOrder();
        Date date = new Date();
        
        SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
        String yymmdd = fmt.format(date);
        String deptId = userInfo.getDepartments().get(0);
        if(Integer.parseInt(deptId) < 10) {
            deptId = "00" + deptId;
        } else if(Integer.parseInt(deptId) < 100) {
            deptId = "0" + deptId;
        }
        String maxOrderNum = this.workOrderDao.getMaxOrderNum(yymmdd + deptId);
        String id = "";
        if(maxOrderNum == null || maxOrderNum.equals("")) {
            id = yymmdd + deptId + "001";
        } else {
            id = String.valueOf(Long.parseLong(maxOrderNum) + 1);
        }
        order.setWorkOrderId(id);
        order.setWorkSpace(workSpace);
        order.setWorkTime(workTime);
        order.setWorkForTeam(workForTeam);
        order.setWorkForReason(workForReason);
        order.setWorkExpert(workExpert);
        order.setWorkExpertName(workExpertName);
        order.setWorkExpertOptional(workExpertOpertional);
        order.setWorkExpertOptionalName(workExpertOpertionalName);
        order.setWorkOrderCreator(userInfo.getUserId());
        order.setWorkOrderCreatorName(userInfo.getName());
        order.setWorkOrderCreatorPhone(userInfo.getMobile());
        order.setWorkOrderCreatorPhoto(userInfo.getPhoto());
        order.setWorkOrderCreateTime(date);
        order.setWorkOrderStatus(WorkOrderStatus.COFIRM);
        order.setWorkOrderApprovalStatus(WorkOrderStatus.APPROVAL_STATUS.UNAPPROVAL);
        order.setWorkOrderDoneEvaluateStatus(WorkOrderStatus.DONE_TEAM_EVALUATE_STATUS.UNEVALUATE);
        order.setWorkOrderDoneApprovalStatus(WorkOrderStatus.DONE_OFFICE_APPROVAL_STATUS.UNAPPROVAL);
        // TODO “待解决问题”的附件
        this.workOrderDao.save(order);
        return order;
    }
    
    public void sendMessageInChart(String workOrderId, String sessionId, String role, String content, UserInfo sender) {
        WorkOrderChart chart = new WorkOrderChart();
        chart.setWorkOrderId(workOrderId);
        chart.setSessionId(sessionId);
        chart.setRole(role);
        chart.setContent(content);
        chart.setSender(sender.getUserId());
        chart.setSenderName(sender.getName());
        chart.setSenderPhone(sender.getMobile());
        chart.setSenderPhoto(sender.getPhoto());
        chart.setTime(new Date());
        this.workOrderChartDao.save(chart);
    }
    
    public WorkOrder confirmWorkOrder(String workOrderId, String confirmWorkTimeStart, String confirmWorkTimeEnd, String confirmWorkExpert, String recordContent, UserInfo workOrderReviewerInfo) {
        WorkOrder order = this.workOrderDao.getEntityById(WorkOrder.class, workOrderId);
        order.setConfirmWorkTimeStart(confirmWorkTimeStart);
        order.setConfirmWorkTimeEnd(confirmWorkTimeEnd);
        order.setConfirmWorkExpert(confirmWorkExpert);
        order.setConfirmWorkExpertName(WeixinUtil.getUserInfoByUserId(confirmWorkExpert).getName());
        order.setWorkOrderStatus(WorkOrderStatus.APPROVAL);
        order.setWorkOrderApprovalStatus(WorkOrderStatus.APPROVAL_STATUS.APPROVING);
        order.setWorkOrderReviewer(workOrderReviewerInfo.getUserId());
        order.setWorkOrderReviewerName(workOrderReviewerInfo.getName());
        order.setWorkOrderReviewerPhone(workOrderReviewerInfo.getMobile());
        order.setWorkOrderReviewerPhoto(workOrderReviewerInfo.getPhoto());
        this.workOrderDao.update(order);
        
        WorkOrderApprovalRecord record = new WorkOrderApprovalRecord();
        record.setWorkOrderId(workOrderId);
        record.setRecordUserId(workOrderReviewerInfo.getUserId());
        record.setRecordUserName(workOrderReviewerInfo.getName());
        record.setRecordContent(recordContent);
        record.setRecordTime(new Date());
        workOrderApprovalRecordDao.save(record);
        return order;
    }
    
    public WorkOrder approvalWorkOrder(String workOrderId, String approvalResult, String approvalContent, UserInfo workOrderApproverInfo) {
        WorkOrder order = this.workOrderDao.getEntityById(WorkOrder.class, workOrderId);
        WorkOrderApprovalRecord record = new WorkOrderApprovalRecord();
        record.setWorkOrderId(workOrderId);
        record.setRecordUserId(workOrderApproverInfo.getUserId());
        record.setRecordUserName(workOrderApproverInfo.getName());
        record.setRecordContent(approvalContent);
        record.setRecordTime(new Date());
        workOrderApprovalRecordDao.save(record);
        
        if(approvalResult.equals("1")) {
            order.setWorkOrderStatus(WorkOrderStatus.DOING);
            order.setWorkOrderApprovalStatus(WorkOrderStatus.APPROVAL_STATUS.PASS);
        } else {
            order.setWorkOrderApprovalStatus(WorkOrderStatus.APPROVAL_STATUS.UNPASS);
        }
        this.workOrderDao.update(order);
        return order;
    }
    
    public void addDailyLog(String workOrderId, String dailyLogDate, String dailyLogContent, String workType) {
        ExpertDailyLog log = new ExpertDailyLog();
        log.setWorkOrderId(workOrderId);
        log.setDailyLogDate(dailyLogDate);
        log.setDailyLogContent(dailyLogContent);
        log.setWorkType(workType);
        if(workType != null && !workType.equals("")) {
            String workTypeName = "";
            for(String type : workType.split(",")) {
                workTypeName += WorkType.workTypeNames.get(type) + ",";
            }
            workTypeName = workTypeName.substring(0, workTypeName.length() - 1);
            log.setWorkTypeName(workTypeName);
        }
        expertDailyLogDao.save(log);
    }
    
    public void doneWorkOrder(String workOrderId) {
        WorkOrder order = this.workOrderDao.getEntityById(WorkOrder.class, workOrderId);
        order.setWorkOrderStatus(WorkOrderStatus.DONE);
        this.workOrderDao.update(order);
    }
    
    public WorkOrder submitReport(String workOrderId, String approvalContent, UserInfo userInfo) {
        ReportApprovalRecord record = new ReportApprovalRecord();
        record.setWorkOrderId(workOrderId);
        record.setRecordUserId(userInfo.getUserId());
        record.setRecordUserName(userInfo.getName());
        record.setRecordContent(approvalContent);
        record.setRecordTime(new Date());
        reportApprovalRecordDao.save(record);
        
        WorkOrder order = this.workOrderDao.getEntityById(WorkOrder.class, workOrderId);
        order.setWorkOrderStatus(WorkOrderStatus.REPORT_SUBMIT);
        order.setWorkOrderDoneEvaluateStatus(WorkOrderStatus.DONE_TEAM_EVALUATE_STATUS.EVALUATING);
        order.setWorkOrderDoneApprovalStatus(WorkOrderStatus.DONE_OFFICE_APPROVAL_STATUS.APPROVING);
        this.workOrderDao.update(order);
        return order;
    }
    
    public WorkOrder evaluateWorkOrder(String workOrderId, String evaluationPoint, String evaluationContent) {
        WorkOrder order = this.workOrderDao.getEntityById(WorkOrder.class, workOrderId);
        order.setEvaluationPoint(evaluationPoint);
        order.setEvaluationContent(evaluationContent);
        order.setWorkOrderDoneEvaluateStatus(WorkOrderStatus.DONE_TEAM_EVALUATE_STATUS.EVALUATED);
        if(order.getWorkOrderDoneApprovalStatus().equals(WorkOrderStatus.DONE_OFFICE_APPROVAL_STATUS.PASS)) {
            order.setWorkOrderStatus(WorkOrderStatus.OVER);
        }
        this.workOrderDao.update(order);
        return order;
    }
    
    public WorkOrder approvalReport(String workOrderId, String approvalResult, String approvalContent, UserInfo reportApproverInfo) {
        WorkOrder order = this.workOrderDao.getEntityById(WorkOrder.class, workOrderId);
        ReportApprovalRecord record = new ReportApprovalRecord();
        record.setWorkOrderId(workOrderId);
        record.setRecordUserId(reportApproverInfo.getUserId());
        record.setRecordUserName(reportApproverInfo.getName());
        record.setRecordContent(approvalContent);
        record.setRecordTime(new Date());
        reportApprovalRecordDao.save(record);
        
        if(approvalResult.equals("1")) {
            order.setWorkOrderDoneApprovalStatus(WorkOrderStatus.DONE_OFFICE_APPROVAL_STATUS.PASS);
            if(order.getWorkOrderDoneEvaluateStatus().equals(WorkOrderStatus.DONE_TEAM_EVALUATE_STATUS.EVALUATED)) {
                order.setWorkOrderStatus(WorkOrderStatus.OVER);
            }
        } else {
            order.setWorkOrderDoneApprovalStatus(WorkOrderStatus.DONE_OFFICE_APPROVAL_STATUS.UNPASS);
        }
        this.workOrderDao.update(order);
        return order;
    }
    
    public void carbonCopyWorkOrder(String workOrderId, List<String> users, String content) {
        if(users!= null && users.size() > 0) {
            for(String user : users) {
                List<WorkOrderCarbonCopy> list = this.workOrderCarbonCopyDao.getCarbonCopyByWorkOrderIdAndUserId(workOrderId, user);
                if(list == null || list.size() == 0) {
                    WorkOrderCarbonCopy cc = new WorkOrderCarbonCopy();
                    cc.setWorkOrderId(workOrderId);
                    cc.setCarbonCopyUser(user);
                    cc.setCarbonCopyContent(content);
                    this.workOrderCarbonCopyDao.save(cc);
                }
            }
        }
    }
    
    public WorkOrder cancelWorkOrder(String workOrderId) {
        WorkOrder order = this.getWorkOrderById(workOrderId);
        order.setWorkOrderStatus(WorkOrderStatus.CANCEL);
        this.workOrderDao.update(order);
        return order;
    }
    
    public boolean validateUserIdAndOrderId(String userId, String orderId) {
        WorkOrder order = this.workOrderDao.getEntityById(WorkOrder.class, orderId);

        if(order != null && order.getConfirmWorkExpert() != null && order.getConfirmWorkExpert().equals(userId)) {
            return true;
        } else {
            return false;
        }
    }
    
    public List<WorkOrderChart> getChartsBySession(String workOrderId, String sessionId) {
        return this.workOrderChartDao.getChartList(workOrderId, sessionId);
    }
    
    public List<WorkOrderApprovalRecord> getRecordsByOrderId(String workOrderId) {
        return this.workOrderApprovalRecordDao.getRecordsByOrderId(workOrderId);
    }
    
    public List<ReportApprovalRecord> getReportRecordsByOrderId(String workOrderId) {
        return this.reportApprovalRecordDao.getRecordsByOrderId(workOrderId);
    }
    
    public List<ExpertDailyLog> getDailyLogByOrderId(String workOrderId) {
        return this.expertDailyLogDao.getDailyLogByOrderId(workOrderId);
    }
    
    public WorkOrder getWorkOrderById(String id) {
        return this.workOrderDao.getEntityById(WorkOrder.class, id);
    }
    
    public WorkOrderCarbonCopy getWorkOrderCarbonCopyById(String id) {
        return this.workOrderCarbonCopyDao.getEntityById(WorkOrderCarbonCopy.class, id);
    }
    
    public List<WorkOrder> getWorkOrderByCreator(String userId) {
        return this.workOrderDao.getWorkOrderListByCreator(userId);
    }
    
    public List<WorkOrder> getWorkOrders() {
        return this.workOrderDao.getWorkOrderList();
    }
    
    public List<WorkOrder> getWorkOrdersByStatus(List<String> statusList) {
        return this.workOrderDao.getWorkOrderListByStatus(statusList);
    }
    
    public List<WorkOrder> getWorkOrdersByExpertAndStatus(String expertId, List<String> statusList) {
        return this.workOrderDao.getWorkOrderListByExpertAndStatus(expertId, statusList);
    }
    
    public List<Object[]> getWorkOrdersByCC(String userId) {
        return this.workOrderDao.getWorkOrderListByCC(userId);
    }
    
}
