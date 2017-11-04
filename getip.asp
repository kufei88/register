<%
	response.write getipadd()
	
	function getipadd()
		ipadd=Request.ServerVariables("HTTP_X_FORWARDED_FOR")
		if ipadd= "" Then ipadd=Request.ServerVariables("REMOTE_ADDR")
		getipadd=ipadd
	end function
%>