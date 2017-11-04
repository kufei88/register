<!-- #include file="conn.asp" -->
<%
	softVersion = request("old")
	sql = "select softVersion from softPrice where softVersion='" & softVersion & "'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  
	  response.write "failed"
	  
	else
	  sql = "delete from softPrice where softVersion ='"&softVersion&"'"
	  
	  conn.execute(sql)
	  response.write "success"
	end if
	

	
	
	
%>