<!-- #include file="json.asp" -->
<!-- #include file="conn.asp" -->
<%
	searchusername = request("searchusername")
	searchDate = request("searchDate")
	searchEndDate = request("searchEndDate")
	totaltype = request("totaltype")
	
	if searchusername <> "" then
	  str1 = " and a.username='"&searchusername&"' "
	end if
	if searchDate <> "" then
	  str2 = " and a.rechargedate>'"&searchDate&"' "
	end if
	if searchEndDate <> "" then
	  str3 = " and convert(char(10),a.rechargedate,120)<='"&searchEndDate&"' "
	end if
	rows = request("rows")
	page = request("page")
	if totaltype <> "1" then
	sqlcount = "select count(*) from recharge a where 1=1 "&str1&str2&str3
	else
	  sqlcount = "select count(*) from (select username from recharge a where 1=1 "&str1&str2&str3&" group by username) a"
	end if
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
    set rsUser = server.CreateObject("adodb.recordset")
	if totaltype <> "1" then
	sql = "select top "&rows&" b.company,a.rechargedate,a.rechargemoney,a.bank as memo from recharge a left join agent b on "&_
	"a.username=b.username where a.id not in (select top "&(page-1)*rows&" a.id from recharge a left join agent b on "&_
	" a.username=b.username where 1=1 "&str1&str2&str3&" order by a.rechargedate) "&str1&str2&str3&" order by a.rechargedate"
	else
	sql = "select top "&rows&" b.company,sum(a.rechargemoney) as rechargemoney from recharge a left join agent b on "&_
	"a.username=b.username where b.company not in (select top "&(page-1)*rows&" b.company from recharge a left join agent b on "&_
	" a.username=b.username where 1=1 "&str1&str2&str3&" group by b.company order by b.company) "&str1&str2&str3&" group by b.company order by b.company"
	end if
	rsUser.Open sql,conn,0,1
	SET jObj=NEW simpleJson
	SET r=jObj.DataBind2(rsUser,rowCount,"rechargemoney")
	Response.Write r.parseString()
%>