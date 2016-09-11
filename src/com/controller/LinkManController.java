package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.LinkMan;
import com.service.LinkManService;
import com.service.CustomerService;
import com.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;


@Controller
@RequestMapping("/linkMan")
public class LinkManController {
	
	@Resource
	private LinkManService linkManService;
	
	@Resource
	private CustomerService customerService;
	
	
	@RequestMapping("list")
	public String list(@RequestParam(value="cusId",required=false)String cusId,HttpServletResponse response) throws Exception{
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("cusId",cusId);
		List<LinkMan> linkManList=linkManService.findLinkManList(map);
		JsonConfig jsonConfig=new JsonConfig();
		//将customer过滤，否则会出现死循环
		jsonConfig.setExcludes(new String[]{"customer"});
		JSONArray jsonArray=JSONArray.fromObject(linkManList,jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(LinkMan linkMan,HttpServletResponse response)throws Exception{
		int resultNum=0;
		if(linkMan.getId()!=null){
			resultNum=linkManService.updateLinkMan(linkMan);
		}else{
			resultNum=linkManService.addLinkMan(linkMan);
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
		resultNum=linkManService.deleteLinkMan(Integer.parseInt(id));
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
