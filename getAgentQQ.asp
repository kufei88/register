<!-- #include file="json.asp" -->
<!--#include file="conn.asp"-->
<%
    '返回1: 传入的参数错误
    '返回2: 用户名或密码错误
    '否则返回客户信息
    dim UserName, Password, sql, ServerIP
	
	rows = request("rows")
	page = request("page")
	username = session("username")
    set rsUser = server.CreateObject("adodb.recordset")
    sqlcount = "select count(*) from agentQQ where username='"&username&"' "
	set rs1=conn.execute(sqlcount)
	rowCount=rs1(0)
	
    sql = "select * from agentQQ where username='"&username&"' "
    
    rsUser.Open sql,conn,1,1
    SET jObj=NEW simpleJson
	SET r=jObj.DataBind(rsUser,rowCount)
	
	Response.Write r.parseString()
 %>