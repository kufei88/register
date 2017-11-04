<%

url = "http://service2.winic.org:8003/Service.asmx"  'webservice 地址

'==============================发送短信函数
function SendMessages(tos,msg)
uid = "13868980148"
pwd = "x068144"
SoapRequest="<?xml version="&CHR(34)&"1.0"&CHR(34)&" encoding="&CHR(34)&"utf-8"&CHR(34)&"?>"& _
"<soap:Envelope xmlns:xsi="&CHR(34)&"http://www.w3.org/2001/XMLSchema-instance"&CHR(34)&" "& _
"xmlns:xsd="&CHR(34)&"http://www.w3.org/2001/XMLSchema"&CHR(34)&" "& _
"xmlns:soap="&CHR(34)&"http://schemas.xmlsoap.org/soap/envelope/"&CHR(34)&">"& _
"<soap:Body>"& _
"<SendMessages xmlns="&CHR(34)&"http://tempuri.org/"&CHR(34)&">"& _
"<uid>"&uid&"</uid>"& _
"<pwd>"&pwd&"</pwd>"& _
"<tos>"&tos&"</tos>"& _
"<msg>"&msg&"</msg>"& _
"<otime>"&otime&"</otime>"& _
"</SendMessages>"& _
"</soap:Body>"& _
"</soap:Envelope>"

Set xmlhttp = server.CreateObject("Msxml2.XMLHTTP")
xmlhttp.Open "POST",url,false
xmlhttp.setRequestHeader "Content-Type", "text/xml;charset=utf-8"
xmlhttp.setRequestHeader "HOST","service2.winic.org"
xmlhttp.setRequestHeader "Content-Length",LEN(SoapRequest)
xmlhttp.setRequestHeader "SOAPAction", "http://tempuri.org/SendMessages" '一定要与WEBSERVICE的命名空间相同，否则服务会拒绝
xmlhttp.Send(SoapRequest)
''样就利用XMLHTTP成功发送了与SOAP示例所符的SOAP请求.'检测一下是否返回200=成功： 

    If xmlhttp.Status = 200 Then
        Set xmlDOC = server.CreateObject("MSXML.DOMDocument")
        xmlDOC.load(xmlhttp.responseXML)
            SendMessages=xmlDOC.documentElement.selectNodes("//SendMessagesResult")(0).text '显示节点为GetUserInfoResult的数据(返回字符串)
        Set xmlDOC = nothing
    Else
        SendMessages=xmlhttp.Status&"&nbsp;"
        SendMessages=xmlhttp.StatusText
    End if
        Set xmlhttp = Nothing
end function

%>