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
	
	$(function(){
		$("#assignMan").combobox({
			onSelect:function(record){
				if(record.trueName!=''){
					$("#assignTime").val(getCurrentDateTime());
				}else{
					$("#assignTime").val('');
				}
			}
		});
	})

	var url;
 	function searchSaleChance(){
 		$('#dg').datagrid('load',{
 			"customerName":$('#s_customerName').val(),
 			"overView":$('#s_overView').val(),
 			"createMan":$('#s_createMan').val(),
 			"state":$('#s_state').combobox("getValue"),
 		})
 	}
 	function formatState(value,row){
 		if(value==1){
 			return "已分配";
 		}else{
 			return "未分配";
 		}
 	}
 	function resetValues(){
 		$("#id").val("");
 		$("#customerName").val("");
 		$("#chanceSource").val("");
 		$("#cgjl").numberbox("setValue","");
 		$("#overView").val("");
 		$("#linkMan").val("");
 		$("#linkPhone").val("");
 		$("#description").val("");
 		$("#createMan").val("");
 		$("#createTime").val("");
 		$("#assignMan").combobox("setValue","");
 		$("#assignTime").val("");
 	}
 	function closeSaleChanceDialog(){
 		resetValues();
 		$("#dlg").dialog("close")
 	}
 	function openSaleChanceAddDialog(){
 		$("#dlg").dialog("open").dialog("setTitle","添加营销机会");
 		url="${pageContext.request.contextPath}/saleChance/save.do";
 		$("#createMan").val("${currentUser.userName}");
 		$("#createTime").val(getCurrentDateTime());
 		
 	}
 	function openSaleChanceModifyDialog(){
 		var selectedRows=$("#dg").datagrid("getSelections");
 		if(selectedRows.length!=1){
 			$.messager.alert("系统提示","请选择一条要修改的数据");
 			return ;
 		}
 		var row=selectedRows[0];
 		$("#dlg").dialog("open").dialog("setTitle","修改营销机会");
 		$("#fm").form("load",row);
 		url="${pageContext.request.contextPath}/saleChance/save.do?id="+row.id;
 	}
 	
 	function saveSaleChance(){
 		$("#fm").form("submit",{
 			url:url,
 			onSubmit:function(){
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
 	
 	function deleteSaleChance(){
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
 				$.post("${pageContext.request.contextPath}/saleChance/delete.do",{ids:strIds},function(result){
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
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>营销机会查询</title>
</head>
<body style="margin: 1px">
	<table id="dg" title="营销机会查询" class="easyui-datagrid" fitColumns="true" pagination="true" 
	rownumbers="true" url="${pageContext.request.contextPath}/saleChance/list.do" fit="true" toolbar="#tb">
	<thead>
		<tr>
			<th field="cb" checkbox="true" align="center"></th>
			<th field="id" width="50" align="center">编号</th>
			<th field="chanceSource" width="50" align="center" hidden="true">机会来源</th>
			<th field="customerName" width="50" align="center">客户名称</th>
			<th field="cgjl" width="50" align="center" hidden="true">成功几率</th>
			<th field="overView" width="80" align="center">概要</th>
			<th field="linkMan" width="50" align="center">联系人</th>
			<th field="linkPhone" width="50" align="center">联系电话</th>
			<th field="description" width="50" align="center"  hidden="true">机会描述</th>
			<th field=createMan width="50" align="center">创建人</th>
			<th field="createTime" width="50" align="center">创建时间</th>
			<th field="assignMan" width="50" align="center" hidden="true">指派人</th>
			<th field="assignTime" width="50" align="center" hidden="true">指派时间</th>
			<th field="state" width="50" align="center" formatter="formatState">状态</th>
		</tr>
	</thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openSaleChanceAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openSaleChanceModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteSaleChance()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;客户名称：&nbsp;
			<input type="text" id="s_customerName" onkeyup="if(event.keyCode==13) searchSaleChance()"/>
			&nbsp;概要：&nbsp;
			<input type="text" id="s_overView" onkeyup="if(event.keyCode==13) searchSaleChance()"/>
			&nbsp;创建人：&nbsp;
			<input type="text" id="s_createMan" onkeyup="if(event.keyCode==13) searchSaleChance()"/>
			&nbsp;分配状态：&nbsp;
			<select id="s_state" class="easyui-combobox" panelHeight="auto" onkeyup="if(event.keyCode==13) searchSaleChance()">
				<option value="">请选择...</option>
				<option value="0">未分配</option>
				<option value="1">已分配</option>
			</select>
			<a href="javascript:searchSaleChance()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
		</div>
	</div>
	<div id="dlg" class="easyui-dialog" buttons="#dlg-buttons" style="height: 400px;width: 600px;padding:10px 20px" closed="true">
		<form id="fm" method="post">
			<table cellspacing="4px">
				<tr>
					<td>客户名称:</td>
					<td><input type="text" id="customerName" name="customerName" required="true" class="easyui-validatebox"/><font color="red">&nbsp;*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>机会来源:</td>
					<td><input type="text" id="chanceSource" name="chanceSource" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td>联系人:</td>
					<td><input type="text" id="linkMan" name="linkMan"  class="easyui-validatebox"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>联系电话:</td>
					<td><input type="text" id="linkPhone" name="linkPhone" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td>成功几率(%):</td>
					<td><input type="text" id="cgjl" name="cgjl"  class="easyui-numberbox" data-options="min:0,max:100"required="true"/><font color="red">&nbsp;*</font></td>
					<td>范围是(0-100)</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td>概要:</td>
					<td colspan="4"><input type="text" style="width: 420px" id="overView" name="overView"  class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td valign="top">机会描述:</td>
					<td colspan="4"><textArea rows="5" style="width: 420px" id="description" name="description"></textArea></td>
				</tr>
				<tr>
					<td>创建人:</td>
					<td><input type="text" id="createMan" name="createMan"  class="easyui-validatebox" required="true" readonly="readonly"/><font color="red">&nbsp;*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>创建时间:</td>
					<td><input type="text" id="createTime" name="createTime" class="easyui-validatebox" required="true" readonly="readonly"/><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>指派给:</td>
					<td><input id="assignMan" class="easyui-combobox" name="assignMan" panelHeight="auto" data-options="valueField:'trueName',textField:'trueName',url:'${pageContext.request.contextPath}/user/customerManageComboList.do'"></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>指派时间:</td>
					<td><input type="text" id="assignTime" name="assignTime" class="easyui-validatebox" readonly="readonly"/></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:saveSaleChance()" iconCls="icon-save" class="easyui-linkbutton">保存</a>
		<a href="javascript:closeSaleChanceDialog()" iconCls="icon-cancel" class="easyui-linkbutton">关闭</a>
	</div>
</body>
</html>