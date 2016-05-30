package org.cd.weioa.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by xuyang on 16/5/10.
 */
@Entity
@Table(name = "work_feedback")
public class WorkFeedBack implements Serializable {

    private static final long serialVersionUID = 3451251193080186816L;

    @Id
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String id;

    @Column(name = "work_no")
    private String workNo;

    @Column(name = "weixin_no")
    private String weixinNo;

    @Column(name = "create_time")
    private Date createTime;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "workFeedBack")
    private Set<WorkFeedBackAttacment> attacments = new HashSet<WorkFeedBackAttacment>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getWorkNo() {
        return workNo;
    }

    public void setWorkNo(String workNo) {
        this.workNo = workNo;
    }

    public String getWeixinNo() {
        return weixinNo;
    }

    public void setWeixinNo(String weixinNo) {
        this.weixinNo = weixinNo;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Set<WorkFeedBackAttacment> getAttacments() {
        return attacments;
    }

    public void setAttacments(Set<WorkFeedBackAttacment> attacments) {
        this.attacments = attacments;
    }

    public void addAttas(String url, int attrType, String name) {

        WorkFeedBackAttacment atta = new WorkFeedBackAttacment();
        atta.setUrl(url);
        atta.setAttrType(attrType);
        atta.setFileName(name);
        atta.setWorkFeedBack(this);

        this.attacments.add(atta);
    }
}
