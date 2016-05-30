package org.cd.weioa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity()
@Table(name = "work_order_carbon_copy")
public class WorkOrderCarbonCopy {
    
    private String carbonCopyId;
    
    private String workOrderId;
    
    private String carbonCopyUser;
    
    private String carbonCopyContent;

    @Id
    @GeneratedValue(generator = "paymentableGenerator")
    @GenericGenerator(name = "paymentableGenerator", strategy = "guid")
    @Column(name = "carbon_copy_id")
    public String getCarbonCopyId() {
        return carbonCopyId;
    }

    public void setCarbonCopyId(String carbonCopyId) {
        this.carbonCopyId = carbonCopyId;
    }

    @Column(name = "work_order_id")
    public String getWorkOrderId() {
        return workOrderId;
    }

    public void setWorkOrderId(String workOrderId) {
        this.workOrderId = workOrderId;
    }

    @Column(name = "carbon_copy_user")
    public String getCarbonCopyUser() {
        return carbonCopyUser;
    }

    public void setCarbonCopyUser(String carbonCopyUser) {
        this.carbonCopyUser = carbonCopyUser;
    }

    @Column(name = "carbon_copy_content")
    public String getCarbonCopyContent() {
        return carbonCopyContent;
    }

    public void setCarbonCopyContent(String carbonCopyContent) {
        this.carbonCopyContent = carbonCopyContent;
    }
    
}
