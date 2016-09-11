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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
 	function searchCustomerLoss(){
 		$('#dg').datagrid('load',{
 			"cusName":$('#s_cusName').val(),
 			"cusManager":$('#s_cusManager').val(),
 			"state":$('#s_state').combobox("getValue"),
 		})
 	}
 	function formatState(value,row){
 		if(value==1){
 			return "确认流失";
 		}else{
 			return "暂缓流失";
 		}
 	}
 
 	function formatAction(value,row){
 		if(row.state==1){
 			return "客户确认流失";
 		}else{
 			return "<a href='javascript:openCustomerReprieve("+row.id+")'>暂缓流失</a>";
 		}
 	}
 	
 	function openCustomerReprieve(id){
 		window.parent.openTab("客户流失暂缓措施管理","customerReprieveManage.jsp?lossId="+id,"icon-khlsgl")
 	}
 	
 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户流失查询</title>
</head>
<body style="margin: 1px">
	<table id="dg" title="客户流失查询" class="easyui-datagrid" fitColumns="true" pagination="true" 
	rownumbers="true" url="${pageContext.request.contextPath}/customerLoss/list.do" fit="true" toolbar="#tb">
	<thead>
		<tr>
			<th field="cb" checkbox="true" align="center"></th>
			<th field="cusNo" width="50" align="center" >客户编号</th>
			<th field="cusName" width="50" align="center">客户名称</th>
			<th field="cusManager" width="50" align="center" >客户经理</th>
			<th field="lastOrderTime" width="80" align="center">上次下单日期</th>
			<th field="confirmLossTime" width="50" align="center">确认流失日期</th>
			<th field="state" width="50" align="center" formatter="formatState">客户状态</th>
			<th field="lossReason" width="50" align="center">流失原因</th>
			<th field="a" width="50" align="center" formatter="formatAction">操作</th>
		</tr>
	</thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openCustomerLossAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openCustomerLossModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteCustomerLoss()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;客户名称：&nbsp;
			<input type="text" id="s_cusName" onkeyup="if(event.keyCode==13) searchCustomerLoss()"/>
			&nbsp;客户经理：&nbsp;
			<input type="text" id="s_cusManager" onkeyup="if(event.keyCode==13) searchCustomerLoss()"/>
			&nbsp;客户状态：&nbsp;
			<select id="s_state" class="easyui-combobox" panelHeight="auto" onkeyup="if(event.keyCode==13) searchCustomerLoss()">
				<option value="">请选择...</option>
				<option value="0">确认流失</option>
				<option value="1">暂缓流失</option>
			</select>
			<a href="javascript:searchCustomerLoss()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
		</div>
	</div>
</body>
</html>