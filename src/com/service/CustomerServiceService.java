package com.service;
import java.util.List;
import java.util.Map;

import com.entity.CustomerService;

public interface CustomerServiceService {
	
	public List<CustomerService> findCustomerServiceList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addCustomerService(CustomerService customerService);
	
	public int updateCustomerService(CustomerService customerService);
	
	public int deleteCustomerService(int id);	
	
}
