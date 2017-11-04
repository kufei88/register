<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="agentValidate.asp"-->



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>购买空狗</title>
	<meta charset="UTF-8">
        <title>购买空狗</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
        <div style="margin:20px 0;"></div>
    <div class="easyui-panel" title="购买空狗" style="width:400px">
        <div style="padding:10px 60px 20px 60px">
        <form id="ff" method="post">
            <table cellpadding="5">
				<tr>
					<th>类型</th>
					<th>数量</th>
				</tr>
                <tr>
                    <td>商务商业空狗:</td>
                    <td><input class="easyui-numberbox" id="businessNumber"  name="businessNumber" value="0" data-options="min:0,max:100,required:true"   ></input></td>
                </tr>
                <tr>
                    <td>商务工业空狗:</td>
                    <td><input class="easyui-numberbox" id="industryNumber"   name="industryNumber" value="0" data-options="min:0,max:100,required:true"   ></input></td>
                </tr>
				<tr>
                    <td>汽修空狗:</td>
                    <td><input class="easyui-numberbox" id="carNumber"   name="carNumber" value="0" data-options="min:0,max:100,required:true"   ></input></td>
                </tr>
				<tr>
                    <td>总数量:</td>
                    <td><input class="easyui-numberbox" id="total"   name="total" value="0" readonly   ></input></td>
                </tr>
            </table>
			<div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitForm()">购买</a>
            
        </div>
        </form>
        
        </div>
    </div>
	<script type="text/javascript">
		$(function () {
               bindevent();  
                
             });
		function bindevent(){
			$('#businessNumber').numberbox({onChange:function(newValue,oldValue){
				$('#total').numberbox('setValue', parseInt($('#businessNumber').val())+parseInt($('#industryNumber').val())
				+parseInt($('#carNumber').val())); 
			}});
			$('#industryNumber').numberbox({onChange:function(newValue,oldValue){
				$('#total').numberbox('setValue', parseInt($('#businessNumber').val())+parseInt($('#industryNumber').val())
				+parseInt($('#carNumber').val())); 
			}});
			$('#carNumber').numberbox({onChange:function(newValue,oldValue){
				$('#total').numberbox('setValue', parseInt($('#businessNumber').val())+parseInt($('#industryNumber').val())
				+parseInt($('#carNumber').val())); 
			}});
		}
		
		function submitForm(){
		if ($('#total').val() == '0'){
			$.messager.show({
                                title: '错误',
                                msg: '数量不能为0'
                            });
			return;
		}
		$.messager.confirm('系统提示', '您确定要购买吗?', function(r) {

                    if (r) {
                       $('#ff').form('submit',{
                    url: 'saveBuyDog.asp',
                    onSubmit: function(){
                        return $(this).form('validate');
                    },
                    success: function(result){
                        //var result = eval('('+result+')');
                        
                        if (result=="exists"){
                            $.messager.show({
                                title: '提示',
                                msg: '该折扣标准已存在'
                            });
                        }
                        else if (result == "failed"){
                        	$.messager.show({
                                title: '错误',
                                msg: '保存出错'
                            });
                        }
						else if (result == "back"){
                        	$.messager.show({
                                title: '错误',
                                msg: '余额不足'
                            });
                        }
                         else {
                           $.messager.show({
                                title: '提示',
                                msg: '购买成功'
                            });
							$('#total').numberbox('setValue',0);
							$('#businessNumber').numberbox('setValue',0);
							$('#industryNumber').numberbox('setValue',0);
							$('#carNumber').numberbox('setValue',0);
                        }
                    }
                });
                    }
                });
                
            }
		var url;
		function newUser(){
			
			$('#dlg').dialog('open').dialog('center').dialog('setTitle','增加手机号码');
			$('#fm').form('clear');
			url = 'addNumber.asp';
		}
		function save(){
                $('#fm').form('submit',{
                    url: url,
                    onSubmit: function(){
                        return $(this).form('validate');
                    },
                    success: function(result){
                        //var result = eval('('+result+')');
                        
                        if (result=="exists"){
                            $.messager.show({
                                title: '提示',
                                msg: '该折扣标准已存在'
                            });
                        }
                        else if (result == "failed"){
                        	$.messager.show({
                                title: '错误',
                                msg: '保存出错'
                            });
                        }
                         else {
                            $('#dlg').dialog('close');        // close the dialog
                            $('#dg').datagrid('reload');    // reload the user data
                        }
                    }
                });
            }
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