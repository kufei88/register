<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="agentValidate.asp"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>客服管理</title>
	<meta charset="UTF-8">
        <title>客服管理</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
	
        
        <table id="dg" title="客服管理" class="easyui-datagrid" style="width:100%;height:550px"
                url="getAgentQQ.asp"
                toolbar="#toolbar" 
                rownumbers="true" fitColumns="true" singleSelect="true"  showfooter="true" >
            <thead>
                <tr>
				    <th field="qqname"  width="50">客服名称</th>
                    <th field="qq" width="50">qq号码</th>
                    <th field="id" width="10">序号</th>
                </tr>
            </thead>
        </table>
        <div id="toolbar">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
            
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除</a>
        </div>
        
        <div id="dlg" class="easyui-dialog" style="width:400px;height:380px;padding:10px 20px"
                closed="true" buttons="#dlg-buttons">
            <div class="ftitle">客服信息</div>
            <form id="fm" method="post" novalidate>
				<div class="fitem">
                    <label>客服名称:</label>
                    <input name="qqname" id="qqname" class="easyui-textbox" required="true">
                </div>
                <div class="fitem">
                    <label>qq号码:</label>
                    <input name="qq" id="qq" class="easyui-textbox" required="true">
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
				
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','增加客服');
                $('#fm').form('clear');
                url = 'addAgentQQ.asp';
            }
            function editUser(){
                var row = $('#dg').datagrid('getSelected');
				//alert(row.begindate);
                if (row){
					$('#username1').textbox('readonly',true);
					
                    $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改客服');
                    $('#fm').form('load',row);
				//	$('#bd').datebox('setValue',row.begindate);
                    url = 'updateAgentQQ.asp?old='+row.username;
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
                                msg: '该客服已存在'
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
                    $.messager.confirm('确认','是否确定要删除该客服?',function(r){
                        if (r){
                            $.post('delAgentQQ.asp',{id:row.id},function(result){
                            	
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