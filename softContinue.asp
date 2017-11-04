<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include virtual="aes.asp"-->
<!--#include file="conn.asp"-->
<!--#include file="agentValidate.asp"-->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>软件续期</title>
<link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
	<script type="text/javascript" src="jquery/jquery.min.js"></script>   
	<script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		function submitForm(){
			//$("#hidden1").val("0");
			//document.form_aes.submit();
			var plainText = $.trim($('#plainText').val());
			if (!plainText){
				$.messager.alert({
                                title: '提示',
                                msg: '请填写请求码'
                            });
				return;
			}
			$.post('saveSoftContinue.asp',
			{aciton:0,plainText:plainText},
			function(r){
			
				if (r.result == "error"){
					$.messager.alert({
                                title: '提示',
                                msg: '请求码错误'
                            });
				}
				else if (r.result == "success"){
				//$('#newversion').textbox('setValue',priceversion);
					$('#lastdate').textbox('setValue',r.lastdate);
					$('#nowdate').textbox('setValue',r.nowdate);
					$('#state').combobox('setValue',r.sstate);
					$('#combine').combobox('setValue',r.scombine);
					$('#dog').val(r.dogCode);
				}
			},'json');
		}
		function clearForm(){
			//$("#hidden1").val("1");
			//document.form_aes.submit();
			var plainText = $.trim($('#plainText').val());
			if (!plainText){
				$.messager.alert({
                                title: '提示',
                                msg: '请填写请求码'
                            });
				return;
			}
			var client = $.trim($('#client').val());
			if (!client){
				$.messager.alert({
                                title: '提示',
                                msg: '请填写客户名称'
                            });
				return;
			}
			$.post('saveSoftContinue.asp',
			{aciton:1,combine:$('#combine').combobox('getValue'),state:$('#state').combobox('getValue'),
			lastdate:$('#lastdate').textbox('getValue'),nowdate:$('#nowdate').textbox('getValue'),
			dog:$('#dog').val(),client:$('#client').textbox('getValue')},
			function(r){
			
				if (r.result == "error"){
					$.messager.alert({
                                title: '提示',
                                msg: '请求码错误'
                            });
				}
				else if (r.result == "success"){
				//$('#newversion').textbox('setValue',priceversion);
					$('#encode').textbox('setValue',r.encode);
					
				}
			},'json');
		}
	</script>
</head>

<body>
<div class="easyui-panel" title="软件续期" style="width:1000px;height:300px">
<div style="padding:30px 60px 20px 60px">
<form name="form_aes" id="ff" method="post" action="" >
<input type="hidden" name = "hidden1" id="hidden1" value="12333" />
<input type="hidden" name = "dog" id="dog"  />
<table width="842" border="0">
  <tr>
    
  </tr>
  <tr>
    <td width="200" align="right">服务请求码:</td>
    <td width="535"><input class="easyui-textbox" name="plainText" size="80"  id="plainText" ></td>
    <td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search"   onclick="submitForm()">请求</a></td>
  </tr>
  <tr>
    <td width="200" align="right">上次日期:</td>
    <td><input name="lastdate" class="easyui-textbox"  id="lastdate" readonly="true" style="width:200px;" ></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">本次日期:</td>
    <td><input name="nowdate" class="easyui-textbox" type="text" readonly="true" id="nowdate" style="width:200px;"  ></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td width="200" align="right">服务到期后处理:</td>
    <td><select class="easyui-combobox" id="state" style=""width:200px;"" ><option value="0" selected>提醒</option><option value="1" >停止使用</option></select>
	</td>
    
  </tr>
  <tr>
    <td width="200" align="right">控制连接电脑:</td>
    <td><select class="easyui-combobox" id="combine" style=""width:200px;"" ><option value="0" selected>不控制</option><option value="1" >控制</option></select>
	</td>
    
  </tr>
  <tr>
    <td width="200" align="right">客户名称:</td>
    <td>
	  <input class="easyui-textbox"  size="80"  id="client"  >
	</td>
    
  </tr>
  <tr>
    <td width="200" align="right">服务码:</td>
    <td>
	  <input class="easyui-textbox" name="encode" size="80"  id="encode" readonly="true" >
	</td>
    <td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="clearForm()">生成</a></td>
  </tr>
  
</table>
</form>
</div>
	
</body>
</html>

