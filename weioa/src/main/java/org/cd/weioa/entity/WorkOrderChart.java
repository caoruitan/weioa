package org.cd.weioa.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity()
@Table(name = "work_order_chart")
public class WorkOrderChart {
    
    private String workOrderChartId; // 主键

    private String workOrderId; // 工作单ID
    
    private String sessionId; // 会话ID，非主动沟通方（办公室发起，可能为专家或者国家队）的用户ID
    
    private String role; // 沟通对象角色，取值WorkOrderChartRole。EXPERT，WorkOrderChartRole。TEAM
    
    private String content; // 发送的内容
    
    private String sender; // 发送者
    
    private String senderName; // 发送者姓名
    
    private String senderPhone; // 发送者电话
    
    private String senderPhoto; // 发送者头像
    
    private Date time; // 发送时间

    @Id
    @GeneratedValue(generator = "paymentableGenerator")
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid")
    @Column(name = "work_order_chart_id")
    public String getWorkOrderChartId() {
        return workOrderChartId;
    }

    public void setWorkOrderChartId(String workOrderChartId) {
        this.workOrderChartId = workOrderChartId;
    }

    @Column(name = "work_order_id")
    public String getWorkOrderId() {
        return workOrderId;
    }

    public void setWorkOrderId(String workOrderId) {
        this.workOrderId = workOrderId;
    }

    @Column(name = "session_id")
    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    @Column(name = "role")
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Column(name = "sender")
    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    @Column(name = "sender_name")
    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    @Column(name = "sender_phone")
    public String getSenderPhone() {
        return senderPhone;
    }

    public void setSenderPhone(String senderPhone) {
        this.senderPhone = senderPhone;
    }

    @Column(name = "sender_photo")
    public String getSenderPhoto() {
        return senderPhoto;
    }

    public void setSenderPhoto(String senderPhoto) {
        this.senderPhoto = senderPhoto;
    }

    @Column(name = "time")
    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
    
}
