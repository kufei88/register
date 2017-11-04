
<%
  username = session("username")
 
  if username = "" then
    response.write(" <script>top.location.href='agentLogin.html' </script>")
	response.end
  end if
%>