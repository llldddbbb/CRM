package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.CustomerServiceDao;
import com.entity.CustomerService;
import com.service.CustomerServiceService;

@Service("customerServiceService")
public class CustomerServiceServiceImpl implements CustomerServiceService{
	
	@Resource
	private CustomerServiceDao customerServiceDao;
	
	@Override
	public int addCustomerService(CustomerService customerService) {
		return customerServiceDao.addCustomerService(customerService);
	}

	@Override
	public List<CustomerService> findCustomerServiceList(Map<String, Object> map) {
		return customerServiceDao.findCustomerServiceList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return customerServiceDao.getTotal(map);
	}

	@Override
	public int updateCustomerService(CustomerService customerService) {
		return customerServiceDao.updateCustomerService(customerService);
	}

	@Override
	public int deleteCustomerService(int id) {
		return customerServiceDao.deleteCustomerService(id);
	}

}
