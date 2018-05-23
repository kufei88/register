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
    sqlcount = "select count(*) from ClientInformation where company like '%"&company&"%'"
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
	
    sql = "select top "&rows&" ClientID,Company,UserName,Password,ServerIP,domain,domain1,remark from ClientInformation "&_
	" where company like '%"&company&"%' and ClientID not in (select top "&((page-1)*rows)&_
	" clientid from clientinformation where company like '%"&company&"%' order by clientid) order by clientid"
    
    rsUser.Open sql,conn,1,1
    SET jObj=NEW simpleJson
	SET r=jObj.DataBind(rsUser,rowCount)
	
	Response.Write r.parseString()
 %>