<!-- #include file="conn.asp" -->
<%
	id = request("id")
    set rsUser = server.CreateObject("adodb.recordset")
	
	  sql = "delete from agentqq where id ="&id
	  
	  conn.execute(sql)
	  response.write "success"
	
	

	
	
	
%>