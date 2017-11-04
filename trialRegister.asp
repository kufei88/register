<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="agentValidate.asp"-->



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>软件试用注册</title>
	<meta charset="UTF-8">
        <title>软件试用注册</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="js/clipboard.js"></script>
	<style>
		
	</style>
</head>
<body>
	
	
        <div style="margin:20px 0;"></div>
    <div class="easyui-panel" title="软件试用注册" style="width:1000px">
        <div style="padding:10px 60px 20px 60px">
        <form id="ff" method="post">
            <table cellpadding="5">
               
                <tr>
                    <td>注册码:</td>
                    <td><input class="easyui-textbox" type="text" name="code" id="code" data-options="required:true" value="" style="width:600px"></input>
					
					</td>
                </tr>
                <tr>
                    <td>试用天数(不能超过180天):</td>
                    <td><input class="easyui-numberbox" type="text" name="useDay" id="useDay" value="180"></input></td>
                </tr>
                <tr>
                    <td>客户名称</td>
                    <td><input class="easyui-textbox" type="text" name="clientName" id="clientName" ></input></td>
                </tr>
				<tr>
                    <td>验证码:</td>
                    <td>
						<input   name="registercode" id="registercode" readonly  style="width:500px;" ></input>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" id="verify">生成</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-cut'" id="copy" data-clipboard-target="#registercode">复制</a>
					</td>
                </tr>
				
				
            </table>
			<input id="newversionhidden" type="hidden" />
        </form>
        
        </div>
    </div>
	<script type="text/javascript">
        $(function(){
			var btn = document.getElementById('copy');
			var clipboard = new Clipboard(btn);//实例化
			$('#copy').click(function(){
				
			})
            $('#verify').click(function(){
                if(!$('#code').val()){
                    $.messager.show({
                        style:{
                            right:'',
                            top:document.body.scrollTop+document.documentElement.scrollTop,
                            bottom:''
                        },
                        title:'提示',
                        msg:'请输入注册码',
                        showType:'show'
                    });
                    return;
                }
                $.ajax({
                    url:'saveTrialRegister.asp',
                    data:{
                        code:$('#code').val(),
                        useDay:$('#useDay').val(),
                        clientName:$('#clientName').val()
                    },
                    type:'post',
                    success:function(data){
                        if(data == 'codeerr'){
                            $.messager.show({
                                style:{
                                    right:'',
                                    top:document.body.scrollTop+document.documentElement.scrollTop,
                                    bottom:''
                                },
                                title:'提示',
                                msg:'注册码错误',
                                showType:'show'
                            });
                            return;
                        }
                        else{
                            console.log(data);
                            $('#registercode').val(data);
                        }
                    }
                })
            })
        })
		
		
	</script>
	
    <style type="text/css">
            #fm{
                margin:0;
                padding:10px 30px;
            }
            .ftitle{
                font-size:14px;
                font-weight:bold;
                padding:5px 0;
                margin-bottom:10px;
                border-bottom:1px solid #ccc;
            }
            .fitem{
                margin-bottom:5px;
            }
            .fitem label{
                display:inline-block;
                width:80px;
            }
            .fitem input{
                width:160px;
            }
        </style>    
        
	
</body>
</html>