package org.cd.weioa.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by xuyang on 16/5/10.
 */
@Entity
@Table(name = "work_feedback_attacment")
public class WorkFeedBackAttacment implements Serializable{

    private static final long serialVersionUID = -5720790007817859632L;

    @Id
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String id;

    @Column(name = "url")
    private String url;

    @Column(name = "attr_type")
    private int attrType;

    @Column(name = "file_name")
    private String fileName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "feedback_id", nullable = true)
    private WorkFeedBack workFeedBack;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getAttrType() {
        return attrType;
    }

    public void setAttrType(int attrType) {
        this.attrType = attrType;
    }

    public WorkFeedBack getWorkFeedBack() {
        return workFeedBack;
    }

    public void setWorkFeedBack(WorkFeedBack workFeedBack) {
        this.workFeedBack = workFeedBack;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
