<!--#include virtual="aes.asp"-->
<%
	dim aes
	key = "13579asdfgh24680"
	KeySize = 128
	registerCode = request("registerCode")
	set aes = new aes_class
	if len(registerCode) = 64 then
		Result = aes.InvCipherHexStrToStr(KeySize, registerCode, key)
		
		mystr = split(Result,",") 
		dogCode = mystr(0)
		priceVersion = mystr(1)
		number = mystr(2)
		oldPriceVersion = mystr(3)
		oldNumber = mystr(4)
		response.write "{""dogCode"":"""&dogCode&""",""priceVersion"":"&priceVersion&",""number"":"&number&",""oldPriceVersion"":"&oldPriceVersion&",""oldNumber"":"&oldNumber&"}"
	else
	  response.write "error"
	end if
%>