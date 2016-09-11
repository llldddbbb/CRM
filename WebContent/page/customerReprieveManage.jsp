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
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.edatagrid.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">

	$(function(){
		$.post("${pageContext.request.contextPath}/customerLoss/findCustomerLossById.do",{id:'${param.lossId}'},function(result){
			var result=eval("("+result+")");
	 		$("#cusNo").val(result.cusNo);
	 		$("#cusName").val(result.cusName);
	 		$("#cusManager").val(result.cusManager);
	 		$("#lastOrderTime").val(result.lastOrderTime);
	 	
		});
		
		$('#dg').edatagrid({
	           url: '${pageContext.request.contextPath}/customerReprieve/list.do?lossId=${param.lossId}',
	           saveUrl: '${pageContext.request.contextPath}/customerReprieve/save.do?customerLoss.id=${param.lossId}',
	           updateUrl: '${pageContext.request.contextPath}/customerReprieve/save.do?customerLoss.id=${param.lossId}',
	           destroyUrl: '${pageContext.request.contextPath}/customerReprieve/delete.do'
	       });
		
	})
	
	function confirmLoss(id){
		 $.messager.prompt('系统提示', '请输入流失原因', function(r){
            if (r){
            	$.post("${pageContext.request.contextPath}/customerLoss/confirmLoss.do",{id:'${param.lossId}',lossReason:r},function(result){
 					var result=eval("("+result+")");
 					if(result.success){
 						$.messager.alert("系统提示","客户已流失!");
 						$("#dg").datagrid("reload");
 					}else{
 						$.messager.alert("系统提示","执行失败!");
 					}
 				});
            }
        });
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流失客户管理</title>
</head>
<body style="margin: 15px">
	
	<div id="p" class="easyui-panel" title="流失客户信息" style="height: 110px;width: 700px;padding:10px">
			<table cellspacing="4px" >
				<tr>
					<td>客户编号:</td>
					<td><input type="text" id="cusNo" name="cusNo" readonly="readonly"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>客户名称:</td>
					<td><input type="text" id="cusName" name="cusName" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>客户经理:</td>
					<td><input type="text" id="cusManager" name="cusManager" readonly="readonly"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>上次下单时间:</td>
					<td><input type="text" id="lastOrderTime" name="lastOrderTime" readonly="readonly"/></td>
				</tr>
			</table>
	</div>
	<br/>
	<table id="dg" title="流失客户管理" style="width:700px;height:250px"
            toolbar="#toolbar"  idField="id" rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th field="id" width="50">编号</th>
                <th field="measure" width="150" editor="{type:'validatebox',options:{required:true}}">暂缓措施</th>
            </tr> 
        </thead>
    </table>
    <div id="toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:$('#dg').edatagrid('addRow')">添加</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#dg').edatagrid('destroyRow')">删除</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#dg').edatagrid('saveRow')">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#dg').edatagrid('cancelRow')">撤销</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-confirm" plain="true" onclick="javascript:confirmLoss(${param.lossId})">确认流失</a>
    </div>
</body>
</html>