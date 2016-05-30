package org.cd.weioa.entity;

import java.util.HashMap;
import java.util.Map;

public class ProblemStatus {

	public final static String PROCESSING = "PROCESSING"; // 处理中
	
	public final static String PROCESSED = "PROCESSED"; // 已处理
	
	public final static Map<String, String> statusNames = new HashMap<String, String>();
	
	static {
		statusNames.put("PROCESSING", "处理中");
		statusNames.put("PROCESSED", "已处理");
	}
	
}
