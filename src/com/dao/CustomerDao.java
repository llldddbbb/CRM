package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.Customer;
import com.entity.CustomerFw;
import com.entity.CustomerGc;
import com.entity.CustomerGx;

public interface CustomerDao {
	
	public List<Customer> findCustomerList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addCustomer(Customer customer);
	
	public int updateCustomer(Customer customer);
	
	public int deleteCustomer(int id);	
	
	public Customer findCustomerById(Integer id);
	
	public List<Customer> findLossCustomer();
	
	public List<CustomerGx> findCustomerGxList(Map<String,Object> map);
	
	public Long getTotalCustomerGx(Map<String,Object> map);
	
	public List<CustomerGc> findCustomerGcList();
	
	public List<CustomerFw> findCustomerFwList();	
	
	
}
