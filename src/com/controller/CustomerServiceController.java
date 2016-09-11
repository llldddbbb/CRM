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

import com.entity.CustomerService;
import com.entity.PageBean;
import com.service.CustomerServiceService;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@RequestMapping("/customerService")
public class CustomerServiceController {
	
	@Resource
	private CustomerServiceService customerServiceService;
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	
	@RequestMapping("list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,CustomerService s_customerService,@RequestParam(value="createTimeFrom",required=false)String createTimeFrom,@RequestParam(value="createTimeTo",required=false)String createTimeTo,HttpServletResponse response) throws Exception{
		PageBean pageBean =new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("customer",StringUtil.formatLike(s_customerService.getCustomer()));
		map.put("overview", StringUtil.formatLike(s_customerService.getOverview()));
		map.put("serveType", s_customerService.getServeType());
		map.put("createTimeFrom", createTimeFrom);
		map.put("createTimeTo", createTimeTo);
		map.put("state",s_customerService.getState());
		map.put("start",pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		Long total=customerServiceService.getTotal(map);
		List<CustomerService> customerServiceList=customerServiceService.findCustomerServiceList(map);
		JsonConfig jsonConfig=new JsonConfig();
		//将日期类型过滤
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray jsonArray=JSONArray.fromObject(customerServiceList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(CustomerService customerService,HttpServletResponse response)throws Exception{
		int resultNum=0;
		if(customerService.getId()==null){
			resultNum=customerServiceService.addCustomerService(customerService);
		}else{
			resultNum=customerServiceService.updateCustomerService(customerService);
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
	
	
	

}
