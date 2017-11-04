<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	
    set rsUser = server.CreateObject("adodb.recordset")
	sql = "select a.id,a.buydate,b.company,a.number,a.businessNumber,a.industrynumber,a.carnumber from buydog a left join agent b on a.username=b.username where a.deliver=0 "
	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.myDataBind(rsUser)
	Response.Write r.parseString()
%>