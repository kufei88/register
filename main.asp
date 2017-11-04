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
		response.write(" <script>alert('"&ErrorMessage&"');location.href='adminLogin.html' </script>")
		response.end
	else
	  session("admin") = request("userid")
	  session("password") = request("pwd")
	end if
  end if
  username = session("admin")
  password = session("password")
  if username = "" then
    response.write(" <script>location.href='adminLogin.html' </script>")
	response.end
  else
	  set rsUser = server.CreateObject("adodb.recordset")
	  dim encode,aes
	  set aes = new aes_class
	  encode = aes.CipherStrToHexStr (128,password , "abcdefgh12345678")
		sql = "select UserName from admin where username='" & username & "' and password='" & encode & "'"
		rsUser.Open sql,conn,1,1
		
		if rsUser.BOF and rsUser.EOF then
		  ErrorMessage = "用户名密码错误"
		  response.write(" <script>alert('"&ErrorMessage&"');location.href='adminLogin.html' </script>")
		  response.end
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
									
									{"menuid":"14","menuname":"用户管理","icon":"icon-role","url":"agentManager.asp"},
									{"menuid":"15","menuname":"软件定价","icon":"icon-tip","url":"softPrice.asp"},
									{"menuid":"16","menuname":"折扣标准","icon":"icon-log","url":"discountList.asp"},
									{"menuid":"17","menuname":"系统设置","icon":"icon-set","url":"setting.asp"},
									{"menuid":"18","menuname":"发空狗","icon":"icon-lock","url":"deliver.asp"},
									{"menuid":"19","menuname":"充值","icon":"icon-doller","url":"recharge.asp"},
									{"menuid":"20","menuname":"注册","icon":"icon-doller","url":"mainRegister.asp"},
									{"menuid":"13","menuname":"余额调整","icon":"icon-doller","url":"moneyChange.asp"},
									{"menuid":"12","menuname":"APP注册信息","icon":"icon-nav","url":"appRegister.asp"},
									{"menuid":"11","menuname":"客服管理","icon":"icon-set","url":"mainagentQQ.asp"}
								    ]},
						{"menuid":"8","icon":"icon-sys","menuname":"查询",
							"menus":[{"menuid":"21","menuname":"充值查询","icon":"icon-nav","url":"rechargeQuery.asp"},
									{"menuid":"22","menuname":"注册查询","icon":"icon-nav","url":"mainRegisterQuery.asp"},
									{"menuid":"23","menuname":"加密狗到期查询","icon":"icon-nav","url":"mainDogExpire.asp"},
									{"menuid":"24","menuname":"买空狗查询","icon":"icon-nav","url":"buyDogQuery.asp"},
									{"menuid":"25","menuname":"对账单","icon":"icon-nav","url":"recon.asp"},
									{"menuid":"26","menuname":"客户远程信息","icon":"icon-nav","url":"clientRemoteInformation.asp"},
									{"menuid":"27","menuname":"试用版注册查询","icon":"icon-nav","url":"trailQuery.asp"}
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

            $.post('/ajax/editpassword.ashx?newpass=' + $newpass.val(), function(msg) {
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
                        location.href = 'adminLogin.html';
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
        line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体"> <span style="float:right; padding-right:20px;" class="head">欢迎 管理员 
		 <a href="#" id="loginOut">安全退出</a></span> <span style="padding-left:10px; font-size: 16px; "><img src="images/blocks.gif" width="20" height="20" align="absmiddle" />济胜软件续费系统</span> </div>
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
          <h1 style="font-size:24px;">欢迎使用济胜售后服务系统</h1>
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