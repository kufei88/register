
<%
  username = session("admin")
 
  if username = "" then
    response.write(" <script>top.location.href='adminLogin.html' </script>")
	response.end
  end if
%>