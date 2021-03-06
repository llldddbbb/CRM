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
		$.post("${pageContext.request.contextPath}/saleChance/findSaleChanceById.do",{id:'${param.saleChanceId}'},function(result){
			var result=eval("("+result+")");
	 		$("#customerName").val(result.customerName);
	 		$("#chanceSource").val(result.chanceSource);
	 		$("#cgjl").val(result.cgjl);
	 		$("#overView").val(result.overView);
	 		$("#linkMan").val(result.linkMan);
	 		$("#linkPhone").val(result.linkPhone);
	 		$("#description").val(result.description);
	 		$("#createMan").val(result.createMan);
	 		$("#createTime").val(result.createTime);
	 		$("#assignMan").val(result.assignMan);
	 		$("#assignTime").val(result.assignTime);
		});
		
		$('#dg').edatagrid({
	           url: '${pageContext.request.contextPath}/cusDevPlan/list.do?saleChanceId=${param.saleChanceId}',
	           saveUrl: '${pageContext.request.contextPath}/cusDevPlan/save.do?saleChance.id=${param.saleChanceId}',
	           updateUrl: '${pageContext.request.contextPath}/cusDevPlan/save.do?saleChance.id=${param.saleChanceId}',
	           destroyUrl: '${pageContext.request.contextPath}/cusDevPlan/delete.do'
	       });
		
	})
	
	function updateSaleChanceDevResult(devResult){
		$.post("${pageContext.request.contextPath}/cusDevPlan/updateSaleChanceDevResult.do",{id:'${param.saleChanceId}',devResult:devResult},function(result){
			var result=eval("("+result+")");
			if(result.success){
				$.messager.alert("系统提示","执行成功!");
			}else{
				$.messager.alert("系统提示","执行失败!")
			}
		})
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户开发计划项</title>
</head>
<body style="margin: 15px">
	
	<div id="p" class="easyui-panel" title="销售机会信息" style="height: 400px;width: 700px;padding:10px">
			<table cellspacing="4px">
				<tr>
					<td>客户名称:</td>
					<td><input type="text" id="customerName" name="customerName" readonly="readonly"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>机会来源:</td>
					<td><input type="text" id="chanceSource" name="chanceSource" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>联系人:</td>
					<td><input type="text" id="linkMan" name="linkMan"  readonly="readonly"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>联系电话:</td>
					<td><input type="text" id="linkPhone" name="linkPhone" readonly="readonly"/></td>
				</tr>
				<tr>
					<td>成功几率(%):</td>
					<td><input type="text" id="cgjl" name="cgjl" readonly="readonly" /></td>
					<td>范围是(0-100)</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td>概要:</td>
					<td colspan="4"><input type="text" style="width: 420px" id="overView" name="overView"  readonly="readonly"/></td>
				</tr>
				<tr>
					<td valign="top">机会描述:</td>
					<td colspan="4"><textArea rows="5" style="width: 420px" id="description" name="description" readonly="readonly"></textArea></td>
				</tr>
				<tr>
					<td>创建人:</td>
					<td><input type="text" id="createMan" name="createMan"   readonly="readonly"/></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>创建时间:</td>
					<td><input type="text" id="createTime" name="createTime"  readonly="readonly"/></td>
				</tr>
				<tr>
					<td>指派给:</td>
					<td><input type="text" id="assignMan" readonly="readonly" name="assignMan" /></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>指派时间:</td>
					<td><input type="text" id="assignTime" name="assignTime" readonly="readonly"/></td>
				</tr>
			</table>
	</div>
	<br/>
	<table id="dg" title="开发计划项" style="width:700px;height:250px"
            toolbar="#toolbar"  idField="id" rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
            <tr>
                <th field="id" width="50"></th>
                <th field="planDate" width="50" editor="{type:'datebox',options:{required:true}}">日期</th>
                <th field="planItem" width="100" editor="{type:'validatebox',options:{required:true}}">计划内容</th>
                <th field="exeAffect" width="100" editor="{type:'validatebox',options:{required:true}}">执行影响</th>
            </tr> 
        </thead>
    </table>
    <div id="toolbar">
    	<c:if test="${param.show!='true'}">
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:$('#dg').edatagrid('addRow')">添加</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="javascript:$('#dg').edatagrid('destroyRow')">删除</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:$('#dg').edatagrid('saveRow')">保存</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:$('#dg').edatagrid('cancelRow')">撤销</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-kfcg" plain="true" onclick="updateSaleChanceDevResult(2)">开发成功</a>
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-zzkf" plain="true" onclick="updateSaleChanceDevResult(3)">终止开发</a>
        </c:if>
    </div>
</body>
</html>