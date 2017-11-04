<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="validate.asp"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>客户远程信息查询</title>
	<meta charset="UTF-8">
        <title>客户远程信息查询</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
	
        
        <table id="dg" title="客户远程信息查询" class="easyui-datagrid" style="width:100%;height:550px"
                url="getClientRemoteInformation.asp" 
                toolbar="#toolbar" 
                rownumbers="true" fitColumns="true" singleSelect="true" pagination="true" showfooter="true"  >
            <thead>
                <tr>
				    <th field="Company"  width="50">公司名称</th>
                    <th field="UserName" width="50">用户名</th>
                    <th field="Password" width="50">密码</th>
					<th field="ServerIP" width="50">服务器Ip</th>
					<th field="domain" width="50">花生壳域名</th>
					
                </tr>
            </thead>
        </table>
        <div id="toolbar">
			&nbsp;&nbsp;&nbsp;公司名称:&nbsp;&nbsp;&nbsp;<input name="client"  class="easyui-textbox" id="client"
					></input>
			
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searcha()">查询</a>
            
        </div>
        
        
        <script type="text/javascript">
            
			function searcha(){
			
            	$('#dg').datagrid('reload',{  
            company:$('#client').textbox('getValue')}  
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