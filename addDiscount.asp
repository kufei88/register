<!-- #include file="conn.asp" -->

<%
	taskMoney = request("taskMoney")
	softVersion = request("softVersion")
	discount = request("discount")
	
	
	sql = "select taskMoney from discountList where taskMoney=" & taskMoney & " and softVersion='"&softVersion&"'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  sql = "insert into  discountList (taskMoney,softVersion,discount) values ("&taskMoney&",'"&softVersion&"',"&discount&")"
	  conn.execute(sql)
	  response.write "success"
	  
	else
	  response.write "exists"
	end if
	
	
%>