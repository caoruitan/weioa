package org.cd.weioa.hibernate;

import java.util.Date;
import java.util.List;
import java.util.Map;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

/**
 * 关系型数据库操作基本接口
 * 
 * @author wangzhw
 */
public interface IBaseDao {

    /**
     * 获取Hibernate的session
     * 
     * @author wangzhw
     * @return
     */
    public Session getCurrentSession();

    /**
     * 新打开一个hibernate Session，该session必须手工关闭
     * 
     * @author wangzhw
     * @return
     */
    public Session openNewSession();

    /**
     * 获取按对象条件查询的对象
     * 
     * @author wangzhw
     * @param poEntityClass PO的class类型
     * @return
     */
    public Criteria getEntityCriteria(Class<?> poEntityClass);

    /**
     * 根据HQL语句获取查询对象Query
     * 
     * @author wangzhw
     * @param hql
     * @return
     */
    public Query getHibernateQuery(final String hql);

    /**
     * 获取原生JDBC SQL 查询对象
     * 
     * @author wangzhw
     * @param sql
     * @return
     */
    public SQLQuery getHibernateSqlQuery(final String sql);

    /**
     * 根据SQL获取数据 pParamMap 参数集合（o.name =:name and o.age=:age 类似这样的参数形式）
     * 
     * @author wangzhw
     * @param sql
     * @param paramMap
     * @return
     */
    public <T> List<T> getDatasBySQL(String sql, Map<String, Object> paramMap);

    /**
     * 根据SQL获取数据 clazz PO对应的CLASS
     * 
     * @author wangzhw
     * @param clazz
     * @param sql
     * @param paramMap 参数集合（o.name =:name and o.age=:age 类似这样的参数形式）
     * @return
     */
    public <T> List<T> getDatasBySQL(Class<T> clazz, String sql, Map<String, Object> paramMap);

    /**
     * 根据sql查询记录条数
     * 
     * @author wangzhw
     * @param sql
     * @param paramMap 参数集合（o.name =:name and o.age=:age 类似这样的参数形式）
     * @return
     */
    public Long getCountBySQL(String sql, Map<String, Object> paramMap);

    /**
     * 根据sql查询记录条数
     * 
     * @author wangzhw
     * @param sql
     * @return
     */
    public Long getCountBySQL(String sql);

    /**
     * 根据HQL查询记录条数
     * 
     * @author wangzhw
     * @param hql
     * @param paramMap
     * @return
     */
    public Long getCountByHQL(String hql, Map<String, Object> paramMap);

    /**
     * 根据HQL查询记录条数
     * 
     * @author wangzhw
     * @param hql
     * @return
     */
    public Long getCountByHQL(String hql);

    /**
     * 根据HQL及参数集合，查询数据并返回
     * 
     * @author wangzhw
     * @param hql
     * @param paramMap
     * @return
     */
    public <T> List<T> getDatasByHQL(String hql, Map<String, Object> paramMap);

    /**
     * 根据HQL返回查询结果
     * 
     * @author wangzhw
     * @param hql
     * @return
     */
    public <T> List<T> getDatasByHQL(String hql);

    /**
     * 按照实体ID，从数据库中查询对应的数据
     * 
     * @author wangzhw
     * @param entityClass 实体类型
     * @param entityId 实体ID
     * @return
     */
    public <T> T getEntityById(Class<T> entityClass, Object entityId);

    /**
     * 保存实体对象
     * 
     * @author wangzhw
     * @param poEntity 实体对象
     */
    public void persist(Object poEntity);

    /**
     * 保存PO,带返回值
     * 
     * @author wangzhw
     * @param poEntity
     * @return
     */
    public <T> T merge(T poEntity);

    /**
     * 新增持久化一条数据
     * 
     * @author wangzhw
     * @param poEntity
     */
    public void save(Object poEntity);

    /**
     * 保存或更新一个对象
     * 
     * @author wangzhw
     * @param poEntity
     */
    public void saveORupdate(Object poEntity);

    /**
     * 更新一个实体对象
     * 
     * @author wangzhw
     * @param poEntity
     */
    public void update(Object poEntity);

    /**
     * 删除一个实体对象
     * 
     * @author wangzhw
     * @param poEntity
     */
    public void delete(Object poEntity);

    /**
     * 执行对数据库操作
     * 
     * @author wangzhw
     * @param sql
     * @param paramMap
     * @return
     */
    public int executeUpdate(String sql, Map<String, Object> paramMap);

    /**
     * 获取数据库系统时间
     * 
     * @author wangzhw
     * @return
     */
    public Date getSysDate();

    /**
     * 获取单条数据
     * 
     * @author wangzhw
     * @param hql
     * @param paramMap
     * @return
     */
    public <T> T getDataByHQL(String hql, Map<String, Object> paramMap);

    /**
     * 获取单条数据
     * 
     * @author wangzhw
     * @param clazz
     * @param sql
     * @param paramMap
     * @return
     */
    public <T> T getDataBySQL(Class<T> clazz, String sql, Map<String, Object> paramMap);
}