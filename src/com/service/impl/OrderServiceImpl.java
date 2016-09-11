package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.OrderDao;
import com.entity.Order;
import com.service.OrderService;

@Service("orderService")
public class OrderServiceImpl implements OrderService{
	
	@Resource
	private OrderDao orderDao;
	
	@Override
	public List<Order> findOrderList(Map<String, Object> map) {
		return orderDao.findOrderList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return orderDao.getTotal(map);
	}

	@Override
	public int addOrder(Order order) {
		return orderDao.addOrder(order);
	}

	@Override
	public int updateOrder(Order order) {
		return orderDao.updateOrder(order);
	}

	@Override
	public int deleteOrder(int id) {
		return orderDao.deleteOrder(id);
	}

}
