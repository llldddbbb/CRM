package com.service;

import java.util.List;
import java.util.Map;
import com.entity.User;

public interface UserService {
	
	public User login(User user);
	
	public List<User> findUserList(Map<String ,Object> map);
	
	public Long getTotal(Map<String ,Object> map);
	
	public int addUser(User user);
	
	public int updateUser(User user);
	
	public int deleteUser(Integer id);
	
}
