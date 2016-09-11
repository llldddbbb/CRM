package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.CustomerReprieveDao;
import com.entity.CustomerReprieve;
import com.service.CustomerReprieveService;

@Service("customerReprieveService")
public class CustomerReprieveServiceImpl implements CustomerReprieveService{

	@Resource
	private CustomerReprieveDao customerReprieveDao;
		
	@Override
	public List<CustomerReprieve> findCustomerReprieveList(Map<String, Object> map) {
		return customerReprieveDao.findCustomerReprieveList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return customerReprieveDao.getTotal(map);
	}

	@Override
	public int addCustomerReprieve(CustomerReprieve customerReprieve) {
		return customerReprieveDao.addCustomerReprieve(customerReprieve);
	}

	@Override
	public int updateCustomerReprieve(CustomerReprieve customerReprieve) {
		return customerReprieveDao.updateCustomerReprieve(customerReprieve);
	}

	@Override
	public int deleteCustomerReprieve(int id) {
		return customerReprieveDao.deleteCustomerReprieve(id);
	}

}
