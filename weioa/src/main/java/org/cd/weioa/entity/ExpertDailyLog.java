package org.cd.weioa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity()
@Table(name = "expert_daily_log")
public class ExpertDailyLog {

    private String dailyLogId;
    
    private String workOrderId;
    
    private String workType;
    
    private String workTypeName;
    
    private String dailyLogContent;
    
    private String dailyLogDate;

    @Id
    @GeneratedValue(generator = "paymentableGenerator")
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid")
    @Column(name = "daily_log_id")
    public String getDailyLogId() {
        return dailyLogId;
    }

    public void setDailyLogId(String dailyLogId) {
        this.dailyLogId = dailyLogId;
    }

    @Column(name = "work_order_id")
    public String getWorkOrderId() {
        return workOrderId;
    }

    public void setWorkOrderId(String workOrderId) {
        this.workOrderId = workOrderId;
    }

    @Column(name = "work_type")
    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    @Column(name = "work_type_name")
    public String getWorkTypeName() {
        return workTypeName;
    }

    public void setWorkTypeName(String workTypeName) {
        this.workTypeName = workTypeName;
    }

    @Column(name = "daily_log_content")
    public String getDailyLogContent() {
        return dailyLogContent;
    }

    public void setDailyLogContent(String dailyLogContent) {
        this.dailyLogContent = dailyLogContent;
    }

    @Column(name = "daily_log_date")
    public String getDailyLogDate() {
        return dailyLogDate;
    }

    public void setDailyLogDate(String dailyLogDate) {
        this.dailyLogDate = dailyLogDate;
    }
    
}
