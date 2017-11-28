<!-- #include file="conn.asp" -->
<!--#include virtual="aes.asp"-->
<%
	username = request("username")
	password = request("password")
	company = request("company")
	
	taskmoney = request("taskmoney")
	number = request("number")
	begindate = request("begindate")
	dim encode,aes
	set aes = new aes_class
	encode = aes.CipherStrToHexStr (128,password , "abcdefgh12345678")
	sql = "select username from agent where username='" & username & "'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  sql = "insert into  agent (company,username,password,taskmoney,number,begindate) values ('"_
	  &company&"','"&username&"','"&encode&"',"&taskmoney&",'"&number&"','"&begindate&"')"
	  
	  conn.execute(sql)
	  response.write "success"
	  
	else
	  response.write "exists"
	end if
	
	
%>