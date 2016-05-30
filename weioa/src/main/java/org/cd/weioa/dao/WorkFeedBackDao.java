package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.WorkFeedBack;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

/**
 * Created by xuyang on 16/5/13.
 */
@Repository
public class WorkFeedBackDao extends BaseDaoImpl<WorkFeedBack> {


    public List<WorkFeedBack> findByWorkNo(String workNo) {
        
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("workNo", workNo);
        return this.getDatasByHQL("from WorkFeedBack fb where fb.workNo=:workNo", params);

    }
}

