<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="validate.asp"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>代理商管理</title>
	<meta charset="UTF-8">
        <title>代理商管理</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
	
        
        <table id="dg" title="代理商管理" class="easyui-datagrid" style="width:100%;height:550px"
                url="getAgent.asp"
                toolbar="#toolbar" 
                rownumbers="true" fitColumns="true" singleSelect="true"  showfooter="true" >
            <thead>
                <tr>
				    <th field="company"  width="50">公司名称</th>
                    <th field="username" width="50">用户名</th>
                    <th field="password" width="50">密码</th>
					<th field="number" width="50">手机号</th>
                    <th field="jsmoney" width="50">结余济胜币</th>
					<th field="taskmoney" width="50">认领任务</th>
					<th field="begindate" width="50">起始日期</th>
                </tr>
            </thead>
        </table>
        <div id="toolbar">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除</a>
        </div>
        
        <div id="dlg" class="easyui-dialog" style="width:400px;height:380px;padding:10px 20px"
                closed="true" buttons="#dlg-buttons">
            <div class="ftitle">用户信息</div>
            <form id="fm" method="post" novalidate>
				<div class="fitem">
                    <label>公司名称:</label>
                    <input name="company" class="easyui-textbox" required="true">
                </div>
                <div class="fitem">
                    <label>用户名:</label>
                    <input name="username" id="username1" class="easyui-textbox" required="true">
                </div>
				
                <div class="fitem">
                    <label>密码:</label>
                    <input name="password" class="easyui-textbox" type="password">
                </div>
				<div class="fitem">
                    <label>手机号:</label>
                    <input name="number" class="easyui-numberbox"  required="true">
                </div>
                
				<div class="fitem">
                    <label>认领任务:</label>
                    <input name="taskmoney" class="easyui-combobox" data-options="
						valueField: 'label',
						textField: 'value',
						editable:false,
						data: [{
							label: '0',
							value: '0'
						},{
							label: '2500',
							value: '2500'
						},{
							label: '5000',
							value: '5000'
						}]"  required="true">
                </div>
				<div class="fitem">
                    <label>起始日期:</label>
                    <input name="begindate" id="bd" class="easyui-datebox"  required="true" >
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
				$('#username1').textbox('readonly',false);
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','增加用户');
                $('#fm').form('clear');
                url = 'addAgent.asp';
            }
            function editUser(){
                var row = $('#dg').datagrid('getSelected');
				//alert(row.begindate);
                if (row){
					$('#username1').textbox('readonly',true);
					
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改用户');
                    $('#fm').form('load',row);
				//	$('#bd').datebox('setValue',row.begindate);
                    url = 'updateAgent.asp?old='+row.username;
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
                                msg: '该用户已存在'
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
                    $.messager.confirm('确认','是否确定要删除该用户?',function(r){
                        if (r){
                            $.post('delAgent.asp',{old:row.username},function(result){
                            	
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
			/*		$('#dg').datagrid({
			rowStyler: function(index,row){
				if (index % 2 == 0){
					return 'background-color:#6293BB;color:#fff;';
				}
			}
		}); */
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