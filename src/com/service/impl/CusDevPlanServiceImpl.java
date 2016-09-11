package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.CusDevPlanDao;
import com.entity.CusDevPlan;
import com.service.CusDevPlanService;

@Service("cusDevPlanService")
public class CusDevPlanServiceImpl implements CusDevPlanService{
	
	@Resource
	private CusDevPlanDao cusDevPlanDao;
	
	@Override
	public List<CusDevPlan> findCusDevPlanList(Map<String, Object> map) {
		return cusDevPlanDao.findCusDevPlanList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return cusDevPlanDao.getTotal(map);
	}

	@Override
	public int addCusDevPlan(CusDevPlan cusDevPlan) {
		return cusDevPlanDao.addCusDevPlan(cusDevPlan);
	}

	@Override
	public int updateCusDevPlan(CusDevPlan cusDevPlan) {
		return cusDevPlanDao.updateCusDevPlan(cusDevPlan);
	}

	@Override
	public int deleteCusDevPlan(int id) {
		return cusDevPlanDao.deleteCusDevPlan(id);
	}

	

}
