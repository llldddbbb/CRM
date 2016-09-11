package com.service.impl;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.dao.SaleChanceDao;
import com.entity.SaleChance;
import com.service.SaleChanceService;

@Service("saleChanceService")
public class SaleChanceServiceImpl implements SaleChanceService{
	
	@Resource
	private SaleChanceDao saleChanceDao;

	@Override
	public List<SaleChance> findSaleChanceList(Map<String, Object> map) {
		return saleChanceDao.findSaleChanceList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return saleChanceDao.getTotal(map);
	}

	@Override
	public int addSaleChance(SaleChance saleChance) {
		return saleChanceDao.addSaleChance(saleChance);
	}

	@Override
	public int updateSaleChance(SaleChance saleChance) {
		return saleChanceDao.updateSaleChance(saleChance);
	}

	@Override
	public int deleteSaleChance(int id) {
		return saleChanceDao.deleteSaleChance(id);
	}

	@Override
	public SaleChance fingSaleChanceById(int id) {
		return saleChanceDao.findSaleChanceById(id);
	}

	
}
