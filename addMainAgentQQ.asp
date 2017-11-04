<!-- #include file="conn.asp" -->

<%
	username = session("admin")
	qqname = request("qqname")
	qq = request("qq")
	
	
	
	
    set rsUser = server.CreateObject("adodb.recordset")
	
	
	  sql = "insert into  agentqq (username,qqname,qq) values ('"&username&"','"&qqname&"','"&qq&"')"
	  conn.execute(sql)
	  response.write "success"
	  
	
	
	
%>