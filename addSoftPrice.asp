<!-- #include file="conn.asp" -->

<%
	softVersion = request("softVersion")
	standardPrice = request("standardPrice")
	sitePrice = request("sitePrice")
	
	
	sql = "select softVersion from softPrice where softVersion='" & softVersion & "'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  sql = "insert into  softPrice (softVersion,standardPrice,sitePrice) values ('"&softVersion&"',"&standardPrice&","&sitePrice&")"
	  conn.execute(sql)
	  response.write "success"
	  
	else
	  response.write "exists"
	end if
	
	
%>