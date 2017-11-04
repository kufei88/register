

<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	sqlcount = "select count(*) from softprice"
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	sql = "select * from softprice order by id"
	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.MyDataBind(rsUser)
	Response.Write r.parseString()
%>