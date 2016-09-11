<%@ page language="java" contentType="text/html; charset=UTF-8"
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
function searchCustomerLoss(){
		$('#dg').datagrid('load',{
			"cusName":$('#s_cusName').val(),
			"cusManager":$('#s_cusManager').val()
		})
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户流失分析</title>
</head>
<body style="margin: 1px">
	<table id="dg" title="客户流失查询" class="easyui-datagrid" fitColumns="true" pagination="true" 
	rownumbers="true" url="${pageContext.request.contextPath}/customerLoss/list.do?state=1" fit="true" toolbar="#tb">
	<thead>
		<tr>
			<th field="cb" checkbox="true" align="center"></th>
			<th field="cusNo" width="50" align="center" >客户编号</th>
			<th field="cusName" width="50" align="center">客户名称</th>
			<th field="cusManager" width="50" align="center" >客户经理</th>
			<th field="lastOrderTime" width="80" align="center">上次下单日期</th>
			<th field="confirmLossTime" width="50" align="center">确认流失日期</th>
			<th field="lossReason" width="50" align="center">流失原因</th>
		</tr>
	</thead>
	</table>
	<div id="tb">
		<div>
			&nbsp;客户名称：&nbsp;
			<input type="text" id="s_cusName" onkeyup="if(event.keyCode==13) searchCustomerLoss()"/>
			&nbsp;客户经理：&nbsp;
			<input type="text" id="s_cusManager" onkeyup="if(event.keyCode==13) searchCustomerLoss()"/>
			<a href="javascript:searchCustomerLoss()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
		</div>
	</div>
</body>
</html>