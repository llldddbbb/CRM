<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	$(function(){
		$.post("${pageContext.request.contextPath}/customer/findCustomerById.do",{id:'${param.cusId}'},function(result){
			var result=eval("("+result+")");
	 		$("#khno").val(result.khno);
	 		$("#name").val(result.name);
	 	
		});
	})
	function formatState(value,row){
		if(value==0){
			return "未回款";
		}else{
			return "已回款";
		}
	}
	
	function formatAction(value,row){
 		return "<a href='javascript:openTab()'>查看明细信息</a>";
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>历史订单管理</title>
</head>
<body style="margin: 15px">
	
	<div id="p" class="easyui-panel" title="历史订单信息" style="height: 100px;width: 700px;padding:10px">
			<table cellspacing="4px">
				<tr>
					<td>客户编号:</td>
					<td><input type="text" id="khno" name="khno" readonly="readonly"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>客户名称:</td>
					<td><input type="text" id="name" name="name" readonly="readonly"/></td>
				</tr>
			</table>
	</div>
	<br/>
	<table id="dg" title="历史订单管理" class="easyui-datagrid" fitColumns="true" pagination="true" 
		rownumbers="true" url="${pageContext.request.contextPath}/order/list.do?cusId=${param.cusId}" fit="true" >
       <thead>
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
				<th field="id" width="50" align="center">编号</th>
				<th field="orderNo" width="100" align="center" >订单号</th>
				<th field="orderDate" width="100" align="center">订购日期</th>
				<th field="address" width="100" align="center">送货地址</th>
				<th field="state" width="100" align="center" formatter="formatState">状态</th>
				<th field="a" width="100" align="center" formatter="formatAction">操作</th>
			</tr>
		</thead>
    </table>
</body>
</html>