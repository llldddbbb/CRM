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

import com.entity.CustomerLoss;
import com.entity.PageBean;
import com.service.CustomerLossService;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@RequestMapping("/customerLoss")
public class CustomerLossController {
	
	@Resource
	private CustomerLossService customerLossService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	
	
	@RequestMapping("list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows, CustomerLoss s_customerLoss,HttpServletResponse response) throws Exception{
		PageBean pageBean =new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("cusName",StringUtil.formatLike(s_customerLoss.getCusName()));
		map.put("cusManager", StringUtil.formatLike(s_customerLoss.getCusManager()));
		map.put("state", s_customerLoss.getState());
		map.put("start",pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		Long total=customerLossService.getTotal(map);
		List<CustomerLoss> customerLossList=customerLossService.findCustomerLossList(map);
		JsonConfig jsonConfig=new JsonConfig();
		//将日期类型过滤
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray jsonArray=JSONArray.fromObject(customerLossList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("findCustomerLossById")
	public String findCustomerLossById(@RequestParam("id")String id,HttpServletResponse response)throws Exception{
		CustomerLoss customerLoss=customerLossService.findCustomerLossById(Integer.parseInt(id));
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONObject jsonObject=JSONObject.fromObject(customerLoss,jsonConfig);
		ResponseUtil.write(response, jsonObject);
		return null;
	}
	
	@RequestMapping("confirmLoss")
	public String confirmLoss(String id,String lossReason,HttpServletResponse response)throws Exception{
		CustomerLoss customerLoss=new CustomerLoss();
		customerLoss.setId(Integer.parseInt(id));
		customerLoss.setLossReason(lossReason);
		customerLoss.setConfirmLossTime(new Date());
		customerLoss.setState(1);
		customerLossService.updateCustomerLoss(customerLoss);
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
