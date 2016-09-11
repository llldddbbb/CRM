package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.Customer;
import com.entity.CustomerFw;
import com.entity.CustomerGc;
import com.entity.CustomerGx;
import com.entity.PageBean;
import com.service.CustomerService;
import com.util.DateUtil;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/customer")
public class CustomerController {
	
	@Resource
	private CustomerService customerService;
	
	@RequestMapping("list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Customer s_customer,HttpServletResponse response) throws Exception{
		PageBean pageBean =new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("khno",StringUtil.formatLike(s_customer.getKhno()));
		map.put("name",StringUtil.formatLike(s_customer.getName()));
		map.put("start",pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Customer> customerList=customerService.findCustomerList(map);
		Long total=customerService.getTotal(map);
		JSONArray jsonArray=JSONArray.fromObject(customerList);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("save")
	public String save(Customer customer,HttpServletResponse response)throws Exception{
		int resultNum=0;
		if(customer.getId()==null){
			customer.setKhno("GD"+DateUtil.getCurrentDateStr());
			resultNum=customerService.addCustomer(customer);
		}else{
			resultNum=customerService.updateCustomer(customer);
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
	public String delete(@RequestParam("ids")String ids,HttpServletResponse response)throws Exception{
		String[] idsStr=ids.split(",");
		int resultNum=0;
		for(String id:idsStr){
			resultNum+=customerService.deleteCustomer(Integer.parseInt(id));
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
	
	@RequestMapping("findCustomerById")
	public String findCustomerById(@RequestParam("id")String id,HttpServletResponse response)throws Exception{
		Customer customer=customerService.findCustomerById(Integer.parseInt(id));
		JSONObject jsonObject=JSONObject.fromObject(customer);
		ResponseUtil.write(response, jsonObject);
		return null;
	}
	
	@RequestMapping("findCustomerGxList")
	public String findCustomerGxList(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,@RequestParam(value="name",required=false)String name,HttpServletResponse response) throws Exception{
		PageBean pageBean =new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("name",StringUtil.formatLike(name));
		map.put("start",pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<CustomerGx> customerGxList=customerService.findCustomerGxList(map);
		Long total=customerService.getTotalCustomerGx(map);
		JSONArray jsonArray=JSONArray.fromObject(customerGxList);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("findCustomerGcList")
	public String findCustomerGcList(HttpServletResponse response)throws Exception{
		List<CustomerGc> customerGcList=customerService.findCustomerGcList();
		JSONArray result=JSONArray.fromObject(customerGcList);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("findCustomerFwList")
	public String findCustomerFwList(HttpServletResponse response)throws Exception{
		List<CustomerFw> customerFwList=customerService.findCustomerFwList();
		JSONArray result=JSONArray.fromObject(customerFwList);
		ResponseUtil.write(response, result);
		return null;
	}
	

}
