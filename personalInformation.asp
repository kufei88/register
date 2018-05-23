<!-- #include file="json.asp" -->
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
	Response.Write "{""company"":"""&company&""",""jsmoney"":"""&jsmoney&""",""taskmoney"":"&taskmoney&",""number"":"""&number&"""}"
%>