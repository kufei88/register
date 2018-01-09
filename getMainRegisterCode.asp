<!--#include virtual="aes.asp"-->
<!-- #include file="conn.asp" -->
<!-- #include file="sms_post.asp" -->
<%
	dim aes
	key = "asdfgh1357924680"
	KeySize = 128
	
	set aes = new aes_class
	dogCode = request("dogCode")
	newversioncode = request("newversioncode")
	newnumber = request("newnumber")
	clinet = request("client")
	oldversion= request("oldversion")
	newversion= request("newversion")
	oldnumber= request("oldnumber")
	registerCharge= request("registerCharge")
	discount= request("discount")
	username = request("username")
	remark = request("remark")
	state = request("state")
	set rsUser = server.CreateObject("adodb.recordset")
	sql = "select isnull(jsmoney,0) as jsmoney,company,number from agent where username='"&username&"'"
	rsUser.open sql,conn,0,1
	jsmoney = rsUser("jsmoney")
	company = rsUser("company")
	number = rsUser("number")

	registerCode = aes.CipherStrToHexStr(keysize,dogCode&newversioncode&newnumber&"JZSOFT55",key)
	'response.write registerCode&"..."
	if state = 0 then
		registerCode = mid(registercode,1,4)&mid(registercode,33,4)&mid(registercode,44,4)&mid(registercode,50,4)
	else
		registerCode = mid(registercode,1,4)&mid(registercode,33,4)&mid(registercode,40,4)&mid(registercode,46,4)
	end if
	sql = "insert into registerhistory (username,registerdate,dognumber,client,oldversion,newversion,discount,consumeJS,ip,oldnumber,newnumber,registerCode,jsmoney,memo)"_
		&" values ('"&username&"',getdate(),'"&mid(dogCode,1,5)&"','"&clinet&"','"&oldversion&"','"_
		&newversion&"',"&discount&","&registerCharge&",'"&getipadd()&"',"&oldnumber&","&newnumber&",'"&registerCode&"',"&jsmoney-registerCharge&",'"&remark&"')"
	
	conn.execute(sql)
	sql = "select * from doginfo where dognumber='"&mid(dogCode,1,5)&"'"
	rsUser.close
	rsUser.Open sql,conn,0,1
	if rsUser.BOF and rsUser.EOF then
	  sql = "insert into doginfo  values ('"&mid(dogCode,1,5)&"','"&newversion&"',"&newnumber&",'"&username&"','"&clinet&"')"
	  conn.execute(sql)
	else
	  sql = "update doginfo set priceversion='"&newversion&"',number="&newnumber&" where dognumber='"&mid(dogCode,1,5)&"'"
	  conn.execute(sql)
	end if
	sql = "update agent set jsmoney=jsmoney-"&registerCharge&" where username='"&username&"'"
	conn.execute(sql)
	
	rsuser.close
	'sql = "select * from agent where username='"&username&"'"
	'rsUser.Open sql,conn,0,1
	'company = rsuser("company")
	'rsUser.close
	sql = "select * from alertnumber "
	rsUser.Open sql,conn,0,1
	Do While Not rsUser.EOF
    mobiles = mobiles & rsUser("number") &","
	rsUser.MoveNext
	Loop 
	rsUser.Close
	sendresult = SendMessages(mobiles&number,company&"注册软件,老版本:"&oldversion&oldnumber&";新版本:"&newversion&newnumber&";费用:"&registerCharge)
	
	
	'response.write dogCode&newversioncode&newnumber&"JZSOFT55"
	response.write registerCode
	'response.write mobiles&number

	function getipadd()
		ipadd=Request.ServerVariables("HTTP_X_FORWARDED_FOR")
		if ipadd= "" Then ipadd=Request.ServerVariables("REMOTE_ADDR")
		getipadd=ipadd
	end function
%>