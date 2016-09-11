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

import com.entity.Order;
import com.entity.PageBean;
import com.service.OrderService;
import com.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Resource
	private OrderService orderService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	
	
	@RequestMapping("list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,@RequestParam(value="cusId",required=false)String cusId,HttpServletResponse response) throws Exception{
		PageBean pageBean =new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("cusId",cusId);
		map.put("start",pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		Long total=orderService.getTotal(map);
		List<Order> orderList=orderService.findOrderList(map);
		JsonConfig jsonConfig=new JsonConfig();
		//将customer过滤，否则会出现死循环
		jsonConfig.setExcludes(new String[]{"customer"});
		//将日期类型过滤
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray jsonArray=JSONArray.fromObject(orderList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	

}
