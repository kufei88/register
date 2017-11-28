<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	dim year,month,dogprice
	set rsUser = server.CreateObject("adodb.recordset")
	sql = "select memvalue from mem where memvar='每年开始时间'"
	rsUser.Open sql,conn,0,1
	if rsUser.BOF and rsUser.EOF then
	  year = "04-01"
	else
		year = rsUser("memvalue")
	end if
	rsUser.close
	sql = "select memvalue from mem where memvar='每期月数'"
	rsUser.Open sql,conn,0,1
	if rsUser.BOF and rsUser.EOF then
	  month = "4"
	else
	  month = rsUser("memvalue")
	end if
	rsUser.close
	sql = "select memvalue from mem where memvar='空狗价格'"
	rsUser.Open sql,conn,0,1
	if rsUser.BOF and rsUser.EOF then
	  dogprice = "100"
	else
	  dogprice = rsUser("memvalue")
	end if
	rsUser.close
	SET jObj=NEW simpleJson
	SET r= NEW jsonObject
	SET r.member("year") = jObj.nV(year)
	SET r.member("month") = jObj.nV(month)
	SET r.member("dogprice") = jObj.nV(dogprice)
	'jObj.member("month") = month
	'jObj.member("dogprice") = dogprice
	Response.Write r.parseString()
%>