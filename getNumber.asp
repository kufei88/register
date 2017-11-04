<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->

<%
	
    set rsUser = server.CreateObject("adodb.recordset")
	sql = "select * from alertnumber order by id"
	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.MyDataBind(rsUser)
	Response.Write r.parseString()
%>