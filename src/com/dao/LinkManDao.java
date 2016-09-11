package com.dao;

import java.util.List;
import java.util.Map;

import com.entity.LinkMan;

public interface LinkManDao {
	
	public List<LinkMan> findLinkManList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addLinkMan(LinkMan linkMan);
	
	public int updateLinkMan(LinkMan linkMan);
	
	public int deleteLinkMan(int id);	
	
}
