<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="validate.asp"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>APP注册管理</title>
	<meta charset="UTF-8">
        <title>APP注册管理</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
	
        
        <table id="dg" title="APP注册管理" class="easyui-datagrid" style="width:100%;height:550px"
                url="getAppRegister.asp"
                toolbar="#toolbar" 
                rownumbers="true" fitColumns="true" singleSelect="true" pagination="true">
            <thead>
                <tr>
				    <th field="Company"  width="50">公司名称</th>
                    <th field="User" width="50">用户名</th>
                    
					<th field="uuid" width="100">注册码</th>
                    <th field="date" width="50">日期</th>
					<th field="version" width="50">版本</th>
					<th field="remark" width="50">备注</th>
					<th field="agent" width="50">代理商</th>
                </tr>
            </thead>
        </table>
        <div id="toolbar">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除</a>
			&nbsp;&nbsp;&nbsp;公司名称:&nbsp;&nbsp;&nbsp;<input name="client"  class="easyui-textbox" id="client"
					></input>
			
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searcha()">查询</a>
        </div>
          
        <div id="dlg" class="easyui-dialog" style="width:800px;height:350px;padding:10px 20px"
                closed="true" buttons="#dlg-buttons">
            <div class="ftitle">APP注册信息</div>
            <form id="fm" method="post" novalidate>
				<div class="fitem">
                    <label>公司名称:</label>
                    <input name="Company" class="easyui-textbox" required="true">
                </div>
                <div class="fitem">
                    <label>用户名:</label>
                    <input name="User"  class="easyui-textbox" required="true">
                </div>
				
                
				<div class="fitem">
                    <label>注册码:</label>
                    <input name="uuid" class="easyui-textbox"  required="true" style="width:400px">
                </div>
				<div class="fitem">
					<label>版本:</label>
					<input name="version" class="easyui-combobox" data-options="
						valueField: 'value',
						textField: 'label',
						editable:false,
						data: [{
							label: '普通版',
							value: '0'
						},{
							label: '客户跟踪',
							value: '1'
						},{
							label: '增强版',
							value: '2'
						}]"  required="true">
				</div>
                <div class="fitem">
                    <label>备注:</label>
                    <input name="remark" class="easyui-textbox"  >
                </div>
				<div class="fitem">
					<label>代理商</label>
					<input name="agent"  class="easyui-combobox" id="agent"
					data-options="valueField:'username',textField:'company',url:'getCompany.asp'"></input>
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
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','增加APP注册');
                $('#fm').form('clear');
                url = 'addAPPRegister.asp';
            }
            function editUser(){
                var row = $('#dg').datagrid('getSelected');
				//alert(row.begindate);
                if (row){
					$('#username1').textbox('readonly',true);
					
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改APP注册');
                    $('#fm').form('load',row);
				//	$('#bd').datebox('setValue',row.begindate);
                    url = 'updateAppRegister.asp?old='+row.id;
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
                                msg: '该信息已存在'
                            });
                        }
                        else if (result == "failed"){
                        	$.messager.show({
                                title: '错误',
                                msg: '保存出错'
                            });
                        }
						else if (result == "fault"){
                        	$.messager.show({
                                title: '错误',
                                msg: '不能由高版本改为低版本'
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
                    $.messager.confirm('确认','是否确定要删除该注册信息?',function(r){
                        if (r){
                            $.post('delAppRegister.asp',{old:row.id},function(result){
                            	
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
		function searcha(){
			
            	$('#dg').datagrid('reload',{  
            company:$('#client').textbox('getValue')}  
            ); 
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