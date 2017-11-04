<!-- #include file="conn.asp" -->
<!--#include virtual="aes.asp"-->
<%
	newpass = request("newpass")
	username = session("username")
	dim encode,aes
	set aes = new aes_class
	encode = aes.CipherStrToHexStr (128,newpass , "abcdefgh12345678")
	sql = "update agent set password='" & encode & "' where username='"&username&"'"
	conn.execute(sql)
	response.write newpass
    
%>