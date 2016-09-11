package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.Order;

public interface OrderDao {
	
	public List<Order> findOrderList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addOrder(Order order);
	
	public int updateOrder(Order order);
	
	public int deleteOrder(int id);	
	
	public Order findLastOrderByCusId(int id);
	
}
