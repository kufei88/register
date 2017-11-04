<!-- #include file="conn.asp" -->

<%
	taskMoney = request("taskMoney")
	softVersion = request("softVersion")
	discount = request("discount")
	oldtaskmoney = request("oldtaskmoney")
	oldsoftversion = request("oldsoftversion")
	sql = "select taskMoney from discountlist where taskMoney=" & oldtaskmoney & " and softversion='"&softversion&"'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  
	  response.write "failed"
	  
	else
	  if (oldtaskmoney <> taskMoney) or (oldsoftversion <> softVersion) then
	    sql = "select taskMoney from discountlist where taskMoney=" & taskMoney & " and softversion='"&softVersion&"'"
		rsUser.close
		rsUser.Open sql,conn,1,1
		if rsUser.BOF and rsUser.EOF then
		  sql = "update  discountlist set softVersion='"&softVersion&"',taskMoney="&taskMoney&",discount="&discount&" where taskMoney=" & oldtaskmoney & " and softversion='"&softversion&"'"
		  response.write sql
		  conn.execute(sql)
		  response.write "success"
		else
		  response.write "exists"
		end if
	  else
		sql = "update  discountlist set softVersion='"&softVersion&"',taskMoney="&taskMoney&",discount="&discount&" where taskMoney=" & oldtaskmoney & " and softversion='"&softversion&"'"
	  
		conn.execute(sql)
		  
		response.write "success"
	  end if
	end if
	

	
	
	
%>