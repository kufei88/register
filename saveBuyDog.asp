<!-- #include file="conn.asp" -->
<!-- #include file="sms_post.asp" -->
<%
	dim businessNumber,industryNumber,carNumber,totalNumber,consumeJS
	businessNumber = request("businessNumber")
	industryNumber = request("industryNumber")
	carNumber = request("carNumber")
	totalNumber = Cint(businessNumber)+cint(industryNumber)+cint(carNumber)
	username = session("username")
	sql = "select memvalue from mem where memvar='空狗价格'"
	set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  consumeJS = totalNumber * 100
	else
	  consumeJS = totalNumber * cint(rsUser("memvalue"))
	end if
	rsUser.close
	sql = "select isnull(jsmoney,0) as jsmoney,taskmoney from agent where username='"&username&"'"
	rsUser.open sql,conn,1,1
	jsmoney = rsUser("jsmoney")
	if jsmoney - consumeJS >= -rsUser("taskmoney")/2 then
		sql = "insert into buydog (username,buydate,number,consumeJS,JSMoney,businessNumber,industryNumber,carNumber) values "&_
		" ('"&username&"',getdate(),"&totalNumber&","&consumeJS&","&jsmoney-consumeJS&","&businessNumber&","&industryNumber&","&carNumber&")"
		
		conn.execute(sql)
		
		sql = "update agent set jsmoney=jsmoney-"&consumeJS&" where username='"&username&"'"
		conn.execute(sql)
		rsuser.close
		sql = "select * from agent where username='"&username&"'"
		rsUser.Open sql,conn,0,1
		company = rsuser("company")
		rsUser.close
		sql = "select * from alertnumber "
		rsUser.Open sql,conn,0,1
		Do While Not rsUser.EOF
		mobiles = mobiles & rsUser("number") &","
		rsUser.MoveNext
		Loop 
		rsUser.Close
		sendresult = SendMessages(mobiles,company&"购买"&totalNumber&"套空狗(商业:"&businessNumber&",工业:"&industryNumber&",汽修:"&carNumber&");费用:"&consumeJS)
		response.write "success"
	else 
	  response.write "back"
	end if
	
	
%>