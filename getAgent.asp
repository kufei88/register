<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	sqlcount = "select count(*) from agent"
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	sql = "select company,username,'********' as password,isnull(jsmoney,0) as jsmoney,isnull(taskmoney,0) as taskmoney,number,convert(char(10),isnull(begindate,'2016-01-01'),120) as begindate from agent "
	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.DataBind3(rsUser,rowCount,"jsmoney","taskmoney")
	Response.Write r.parseString()
%>