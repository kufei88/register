<!-- #include file="conn.asp" -->
<%
	oldtaskmoney = request("oldtaskmoney")
	oldsoftversion = request("oldsoftversion")
	sql = "select taskMoney from discountlist where taskMoney=" & oldtaskmoney & " and softversion='"&oldsoftversion&"'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  
	  response.write "failed"
	  
	else
	  sql = "delete from discountlist where taskMoney=" & oldtaskmoney & " and softversion='"&oldsoftversion&"'"
	  
	  conn.execute(sql)
	  response.write "success"
	end if
	

	
	
	
%>