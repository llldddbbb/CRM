package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.ProductDao;
import com.entity.Product;
import com.service.ProductService;
/**
 * 用户service实现类
 * @author ldb
 *
 */
@Service("productService")
public class ProductServiceImpl implements ProductService{
	
	@Resource
	private ProductDao productDao;

	@Override
	public List<Product> findProductList(Map<String, Object> map) {
		return productDao.findProductList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return productDao.getTotal(map);
	}

	
}
