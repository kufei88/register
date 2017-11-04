<!--#include file="conn.asp"-->
<!--#include virtual="aes.asp"-->
<!-- #include file="sms_post.asp" -->
<%
    dim aes
	key = "asdfgh1357924680"
	KeySize = 128
	set aes = new aes_class
	response.write aes.CipherStrToHexStr(keysize,"1234567JZSOFT55",key)
	response.write aes.CipherStrToHexStr(keysize,"1122334JZSOFT55",key)
%>



