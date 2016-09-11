package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.DataDicDao;
import com.entity.DataDic;
import com.service.DataDicService;

@Service("DataDicService")
public class DataDicServiceImpl implements DataDicService{

	@Resource
	private DataDicDao dataDicDao;
	
	@Override
	public List<DataDic> findDataDicList(Map<String, Object> map) {
		return dataDicDao.findDataDicList(map);
	}

	@Override
	public List<DataDic> findAll() {
		return dataDicDao.findAll();
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return dataDicDao.getTotal(map);
	}

	@Override
	public int addDataDic(DataDic dataDic) {
		return dataDicDao.addDataDic(dataDic);
	}

	@Override
	public int updateDataDic(DataDic dataDic) {
		return dataDicDao.updateDataDic(dataDic);
	}

	@Override
	public int deleteDataDic(int id) {
		return dataDicDao.deleteDataDic(id);
	}
	
}
