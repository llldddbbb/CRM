package com.service;

import java.util.List;
import java.util.Map;
import com.entity.SaleChance;

public interface SaleChanceService {
	
	public List<SaleChance> findSaleChanceList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addSaleChance(SaleChance saleChance);
	
	public int updateSaleChance(SaleChance saleChance);
	
	public int deleteSaleChance(int id);
	
	public SaleChance fingSaleChanceById(int id);
}
