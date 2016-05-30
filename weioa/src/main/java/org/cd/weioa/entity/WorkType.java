package org.cd.weioa.entity;

import java.util.HashMap;
import java.util.Map;

public class WorkType {

	public static Map<String, String> workTypeNames = new HashMap<String, String>();
	
	static {
		workTypeNames.put("1", "差旅");
		workTypeNames.put("2", "技术服务");
		workTypeNames.put("3", "讲课");
		workTypeNames.put("4", "休息");
	}
	
}
