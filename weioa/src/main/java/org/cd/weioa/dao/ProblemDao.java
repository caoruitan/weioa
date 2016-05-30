package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.Problem;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class ProblemDao extends BaseDaoImpl<Problem> {

    public List<Problem> getProblemList() {
        Map<String, Object> params = new HashMap<String, Object>();
        return this.getDatasByHQL("from Problem p order by p.createTime", params);
    }
    
    public List<Problem> getProblemListByCreator(String userId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("creator", userId);
        return this.getDatasByHQL("from Problem p where p.creator=:creator order by p.createTime", params);
    }
    
}
