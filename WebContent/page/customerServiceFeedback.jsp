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

	var url;
 	function resetValues(){
 		$("#serveType").val("");
 		$("#customer").val("");
 		$("#overview").val("");
 		$("#servicerequest").val("");
 		$("#createPeople").val("");
 		$("#createTime").val("");
 		$("#assigner").val("");
 		$("#serviceProcePeople").val("");
 		$("#serviceProceTime").val("");
 		$("#serviceProceResult").val("");
 		$("#myd").combobox("setValues","");
 	}
 	
 	function openCustomerServiceFeedbackDialog(){
 		var selectedRows=$('#dg').datagrid("getSelections");
 		if(selectedRows.length!=1){
 			$.messager.alert("系统提示","请选择一条要反馈的客户服务！");
 			return;
 		}
 		var row=selectedRows[0];
 		$('#dlg').dialog("open").dialog("setTitle","反馈客户服务");
 		$("#fm").form("load",row);
 		url="${pageContext.request.contextPath}/customerService/save.do?state=已归档&id="+row.id
 	}
 	
 	function closeCustomerServiceFeedbackDialog(){
 		resetValues();
		$("#dlg").dialog("close");
 	}
 	
 	function saveCustomerServiceFeedback(){
 		$('#fm').form("submit",{
 			url:url,
 			onSubmit:function(){
 				if($("#myd").combobox("getValue")==''){
 					$.messager.alert("系统提示","请选择客户满意度");
 					return false;
 				}
 				return $(this).form("validate");//验证表单，easyui提供的方法
 			},
 			success:function(result){
 				var result=eval("("+result+")");
 				if(result.success){
 					$.messager.alert("系統提示","执行成功");
 					resetValues();
 					$("#dlg").dialog("close");
 					$("#dg").datagrid("reload");
 				}else{
 					$.messager.alert("系統提示","保存失敗");
 					return;
 				}
 			}
 		})
 	}
 	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户服务处理管理</title>
</head>
<body style="margin: 1px">
	<table id="dg" title="客户服务处理管理" class="easyui-datagrid" fitColumns="true" pagination="true" 
	rownumbers="true" url="${pageContext.request.contextPath}/customerService/list.do?state=已处理" fit="true" toolbar="#tb">
	<thead>
		<tr>
			<th field="cb" checkbox="true" align="center"></th>
			<th field="id" width="50" align="center">编号</th>
			<th field="customer" width="100" align="center">客户</th>
			<th field="overview" width="200" align="center">概要</th>
			<th field="serveType" width="100" align="center">服务类型</th>
			<th field="createPeople" width="100" align="center">创建人</th>
			<th field="createTime" width="100" align="center">创建日期</th>
			<th field="state" width="50" align="center" hidden="true">客户服务状态</th>
			<th field="servicerequest" width="200" align="center" hidden="true">服务请求</th>
			<th field="assigner" width="100" align="center" >反馈人</th>
			<th field="assignTime" width="100" align="center">反馈日期</th>
			<th field="serviceProce" width="100" align="center" hidden="true">服务处理</th>
			<th field="serviceProcePeople" width="100" align="center" >服务处理人</th>
			<th field="serviceProceTime" width="100" align="center" >服务处理日期</th>
			<th field="serviceProceResult" width="100" align="center" hidden="true">服务处理结果</th>
			<th field="myd" width="100" align="center" hidden="true">客户满意度</th>
		</tr>
	</thead>
	</table>
	
	<div id="tb">
		<div>
			<a href="javascript:openCustomerServiceFeedbackDialog()" class="easyui-linkbutton" iconCls="icon-fwfk" plain="true">客户服务反馈</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:600px;height:600px; padding:10px 20px" closed="true">
		<form id="fm" method="post">
			<table cellspacing="8px">
				<tr>
					<td>服务类型:</td>
					<td><input type="text" id="serveType" name='serveType'readonly="readonly"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>客户:</td>
					<td><input type="text" id="customer" name="customer" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>概要:</td>
					<td colspan="4"><input type="text" id="overview" name="overview" style="width:419px" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>服务请求:</td>
					<td colspan="4">
						<textarea rows="5" cols="49" id="servicerequest" name="servicerequest" readonly="readonly"></textarea>
					</td>
				</tr>
				<tr>
					<td>创建人:</td>
					<td>
						<input type="text" id="createPeople" name="createPeople" readonly="readonly"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>创建时间:</td>
					<td><input type="text" id="createTime" name="createTime"  readonly="readonly"/></td>
				</tr>
				<tr>
					<td>分配人:</td>
					<td>
						<input id="assigner" name="assigner" type="text" readonly="readonly">
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>分配时间:</td>
					<td><input type="text" id="assignTime" name="assignTime"  readonly="readonly"/></td>
				</tr>
				<tr>
					<td>服务处理:</td>
					<td colspan="4">
						<textarea rows="5" cols="49" id="serviceProce" name="serviceProce" readonly="readonly"></textarea>
					</td>
				</tr>
				<tr>
					<td>处理人:</td>
					<td>
						<input type="text" id="serviceProcePeople" name="serviceProcePeople"  readonly="readonly"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>处理时间:</td>
					<td><input type="text" id="serviceProceTime" name="serviceProceTime"  readonly="readonly"/></td>
				</tr>
				<tr>
					<td>处理结果:</td>
					<td>
						<input type="text" id="serviceProceResult" name="serviceProceResult" class="validatebox" required="true"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>客户满意度:</td>
					<td>
						<select id="myd" name="myd" editable="false" panelHeight="auto" class="easyui-combobox" style="width:148px">
							<option value="">请选择...</option>
							<option value="☆">☆</option>
							<option value="☆☆">☆☆</option>
							<option value="☆☆☆">☆☆☆</option>
							<option value="☆☆☆☆">☆☆☆☆</option>
							<option value="☆☆☆☆☆">☆☆☆☆☆</option>
						</select>
					</td>
				<tr>
				</tr>
				<tr>
					<td colspan="4"></td>
					<td>
						<a href="javascript:saveCustomerServiceFeedback()" iconCls="icon-ok" class="easyui-linkbutton">保存</a>
						<a href="javascript:closeCustomerServiceFeedbackDialog()" iconCls="icon-cancel" class="easyui-linkbutton">关闭</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>