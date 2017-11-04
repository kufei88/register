<!-- #include file="conn.asp" -->

<%
	number = request("number")
	
	
	
	sql = "select number from alertnumber where number='" & number & "'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  sql = "insert into  alertnumber  values ('"&number&"')"
	  conn.execute(sql)
	  response.write "success"
	  
	else
	  response.write "exists"
	end if
	
	
%>