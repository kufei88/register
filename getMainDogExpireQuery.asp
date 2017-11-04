<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	client = request("client")
	searchDate = request("searchDate")
	searchEndDate = request("searchEndDate")
	username = session("username")
	
	
	if client <> "" then
	  str1 = " and a.agent='"&client&"' "
	end if
	if searchDate <> "" then
	  str2 = " and a.enddate>'"&searchDate&"' "
	end if
	if searchEndDate <> "" then
	  str3 = " and convert(char(10),a.enddate,120)<='"&searchEndDate&"' "
	end if
	rows = request("rows")
	page = request("page")
	
	sqlcount = "select count(*) from softcontinue a where 1=1  "&str1&str2&str3
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	
	sql = "select top "&rows&" c.company,a.client,a.dogcode,b.priceversion+convert(char(10),b.number) as dogversion,"&_
	"(case when a.state=0 then '提醒' else '停止使用' end) as dealafterexpire, "&_
	"(case when a.combine=0 then '不控制' else '控制' end) as controlsite,a.enddate from softcontinue a left join doginfo b "&_ 
	" on a.dogcode=b.dognumber left join agent c on a.agent=c.username where a.id not in (select top "&(page-1)*rows&" id from "&_
	" softcontinue a where 1=1 "&str1&str2&str3&"order by a.enddate) "&str1&str2&str3&"order by a.enddate"
	
	rsUser.Open sql,conn,0,1
	
	SET jObj=NEW simpleJson
	SET r=jObj.DataBind(rsUser,rowCount)
	
	Response.Write r.parseString()
	
%>