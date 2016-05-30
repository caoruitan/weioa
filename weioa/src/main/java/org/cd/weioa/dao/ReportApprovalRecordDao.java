package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.ReportApprovalRecord;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class ReportApprovalRecordDao extends BaseDaoImpl<ReportApprovalRecord> {
    
    public List<ReportApprovalRecord> getRecordsByOrderId(String workOrderId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("workOrderId", workOrderId);
        return this.getDatasByHQL("from ReportApprovalRecord ar where ar.workOrderId=:workOrderId order by ar.recordTime", params);
    }
    
}
