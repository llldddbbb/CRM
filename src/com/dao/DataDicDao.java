package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.DataDic;

public interface DataDicDao {
	
	public List<DataDic> findDataDicList(Map<String,Object> map);
	
	//��ѯ���е������ֵ�����
	public List<DataDic> findAll();
	
	public Long getTotal(Map<String,Object> map);
	
	public int addDataDic(DataDic dataDic);
	
	public int updateDataDic(DataDic dataDic);
	
	public int deleteDataDic(int id);
}
