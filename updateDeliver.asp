<!-- #include file="conn.asp" -->

<%
	dim id
	id = request("id")
	
	sql = "update buydog set deliver=1 where id="&id
	conn.execute(sql)
	
	response.write "success"
	
	
%>