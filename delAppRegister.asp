<!-- #include file="conn.asp" -->
<%
	username = request("old")
	sql = "select company from jsphoneuuid where id="&username 
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  
	  response.write "failed"
	  
	else
	  sql = "delete from jsphoneuuid where id ="&username
	  
	  conn.execute(sql)
	  response.write "success"
	end if
	

	
	
	
%>