<!-- #include file="conn.asp" -->
<%
	number = request("old")
	sql = "select * from alertnumber where number='" & number & "'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  
	  response.write "failed"
	  
	else
	  sql = "delete from alertnumber where number ='"&number&"'"
	  
	  conn.execute(sql)
	  response.write "success"
	end if
	

	
	
	
%>