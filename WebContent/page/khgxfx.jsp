khfwfx.jsp<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
 	function searchCustomerGx(){
 		$('#dg').datagrid('load',{
 			"name":$('#s_name').val()
 		})
 	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户贡献分析</title>
</head>
<body style="margin: 1px">
	<table id="dg" title="客户贡献分析" class="easyui-datagrid" fitColumns="true" pagination="true" 
	rownumbers="true" url="${pageContext.request.contextPath}/customer/findCustomerGxList.do" fit="true" toolbar="#tb">
	<thead>
		<tr>
			<th field="cb" checkbox="true" align="center"></th>
			<th field="name" width="80" align="center">客户名称</th>
			<th field="gx" width="50" align="center">订单总金额(元)</th>
		</tr>
	</thead>
	</table>
	<div id="tb">
		<div>
			&nbsp;客户名称：&nbsp;<input type="text" id="s_name" onkeyup="if(event.keyCode==13) searchCustomerGx()"/>
			<a href="javascript:searchCustomerGx()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
		</div>
	</div>
	
</body>
</html>