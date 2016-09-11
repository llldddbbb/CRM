package com.service;

import java.util.List;
import java.util.Map;

import com.entity.CusDevPlan;

public interface CusDevPlanService {
	
	public List<CusDevPlan> findCusDevPlanList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addCusDevPlan(CusDevPlan cusDevPlan);
	
	public int updateCusDevPlan(CusDevPlan cusDevPlan);
	
	public int deleteCusDevPlan(int id);
	

}
