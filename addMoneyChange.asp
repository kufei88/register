<!-- #include file="conn.asp" -->

<%
	username = request("username")
	rechargemoney = request("rechargemoney")
	remark = request("remark")
	
	
	
    set rsUser = server.CreateObject("adodb.recordset")
	sql = "select isnull(jsmoney,0) as jsmoney from agent where username='"&username&"'"
	rsUser.open sql,conn,0,1
	if rsUser.eof and rsUser.bof then
	  response.write "not"
	else
	  jsmoney = rsUser("jsmoney")
	  sql = "insert into  changehistory (username,moneychange,changedate,remark,jsmoney) values ('"&username&"',"&rechargemoney&",getdate(),'"&remark&"',"&jsmoney+rechargemoney&")"
	  conn.execute(sql)
	  sql = "update agent set jsmoney = isnull(jsmoney,0) + "&rechargemoney&" where username='"&username&"'"
	  conn.execute(sql)
	  response.write "success"
	end if  
	
	
	
%>