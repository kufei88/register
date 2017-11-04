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
	  str2 = " and registerdate>'"&searchDate&"' "
	end if
	if searchEndDate <> "" then
	  str3 = " and convert(char(10),registerdate,120)<='"&searchEndDate&"' "
	end if
	rows = request("rows")
	page = request("page")
	sqlcount = "select count(*) from agentHistory where username='"&username&"'"&str1&str2&str3
	
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	sql = "select top "&rows&" * from agentHistory  where  username = '"&username&_
	"' and id not in (select top "&(page-1)*rows&" id from agentHistory where  username = '"&username&"'"&str1&str2&str3&" order by registerdate) "&str1&str2&str3&" order by registerdate"

	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.DataBind(rsUser,rowCount)
	Response.Write r.parseString()
%>