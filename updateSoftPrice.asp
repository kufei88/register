<!-- #include file="conn.asp" -->

<%
	softVersion = request("softVersion")
	standardPrice = request("standardPrice")
	sitePrice = request("sitePrice")
	old = request("old")
	sql = "select softVersion from softPrice where softVersion='" & old & "'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  
	  response.write "failed"
	  
	else
	  if old <> softVersion then
	    sql = "select softVersion from softPrice where softVersion='" & softVersion & "'"
		rsUser.close
		rsUser.Open sql,conn,1,1
		if rsUser.BOF and rsUser.EOF then
		  sql = "update  softPrice set softVersion='"&softVersion&"',standardPrice="&standardPrice&",sitePrice="&sitePrice&" where softVersion ='"&old&"'"
		  response.write sql
		  conn.execute(sql)
		  response.write "success"
		else
		  response.write "exists"
		end if
	  else
		sql = "update  softPrice set softVersion='"&softVersion&"',standardPrice="&standardPrice&",sitePrice="&sitePrice&" where softVersion ='"&old&"'"
	  
		conn.execute(sql)
		  
		response.write "success"
	  end if
	end if
	

	
	
	
%>