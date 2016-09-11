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

import com.entity.PageBean;
import com.entity.SaleChance;
import com.service.SaleChanceService;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@RequestMapping("/saleChance")
public class SaleChanceController {
	
	@Resource
	private SaleChanceService saleChanceService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	
	@RequestMapping("list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,SaleChance s_saleChance,HttpServletResponse response) throws Exception{
		PageBean pageBean =new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("customerName",StringUtil.formatLike(s_saleChance.getCustomerName()));
		map.put("overView",StringUtil.formatLike(s_saleChance.getOverView()));
		map.put("createMan",StringUtil.formatLike(s_saleChance.getCreateMan()));
		map.put("state",s_saleChance.getState());
		map.put("devResult",s_saleChance.getDevResult());
		map.put("start",pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<SaleChance> saleChanceList=saleChanceService.findSaleChanceList(map);
		Long total=saleChanceService.getTotal(map);
		JsonConfig jsonConfig=new JsonConfig();
		//过滤date类型，转换为字符串
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm"));
		JSONArray jsonArray=JSONArray.fromObject(saleChanceList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(SaleChance saleChance,HttpServletResponse response)throws Exception{
		int resultNum=0;
		if(StringUtil.isNotEmpty(saleChance.getAssignMan())){
			saleChance.setState(1);
		}else{
			saleChance.setState(0);
		}
		if(saleChance.getId()!=null){
			resultNum=saleChanceService.updateSaleChance(saleChance);
		}else{
			saleChance.setDevResult(0);
			resultNum=saleChanceService.addSaleChance(saleChance);
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
	public String delete(@RequestParam(value="ids")String ids,HttpServletResponse response)throws Exception{
		String[] idsStr=ids.split(",");
		int resultNum=0;
		for(String id:idsStr){
			resultNum+=saleChanceService.deleteSaleChance(Integer.parseInt(id));
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
	
	@RequestMapping("findSaleChanceById")
	public String findSaleChanceByid(@RequestParam(value="id")String id,HttpServletResponse response)throws Exception{
		SaleChance saleChance=saleChanceService.fingSaleChanceById(Integer.parseInt(id));
		JsonConfig jsonConfig=new JsonConfig();
		//过滤date类型，转换为字符串
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm"));
		JSONObject result=JSONObject.fromObject(saleChance,jsonConfig);
		ResponseUtil.write(response, result);
		return null;
	}

}
