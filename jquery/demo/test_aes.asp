<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include virtual="aes.asp"-->
<%
dim aes, s, key, Result, CipherText, KeySize, sKeySize
set aes = new aes_class
action = Request.Form("action")

s = Request.Form("plainText")
key = "12345678abcdefgh"
KeySize = 128
select case KeySize
	case 256 sKeySize = "<input type=""radio"" name=""KeySize"" value=""128"">128λ(16�ַ�����)  <input type=""radio"" name=""KeySize"" value=""192"">192λ(24�ַ�����)  <input name=""KeySize"" type=""radio"" value=""256"" checked>256λ(32�ַ�����)"
	case 192 sKeySize = "<input type=""radio"" name=""KeySize"" value=""128"">128λ(16�ַ�����)  <input type=""radio"" name=""KeySize"" value=""192"" checked>192λ(24�ַ�����)  <input name=""KeySize"" type=""radio"" value=""256"">256λ(32�ַ�����)"
	case else
		sKeySize = "<input type=""radio"" name=""KeySize"" value=""128"" checked>128λ(16�ַ�����)  <input type=""radio"" name=""KeySize"" value=""192"">192λ(24�ַ�����)  <input name=""KeySize"" type=""radio"" value=""256"" >256λ(32�ַ�����)"
end select
CipherText = aes.CipherStrToHexStr(KeySize, s, key)
Result = aes.InvCipherHexStrToStr(KeySize, CipherText, key)
lastdate = CipherText
nowdate = Result
if isnull(s) or s = "" then 
	CipherText = ""
	Result = ""
	lastdate = ""
	nowdate = ""
end if
Response.Write action
if action = "0" then
  lastdate = "0000"

elseif action = "1" then
  lastdate = "1111"
end if
's = "�������ģ����ܿ�����"
'key = "ABCDEFGHIJKLMNOPQRSTUVWX"
'keysize = 192
'Response.Write("<BR>����<BR>")
'Response.Write(S)
'Response.Write("<BR>����<BR>")
'Response.Write(aes.CipherStrToHexStr (keysize, s, key))
'Response.Write("<BR>�����ַ���<BR>")
'Response.Write(aes.InvCipherHexStrToStr(keysize, aes.CipherStrToHexStr (keysize, s, key), key))
'Response.Write("<BR>����ʮ�������ַ���<BR>")
'Response.Write(aes.InvCipherHexStrToHexStr(keysize, aes.CipherStrToHexStr (keysize, s, key), key))
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�������</title>
<link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
	<script type="text/javascript" src="jquery/jquery.min.js"></script>   
	<script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		function submitForm(){
			document.form_aes.action="your add method url";
			document.form_aes.submit();
		}
		function clearForm(){
			document.form_aes.action="your add method url2";
			document.form_aes.submit();
		}
	</script>
</head>

<body>
<div class="easyui-panel" title="�������" style="width:1000px;height:300px">
<div style="padding:30px 60px 20px 60px">
<form name="form_aes" id="ff" method="post" >
<table width="842" border="0">
  
  <tr>
    <td width="200" align="right">����������1:</td>
    <td width="535"><input class="easyui-textbox" name="plainText" size="80"  id="plainText"></td>
    <td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">����</a></td>
  </tr>
  <tr>
    <td width="200" align="right">�ϴ�����:</td>
    <td><input name="lastdate" class="easyui-textbox"  id="lastdate" readonly="true" style="width:200px;" value="<%=lastdate%>"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">��������:</td>
    <td><input name="nowdate" class="easyui-textbox" type="text" readonly="true" id="nowdate" style="width:200px;"  value="<%=nowdate%>"></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td width="200" align="right">�����ں���:</td>
    <td><select class="easyui-combobox" name="state" style="width:200px;">
			<option value="0">����</option>
			<option value="1">ֹͣʹ��</option>
		</select>
	</td>
    
  </tr>
  <tr>
    <td width="200" align="right">�������ӵ���:</td>
    <td><select class="easyui-combobox" name="combine" style="width:200px;">
			<option value="0">������</option>
			<option value="1">����</option>
		</select>
	</td>
    
  </tr>
  <tr>
    <td width="200" align="right">������:</td>
    <td>
	  <input class="easyui-textbox" name="plainText" size="80"  id="plainText">
	</td>
    <td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">����</a></td>
  </tr>
  
</table>
</form>
</div>
	
</body>
</html>
