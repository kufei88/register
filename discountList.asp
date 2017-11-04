<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="validate.asp"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>折扣标准</title>
	<meta charset="UTF-8">
        <title>折扣标准</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
	
        
        <table id="dg" title="折扣标准" class="easyui-datagrid" style="width:700px;height:550px"
                url="getDiscount.asp"
                toolbar="#toolbar" 
                rownumbers="true" fitColumns="true" singleSelect="true" >
            <thead>
                <tr>
				    <th field="taskmoney"  width="50">认领任务</th>
                    <th field="softVersion" width="50">软件</th>
                    <th field="discount" width="50">折扣</th>
                   
                </tr>
            </thead>
        </table>
        <div id="toolbar">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除</a>
        </div>
        
        <div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
                closed="true" buttons="#dlg-buttons">
            <div class="ftitle">折扣标准</div>
            <form id="fm" method="post" novalidate>
				<div class="fitem">
                    <label>认领任务:</label>
                    <input name="taskmoney" class="easyui-numberbox"  required="true">
                </div>
                <div class="fitem">
                    <label>软件:</label>
                    <input name="softVersion"  class="easyui-combobox" id="softVersion"
					data-options="valueField:'softVersion',textField:'softVersion',url:'getSoftPrice.asp'"   required="true">
                </div>
                <div class="fitem">
                    <label>折扣:</label>
                    <input name="discount" class="easyui-numberbox" precision="3" required="true">
                </div>
                
            </form>
        </div>
        <div id="dlg-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()" style="width:90px">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
        </div>
        <script type="text/javascript">
            var url;
            function newUser(){
				
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','增加折扣标准');
                $('#fm').form('clear');
                url = 'addDiscount.asp';
            }
            function editUser(){
                var row = $('#dg').datagrid('getSelected');
                if (row){
					
					
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改折扣标准');
                    $('#fm').form('load',row);
                    url = 'updateDiscount.asp?oldtaskmoney='+row.taskmoney+'&oldsoftversion='+row.softVersion;
                }
            }
            function saveUser(){
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
                    $.messager.confirm('确认','是否确定要删除该折扣标准?',function(r){
                        if (r){
                            $.post('delDiscount.asp',{oldtaskmoney:row.taskmoney,oldsoftversion:row.softVersion},function(result){
                            	
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