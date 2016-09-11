package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.entity.PageBean;
import com.entity.Product;
import com.service.ProductService;
import com.util.ResponseUtil;
import com.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Resource
	private ProductService productService;
	
	@RequestMapping("list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Product s_product,HttpServletResponse response) throws Exception{
		PageBean pageBean =new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String ,Object> map=new HashMap<String,Object>();
		map.put("productName",StringUtil.formatLike(s_product.getProductName()));
		map.put("start",pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Product> productList=productService.findProductList(map);
		Long total=productService.getTotal(map);
		JSONArray jsonArray=JSONArray.fromObject(productList);
		JSONObject result=new JSONObject();
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	

	

}
