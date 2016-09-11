package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.DataDic;
import com.entity.PageBean;
import com.service.DataDicService;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/dataDic")
public class DataDicController {
	
	@Resource
	private DataDicService dataDicService;
	
	@RequestMapping("list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,DataDic s_dataDic,HttpServletResponse response) throws Exception{
		PageBean pageBean =new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("dataDicName",s_dataDic.getDataDicName());
		map.put("dataDicValue", StringUtil.formatLike(s_dataDic.getDataDicValue()));
		map.put("start",pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<DataDic> dataDicList=dataDicService.findDataDicList(map);
		Long total=dataDicService.getTotal(map);
		JSONArray jsonArray=JSONArray.fromObject(dataDicList);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("findDataDicName")
	public String dataDicNameComboList(HttpServletResponse response)throws Exception{
		JSONArray jsonArray=new JSONArray();
		List<DataDic> dataDicList=dataDicService.findAll();
		@SuppressWarnings("static-access")
		JSONArray rows=jsonArray.fromObject(dataDicList);
		jsonArray.addAll(rows);
		ResponseUtil.write(response, jsonArray);
		return null;
	}
	
	@RequestMapping("findDataDicComboList")
	public String findDataDicComboList(String dataDicName,HttpServletResponse response)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("dataDicName",dataDicName);
		List<DataDic> dataDicList=dataDicService.findDataDicList(map);
		JSONArray jsonArray=new JSONArray();
		@SuppressWarnings("static-access")
		JSONArray rows=jsonArray.fromObject(dataDicList);
		jsonArray.addAll(rows);
		ResponseUtil.write(response, jsonArray);
		return null;
	}
	
	
	@RequestMapping("save")
	public String save(DataDic dataDic,HttpServletResponse response)throws Exception{
		int resultNum=0;
		if(dataDic.getId()!=null){
			resultNum=dataDicService.updateDataDic(dataDic);
		}else{
			resultNum=dataDicService.addDataDic(dataDic);
		}
		JSONObject result =new JSONObject();
		if(resultNum>0){
			result.put("success", true);
		}else{
			result.put("success",false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("delete")
	public String delete(String ids,HttpServletResponse response)throws Exception{
		String[] deleteIds=ids.split(",");
		int resultNum=0;
		for(String id:deleteIds){
			resultNum+=dataDicService.deleteDataDic(Integer.parseInt(id));
		}
		JSONObject result=new JSONObject();
		if(resultNum>0){
			result.put("success",true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}

}
