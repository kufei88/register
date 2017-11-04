<!-- #include file="conn.asp" -->
<%
	username = request("old")
	sql = "select username from agent where username='" & username & "'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  
	  response.write "failed"
	  
	else
	  sql = "delete from agent where username ='"&username&"'"
	  
	  conn.execute(sql)
	  response.write "success"
	end if
	

	
	
	
%>