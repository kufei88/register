<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	client = request("client")
	searchDate = request("searchDate")
	searchEndDate = request("searchEndDate")
	username = session("username")
	
	if client <> "" then
	  str1 = " and client='"&client&"' "
	end if
	if searchDate <> "" then
	  str2 = " and enddate>'"&searchDate&"' "
	end if
	if searchEndDate <> "" then
	  str3 = " and convert(char(10),enddate,120)<='"&searchEndDate&"' "
	end if
	rows = request("rows")
	page = request("page")
	sqlcount = "select count(*) from softcontinuequery where agent='"&username&"'"&str1&str2&str3
	
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	sql = "select top "&rows&" * from softcontinuequery  where  agent = '"&username&_
	"' and id not in (select top "&(page-1)*rows&" id from softcontinuequery where  agent = '"&username&"'"&str1&str2&str3&" order by enddate) "&str1&str2&str3&" order by enddate"

	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.DataBind(rsUser,rowCount)
	Response.Write r.parseString()
%>