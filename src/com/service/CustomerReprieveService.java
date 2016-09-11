package com.service;

import java.util.List;
import java.util.Map;

import com.entity.CustomerReprieve;

public interface CustomerReprieveService {
	
	public List<CustomerReprieve> findCustomerReprieveList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addCustomerReprieve(CustomerReprieve customerReprieve);
	
	public int updateCustomerReprieve(CustomerReprieve customerReprieve);
	
	public int deleteCustomerReprieve(int id);	
	
}
