package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.CustomerReprieve;
import com.service.CustomerReprieveService;
import com.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@RequestMapping("/customerReprieve")
public class CustomerReprieveController {
	
	@Resource
	private CustomerReprieveService customerReprieveService;
	
	
	@RequestMapping("list")
	public String list(@RequestParam(value="lossId",required=false)String lossId,HttpServletResponse response) throws Exception{
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("lossId",lossId);
		List<CustomerReprieve> customerReprieveList=customerReprieveService.findCustomerReprieveList(map);
		JsonConfig jsonConfig=new JsonConfig();
		//将customer过滤，否则会出现死循环
		jsonConfig.setExcludes(new String[]{"customerLoss"});
		JSONArray jsonArray=JSONArray.fromObject(customerReprieveList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(CustomerReprieve customerReprieve,HttpServletResponse response)throws Exception{
		int resultNum=0;
		if(customerReprieve.getId()!=null){
			resultNum=customerReprieveService.updateCustomerReprieve(customerReprieve);
		}else{
			resultNum=customerReprieveService.addCustomerReprieve(customerReprieve);
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
		resultNum=customerReprieveService.deleteCustomerReprieve(Integer.parseInt(id));
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
