<!-- #include file="conn.asp" -->
<!--#include virtual="aes.asp"-->
<%
	company = request("Company")
	User = request("User")
	uuid = request("uuid")
	
	remark = request("remark")
	agent = session("username")
	version = request("version")
	
	
	sql = "select company from jsphoneuuid where company='" & company & "' and uuid='"&uuid&"'"
    set rsUser = server.CreateObject("adodb.recordset")
	rsUser.Open sql,conn,1,1
	if rsUser.BOF and rsUser.EOF then
	  
	  rsUser.close
	  sql = "select (case when convert(datetime,convert(char(4),year(getdate()))+'-'+memvalue)>getdate() "_
		&"then convert(char(4),year(getdate())-1)+'-'+memvalue else convert(char(4),year(getdate()))+'-'+memvalue end) begindate  from mem where memvar='每年开始时间'"
		
		rsUser.Open sql,conn,0,1
		begindate = rsUser("begindate")
		
		rsUser.close
		sql = "select convert(char(10),isnull(begindate,'2016-01-01'),120) as begindate,isnull(jsmoney,0) as jsmoney from agent where username='"&agent&"'"
		rsUser.Open sql,conn,0,1
		begindate1 = rsUser("begindate")
		jsmoney = rsUser("jsmoney")
		rsUser.close
		if begindate1 > begindate then
		  begindate = begindate1
		end if 
		sql = "select round((datediff(month,'"&begindate&"',getdate())-1)/memvalue+0.500001,0)*taskmoney as musttaskmoney,taskmoney"_
		&" from mem a,agent b where memvar='每期月数' and username='"&agent&"'"
		rsUser.Open sql,conn,0,1
		taskmoney1 = rsUser("taskmoney")
		musttaskmoney = rsUser("musttaskmoney")
		rsUser.close
		sql = "select sum(rechargemoney) as rechargemoney from recharge where username='"&agent&"' and rechargeDate>'"_
		&begindate&"' "
		rsUser.Open sql,conn,0,1
		rechargemoney = rsUser("rechargemoney")
		if rechargemoney >= musttaskmoney then
		  taskmoney = taskmoney1
		else
		  taskmoney = 0
		end if
		rsUser.close
		if version = 0 then
		  realVersion = "手机APP"
		elseif version = 1 then
		  realVersion = "客户跟踪"
		else
		  realVersion = "手机增强版"
		end if
		sql = "select standardprice*discount  as price,discount from softprice a left join discountlist b"_
		&" on a.softversion=b.softversion where a.softVersion='"&realVersion&"' and b.taskmoney="&taskmoney
		
		rsUser.Open sql,conn,0,1
		if rsUser.eof and rsUser.bof then
		  if version = 0 then
			  price = 450
		  elseif version = 1 then
			  price = 240
		  else
			  price = 600
		  end if
		  discount = 0.3
		else
		  price = rsUser("price")
		  discount = rsUser("discount")
		end if
		rsUser.close
		if jsmoney - price >= -taskmoney/2 then
		  	sql = "insert into  jsphoneuuid (company,[user],uuid,date,remark,agent,version) values ('"_
			&company&"','"&User&"','"&uuid&"',getdate(),'"&remark&"','"&agent&"',"&version&")"
			conn.execute(sql)
			sql = "update agent set jsmoney=isnull(jsmoney,0)-"&price&" where username='"&agent&"'"
			conn.execute(sql)
			sql = "insert registerhistory (username,registerDate,client,newVersion,discount,consumeJS,ip,JSMoney,memo)"&_
				" values ('"&agent&"',getdate(),'"&company&"','"&realVersion&"',"&discount&","&price&",'"&_
				getipadd()&"',"&(jsmoney - price)&",'"&remark&"')"
			
			conn.execute(sql)
		    response.write "success"
		else
		    response.write "notenough"
		end if
		
	  
	else
	  response.write "exists"
	end if
	
	function getipadd()
		ipadd=Request.ServerVariables("HTTP_X_FORWARDED_FOR")
		if ipadd= "" Then ipadd=Request.ServerVariables("REMOTE_ADDR")
		getipadd=ipadd
	end function
	
	
%>