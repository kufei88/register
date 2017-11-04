<% Session.CodePage=65001 %>
<% Response.Charset="UTF-8" %>
<!--#include file="conn.asp"-->
<%
	newversion = request("newversion")
	newnumber = request("newnumber")
	oldversion = request("oldversion")
	oldnumber = request("oldnumber")
	username = request("client")
	dognumber = request("dogCode")
	
	'response.write newversion
	'response.write oldversion
	
	set rsUser = server.CreateObject("adodb.recordset")
	sql = "select * from doginfo where dognumber='"&mid(dognumber,1,5)&"'"
	rsUser.open sql,conn,0,1
	result = 0
	if rsUser.BOF and rsUser.EOF then
	  
	else
	  checkversion = rsUser("priceversion")
	  checknumber = rsUser("number") 
	  if (checkversion = oldversion) and (CDbl(checknumber) = CDbl(oldnumber)) then
		result = 0
	  else
	    result = 1
	  end if
	end if
	
	rsUser.close
	if result = 0 then
		sql = "select (case when convert(datetime,convert(char(4),year(getdate()))+'-'+memvalue)>getdate() "_
		&"then convert(char(4),year(getdate())-1)+'-'+memvalue else convert(char(4),year(getdate()))+'-'+memvalue end) begindate  from mem where memvar='每年开始时间'"
		rsUser.Open sql,conn,0,1
		begindate = rsUser("begindate")
		
		rsUser.close
		sql = "select convert(char(10),isnull(begindate,'2016-01-01'),120) as begindate from agent where username='"&username&"'"
		rsUser.Open sql,conn,0,1
		begindate1 = rsUser("begindate")
		rsUser.close
		if begindate1 > begindate then
		  begindate = begindate1
		end if 
		sql = "select round((datediff(month,'"&begindate&"',getdate())-1)/memvalue+0.500001,0)*taskmoney as musttaskmoney,taskmoney"_
		&" from mem a,agent b where memvar='每期月数' and username='"&username&"'"
		rsUser.Open sql,conn,0,1
		taskmoney1 = rsUser("taskmoney")
		musttaskmoney = rsUser("musttaskmoney")
		rsUser.close
		sql = "select sum(rechargemoney) as rechargemoney from recharge where username='"&username&"' and rechargeDate>'"_
		&begindate&"' "
		rsUser.Open sql,conn,0,1
		rechargemoney = rsUser("rechargemoney")
		if rechargemoney >= musttaskmoney then
		  taskmoney = taskmoney1
		else
		  taskmoney = 0
		end if
		rsUser.close
		sql = "select (standardprice+siteprice*"&oldnumber-1&")*discount  as oldprice from softprice a left join discountlist b"_
		&" on a.softversion=b.softversion where a.softVersion='"&oldversion&"' and b.taskmoney="&taskmoney
		
		rsUser.Open sql,conn,0,1
		if rsUser.eof and rsUser.bof then
		  oldprice = 100
		else
		  oldprice = rsUser("oldprice")
		end if
		rsUser.close
		sql = "select (standardprice+siteprice*"&newnumber-1&")*discount  as newprice,convert(varchar(10),discount) as discount from softprice a left join discountlist b"_
		&" on a.softversion=b.softversion where a.softVersion='"&newversion&"' and b.taskmoney="&taskmoney
		
		rsUser.Open sql,conn,0,1
		if rsUser.eof and rsUser.bof then
		
		else
		  newprice = rsUser("newprice")
		  discount = rsUser("discount")
		end if
		rsUser.close
		'if oldprice > newprice then
		  'response.write "{""state"":3}"
		'else
		  sql = "select isnull(jsmoney,0) as jsmoney from agent where username='"&username&"'"
		  rsUser.Open sql,conn,0,1
		  if rsUser.eof and rsUser.bof then
		
		  else
		    jsmoney = rsUser("jsmoney")
		  end if
		  'if jsmoney - (newprice - oldprice) > -taskmoney/2 then
			response.write "{""state"":1,""money"":"&newprice - oldprice&",""discount"":"&discount&"}"
		  'else
		    'response.write "{""state"":4,""balance"":"&jsmoney - (newprice - oldprice)&",""jsmoney"":"&jsmoney&"}"
		  'end if
		'end if
	
	else
	  response.write "{""state"":2,""oldversion"":"""&checkversion&""",""oldnumber"":"&checknumber&",""oldversion"":"""&oldversion&""",""oldnumber"":"&oldnumber&"}"
	end if 
	
%>