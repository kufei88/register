<% Session.CodePage=65001 %>
<% Response.Charset="UTF-8" %>
<!-- #include file="conn.asp" -->
<!--#include virtual="aes.asp"-->
<%
	old = request("old")
	username = request("username")
	password = request("password")
	company = request("company")
	jsmoney = request("jsmoney")
	taskmoney = request("taskmoney")
	number = request("number")
	begindate = request("begindate")
	sql = "select username from agent where username='" & old & "'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  
	  response.write "failed"
	  
	else
	  if password = "********" then
	    sql = "update  agent set username='"&username&"',company='"&company&"',taskmoney="&taskmoney&",number='"&number&"',begindate='"&begindate&"' where username ='"&old&"'"
	  else
	    dim encode,aes
		set aes = new aes_class
		encode = aes.CipherStrToHexStr (128,password , "abcdefgh12345678")
		sql = "update  agent set username='"&username&"',company='"&company&"',password='"&encode&"',taskmoney="&taskmoney&",number='"&number&"',begindate='"&begindate&"' where username ='"&old&"'"
	  end if
	  
	  conn.execute(sql)
	  
	  response.write "success"
	end if
	

	
	
	
%>