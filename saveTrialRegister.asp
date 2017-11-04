<!-- #include file="conn.asp" -->
<!--#include virtual="aes.asp"-->

<%
    dim tempArr,tempstr
    code = request("code")
    useDay = request("useDay")
    clientName = request("clientName")
    username = session("username")
    set aes = new aes_class
    
    registerCode = aes.InvCipherHexStrToStr(128,code,"jishengsoft20170810")

    tempArr = Split(registerCode,",")
    
    if ubound(tempArr) <> 3 then
    
        response.write "codeerr"
        response.end
    end if
    if (useDay > 128) or (useDay < 1) then
        useDay = 128
    end if
    tempstr = aes.CipherStrToHexStr(128,tempArr(0)&","&useDay&","&tempArr(1),"jishengsoft20170817")
    sql = "insert into trial (username,clientName,macAddress,useDay,trialDate) values ('"&username&"','"&clientName&"','"&tempArr(0)&"-"&tempArr(3)&"',"&useDay&",getdate())"
    conn.execute(sql)
    response.write tempstr
    response.end
%>