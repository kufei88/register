<!-- #include file="json.asp" -->
<!--#include file="conn.asp"-->
<%
    '返回1: 传入的参数错误
    '返回2: 用户名或密码错误
    '否则返回客户信息
    dim UserName, Password, sql, ServerIP
	company = request("company")
	rows = request("rows")
	page = request("page")
    set rsUser = server.CreateObject("adodb.recordset")
    sqlcount = "select count(*) from jsphoneuuid a left join agent b on a.agent=b.username where b.company like '%"&_
	company&"%' or a.company like '%"&company&"%'"
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
	
    sql = "select top "&rows&" a.id,a.Company,a.[User],uuid,a.date,a.remark,b.company as agent,"&_
	"(case when isnull(version,0)=0 then '普通版' when isnull(version,0)=1 then '客户跟踪' else '增强版' end) as version,"&_
	"version as realversion,a.agent as realagent from "&_
	"jsphoneuuid a left join agent b on a.agent=b.username"&_
	" where (a.company like '%"&company&"%' or b.company like '%"&company&"%') and a.ID not in (select top "&((page-1)*rows)&_
	" a.id from jsphoneuuid a left join agent b on a.agent=b.username"&_
	" where (a.company like '%"&company&"%' or b.company like '%"&company&"%') order by a.id) order by a.id"
    
    rsUser.Open sql,conn,1,1
    SET jObj=NEW simpleJson
	SET r=jObj.DataBind(rsUser,rowCount)
	
	Response.Write r.parseString()
 %>