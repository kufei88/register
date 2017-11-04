<!-- #include file="conn.asp" -->

<%
	username = session("username")
	qqname = request("qqname")
	qq = request("qq")
	
	
	
	
    set rsUser = server.CreateObject("adodb.recordset")
	
	
	  sql = "insert into  agentqq (username,qqname,qq) values ('"&username&"','"&qqname&"','"&qq&"')"
	  conn.execute(sql)
	  response.write "success"
	  
	
	
	
%>