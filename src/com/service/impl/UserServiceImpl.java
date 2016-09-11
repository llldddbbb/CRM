package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.UserDao;
import com.entity.User;
import com.service.UserService;
/**
 * 用户service实现类
 * @author ldb
 *
 */
@Service("userService")
public class UserServiceImpl implements UserService{
	
	@Resource
	private UserDao userDao;

	@Override
	public User login(User user) {
		return userDao.login(user);
	}

	@Override
	public List<User> findUserList(Map<String, Object> map) {
		return userDao.findUserList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return userDao.getTotal(map);
	}

	@Override
	public int addUser(User user) {
		return userDao.addUser(user);
	}

	@Override
	public int updateUser(User user) {
		return userDao.updateUser(user);
	}

	@Override
	public int deleteUser(Integer id) {
		return userDao.deleteUser(id);
	}
}
