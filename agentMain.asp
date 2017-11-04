<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!-- #include file="conn.asp" -->
<!--#include virtual="aes.asp"-->
<%
  iscode = request("isCode")
  if iscode = "1" then
    if trim(session("firstecode")) <> trim(Request("VerifyCode")) then
		ErrorMessage = "请输入正确的验证码"
		response.write(" <script>alert('"&ErrorMessage&"');location.href='agentLogin.html' </script>")
		response.end
	else
	  session("username") = request("userid")
	  session("password") = request("pwd")
	end if
  end if
  username = session("username")
  password = session("password")
  if username = "" then
    response.write(" <script>location.href='agentLogin.html' </script>")
	response.end
  else
	  set rsUser = server.CreateObject("adodb.recordset")
	  dim encode,aes
	  set aes = new aes_class
	  encode = aes.CipherStrToHexStr (128,password , "abcdefgh12345678")
		sql = "select UserName,company from agent where username='" & username & "' and password='" & encode & "'"
		rsUser.Open sql,conn,1,1
		
		if rsUser.BOF and rsUser.EOF then
		  ErrorMessage = "用户名密码错误"
		  response.write(" <script>alert('"&ErrorMessage&"');location.href='agentLogin.html' </script>")
		  response.end
		else
		  company = rsUser("company")
		end if
  end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>济胜软件续费系统</title>
    <link href="css/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css" />
    <script type="text/javascript" src="jquery/jquery.min.js"></script>
    <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jquery/outlook2.js"> </script>
	<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
	
	 var _menus = {
		                 "menus":[
						           {"menuid":"1","icon":"icon-sys","menuname":"功能",
							      "menus":[
									{"menuid":"12","menuname":"软件续期","icon":"icon-page","url":"softContinue.asp"},
									{"menuid":"13","menuname":"软件注册","icon":"icon-class","url":"register.asp"},
									
									{"menuid":"15","menuname":"购买空狗","icon":"icon-dog","url":"buyDog.asp"},
									{"menuid":"16","menuname":"APP注册管理","icon":"icon-set","url":"agentAppRegister.asp"},
									{"menuid":"17","menuname":"客服管理","icon":"icon-set","url":"agentQQ.asp"},
                                    {"menuid":"18","menuname":"软件试用","icon":"icon-set","url":"trialRegister.asp"}
								    ]},
						{"menuid":"8","icon":"icon-sys","menuname":"查询",
							"menus":[{"menuid":"21","menuname":"注册记录查询","icon":"icon-nav","url":"RegisterQuery.asp"},
									{"menuid":"22","menuname":"余额查询","icon":"icon-nav","url":"personalInformation.asp"},
									{"menuid":"23","menuname":"软件到期查询","icon":"icon-nav","url":"softContinueQuery.asp"}
								]
						}
				]};
        //设置登录窗口
        function openPwd() {
            $('#w').window({
                title: '修改密码',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 160,
                resizable:false
            });
        }
        //关闭登录窗口
        function closePwd() {
            $('#w').window('close');
        }

        

        //修改密码
        function serverLogin() {
            var $newpass = $('#txtNewPass');
            var $rePass = $('#txtRePass');

            if ($newpass.val() == '') {
                msgShow('系统提示', '请输入密码！', 'warning');
                return false;
            }
            if ($rePass.val() == '') {
                msgShow('系统提示', '请在一次输入密码！', 'warning');
                return false;
            }

            if ($newpass.val() != $rePass.val()) {
                msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
                return false;
            }

            $.post('updatePwd.asp?newpass=' + $newpass.val(), function(msg) {
                msgShow('系统提示', '恭喜，密码修改成功！<br>您的新密码为：' + msg, 'info');
                $newpass.val('');
                $rePass.val('');
                close();
            })
            
        }

        $(function() {

            openPwd();

            $('#editpass').click(function() {
                $('#w').window('open');
            });

            $('#btnEp').click(function() {
                serverLogin();
            })

			$('#btnCancel').click(function(){closePwd();})

            $('#loginOut').click(function() {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {

                    if (r) {
                        location.href = 'agentLogin.html';
                    }
                });
            })
        });
		
		
    </script>
    </head>
    <body class="easyui-layout" style="overflow-y: hidden"  scroll="no">
<noscript>
    <div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;"> <img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' /> </div>
    </noscript>
<div region="north" split="true" border="false" style="overflow: hidden; height: 30px;
        background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%;
        line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体"> <span style="float:right; padding-right:20px;" class="head">欢迎 <%=company%> <a href="#" id="editpass">修改密码</a> <a href="#" id="loginOut">安全退出</a></span> <span style="padding-left:10px; font-size: 16px; "><img src="images/blocks.gif" width="20" height="20" align="absmiddle" />济胜软件续费系统</span> </div>
<div region="south" split="true" style="height: 30px; background: #D2E0F2; ">
      <div class="footer">版权所有，翻版必究</div>
    </div>
<div region="west" hide="true" split="true" title="导航菜单" style="width:180px;" id="west">
      <div id="nav" class="easyui-accordion" fit="true" border="false"> 
    <!--  导航内容 --> 
    
  </div>
    </div>
<div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
      <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
    <div title="欢迎使用" style="padding:20px;overflow:hidden; color:red; " >
          <h1 style="font-size:24px;">欢迎使用济胜软件续费系统</h1>
        </div>
  </div>
    </div>


<!--修改密码窗口-->
<div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save"  style="width: 300px; height: 150px; padding: 5px;
        background: #fafafa;">
      <div class="easyui-layout" fit="true">
    <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
          <table cellpadding=3>
        <tr>
              <td>新密码：</td>
              <td><input id="txtNewPass" type="Password" class="txt01" /></td>
            </tr>
        <tr>
              <td>确认密码：</td>
              <td><input id="txtRePass" type="Password" class="txt01" /></td>
            </tr>
      </table>
        </div>
    <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;"> <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" > 确定</a> <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a> </div>
  </div>
    </div>
<div id="mm" class="easyui-menu" style="width:150px;">
      <div id="mm-tabupdate">刷新</div>
      <div class="menu-sep"></div>
      <div id="mm-tabclose">关闭</div>
      <div id="mm-tabcloseall">全部关闭</div>
      <div id="mm-tabcloseother">除此之外全部关闭</div>
      <div class="menu-sep"></div>
      <div id="mm-tabcloseright">当前页右侧全部关闭</div>
      <div id="mm-tabcloseleft">当前页左侧全部关闭</div>
      <div class="menu-sep"></div>
      <div id="mm-exit">退出</div>
    </div>
</body>
</html>