<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	sqlcount = "select count(*) from discountlist"
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	sql = "select taskmoney,softVersion,convert(varchar(8),discount) as discount from discountlist order by id"
	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.myDataBind(rsUser)
	Response.Write r.parseString()
%>