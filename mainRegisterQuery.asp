﻿<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="validate.asp"-->


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
                url="getMainRegisterQuery.asp" 
                toolbar="#toolbar" 
                rownumbers="true" fitColumns="true" singleSelect="true" pagination="true" showfooter="true"  >
            <thead>
                <tr>
				    <th field="company"  width="50">公司名称</th>
                    <th field="oldversion" width="50">老版本</th>
                    <th field="newversion" width="50">新版本</th>
					<th field="consumeJS" width="50">金额</th>
					<th field="registerdate" width="50">注册时间</th>
					<th field="client"  width="50">客户名称</th>
					<th field="memo"  width="50">备注</th>
                </tr>
            </thead>
        </table>
        <div id="toolbar">
			&nbsp;&nbsp;&nbsp;公司名称:&nbsp;&nbsp;&nbsp;<input name="client"  class="easyui-combobox" id="client"
					data-options="valueField:'username',textField:'company',url:'getCompany.asp'" ></input>
			&nbsp;&nbsp;&nbsp;开始日期:&nbsp;&nbsp;&nbsp; <input class="easyui-datebox" id="searchDate" style="width:110px">
        	&nbsp;&nbsp;&nbsp;结束日期:&nbsp;&nbsp;&nbsp; <input class="easyui-datebox" id="searchEndDate" style="width:110px">	
			汇总方式: <select class="easyui-combobox" name="state" id="totaltype"  style="width:110px">
				<option value="0">明细</option>
				<option value="1">汇总</option>
			 </select>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searcha()">查询</a>
            
        </div>
        
        
        <script type="text/javascript">
            
			function searcha(){
			if ($('#totaltype').combobox('getValue') == '1'){
			
				$('#dg').datagrid({
				url:'getMainRegisterQuery.asp',
				columns:[[
					{field:'company',title:'公司名称',width:100},
					{field:'consumeJS',title:'金额',width:100}
				]]
			});
            	
			}
			else
			{
				$('#dg').datagrid({
				url:'getMainRegisterQuery.asp',
				columns:[[
					{field:'company',title:'公司名称',width:50},
					{field:'oldversion',title:'老版本',width:50},
                    {field:'newversion',title:'新版本',width:50},
					{field:'consumeJS',title:'金额',width:50},
					{field:'registerdate',title:'注册时间',width:50},
					{field:'client',title:'客户名称',width:50},
					{field:'memo',title:'备注',width:50}
				]]
			});
			}	
            	$('#dg').datagrid('reload',{  
            client:$('#client').combobox('getValue'),  
            searchDate:$('#searchDate').datebox('getValue'),
            searchEndDate:$('#searchEndDate').datebox('getValue'),
			totaltype:$('#totaltype').combobox('getValue')}  
            ); 
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