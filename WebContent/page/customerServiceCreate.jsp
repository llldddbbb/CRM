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
		$("#createTime").val(getCurrentDate());
	})
	
	function resetValue(){
		$("#serveType").combobox('setValues','');
		$("#customer").val("");
		$("#overview").val("");
		$("#servicerequest").val("");
	}
	
	function saveCustomerService(){
		$("#fm").form('submit',{
			url:'${pageContext.request.contextPath}/customerService/save.do',
		    onSubmit: function(){
		        if($("#serveType").combobox("getValue")==''){
		        	$.messager.alert("系统提示","服务类型不能为空")
		        	return false;
		        }
		        return $("this").form("validate");
		    },
		    success: function(result){
		        var result=eval('('+result+')');  
		        if (result.success){
		        	$.messager.alert("系统提示","保存成功!");
		        	resetValue();
		        }else{
		        	$.messager.alert("系统提示","保存失败!");
		        	return ;
		        }
		    }
		})
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户开发计划项</title>
</head>
<body style="margin: 15px">
	
	<div id="p" class="easyui-panel" title="客户服务创建" style="height: 350px;width: 580px;padding:10px">
		<form id="fm" method="post">
			<table cellspacing="8px">
				<tr>
					<td>服务类型:</td>
					<td><input id="serveType" class="easyui-combobox" name="serveType" panelHeight="auto" data-options="valueField:'dataDicValue',textField:'dataDicValue',url:'${pageContext.request.contextPath}/dataDic/findDataDicComboList.do?dataDicName=服务类型'"><font color="red">&nbsp;*</font></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>客户:</td>
					<td><input type="text" id="customer" name="customer" class="easyui-validatebox" required="true" /><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td>概要:</td>
					<td colspan="4"><input type="text" id="overview" name="overview" style="width:419px" class="validatebox" required="true"/><font color='red'>&nbsp;*</font></td>
				</tr>
				<tr>
					<td>服务请求:</td>
					<td colspan="4">
						<textarea rows="5" cols="49" id="servicerequest" name="servicerequest" class="easyui-validatebox" required="true"></textarea>
					</td>
				</tr>
				<tr>
					<td>创建人:</td>
					<td>
						<input type="hidden" name="state" value="新创建">
						<input type="text" id="createPeople" name="createPeople" value="${currentUser.trueName }"  readonly="readonly"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>创建时间:</td>
					<td><input type="text" id="createTime" name="createTime"  readonly="readonly"/></td>
				</tr>
				<tr>
					<td colspan="4"></td>
					<td>
						<a href="javascript:saveCustomerService()" iconCls="icon-ok" class="easyui-linkbutton">保存</a>
						<a href="javascript:resetValue()" iconCls="icon-reset" class="easyui-linkbutton">重置</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>