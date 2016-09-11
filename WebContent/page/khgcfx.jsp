<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script src="${pageContext.request.contextPath}/highcharts4/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/highcharts4/js/highcharts.js" type="text/javascript"></script> 
<script type="text/javascript">
$(function(){
	var chart = new Highcharts.Chart({
	    chart : {
	    	type: 'column',
	        renderTo : "container" , // 注意这里一定是 ID 选择器
	        events:{
	        	"load":function(event){
	        		$.post("${pageContext.request.contextPath}/customer/findCustomerGcList.do",{},function(result){
	        			var result=eval("("+result+")");
	        			var xArr=new Array();
	        			var yArr=new Array();
	        			for(var i=0;i<result.length;i++){
	        				xArr.push(result[i].customerLevel);
	        				yArr.push(result[i].customerNum);
	        			}
       					chart.xAxis[0].categories=xArr;
        				chart.series[0].setData(yArr);
	        		})
	        	}
	        }
	    },
	    title: {
	        text: '客户构成分析'
	    },
	    xAxis: {
	        categories: [
	            'A',
	            'B',
	            'C'
	        ]
	    },
	    yAxis: {
	        title: {
	            text: '客户数量'
	        }
	    },
	    series: [{
	        name: '客户',
	        data: [1, 2, 3]
	    }]
	}); 
});
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户构成分析</title>
</head>
<body style="margin: 1px">
	
	<div id="container" style="min-width:800px;hight:400px">
	</div>
	
</body>
</html>