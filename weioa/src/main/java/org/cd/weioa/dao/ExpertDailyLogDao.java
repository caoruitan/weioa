package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.ExpertDailyLog;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class ExpertDailyLogDao extends BaseDaoImpl<ExpertDailyLog> {

    public List<ExpertDailyLog> getDailyLogByOrderId(String workOrderId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("workOrderId", workOrderId);
        return this.getDatasByHQL("from ExpertDailyLog edl where edl.workOrderId=:workOrderId order by edl.dailyLogDate", params);
    }
    
}
