<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="validate.asp"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>软件狗到期查询</title>
	<meta charset="UTF-8">
        <title>软件狗到期查询</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
	
        
        <table id="dg" title="软件狗到期查询" class="easyui-datagrid" style="width:100%;height:550px"
                url="getMainDogExpireQuery.asp" 
                toolbar="#toolbar" 
                rownumbers="true" fitColumns="true" singleSelect="true" pagination="true" showfooter="true"  >
            <thead>
                <tr>
					<th field="company"  width="50">合作伙伴</th>
				    <th field="client"  width="50">公司名称</th>
                    <th field="dogcode" width="50">软件狗号</th>
					<th field="dogversion" width="50">软件版本</th>
                    <th field="dealafterexpire" width="50">服务到期后处理</th>
					<th field="controlsite" width="50">控制连接电脑</th>
					<th field="enddate" width="50">到期时间</th>
					
                </tr>
            </thead>
        </table>
        <div id="toolbar">
			&nbsp;&nbsp;&nbsp;公司名称:&nbsp;&nbsp;&nbsp;<input name="client"  class="easyui-combobox" id="client"
					data-options="valueField:'username',textField:'company',url:'getCompany.asp'" ></input>
			&nbsp;&nbsp;&nbsp;开始日期:&nbsp;&nbsp;&nbsp; <input class="easyui-datebox" id="searchDate" style="width:110px">
        	&nbsp;&nbsp;&nbsp;结束日期:&nbsp;&nbsp;&nbsp; <input class="easyui-datebox" id="searchEndDate" style="width:110px">	
			
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searcha()">查询</a>
            
        </div>
        
        
        <script type="text/javascript">
            
			function searcha(){
				
			
            	$('#dg').datagrid('reload',{  
            client:$('#client').combobox('getValue'),  
            searchDate:$('#searchDate').datebox('getValue'),
            searchEndDate:$('#searchEndDate').datebox('getValue')}  
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