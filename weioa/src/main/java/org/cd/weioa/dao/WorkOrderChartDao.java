package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.WorkOrderChart;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class WorkOrderChartDao extends BaseDaoImpl<WorkOrderChart> {

    public List<WorkOrderChart> getChartList(String workOrderId, String sessionId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("workOrderId", workOrderId);
        params.put("sessionId", sessionId);
        return this.getDatasByHQL("from WorkOrderChart woc where woc.workOrderId=:workOrderId and woc.sessionId=:sessionId order by woc.time", params);
    }

}
