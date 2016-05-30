package org.cd.weioa.hibernate;


import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * 关系型数据库操作基类
 * @author wangzhw
 */
@Repository
public class BaseDaoImpl<T> implements IBaseDao {

    @Autowired
    public SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    Log log = LogFactory.getLog(this.getClass());

    @Override
    public Session getCurrentSession() {
        Session session = null;
        try {
            session = getSessionFactory().getCurrentSession();
        } catch (HibernateException e) {
            e.getStackTrace();
        }
        return session;
    }

    @Override
    public Session openNewSession() {
        return getSessionFactory().openSession();
    }

    @Override
    public Criteria getEntityCriteria(Class<?> poEntityClass) {
        return getCurrentSession().createCriteria(poEntityClass);
    }

    @Override
    public Query getHibernateQuery(final String psHQL) {
        return getCurrentSession().createQuery(psHQL);
    }

    @Override
    public SQLQuery getHibernateSqlQuery(final String psSql) {
        return getCurrentSession().createSQLQuery(psSql);
    }

    @Override
    @SuppressWarnings({ "unchecked", "hiding" })
    public <T> List<T> getDatasBySQL(Class<T> clazz, String psSQL, Map<String, Object> pParamMap) {
        SQLQuery sqlQuery = getSqlQuery(getCurrentSession(), psSQL, pParamMap);

        if (null != clazz) {
            sqlQuery.addEntity(clazz);
        }
        return (List<T>) sqlQuery.list();
    }

    @SuppressWarnings("hiding")
    @Override
    public <T> List<T> getDatasBySQL(String psSQL, Map<String, Object> pParamMap) {
        return getDatasBySQL(null, psSQL, pParamMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Long getCountBySQL(String psSQL, Map<String, Object> pParamMap) {
        SQLQuery sqlQuery = getSqlQuery(getCurrentSession(), psSQL, pParamMap);
        List lstResult = sqlQuery.list();
        Long count = 0L;
        if (count != null) {
            count = Long.valueOf(lstResult.get(0) != null ? lstResult.get(0).toString() : "0");
        }
        return count;
    }

    @Override
    public Long getCountBySQL(String psSQL) {
        return getCountBySQL(psSQL, null);
    }

    @Override
    public Long getCountByHQL(String psHQL, Map<String, Object> pParamMap) {
        Query query = getQuery(getCurrentSession(), psHQL, pParamMap);
        Long count = (Long) query.iterate().next();
        return count;
    }

    @Override
    public Long getCountByHQL(String psHQL) {
        return getCountByHQL(psHQL, null);
    }

    @Override
    @SuppressWarnings({ "unchecked", "hiding" })
    public <T> List<T> getDatasByHQL(String psHQL, Map<String, Object> pParamMap) {
        Query query = getQuery(getCurrentSession(), psHQL, pParamMap);
        return ((List<T>) query.list());
    }

    @SuppressWarnings({ "unchecked", "hiding" })
    public <T> T getDataByHQL(String psHQL, Map<String, Object> pParamMap) {

        Query query = getQuery(getCurrentSession(), psHQL, pParamMap);

        return (T) query.uniqueResult();

    }

    @SuppressWarnings({ "hiding", "unchecked" })
    public <T> T getDataBySQL(Class<T> clazz, String psSQL, Map<String, Object> pParamMap) {

        SQLQuery query = getSqlQuery(getCurrentSession(), psSQL, pParamMap);

        if (clazz != null) {
            query.addEntity(clazz);
        }

        return (T) query.uniqueResult();

    }

    @Override
    @SuppressWarnings({ "unchecked", "hiding" })
    public <T> List<T> getDatasByHQL(String psHQL) {
        return (List<T>) getDatasByHQL(psHQL, null);
    }

    @Override
    @SuppressWarnings({ "unchecked", "hiding" })
    public <T> T getEntityById(Class<T> entityClass, Object entityId) {
        return (T) (getCurrentSession().get(entityClass, (Serializable) entityId));
    }

    @Override
    public void persist(Object poEntity) {
        getCurrentSession().persist(poEntity);
    }

    @Override
    public void save(Object poEntity) {
        getCurrentSession().save(poEntity);
    }

    @Override
    @SuppressWarnings({ "unchecked", "hiding" })
    public <T> T merge(T poEntity) {
        return (T) getCurrentSession().merge(poEntity);
    }

    @Override
    public void saveORupdate(Object poEntity) {
        getCurrentSession().saveOrUpdate(poEntity);
    }

    @Override
    public int executeUpdate(String psSQL, Map<String, Object> pParamMap) {
        SQLQuery sqlQuery = getSqlQuery(getCurrentSession(), psSQL, pParamMap);
        return sqlQuery.executeUpdate();
    }

    @Override
    public void update(Object poEntity) {
        getCurrentSession().update(poEntity);
    }

    @Override
    public void delete(Object poEntity) {
        getCurrentSession().delete(poEntity);
    }

    /*
     * (non-Javadoc)
     * @see com.sysware.framework.dbaccess.IBaseDao#getSysDate()
     */
    public Date getSysDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String sql = "select to_char(sysdate, 'yyyy-MM-dd HH24:mi:ss') from dual";
        String date = this.getHibernateSqlQuery(sql).list().get(0).toString();
        try {
            return sdf.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Query getQuery(Session session, String psHQL, Map<String, Object> pParamMap) {
        Query hqlQuery = session.createQuery(psHQL);

        fillParameter(hqlQuery, psHQL, pParamMap);

        return hqlQuery;
    }

    private SQLQuery getSqlQuery(Session session, String psSQL, Map<String, Object> pParamMap) {

        SQLQuery sqlQuery = session.createSQLQuery(psSQL);

        fillParameter(sqlQuery, psSQL, pParamMap);

        return sqlQuery;
    }

    /**
     * 填充参数
     * 
     * @param pQuery
     * @param pParamMap
     */
    @SuppressWarnings("rawtypes")
    private void fillParameter(Query pQuery, String sql, Map<String, Object> pParamMap) {
        if (pParamMap != null && pParamMap.size() > 0) {
            for (String key : pParamMap.keySet()) {
                if (isAryOrCollection(pParamMap.get(key))) {
                    try {
                        pQuery.setParameterList(key, (Object[]) pParamMap.get(key));
                    } catch (Exception e) {
                        pQuery.setParameterList(key, (Collection) pParamMap.get(key));
                    }
                } else {
                    pQuery.setParameter(key, pParamMap.get(key));
                }

            }
        }
    }

    /**
     * 判断数据是否为数组、集合
     * 
     * @since : 2012-5-24:上午11:40:01
     * @param obj 要判断数据
     * @return 是数组、集合返回True，否则为false
     */
    private boolean isAryOrCollection(Object obj) {
        if (obj instanceof Object[] || obj instanceof Collection) {
            return true;
        } else {
            return false;
        }
    }
}
