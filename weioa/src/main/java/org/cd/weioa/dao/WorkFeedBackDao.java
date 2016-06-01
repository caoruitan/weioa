package org.cd.weioa.dao;

import org.cd.weioa.entity.WorkFeedBack;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by xuyang on 16/5/13.
 */
@Repository
public class WorkFeedBackDao extends BaseDaoImpl<WorkFeedBack> {


    public List<WorkFeedBack> findByWorkNo(String workNo) {

        Criterion workNoEQ = Restrictions.eq("workNo", workNo);

        Criteria criteria = getCurrentSession().createCriteria(WorkFeedBack.class);

        criteria.add(workNoEQ);

        List<WorkFeedBack> l = (List<WorkFeedBack>) criteria.list();

        if(l.size() <= 0) {
            return null;
        }

        return l;
    }

    public void deleteFiles(String feedId) {

        String sql = "delete from work_feedback_attacment  where feedback_id=:feedId";
        SQLQuery sqlQuery = getCurrentSession().createSQLQuery(sql);
        sqlQuery.setString("feedId", feedId);
        sqlQuery.executeUpdate();
    }
}

