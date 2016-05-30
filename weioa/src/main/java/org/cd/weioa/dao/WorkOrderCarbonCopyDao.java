package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.WorkOrderCarbonCopy;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class WorkOrderCarbonCopyDao extends BaseDaoImpl<WorkOrderCarbonCopy> {
    
    public List<WorkOrderCarbonCopy> getCarbonCopyByWorkOrderIdAndUserId(String workOrderId, String userId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("workOrderId", workOrderId);
        params.put("userId", userId);
        return this.getDatasByHQL("from WorkOrderCarbonCopy cc where cc.workOrderId=:workOrderId and cc.carbonCopyUser=:userId", params);
    }
    
}
