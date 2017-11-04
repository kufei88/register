<!-- #include file="conn.asp" -->

<%
	dim year,month,dogprice,i
	year = request("year")
	month = request("month")
	dogprice = request("dogprice")
	
	sql = "delete mem"
	conn.execute(sql)
	sql = "insert into mem values ('每年开始时间','"&year&"')"
	conn.execute(sql)
	sql = "insert into mem values ('每期月数','"&month&"')"
	conn.execute(sql)
	sql = "delete monthSection"
	conn.execute(sql)
	for i=0 to 30
	  sql = "insert into monthSection (begindate,enddate,sectiondate) values (dateadd(month,"&i*month&",convert(datetime,convert(varchar(4),year(getdate()))+'-04-01'))"_
	  &",dateadd(month,"&(i+1)*month&",convert(datetime,convert(varchar(4),year(getdate()))+'-04-01'))-1,convert(varchar(10),dateadd(month,"&i*month&",convert(datetime,convert(varchar(4),year(getdate()))+'-04-01')),120))"
	  conn.execute(sql)
	next
	sql = "insert into mem values ('空狗价格','"&dogprice&"')"
	conn.execute(sql)
	response.write "success"
	
	
%>