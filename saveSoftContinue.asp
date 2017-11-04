<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include virtual="aes.asp"-->
<!--#include file="conn.asp"-->
<!--#include file="agentValidate.asp"-->
<%



'-----对 post 表 单值的过滤.
'if request.form<>"" then
'Chk_badword=split(Form_Badword,"‖")
'FOR EACH form_name IN Request.Form
'for i=0 to ubound(Chk_badword)
'If Instr(LCase(request.form(form_name)),Chk_badword(i))<>0 Then
'Select Case Err_Message
'Case "1"
'Response.Write "<Script Language=JavaScript>alert('出错了！表单 "&form_name&" 的值中包含非法字符串！\n\n请不要在表单中出现： % & * # ( ) 等非法字符！');window.close();</Script>"
'Case "2"
'Response.Write "<Script Language=JavaScript>location.href='"&Err_Web&"'</Script>"
'Case "3"
'Response.Write "<Script Language=JavaScript>alert('出错了！参数 "&form_name&"的值中包含非法字符串！\n\n请不要在表单中出现： % & * # ( ) 等非法字符！');location.href='"&Err_Web&"';</Script>"
'End Select
'Response.End
'End If
'NEXT
'NEXT
'end if


dim aes, s, key, Result, CipherText, KeySize, sKeySize,sstate,scombine
action = request("aciton")

set aes = new aes_class
sstate = "0"
scombine = "0"

s = request("plainText")

key = "12345678abcdefgh"
enkey = "abcdefgh12345678"
KeySize = 128
'sstate = "<select class=""easyui-combobox"" name=""state"" style=""width:200px;"" ><option value=""0"" selected>提醒</option><option value=""1"" >停止使用</option></select>"
'scombine = "<select class=""easyui-combobox"" name=""combine"" style=""width:200px;"" ><option value=""0"" selected>不控制</option><option value=""1"" >控制</option></select>"
if action = 0 then
  if (len(s) = 128) or (len(s) = 160) then
	  Result = aes.InvCipherHexStrToStr(KeySize, s, key)
	  if (len(Result) > 30) and (len(Result) < 35) then
	      dogCode = mid(Result,1,5)
		  lastdate = mid(Result,7,10)
		  nowdate = mid(Result,18,10)
		  combine = mid(Result,29,1)
		  if combine = "1" then
		    sstate = "1"
		  end if
		  deal = mid(Result,31,1)
		  if deal = "1" then
		    scombine = "1"
		  end if
		  response.write "{""result"":""success"",""lastdate"":"""&lastdate&""",""nowdate"":"""_
		  &nowdate&""",""sstate"":"""&sstate&""",""scombine"":"""&scombine&""",""dogCode"":"""&dogCode&"""}"
	   else
		 response.write "{""result"":""error""}"  
	  end if
   else 
     response.write "{""result"":""error""}" 
   end if
  
elseif action = 1 then
  combine = request("combine")
  deal = request("state")
  lastdate = request("lastdate")
  nowdate = request("nowdate")
  dogCode= request("dog")
  client = request("client")
  username = session("username")
  encode = aes.CipherStrToHexStr (keysize,dogCode+","+nowdate+","+combine+","+deal , enkey)
  set rsUser = server.CreateObject("adodb.recordset")
  sql = "select 1 from softContinue where dogcode='"&dogCode&"'"
  rsUser.open sql,conn,0,1
  if rsUser.BOF and rsUser.EOF then
	conn.execute("insert into softContinue (dogcode,client,state,combine,agent,enddate) values ('"_
	&dogCode&"','"&client&"',"&deal&","&combine&",'"&username&"','"&nowdate&"')")
	
  else
    
	conn.execute("update softContinue set client='"&client&"',state="&deal&",combine="&combine&",agent='"_
	&username&"',enddate='"&nowdate&"' where dogcode='"&dogCode&"'")
  end if
  
  response.write "{""result"":""success"",""encode"":"""&encode&"""}" 
  'encode = aes.InvCipherHexStrToStr(KeySize, encode, key)
end if





's = "我是明文，都能看到吧"
'key = "ABCDEFGHIJKLMNOPQRSTUVWX"
'keysize = 192
'Response.Write("<BR>明文<BR>")
'Response.Write(S)
'Response.Write("<BR>密文<BR>")
'Response.Write(aes.CipherStrToHexStr (keysize, s, key))
'Response.Write("<BR>解密字符串<BR>")
'Response.Write(aes.InvCipherHexStrToStr(keysize, aes.CipherStrToHexStr (keysize, s, key), key))
'Response.Write("<BR>解密十六进制字符串<BR>")
'Response.Write(aes.InvCipherHexStrToHexStr(keysize, aes.CipherStrToHexStr (keysize, s, key), key))
%>