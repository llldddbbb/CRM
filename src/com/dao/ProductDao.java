package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.Product;

public interface ProductDao {
	
	public List<Product> findProductList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
}
