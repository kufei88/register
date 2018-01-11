<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	client = request("client")
	searchDate = request("searchDate")
	searchEndDate = request("searchEndDate")
	
	
	if client <> "" then
	  str1 = " and clientName='"&client&"' "
	end if
	if searchDate <> "" then
	  str2 = " and trialDate>'"&searchDate&"' "
	end if
	if searchEndDate <> "" then
	  str3 = " and convert(char(10),trialDate,120)<='"&searchEndDate&"' "
	end if
	rows = request("rows")
	page = request("page")
	sqlcount = "select count(*) from trial where 1=1 "&str1&str2&str3
	
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	sql = "select top "&rows&" a.*,b.company from trial a left join agent b on a.username=b.username where  "&_
	"  a.id not in (select top "&(page-1)*rows&" a.id from trial a left join agent b on a.username=b.username  where  1=1 "&str1&str2&str3&" order by trialDate) "&str1&str2&str3&" order by trialDate"
	'response.write sql
	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.DataBind(rsUser,rowCount)
	Response.Write r.parseString()
%>