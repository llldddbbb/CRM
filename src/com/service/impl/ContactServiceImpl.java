package com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.ContactDao;
import com.entity.Contact;
import com.service.ContactService;

@Service("contactService")
public class ContactServiceImpl implements ContactService{
	
	@Resource
	public ContactDao contactDao;
	
	@Override
	public List<Contact> findContactList(Map<String, Object> map) {
		return contactDao.findContactList(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return contactDao.getTotal(map);
	}

	@Override
	public int addContact(Contact contact) {
		return contactDao.addContact(contact);
	}

	@Override
	public int updateContact(Contact contact) {
		return contactDao.updateContact(contact);
	}

	@Override
	public int deleteContact(int id) {
		return contactDao.deleteContact(id);
	}

}
