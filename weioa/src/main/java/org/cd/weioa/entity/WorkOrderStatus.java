package org.cd.weioa.entity;

import java.util.HashMap;
import java.util.Map;

public class WorkOrderStatus {

	public final static String COFIRM = "COFIRM"; // 国家队提交，办公室沟通确认中
	
	public final static String APPROVAL = "APPROVAL"; // 办公室确认完成，科教司审批中
	
	public final static class APPROVAL_STATUS {
		
		public final static String UNAPPROVAL = "UNAPPROVAL";
		
		public final static String APPROVING = "APPROVING";
		
		public final static String PASS = "PASS";
		
		public final static String UNPASS = "UNPASS";
		
	}
	
	public final static String DOING = "DOING"; // 办公室确认完成，科教司审批中
	
	public final static String DONE = "DONE"; // 工作完成，工作报告、财务报告待提交
	
	public final static String REPORT_SUBMIT = "REPORT_SUBMIT"; // 工作报告、财务报告已提交，国家队点评，办公室审核
	
	public final static class DONE_TEAM_EVALUATE_STATUS {
		
		public final static String UNEVALUATE = "UNEVALUATE";
		
		public final static String EVALUATING = "EVALUATING";
		
		public final static String EVALUATED = "EVALUATED";
		
	}
	
	public final static class DONE_OFFICE_APPROVAL_STATUS {
		
		public final static String UNAPPROVAL = "UNAPPROVAL";
		
		public final static String APPROVING = "APPROVING";
		
		public final static String PASS = "PASS";
		
		public final static String UNPASS = "UNPASS";
		
	}
	
	public final static String OVER = "OVER";
	
	public final static String CANCEL = "CANCEL";
	
	public final static Map<String, String> statusNames = new HashMap<String, String>();
	
	static {
		statusNames.put("COFIRM", "办公室确认中");
		statusNames.put("APPROVAL", "科教司审批中");
		statusNames.put("DOING", "进行中");
		statusNames.put("DONE", "工作已完成");
		statusNames.put("REPORT_SUBMIT", "报告已提交");
		statusNames.put("OVER", "结束");
		statusNames.put("CANCEL", "已取消");
	}
	
}
