package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.LinkManDao;
import com.entity.LinkMan;
import com.service.LinkManService;

@Service("linkManService")
public class LinkManServiceImpl implements LinkManService{
	
	@Resource
	public LinkManDao linkManDao;
	
	@Override
	public List<LinkMan> findLinkManList(Map<String, Object> map) {
		return linkManDao.findLinkManList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return linkManDao.getTotal(map);
	}

	@Override
	public int addLinkMan(LinkMan linkMan) {
		return linkManDao.addLinkMan(linkMan);
	}

	@Override
	public int updateLinkMan(LinkMan linkMan) {
		return linkManDao.updateLinkMan(linkMan);
	}

	@Override
	public int deleteLinkMan(int id) {
		return linkManDao.deleteLinkMan(id);
	}

}
