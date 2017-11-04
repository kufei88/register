<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="Validate.asp"-->
<!-- #include file="conn.asp" -->
<%
	dim company,jsmoney
	username = session("username")
	set rsUser = server.CreateObject("adodb.recordset")
	sql = "select company,jsmoney from agent where username='"&username&"'"
	rsUser.Open sql,conn,0,1
	if rsUser.BOF and rsUser.EOF then
	  
	else
	  company = rsUser("company")
	  jsmoney = rsUser("jsmoney")
	end if
	rsUser.close
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>充值</title>
	<meta charset="UTF-8">
        <title>充值</title>
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
    <div class="easyui-panel" title="充值" style="width:400px">
        <div style="padding:10px 60px 20px 60px">
        <form id="ff" method="post">
            <table cellpadding="5">
                <tr>
                    <td>公司名称:</td>
                    <td><input name="company"  class="easyui-combobox" id="company"
					data-options="valueField:'username',textField:'company',url:'getCompany.asp'"    required="true"></input></td>
					
                </tr>
                <tr>
                    <td>余额:</td>
                    <td><input class="easyui-numberbox" type="text" name="jsmoney" id="jsmoney" readonly  ></input></td>
                </tr>
                <tr>
                    <td>充值金额:</td>
                    <td><input class="easyui-numberbox" type="text" id="recharge" name="recharge" value="0"    data-options="required:true,min:1,max:100000"></input></td>
                </tr>
				<tr>
                    <td>备注:</td>
                    <td><input class="easyui-textbox" type="text" name="remark" id="remark" name="remark"     ></input></td>
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
		var money = $('#recharge').val();
		if (money !=''){
		$.messager.confirm('系统提示', '您确定要充值'+money+'吗?', function(r) {
			$.post('addRecharge.asp',{username:$('#company').combobox('getValue'),rechargemoney:$('#recharge').val(),
									remark:$('#remark').val()},
								function(result){
                            	
                                if (result == "success"){
                                    $.messager.show({    // show error message
                                        title: '提示',
                                        msg: '充值成功'
                                    });    // reload the user data
									$('#company').combobox('setValue','');
									$('#jsmoney').numberbox('setValue','');
									$('#recharge').numberbox('setValue','1');
									$('#remark').textbox('setValue','');
                                }
								else if (result == "not")
								{
									$.messager.show({    // show error message
                                        title: '错误',
                                        msg: '该公司不存在'
                                    });
								}
								else {
                                    $.messager.show({    // show error message
                                        title: '错误',
                                        msg: '充值出错'
                                    });
                                }
                            },'text');
		}
		);
		}
	}	
	
	$('#company').combobox({
	onSelect: function(record){
		$('#jsmoney').numberbox('setValue',record.jsmoney);
		
	}
});
	
	
	</script>
	
        
     
        
	
</body>
</html>