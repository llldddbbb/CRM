<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户关系管理系统</title>
</head>
<script type="text/javascript">
	function openTab(text,url,iconCls){
		if($('#tabs').tabs("exists",text)){
			$('#tabs').tabs('select',text)
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='height:100%;width:100%' src='${pageContext.request.contextPath}/page/"+url+"'></iframe>";
			$('#tabs').tabs('add',{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			})
		}
	}
	function resetValues(){
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}
	var url;
	function openPasswordModifyDialog(){
		$("#dlg").dialog("open");
		url="${pageContext.request.contextPath}/user/modifyPassword.do?id=${currentUser.id}";
	}
	function modifyPassword(){
		$("#fm").form("submit",{
			url:url,
 			onSubmit:function(){
 				if($('#oldPassword').val()!='${currentUser.password}'){
 					$.messager.alert("系统提示","原密码错误！");
 					return false;
 				}
 				if($("#newPassword").val()!=$("#newPassword2").val()){
 					$.messager.alert("系统提示","新密码与确认新密码不一致！");
 					return false;
 				}
 				return $(this).form("validate");//验证表单，easyui提供的方法
 			},
 			success:function(result){
 				var result=eval("("+result+")");
 				if(result.success){
 					$.messager.alert("系統提示","密码修改成功");
 					closePasswordModifyDialog();
 				}else{
 					$.messager.alert("系統提示","保存失敗");
 					return;
 				}
 			}
		})
	}
	function closePasswordModifyDialog(){
		resetValues();
		$("#dlg").dialog("close");
	}
	
	function logout(){
		$.messager.confirm("系统提示","您确定要退出系统吗?",function(r){
			if(r){
				window.location.href="${pageContext.request.contextPath}/user/logout.do";
			}
		})
	}
	
</script>
<body class="easyui-layout">
	<div region="north" style="height: 78px;background-color:#E0ECFF ">
		<table style="padding:5px width:100%">
			<tr>
				<td width="50%">
					<img src="${pageContext.request.contextPath}/images/bglogo.png"/>
				</td>
				<td valign="bottom" align="right" width="50%">
					<font size="3" color="red">&nbsp;&nbsp;<strong>欢迎：</strong>${currentUser.userName }</font>【${currentUser.trueName }】【${currentUser.roleName }】
				</td>
			</tr>
		</table>
	</div>
	
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页" data-options="iconCls:'icon-home'">
				<div align="center"> </div>
			</div>
		</div>
	</div>
	
	<div region="west"style="width:200px " title="导航菜单" split="true">
		<div class="easyui-accordion" data-options="fit:true,border:false">
			<div title="营销管理" data-options="selected:true,iconCls:'icon-yxgl'" style="padding:10px">
				<a href="javascript:openTab('营销机会管理','saleChanceManage.jsp','icon-yxjhgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-yxjhgl'" style="width:150px">营销机会管理</a>
				<a href="javascript:openTab('客户开发计划','cusdevplanManage.jsp','icon-khkfjh')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khkfjh'" style="width:150px">客户开发计划</a>
			</div>
			<div title="客户管理"  data-options="iconCls:'icon-khgl'" style="padding:10px;">
				<a href="javascript:openTab('客户信息管理','customerManage.jsp','icon-khxxgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khxxgl'" style="width: 150px;">客户信息管理</a>
				<a href="javascript:openTab('客户流失管理','customerLossManage.jsp','icon-khlsgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khlsgl'" style="width: 150px;">客户流失管理</a>
			</div>
			<div title="服务管理" data-options="iconCls:'icon-fwgl'" style="padding:10px">
				<a href="javascript:openTab('服务创建','customerServiceCreate.jsp','icon-fwcj')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwcj'" style="width: 150px;">服务创建</a>
				<a href="javascript:openTab('服务分配','customerServiceAssign.jsp','icon-fwfp')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwfp'" style="width: 150px;">服务分配</a>
				<a href="javascript:openTab('服务处理','customerServiceProce.jsp','icon-fwcl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwcl'" style="width: 150px;">服务处理</a>
				<a href="javascript:openTab('服务反馈','customerServiceFeedback.jsp','icon-fwfk')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwfk'" style="width: 150px;">服务反馈</a>
				<a href="javascript:openTab('服务归档','customerServiceFile.jsp','icon-fwgd')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwgd'" style="width: 150px;">服务归档</a>
			</div>
			<div title="统计报表"  data-options="iconCls:'icon-tjbb'" style="padding:10px">
				<a href="javascript:openTab('客户贡献分析','khgxfx.jsp','icon-khgxfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khgxfx'" style="width: 150px;">客户贡献分析</a>
				<a href="javascript:openTab('客户构成分析','khgcfx.jsp','icon-khgcfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khgcfx'" style="width: 150px;">客户构成分析</a>
				<a href="javascript:openTab('客户服务分析','khfwfx.jsp','icon-khfwfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khfwfx'" style="width: 150px;">客户服务分析</a>
				<a href="javascript:openTab('客户流失分析','khlsfx.jsp','icon-khlsfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khlsfx'" style="width: 150px;">客户流失分析</a>
			</div>
			<div title="基础数据管理"  data-options="iconCls:'icon-jcsjgl'" style="padding:10px">
				<a href="javascript:openTab('数据字典管理','dataDicManage.jsp','icon-sjzdgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 150px;">数据字典管理</a>
				<a href="javascript:openTab('产品信息查询','productSearch.jsp','icon-cpxxgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cpxxgl'" style="width: 150px;">产品信息查询</a>
				<a href="javascript:openTab('用户信息管理','userManage.jsp','icon-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user'" style="width: 150px;">用户信息管理</a>
			</div>
			<div title="系统管理"  data-options="iconCls:'icon-item'" style="padding:10px">
				<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
				<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
			</div>
		</div>
	</div>
	<div region="south" style="height: 25px; padding:5px" align="center">
		版权所有：571002217@qq.com
	</div>
	
	
	<div id="dlg" class="easyui-dialog" style="width:620px;height:250px; padding:10px 20px" buttons="#dlg-buttons" closed="true">
	
		<form id="fm" method="post">
			<table cellspacing="8px">
				<tr>
					<td>用户名:</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><input type="text" id="userName" name='userName'  value="${currentUser.trueName }" readonly="readonly" style="width:200px"/></td>
				</tr>
				<tr>
					<td>原密码:</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><input type="password" id="oldPassword" name="oldPassword" class="easyui-validatebox" required="true" style="width:200px"/></td>
				</tr>
				<tr>
					<td>新密码:</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><input type="password" id="newPassword" name="newPassword" class="easyui-validatebox" required="true" style="width:200px"/></td>
				</tr>
				<tr>
					<td>确认新密码:</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><input type="password" id="newPassword2" name="newPassword2" class="easyui-validatebox" required="true" style="width:200px"/></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-add">保存</a>  
		<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>  
	</div>
</body>
</html>