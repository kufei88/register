<!-- #include file="json.asp" -->
<!--#include file="conn.asp"-->
<%
    '返回1: 传入的参数错误
    '返回2: 用户名或密码错误
    '否则返回客户信息
    dim UserName, Password, sql, ServerIP
	
	
	dognumber = request("dognumber")
    set rsUser = server.CreateObject("adodb.recordset")
    
	sql = "select username from doginfo where dognumber="&dognumber
	
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  username = "admin"
	else
	  username = rsUser("username")
	end if
	
	rsUser.close
    sql = "select * from agentQQ where username='"&username&"' "
    
    rsUser.Open sql,conn,1,1
    SET jObj=NEW simpleJson
	SET r=jObj.DataBind(rsUser,1)
	
	Response.Write r.parseString()
 %>