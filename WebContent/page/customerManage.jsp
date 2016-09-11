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
	var url;
 	function searchCustomer(){
 		$('#dg').datagrid('load',{
 			"khno":$('#s_khno').val(),
 			"name":$('#s_name').val()
 		})
 	}
 	function resetValues(){
 		$("#name").val("");
 		$("#id").val("");
 		$("#khno").val("");
 		$("#area").combobox("setValue","");
 		$("#cusManager").combobox("setValue","");
 		$("#level").combobox("setValue","");
 		$("#myd").combobox("setValue","");
 		$("#xyd").combobox("setValue","");
 		$("#address").val("");
 		$("#postCode").val("");
 		$("#phone").val("");
 		$("#fax").val("");
 		$("#webSite").val("");
 		$("#yyzzzch").val("");
 		$("#fr").val("");
 		$("#zczj").val("");
 		$("#nyye").val("");
 		$("#khyh").val("");
 		$("#khzh").val("");
 		$("#dsdjh").val("");
 		$("#gsdjh").val("");
 	}
 	function closeCustomerDialog(){
 		resetValues();
 		$("#dlg").dialog("close")
 	}
 	function openCustomerAddDialog(){
 		$("#dlg").dialog("open").dialog("setTitle","添加客户信息");
 		url="${pageContext.request.contextPath}/customer/save.do";
 		
 	}
 	function openCustomerModifyDialog(){
 		var selectedRows=$("#dg").datagrid("getSelections");
 		if(selectedRows.length!=1){
 			$.messager.alert("系统提示","请选择一条要修改的数据");
 			return ;
 		}
 		var row=selectedRows[0];
 		$("#dlg").dialog("open").dialog("setTitle","修改客户信息");
 		$("#fm").form("load",row);
 		url="${pageContext.request.contextPath}/customer/save.do?id="+row.id;
 	}
 	function saveCustomer(){
 		$("#fm").form("submit",{
 			url:url,
 			onSubmit:function(){
 				if($("#area").combobox("getValue")==""){
 					$.messager.alert("系统提示","请选择客户地区！")
 					return false;
 				}
 				if($("#cusManager").combobox("getValue")==""){
 					$.messager.alert("系统提示","请选择客户经理！")
 					return false;
 				}
 				if($("#level").combobox("getValue")==""){
 					$.messager.alert("系统提示","请选择客户等级！")
 					return false;
 				}
 				if($("#myd").combobox("getValue")==""){
 					$.messager.alert("系统提示","请选择客户满意度!");
 					return false;
 				}
 				if($("#xyd").combobox("getValue")==""){
 					$.messager.alert("系统提示","请选择客户信誉度！")
 					return false;
 				}
 				return $(this).form("validate");//验证表单，easyui提供的方法
 			},
 			success:function(result){
 				var result=eval("("+result+")");
 				if(result.success){
 					$.messager.alert("系統提示","保存成功");
 					resetValues();
 					$("#dlg").dialog("close");
 					$("#dg").datagrid("reload");
 				}else{
 					$.messager.alert("系統提示","保存失敗");
 					return;
 				}
 			}
 		});
 	}
 	function deleteCustomer(){
 		var selectedRows=$("#dg").datagrid("getSelections");
 		if(selectedRows.length==0){
 			$.messager.alert("系统提示","请选择要删除的数据");
 			return ;
 		}
 		$.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗?",function(r){
 			if(r){
 				var ids=[];
 				for(var i=0;i<selectedRows.length;i++){
 					ids.push(selectedRows[i].id);
 				}
 				var strIds=ids.join(",");
 				$.post("${pageContext.request.contextPath}/customer/delete.do",{ids:strIds},function(result){
 					var result=eval("("+result+")");
 					if(result.success){
 						$.messager.alert("系统提示","删除成功");
 						$("#dg").datagrid("reload");
 					}else{
 						$.messager.alert("系统提示","删除失败,请联系系统管理员");
 					}
 				});
 			}
 		})
 	}
 	
 	function openCustomerLinkMan(){
 		var selectedRows=$("#dg").datagrid("getSelections");
 		if(selectedRows.length!=1){
 			$.messager.alert("系统提示","请选择一个要管理的客户");
 			return ;
 		}
 		window.parent.openTab("联系人管理","linkManManage.jsp?cusId="+selectedRows[0].id,"icon-lxr");
 	}
 	
 	function openCustomerContact(){
 		var selectedRows=$("#dg").datagrid("getSelections");
 		if(selectedRows.length!=1){
 			$.messager.alert("系统提示","请选择一个要管理的客户");
 			return ;
 		}
 		window.parent.openTab("交往记录管理","contactManage.jsp?cusId="+selectedRows[0].id,"icon-jwjl");
 	}
 	
 	function openCustomerOrder(){
 		var selectedRows=$("#dg").datagrid("getSelections");
 		if(selectedRows.length!=1){
 			$.messager.alert("系统提示","请选择一个要管理的客户");
 			return ;
 		}
 		window.parent.openTab("历史订单管理","orderManage.jsp?cusId="+selectedRows[0].id,"icon-lsdd");
 	}
 	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户信息管理</title>
</head>
<body style="margin: 1px">
	<table id="dg" title="客户信息管理" class="easyui-datagrid"  pagination="true" 
	rownumbers="true" url="${pageContext.request.contextPath}/customer/list.do" fit="true" toolbar="#tb">
	<thead data-options="frozen:true">
		<tr>
			<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center" hidden="true">编号</th>
	 		<th field="khno" width="150" align="center">客户编号</th>
	 		<th field="name" width="200" align="center">客户名称</th>
	 		<th field="cusManager" width="100" align="center">客户经理</th>
	 		<th field="level" width="100" align="center">客户等级</th>
	 		<th field="phone" width="100" align="center">联系电话</th>
		</tr>
	</thead>
	<thead>
		<tr>
			<th field="area" width="80" align="center">客户地区</th>	
	 		<th field="myd" width="80" align="center">客户满意度</th>
	 		<th field="xyd" width="80" align="center">客户信用度</th>
	 		<th field="address" width="200" align="center" >客户地址</th>
	 		<th field="postCode" width="100" align="center" >邮政编码</th>
	 		<th field="fax" width="100" align="center" >传真</th>
	 		<th field="webSite" width="100" align="center" >网址</th>
	 		<th field="yyzzzch" width="100" align="center" >营业执照注册号</th>
	 		<th field="fr" width="100" align="center" >法人</th>
	 		<th field="zczj" width="100" align="center" >注册资金(万元)</th>
	 		<th field="nyye" width="100" align="center" >年营业额(万元)</th>
	 		<th field="khyh" width="100" align="center" >开户银行</th>
	 		<th field="khzh" width="100" align="center" >开户帐号</th>
	 		<th field="dsdjh" width="100" align="center" >地税登记号</th>
	 		<th field="gsdjh" width="100" align="center" >国税登记号</th>
		</tr>
	</thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openCustomerAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openCustomerModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteCustomer()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
			<a href="javascript:openCustomerLinkMan()" class="easyui-linkbutton" iconCls="icon-lxr" plain="true">联系人管理</a>
			<a href="javascript:openCustomerContact()" class="easyui-linkbutton" iconCls="icon-jwjl" plain="true">交往记录管理</a>
			<a href="javascript:openCustomerOrder()" class="easyui-linkbutton" iconCls="icon-lsdd" plain="true">历史订单管理</a>
		</div>
		<div>
			&nbsp;客户编号：&nbsp;<input type="text" id="s_khno" onkeyup="if(event.keyCode==13) searchCustomer()"/>
			&nbsp;客户名称：&nbsp;<input type="text" id="s_name" onkeyup="if(event.keyCode==13) searchCustomer()"/>
			<a href="javascript:searchCustomer()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" buttons="#dlg-buttons" style="height: 450px;width: 700px;padding:20px 40px" closed="true">
		<form id="fm" method="post">
			<table cellspacing="4px" align="center">
				<tr>
					<td>客户名称:</td>
					<td><input type="text" id="name" name="name" required="true" class="easyui-validatebox"/><font color="red">&nbsp;*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>地区:</td>
					<td>
						<select id="area"  name="area" editable="false" panelHeight="auto" class="easyui-combobox" style="width:148px">
							<option value="">请选择地区...</option>
							<option value="北京">北京</option>
							<option value="上海">上海</option>
							<option value="广东">广东</option>
							<option value="深圳">深圳</option>
						</select>
					<font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>客户经理:</td>
					<td><input id="cusManager" class="easyui-combobox" name="cusManager" panelHeight="auto" data-options="valueField:'trueName',textField:'trueName',url:'${pageContext.request.contextPath}/user/customerManageComboList.do'"><font color="red">&nbsp;*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>客户等级:</td>
					<td>
						<input id="level" class="easyui-combobox" name="level" panelHeight="auto" data-options="valueField:'dataDicValue',textField:'dataDicValue',url:'${pageContext.request.contextPath}/dataDic/findDataDicComboList.do?dataDicName=客户等级'">
					<font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
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
					<font color="red">&nbsp;*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>客户信用度:</td>
					<td>
						<select id="xyd" name="xyd" editable="false" panelHeight="auto" class="easyui-combobox" style="width:148px">
							<option value="">请选择...</option>
							<option value="☆">☆</option>
							<option value="☆☆">☆☆</option>
							<option value="☆☆☆">☆☆☆</option>
							<option value="☆☆☆☆">☆☆☆☆</option>
							<option value="☆☆☆☆☆">☆☆☆☆☆</option>
						</select>
					<font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>邮政编码:</td>
					<td><input type="text" id="postCode" name="postCode"  class="easyui-validatebox" required="true"/><font color="red">&nbsp;*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>联系电话:</td>
					<td><input type="text" id="phone" name="phone"  class="easyui-validatebox" required="true"/><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>传真:</td>
					<td><input type="text" id="fax" name="fax"  class="easyui-validatebox" required="true" /><font color="red">&nbsp;*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>网址:</td>
					<td><input type="text" id="webSite" name="webSite" class="easyui-validatebox" required="true" /><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>客户地址:</td>
					<td colspan="4"><input type="text" id="address"  style="width:420px" class="easyui-validatebox" name="address" required="true"><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>营业执照注册号:</td>
					<td><input type="text" id="yyzzzch" name="yyzzzch" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>法人:</td>
					<td><input type="text" id="fr" name="fr" class="easyui-validatebox" required="true" /><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>注册资金(万元):</td>
					<td><input type="text" id="zczj" name="zczj" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>年营业额(万元):</td>
					<td><input type="text" id="nyye" name="nyye" class="easyui-validatebox" required="true" /><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>开户银行:</td>
					<td><input type="text" id="khyh" name="khyh"  class="easyui-validatebox" required="true" /><font color="red">&nbsp;*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>开户帐号:</td>
					<td><input type="text" id="khzh" name="khzh" class="easyui-validatebox" required="true" /><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>地税登记号:</td>
					<td><input type="text" id="dsdjh" name="dsdjh" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>国税登记号:</td>
					<td><input type="text" id="gsdjh" name="gsdjh"/></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:saveCustomer()" iconCls="icon-save" class="easyui-linkbutton">保存</a>
		<a href="javascript:closeCustomerDialog()" iconCls="icon-cancel" class="easyui-linkbutton">关闭</a>
	</div>
	
</body>
</html>