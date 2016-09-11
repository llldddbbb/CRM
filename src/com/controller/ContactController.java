package com.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.Contact;
import com.service.ContactService;
import com.service.CustomerService;
import com.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@RequestMapping("/contact")
public class ContactController {
	
	@Resource
	private ContactService contactService;
	
	@Resource
	private CustomerService customerService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	
	
	@RequestMapping("list")
	public String list(@RequestParam(value="cusId",required=false)String cusId,HttpServletResponse response) throws Exception{
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("cusId",cusId);
		List<Contact> contactList=contactService.findContactList(map);
		JsonConfig jsonConfig=new JsonConfig();
		//将customer过滤，否则会出现死循环
		jsonConfig.setExcludes(new String[]{"customer"});
		//将日期类型过滤
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray jsonArray=JSONArray.fromObject(contactList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(Contact contact,HttpServletResponse response)throws Exception{
		int resultNum=0;
		if(contact.getId()!=null){
			resultNum=contactService.updateContact(contact);
		}else{
			resultNum=contactService.addContact(contact);
		}
		JSONObject result=new JSONObject();
		if(resultNum>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("delete")
	public String delete(@RequestParam(value="id")String id,HttpServletResponse response)throws Exception{
		int resultNum=0;
		resultNum=contactService.deleteContact(Integer.parseInt(id));
		JSONObject result=new JSONObject();
		if(resultNum>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}

}
