package org.cd.weioa.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity()
@Table(name = "work_order")
public class WorkOrder {

    private String workOrderId;
    
    private String workTime;
    
    private String confirmWorkTimeStart;
    
    private String confirmWorkTimeEnd;
    
    private String workSpace;
    
    private String workForTeam;
    
    private String workForReason;
    
    private String workExpert;
    
    private String workExpertName;
    
    private String confirmWorkExpert;
    
    private String confirmWorkExpertName;
    
    private String workExpertOptional;
    
    private String workExpertOptionalName;
    
    private String workOrderCreator;
    
    private String workOrderCreatorName;
    
    private String workOrderCreatorPhone;
    
    private String workOrderCreatorPhoto;
    
    private Date workOrderCreateTime;
    
    private String workOrderReviewer;
    
    private String workOrderReviewerName;
    
    private String workOrderReviewerPhone;
    
    private String workOrderReviewerPhoto;
    
    private String evaluationPoint;
    
    private String evaluationContent;
    
    private String workOrderStatus;
    
    private String workOrderApprovalStatus;
    
    private String workOrderDoneEvaluateStatus;
    
    private String workOrderDoneApprovalStatus;

    @Id
    @Column(name = "work_order_id")
    public String getWorkOrderId() {
        return workOrderId;
    }

    public void setWorkOrderId(String workOrderId) {
        this.workOrderId = workOrderId;
    }

    @Column(name = "work_time")
    public String getWorkTime() {
        return workTime;
    }

    public void setWorkTime(String workTime) {
        this.workTime = workTime;
    }

    @Column(name = "confirm_work_time_start")
    public String getConfirmWorkTimeStart() {
        return confirmWorkTimeStart;
    }

    public void setConfirmWorkTimeStart(String confirmWorkTimeStart) {
        this.confirmWorkTimeStart = confirmWorkTimeStart;
    }

    @Column(name = "confirm_work_time_end")
    public String getConfirmWorkTimeEnd() {
        return confirmWorkTimeEnd;
    }

    public void setConfirmWorkTimeEnd(String confirmWorkTimeEnd) {
        this.confirmWorkTimeEnd = confirmWorkTimeEnd;
    }

    @Column(name = "work_space")
    public String getWorkSpace() {
        return workSpace;
    }

    public void setWorkSpace(String workSpace) {
        this.workSpace = workSpace;
    }

    @Column(name = "work_for_team")
    public String getWorkForTeam() {
        return workForTeam;
    }

    public void setWorkForTeam(String workForTeam) {
        this.workForTeam = workForTeam;
    }

    @Column(name = "work_for_reason")
    public String getWorkForReason() {
        return workForReason;
    }

    public void setWorkForReason(String workForReason) {
        this.workForReason = workForReason;
    }

    @Column(name = "work_expert")
    public String getWorkExpert() {
        return workExpert;
    }

    public void setWorkExpert(String workExpert) {
        this.workExpert = workExpert;
    }

    @Column(name = "work_expert_name")
    public String getWorkExpertName() {
        return workExpertName;
    }

    public void setWorkExpertName(String workExpertName) {
        this.workExpertName = workExpertName;
    }

    @Column(name = "confirm_work_expert")
    public String getConfirmWorkExpert() {
        return confirmWorkExpert;
    }

    public void setConfirmWorkExpert(String confirmWorkExpert) {
        this.confirmWorkExpert = confirmWorkExpert;
    }

    @Column(name = "confirm_work_expert_name")
    public String getConfirmWorkExpertName() {
        return confirmWorkExpertName;
    }

    public void setConfirmWorkExpertName(String confirmWorkExpertName) {
        this.confirmWorkExpertName = confirmWorkExpertName;
    }

    @Column(name = "work_expert_optional")
    public String getWorkExpertOptional() {
        return workExpertOptional;
    }

    public void setWorkExpertOptional(String workExpertOptional) {
        this.workExpertOptional = workExpertOptional;
    }

    @Column(name = "work_expert_optional_name")
    public String getWorkExpertOptionalName() {
        return workExpertOptionalName;
    }

    public void setWorkExpertOptionalName(String workExpertOptionalName) {
        this.workExpertOptionalName = workExpertOptionalName;
    }

    @Column(name = "work_order_creator")
    public String getWorkOrderCreator() {
        return workOrderCreator;
    }

    public void setWorkOrderCreator(String workOrderCreator) {
        this.workOrderCreator = workOrderCreator;
    }

    @Column(name = "work_order_creator_name")
    public String getWorkOrderCreatorName() {
        return workOrderCreatorName;
    }

    public void setWorkOrderCreatorName(String workOrderCreatorName) {
        this.workOrderCreatorName = workOrderCreatorName;
    }

    @Column(name = "work_order_creator_phone")
    public String getWorkOrderCreatorPhone() {
        return workOrderCreatorPhone;
    }

    public void setWorkOrderCreatorPhone(String workOrderCreatorPhone) {
        this.workOrderCreatorPhone = workOrderCreatorPhone;
    }

    @Column(name = "work_order_creator_photo")
    public String getWorkOrderCreatorPhoto() {
        return workOrderCreatorPhoto;
    }

    public void setWorkOrderCreatorPhoto(String workOrderCreatorPhoto) {
        this.workOrderCreatorPhoto = workOrderCreatorPhoto;
    }

    @Column(name = "work_order_create_time")
    public Date getWorkOrderCreateTime() {
        return workOrderCreateTime;
    }

    public void setWorkOrderCreateTime(Date workOrderCreateTime) {
        this.workOrderCreateTime = workOrderCreateTime;
    }

    @Column(name = "work_order_reviewer")
    public String getWorkOrderReviewer() {
        return workOrderReviewer;
    }

    public void setWorkOrderReviewer(String workOrderReviewer) {
        this.workOrderReviewer = workOrderReviewer;
    }

    @Column(name = "work_order_reviewer_name")
    public String getWorkOrderReviewerName() {
        return workOrderReviewerName;
    }

    public void setWorkOrderReviewerName(String workOrderReviewerName) {
        this.workOrderReviewerName = workOrderReviewerName;
    }

    @Column(name = "work_order_reviewer_phone")
    public String getWorkOrderReviewerPhone() {
        return workOrderReviewerPhone;
    }

    public void setWorkOrderReviewerPhone(String workOrderReviewerPhone) {
        this.workOrderReviewerPhone = workOrderReviewerPhone;
    }

    @Column(name = "work_order_reviewer_photo")
    public String getWorkOrderReviewerPhoto() {
        return workOrderReviewerPhoto;
    }

    public void setWorkOrderReviewerPhoto(String workOrderReviewerPhoto) {
        this.workOrderReviewerPhoto = workOrderReviewerPhoto;
    }

    @Column(name = "evaluation_point")
    public String getEvaluationPoint() {
        return evaluationPoint;
    }

    public void setEvaluationPoint(String evaluationPoint) {
        this.evaluationPoint = evaluationPoint;
    }

    @Column(name = "evaluation_content")
    public String getEvaluationContent() {
        return evaluationContent;
    }

    public void setEvaluationContent(String evaluationContent) {
        this.evaluationContent = evaluationContent;
    }

    @Column(name = "work_order_status")
    public String getWorkOrderStatus() {
        return workOrderStatus;
    }

    public void setWorkOrderStatus(String workOrderStatus) {
        this.workOrderStatus = workOrderStatus;
    }

    @Column(name = "work_order_approval_status")
    public String getWorkOrderApprovalStatus() {
        return workOrderApprovalStatus;
    }

    public void setWorkOrderApprovalStatus(String workOrderApprovalStatus) {
        this.workOrderApprovalStatus = workOrderApprovalStatus;
    }

    @Column(name = "work_order_done_evaluate_status")
    public String getWorkOrderDoneEvaluateStatus() {
        return workOrderDoneEvaluateStatus;
    }

    public void setWorkOrderDoneEvaluateStatus(String workOrderDoneEvaluateStatus) {
        this.workOrderDoneEvaluateStatus = workOrderDoneEvaluateStatus;
    }

    @Column(name = "work_order_done_approval_status")
    public String getWorkOrderDoneApprovalStatus() {
        return workOrderDoneApprovalStatus;
    }

    public void setWorkOrderDoneApprovalStatus(String workOrderDoneApprovalStatus) {
        this.workOrderDoneApprovalStatus = workOrderDoneApprovalStatus;
    }
    
}
