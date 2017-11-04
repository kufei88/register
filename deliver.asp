<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="validate.asp"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>发空狗</title>
	<meta charset="UTF-8">
        <title>发空狗</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	
	
	
        
        <table id="dg" title="发空狗" class="easyui-datagrid" style="width:900px;height:550px"
                url="getNotDeliver.asp"
                 
                rownumbers="true" fitColumns="true" singleSelect="true" >
            <thead>
                <tr>
				    <th field="company"  width="50">公司名称</th>
                    <th field="buydate" width="50">时间</th>
                    <th field="number" width="50">总数量</th>
					<th field="businessNumber" width="50">商务商业空狗</th>
                    <th field="industernumber" width="50">商务工业空狗</th>
					<th field="carnumber" width="50">汽修空狗</th>
					<th data-options="field:'_operate',width:80,align:'center',formatter:formatOper">操作</th>  
                </tr>
            </thead>
        </table>
        
        
        
        <script type="text/javascript">
            function formatOper(val,row,index){  
				return '<a href="#" class="easyui-linkbutton" onclick="editUser('+index+')">发货</a>';  
			}
			
			    function editUser(index){  
        $('#dg').datagrid('selectRow',index);// 关键在这里  
        var row = $('#dg').datagrid('getSelected');  
        if (row){  
            $.post('updateDeliver.asp?id=' + row.id, function(msg) {
                
                
                $('#dg').datagrid('reload');
            })
        }  
    }  
        </script>
        <style type="text/css">
            
        </style>
	
</body>
</html>