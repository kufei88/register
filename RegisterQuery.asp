<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="agentvalidate.asp"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>软件注册查询</title>
	<meta charset="UTF-8">
        <title>软件注册查询</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
	
        
        <table id="dg" title="软件注册查询" class="easyui-datagrid" style="width:100%;height:550px"
                url="getRegisterQuery.asp"
                toolbar="#toolbar" onLoadSuccess="onLoadSuccess()"
                rownumbers="true" fitColumns="true" singleSelect="true" pagination="true" >
            <thead>
                <tr>
					<th field="操作"  width="30">操作</th>
				    <th field="client"  width="50">客户名称</th>
					<th field="dognumber" width="50">加密狗号</th>
                    <th field="oldversion" width="50">老版本</th>
                    <th field="newversion" width="50">新版本</th>
					<th field="consumeJS" width="50">金额</th>
					<th field="jsmoney" width="50">余额</th>
					<th field="registerdate" width="70">注册时间</th>
					<th field="registercode" width="100">注册码</th>
					<th field="memo"  width="50">备注</th>
                </tr>
            </thead>
        </table>
        <div id="toolbar">
			&nbsp;&nbsp;&nbsp;客户名称:&nbsp;&nbsp;&nbsp;<input name="client"  class="easyui-textbox" id="client"></input>
			&nbsp;&nbsp;&nbsp;开始日期:&nbsp;&nbsp;&nbsp; <input class="easyui-datebox" id="searchDate" style="width:110px">
        	&nbsp;&nbsp;&nbsp;结束日期:&nbsp;&nbsp;&nbsp; <input class="easyui-datebox" id="searchEndDate" style="width:110px">		
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searcha()">查询</a>
            
        </div>
        
        
        <script type="text/javascript">
            
			function searcha(){
				
            	$('#dg').datagrid('load',{  
            client:$('#client').textbox('getValue'),  
            searchDate:$('#searchDate').datebox('getValue'),
            searchEndDate:$('#searchEndDate').datebox('getValue')}  
            ); 
			}
			function onLoadSuccess() {
            //添加“合计”列
            $('#dg').datagrid('appendRow', {
                Saler: '<span class="subtotal">合计</span>',
                TotalOrderCount: '<span class="subtotal">' + compute("TotalOrderCount") + '</span>',
                TotalOrderMoney: '<span class="subtotal">' + compute("TotalOrderMoney") + '</span>',
                TotalOrderScore: '<span class="subtotal">' + compute("TotalOrderScore") + '</span>',
                TotalTrailCount: '<span class="subtotal">' + compute("TotalTrailCount") + '</span>',
                Rate: '<span class="subtotal">' + ((compute("TotalOrderScore") / compute("TotalTrailCount")) * 100).toFixed(2) + '</span>'
            });
        }
        //指定列求和
        function compute(colName) {
            var rows = $('#table').datagrid('getRows');
            var total = 0;
            for (var i = 0; i < rows.length; i++) {
                total += parseFloat(rows[i][colName]);
            }
            return total;
        }
			
			
        </script>
        <style type="text/css">
            #fm{
                margin:0;
                padding:10px 30px;
            }
            .ftitle{
                font-size:14px;
                font-weight:bold;
                padding:5px 0;
                margin-bottom:10px;
                border-bottom:1px solid #ccc;
            }
            .fitem{
                margin-bottom:5px;
            }
            .fitem label{
                display:inline-block;
                width:80px;
            }
            .fitem input{
                width:160px;
            }
        </style>
	
</body>
</html>