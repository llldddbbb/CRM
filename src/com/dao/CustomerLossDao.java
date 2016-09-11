package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.CustomerLoss;

public interface CustomerLossDao {
	
	public List<CustomerLoss> findCustomerLossList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addCustomerLoss(CustomerLoss customerLoss);
	
	public CustomerLoss findCustomerLossById(Integer id);
	
	public int updateCustomerLoss(CustomerLoss customerLoss);
}
