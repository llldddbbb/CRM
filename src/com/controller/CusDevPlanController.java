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

import com.entity.CusDevPlan;
import com.entity.SaleChance;
import com.service.CusDevPlanService;
import com.service.SaleChanceService;
import com.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@RequestMapping("/cusDevPlan")
public class CusDevPlanController {
	
	@Resource
	private CusDevPlanService cusDevPlanService;
	
	@Resource
	private SaleChanceService saleChanceService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	
	@RequestMapping("list")
	public String list(@RequestParam(value="saleChanceId",required=false)String saleChanceId,HttpServletResponse response) throws Exception{
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("saleChanceId",saleChanceId);
		List<CusDevPlan> cusDevPlanList=cusDevPlanService.findCusDevPlanList(map);
		JsonConfig jsonConfig=new JsonConfig();
		//过滤date类型，转换为字符串
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		//将saleChance过滤，否则会出现死循环
		jsonConfig.setExcludes(new String[]{"saleChance"});
		JSONArray jsonArray=JSONArray.fromObject(cusDevPlanList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(CusDevPlan cusDevPlan,HttpServletResponse response)throws Exception{
		int resultNum=0;
		if(cusDevPlan.getId()!=null){
			resultNum=cusDevPlanService.updateCusDevPlan(cusDevPlan);
		}else{
			SaleChance saleChance=new SaleChance();
			saleChance.setId(cusDevPlan.getSaleChance().getId());
			saleChance.setDevResult(1);//将状态设置成开发中
			saleChanceService.updateSaleChance(saleChance);
			resultNum=cusDevPlanService.addCusDevPlan(cusDevPlan);
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
		resultNum=cusDevPlanService.deleteCusDevPlan(Integer.parseInt(id));
		JSONObject result=new JSONObject();
		if(resultNum>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("updateSaleChanceDevResult")
	public String updateSaleChanceDevResult(SaleChance saleChance,HttpServletResponse response)throws Exception{
		int resultNum=0;
		resultNum=saleChanceService.updateSaleChance(saleChance);
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
