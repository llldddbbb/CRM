package com.service;

import java.util.List;
import java.util.Map;

import com.entity.Order;

public interface OrderService {
public List<Order> findOrderList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addOrder(Order order);
	
	public int updateOrder(Order order);
	
	public int deleteOrder(int id);	
}
