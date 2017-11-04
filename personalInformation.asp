<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="agentValidate.asp"-->
<!-- #include file="conn.asp" -->
<%
	dim company,username,jsmoney,taskmoney,number
	username= session("username")
	set rsUser = server.CreateObject("adodb.recordset")
	sql = "select company,isnull(jsmoney,0) as jsmoney,taskmoney,isnull(number,'空')  as number from agent where username='"&username&"'"
	rsUser.Open sql,conn,0,1
	company = rsUser("company")
	jsmoney = rsUser("jsmoney")
	taskmoney = rsUser("taskmoney")
	
	number = rsUser("number")
	
	rsUser.close
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>个人信息</title>
	<meta charset="UTF-8">
        <title>个人信息</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
        <div style="margin:20px 0;"></div>
    <div class="easyui-panel" title="个人信息" style="width:400px">
        <div style="padding:10px 60px 20px 60px">
        <form id="ff" method="post">
            <table cellpadding="5">
                <tr>
                    <td>公司名称:</td>
                    <td><input class="easyui-textbox"  name="company" value=<%=company%> readonly></input></td>
                </tr>
                <tr>
                    <td>余额:</td>
                    <td><input class="easyui-textbox"  name="jsmoney" readonly="true" value=<%=jsmoney%> ></input></td>
                </tr>
				<tr>
                    <td>任务目标:</td>
                    <td><input class="easyui-textbox"  name="taskmoney" value=<%=taskmoney%> readonly></input></td>
                </tr>
				<tr>
                    <td>联系方式:</td>
                    <td><input class="easyui-textbox"  name="number" value=<%=number%> readonly></input></td>
                </tr>
                
            </table>
        </form>
        
        </div>
    </div>
	<script type="text/javascript">

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