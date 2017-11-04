<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	client = Request("client")
	searchDate = Request("searchDate")
	searchEndDate = Request("searchEndDate")
	totaltype = request("totaltype")
	rows = request("rows")
	page = request("page")
	if client <> "" then
	  str1 = " and a.username='"&client&"' "
	end if
	if searchDate <> "" then
	  str2 = " and buydate>'"&searchDate&"' "
	end if
	if searchEndDate <> "" then
	  str3 = " and convert(char(10),buydate,120)<='"&searchEndDate&"' "
	end if
	if totaltype <> "1" then
	sqlcount = "select count(*) from buydog a where 1=1  "&str1&str2&str3
	else
	  sqlcount = "select count(*) from (select username from buydog a where 1=1 "&str1&str2&str3&" group by username) a"
	end if
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	if totaltype <> "1" then
	sql = "select top "&rows&" a.id,a.buydate,b.company,a.number,a.consumeJS,a.businessNumber,a.industrynumber,"_
	&"a.carnumber from buydog a left join agent b on a.username=b.username where 1=1  "&str1&str2&str3&" and a.id not in "_
	&" (select top "&(page-1)*rows&" id from buydog a where 1=1 "&str1&str2&str3&" order by id) order by a.id"
	else
	  sql = "select top "&rows&" b.company,sum(consumeJS) as consumeJS,sum(a.number) as number from buydog a left join agent b on a.username=b.username  where  "&_
	"  b.company not in (select top "&(page-1)*rows&" b.company from buydog a left join agent b on a.username=b.username where  1=1 "_
	&str1&str2&str3&" group by b.company order by b.company) "&str1&str2&str3&" group by b.company order by b.company"
	end if  
	
	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.DataBind2(rsUser,rowCount,"consumeJS")
	Response.Write r.parseString()
%>