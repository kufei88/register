<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	client = request("client")
	searchDate = request("searchDate")
	searchEndDate = request("searchEndDate")
	username = session("username")
	totaltype = request("totaltype")
	
	if client <> "" then
	  str1 = " and a.username='"&client&"' "
	end if
	if searchDate <> "" then
	  str2 = " and registerdate>'"&searchDate&"' "
	end if
	if searchEndDate <> "" then
	  str3 = " and convert(char(10),registerdate,120)<='"&searchEndDate&"' "
	end if
	rows = request("rows")
	page = request("page")
	if totaltype <> "1" then
	sqlcount = "select count(*) from registerhistory a where 1=1  "&str1&str2&str3
	else
	  sqlcount = "select count(*) from (select username from registerhistory a where 1=1 "&str1&str2&str3&" group by username) a"
	end if
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	if totaltype <> "1" then
	sql = "select top "&rows&" registerdate,b.company , a.client,consumeJS,oldversion+isnull(convert(varchar(3),oldnumber),'') as oldversion, "&_
	"newversion+isnull(convert(varchar(3),newnumber),'') as newversion,a.memo from registerhistory a left join agent b on a.username=b.username  where  "&_
	"  a.id not in (select top "&(page-1)*rows&" id from registerhistory a where  1=1 "&str1&str2&str3&" order by id) "&str1&str2&str3&" order by a.id"
	else
	  sql = "select top "&rows&" b.company,sum(consumeJS) as consumeJS from registerhistory a left join agent b on a.username=b.username  where  "&_
	"  b.company not in (select top "&(page-1)*rows&" b.company from registerhistory a left join agent b on a.username=b.username where  1=1 "_
	&str1&str2&str3&" group by b.company order by b.company) "&str1&str2&str3&" group by b.company order by b.company"
	end if
	rsUser.Open sql,conn,0,1
	
	SET jObj=NEW simpleJson
	SET r=jObj.DataBind2(rsUser,rowCount,"consumeJS")
	
	Response.Write r.parseString()
	
%>