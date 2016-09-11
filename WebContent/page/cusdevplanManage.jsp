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
	
 	function searchSaleChance(){
 		$('#dg').datagrid('load',{
 			"customerName":$('#s_customerName').val(),
 			"overView":$('#s_overView').val(),
 			"devResult":$('#s_devResult').combobox("getValue")
 		})
 	}
 	function formatDevResult(value,row){
 		if(value==0){
 			return "未开发";
 		}else if(value==1){
 			return "开发中";
 		}else if(value==2){
 			return "开发成功";
 		}else{
 			return "开发失败";
 		}
 	}
 	
 	function openCusDevPlanTab(id){
 		window.parent.openTab("客户开发计划项管理","cusDevPlanItemManage.jsp?saleChanceId="+id,"icon-khkfjh");
 	}
 	
 	function openCusDevPlanTab2(id){
 		window.parent.openTab("客户开发计划项管理","cusDevPlanItemManage.jsp?saleChanceId="+id+'&show=true',"icon-khkfjh");
 	}
 	
 	function formatAction(value,row){
 		if(row.devResult==1||row.devResult==0){
 			return "<a href='javascript:openCusDevPlanTab("+row.id+")'>开发</a>";
 		}else{
 			return "<a href='javascript:openCusDevPlanTab2("+row.id+")'>查看详细信息</a>";
 		}
 	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户开发计划</title>
</head>
<body style="margin: 1px">
	<table id="dg" title="客户开发计划" class="easyui-datagrid" fitColumns="true" pagination="true" 
	rownumbers="true" url="${pageContext.request.contextPath}/saleChance/list.do?state=1" fit="true" toolbar="#tb">
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
			<th field="devResult" width="50" align="center" formatter="formatDevResult">客户开发状态</th>
			<th field="a" width="50" align="center" formatter="formatAction">操作</th>
		</tr>
	</thead>
	</table>
	<div id="tb">
		<div>
			&nbsp;客户名称：&nbsp;
			<input type="text" id="s_customerName" onkeyup="if(event.keyCode==13) searchSaleChance()"/>
			&nbsp;概要：&nbsp;
			<input type="text" id="s_overView" onkeyup="if(event.keyCode==13) searchSaleChance()"/>
			&nbsp;客户开发状态：&nbsp;
			<select id="s_devResult" class="easyui-combobox" panelHeight="auto" onkeyup="if(event.keyCode==13) searchSaleChance()">
				<option value="">请选择...</option>
				<option value="0">未开发</option>
				<option value="1">开发中</option>
				<option value="2">开发成功</option>
				<option value="3">开发失败</option>
			</select>
			<a href="javascript:searchSaleChance()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
		</div>
	</div>
</body>
</html>