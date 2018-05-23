<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!-- #include file="conn.asp" -->
<!--#include virtual="aes.asp"-->
<%
  
  username = request("userid")
  password = request("pwd")
  if username = "" then
    response.write "error"
	response.end
  else
	  set rsUser = server.CreateObject("adodb.recordset")
	  dim encode,aes
	  set aes = new aes_class
	  encode = aes.CipherStrToHexStr (128,password , "abcdefgh12345678")
		sql = "select UserName,company from agent where username='" & username & "' and password='" & encode & "'"
		rsUser.Open sql,conn,1,1
		
		if rsUser.BOF and rsUser.EOF then
		  ErrorMessage = "用户名密码错误"
		  response.write "error"
		  response.end
		else
		  company = rsUser("company")
		  
		  session("username") = username
		  response.write "success"
		end if
		
  end if
%>
