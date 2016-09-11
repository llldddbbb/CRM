package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.entity.PageBean;
import com.entity.User;
import com.service.UserService;
import com.util.ResponseUtil;
import com.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
/**
 * 用户controller层
 * @author ldb
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {
	
	@Resource
	private UserService userService;
	
	@RequestMapping("/login")
	public String login(User user,HttpServletRequest request)throws Exception{
		User resultUser=userService.login(user);
		if(resultUser!=null){
			HttpSession session=request.getSession();
			session.setAttribute("currentUser", resultUser);
			return "redirect:/main.jsp";
		}else{
			request.setAttribute("user", user);//将错误密码返回到页面，优化用户体验
			request.setAttribute("errorMsg", "用户名或密码错误！");
			return "login";
		}
	}
	@RequestMapping("list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,User s_user,HttpServletResponse response) throws Exception{
		PageBean pageBean =new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("userName",StringUtil.formatLike(s_user.getUserName()));
		map.put("start",pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<User> userList=userService.findUserList(map);
		Long total=userService.getTotal(map);
		JSONArray jsonArray=JSONArray.fromObject(userList);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(User user,HttpServletResponse response)throws Exception{
		int resultTotal=0;
		if(user.getId()!=null){
			resultTotal=userService.updateUser(user);
		}else{
			resultTotal=userService.addUser(user);
		}
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids")String ids,HttpServletResponse response)throws Exception{
		String[] idsStr=ids.split(",");
		int resultTotal=0;
		for(String id:idsStr){
			resultTotal+=userService.deleteUser(Integer.parseInt(id));
		}
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("customerManageComboList")
	public String customerManageComboList(HttpServletResponse response)throws Exception{
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("roleName", "客户经理");
		JSONArray result=JSONArray.fromObject(userService.findUserList(map));
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("modifyPassword")
	public String modifyPassword(@RequestParam(value="id")String id,@RequestParam(value="newPassword")String newPassword,HttpServletResponse response)throws Exception{
		int resultTotal=0;
		User user=new User();
		user.setId(Integer.parseInt(id));
		user.setPassword(newPassword);
		resultTotal=userService.updateUser(user);
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest request){
		HttpSession session=request.getSession();
		session.removeAttribute("currentUser");
		return "redirect:/login.jsp";
	}
}
