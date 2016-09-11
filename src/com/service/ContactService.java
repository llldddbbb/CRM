package com.service;

import java.util.List;
import java.util.Map;

import com.entity.Contact;

public interface ContactService {
	
	public List<Contact> findContactList(Map<String ,Object> map);
	
	public Long getTotal(Map<String,Object> map);
	
	public int addContact(Contact contact);
	
	public int updateContact(Contact contact);
	
	public int deleteContact(int id);	
}
