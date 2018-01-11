<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!-- #include file="conn.asp" -->
<!--#include virtual="aes.asp"-->
<%
	username = request("username")
	password = request("password")
	set rsUser = server.CreateObject("adodb.recordset")
	  dim encode,aes
	  set aes = new aes_class
	  encode = aes.CipherStrToHexStr (128,password , "abcdefgh12345678")
		sql = "select UserName from admin where username='" & username & "' and password='" & encode & "'"
		rsUser.Open sql,conn,1,1
		
		if rsUser.BOF and rsUser.EOF then
		  
		  response.write "error"
		  response.end
		end if
		response.write "success"
		response.end
%>