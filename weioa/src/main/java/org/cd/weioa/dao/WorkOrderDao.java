package org.cd.weioa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cd.weioa.entity.WorkOrder;
import org.cd.weioa.hibernate.BaseDaoImpl;
import org.springframework.stereotype.Repository;

@Repository
public class WorkOrderDao extends BaseDaoImpl<WorkOrder> {

	public List<WorkOrder> getWorkOrderListByCreator(String userId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("creator", userId);
		return this.getDatasByHQL("from WorkOrder o where o.workOrderCreator=:creator order by o.workOrderCreateTime", params);
	}
	
	public List<WorkOrder> getWorkOrderList() {
		return this.getDatasByHQL("from WorkOrder o order by o.workOrderCreateTime");
	}

	public List<WorkOrder> getWorkOrderListByStatus(List<String> statusList) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("statusList", statusList);
		return this.getDatasByHQL("from WorkOrder o where o.workOrderStatus in (:statusList) order by o.workOrderCreateTime", params);
	}

	public List<WorkOrder> getWorkOrderListByExpertAndStatus(String expertId, List<String> statusList) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("statusList", statusList);
		params.put("expertId", expertId);
		return this.getDatasByHQL("from WorkOrder o where o.confirmWorkExpert=:expertId and o.workOrderStatus in (:statusList) order by o.workOrderCreateTime", params);
	}

	public List<Object[]> getWorkOrderListByCC(String userId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		return this.getDatasByHQL("from WorkOrder o, WorkOrderCarbonCopy cc where o.workOrderId = cc.workOrderId and cc.carbonCopyUser = :userId", params);
	}
	
	public String getMaxOrderNum(String prefix) {
		Object obj = this.getCurrentSession().createSQLQuery("SELECT MAX(work_order_id) FROM work_order WHERE work_order_id LIKE '" + prefix + "%'").uniqueResult();
		if(obj == null) return null;
		return obj.toString();
	}
	
}
