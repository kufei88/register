<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="validate.asp"-->
<!-- #include file="conn.asp" -->
<%
	dim year,month,dogprice
	set rsUser = server.CreateObject("adodb.recordset")
	sql = "select memvalue from mem where memvar='每年开始时间'"
	rsUser.Open sql,conn,0,1
	if rsUser.BOF and rsUser.EOF then
	  year = "04-01"
	else
		year = rsUser("memvalue")
	end if
	rsUser.close
	sql = "select memvalue from mem where memvar='每期月数'"
	rsUser.Open sql,conn,0,1
	if rsUser.BOF and rsUser.EOF then
	  month = "4"
	else
	  month = rsUser("memvalue")
	end if
	rsUser.close
	sql = "select memvalue from mem where memvar='空狗价格'"
	rsUser.Open sql,conn,0,1
	if rsUser.BOF and rsUser.EOF then
	  dogprice = "100"
	else
	  dogprice = rsUser("memvalue")
	end if
	rsUser.close
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>系统设置</title>
	<meta charset="UTF-8">
        <title>系统设置</title>
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
    <div class="easyui-panel" title="系统设置" style="width:400px">
        <div style="padding:10px 60px 20px 60px">
        <form id="ff" method="post">
            <table cellpadding="5">
                <tr>
                    <td>每年开始计算日期:</td>
                    <td><input class="easyui-textbox" type="text" name="year" value=<%=year%> data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>每期月数:</td>
                    <td><input class="easyui-numberbox" type="text" name="month" value=<%=month%> data-options="required:true"></input></td>
                </tr>
                <tr>
                    <td>空狗价格:</td>
                    <td><input class="easyui-numberbox" type="text" name="dogprice" value=<%=dogprice%>  data-options="required:true"></input></td>
                </tr>
                
            </table>
        </form>
        <div style="text-align:center;padding:5px">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitForm()">确定</a>
            
        </div>
        </div>
    </div>
	<script type="text/javascript">
		function submitForm(){
                $('#ff').form('submit',{
                    url: 'saveSetting.asp',
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
                           $.messager.show({
                                title: '提示',
                                msg: '保存成功'
                            });
                        }
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
			
			function destroyUser(){
                var row = $('#dg').datagrid('getSelected');
                if (row){
                    $.messager.confirm('确认','是否确定要删除该手机号?',function(r){
                        if (r){
                            $.post('delNumber.asp',{old:row.number},function(result){
                            	
                                if (result == "success"){
                                    $('#dg').datagrid('reload');    // reload the user data
                                } else {
                                    $.messager.show({    // show error message
                                        title: '错误',
                                        msg: '删除出错'
                                    });
                                }
                            },'text');
                        }
                    });
                }
				
            }
	</script>
	<div style="margin:20px 0;"></div>
	
		
		<table id="dg" title="提醒手机号码" class="easyui-datagrid" style="width:400px;height:250px"
                url="getNumber.asp"
                toolbar="#toolbar" 
                rownumbers="true" fitColumns="true" singleSelect="true" >
            <thead>
                <tr>
				    <th field="number"  width="50">手机号码</th>
                    
                   
                </tr>
            </thead>
        </table>
        <div id="toolbar">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
 
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除</a>
        </div>
		
		<div id="dlg" class="easyui-dialog" style="width:400px;height:180px;padding:10px 20px"
                closed="true" buttons="#dlg-buttons">
            <div class="ftitle">提醒号码</div>
            <form id="fm" method="post" novalidate>
				<div class="fitem">
                    <label>手机号:</label>
                    <input name="number"  class="easyui-numberbox"  data-options="required:true">
                </div>
                
                
            </form>
        </div>
        <div id="dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="save()" style="width:90px">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
        </div>
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