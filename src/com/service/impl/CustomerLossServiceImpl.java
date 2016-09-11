package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.CustomerLossDao;
import com.entity.CustomerLoss;
import com.service.CustomerLossService;

@Service("customerLossService")
public class CustomerLossServiceImpl implements CustomerLossService{
	
	@Resource
	private CustomerLossDao customerLossDao;
	
	@Override
	public List<CustomerLoss> findCustomerLossList(Map<String, Object> map) {
		return customerLossDao.findCustomerLossList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return customerLossDao.getTotal(map);
	}
	
	@Override
	public int addCustomerLoss(CustomerLoss customerLoss) {
		return customerLossDao.addCustomerLoss(customerLoss);
	}

	@Override
	public CustomerLoss findCustomerLossById(Integer id) {
		return customerLossDao.findCustomerLossById(id);
	}

	@Override
	public int updateCustomerLoss(CustomerLoss customerLoss) {
		return customerLossDao.updateCustomerLoss(customerLoss);
	}
	
}
