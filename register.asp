<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CodePage=65001%>
<%Response.Charset="utf-8"%>
<!--#include file="agentValidate.asp"-->



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>软件注册</title>
	<meta charset="UTF-8">
        <title>软件注册</title>
        <link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
        <link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
        <link rel="stylesheet" type="text/css" href="jquery/demo/demo.css">
        <script type="text/javascript" src="jquery/jquery.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="jquery/locale/easyui-lang-zh_CN.js"></script>
	<style>
		
	</style>
</head>
<body>
	
	
        <div style="margin:20px 0;"></div>
    <div class="easyui-panel" title="软件注册" style="width:800px">
        <div style="padding:10px 60px 20px 60px">
        <form id="ff" method="post">
            <table cellpadding="5">
                <tr>
                    <td>软件:</td>
                    <td><select class="easyui-combobox" id="state" name="state" style="width:300px;">
						        <option value="0">商务</option>
								<option value="1">汽修</option>
								
					</select></td>
                </tr>
                <tr>
                    <td>注册码:</td>
                    <td><input class="easyui-textbox" type="text" name="code" id="code" data-options="required:true" value="" style="width:500px"></input>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="getCode()">获取</a>
					</td>
                </tr>
                <tr>
                    <td>加密狗号:</td>
                    <td><input class="easyui-numberbox"  name="dognumber" id="dognumber" readonly  style="width:300px;"></input>
					  <input   type="hidden" id="dognumber1" ></input>
					</td>
                </tr>
                <tr>
                    <td>客户:</td>
                    <td><input class="easyui-textbox"  name="client"  id="client"   style="width:300px; "></input></td>
                </tr>
                <tr>
                    <td>备注:</td>
                    <td><input class="easyui-textbox"  name="remark"  id="remark"  style="width:300px;"></input></td>
                </tr>
				<tr>
                    <td>老软件:</td>
                    <td><input class="easyui-textbox"  name="oldversion" id="oldversion" readonly  style="width:135px;" ></input> 
					站点:<input class="easyui-textbox"  name="oldnumber" id="oldnumber" readonly   style="width:130px;"></td>
                </tr>
				<tr>
                    <td>新软件:</td>
                    <td><input class="easyui-textbox"  name="newversion" id="newversion" readonly   style="width:135px;"></input>
					站点:<input class="easyui-textbox"  name="newnumber" id="newnumber" readonly   style="width:130px;"></td>
                </tr>
				<tr>
                    <td>注册码:</td>
                    <td>
						<input class="easyui-textbox"  name="registercode" id="registercode" readonly  style="width:300px;" ></input>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="getRegisterCode()">生成</a>(将此注册码复制到软件的注册界面)
					</td>
                </tr>
				
				<tr>
					<td></td>
					<td>
						<input type="hidden"  name="registerCharge" id="registerCharge"  />
						<input type="hidden"   name="discount" id="discount"   />
					</td>
				</tr>
            </table>
			<input id="newversionhidden" type="hidden" />
        </form>
        
        </div>
    </div>
	<script type="text/javascript">
	function getCode(){
	    
		$.post('getDecode.asp?registerCode=' + $('#code').val(), function(msg) {
				var priceversion,oldpriceversion;
				var state = $('#state').combobox('getValue');
				//alert(state);
				if (msg == 'error')
				{
					alert('注册码错误');
				}
				else{
					var s = msg.dogCode;
					
					$('#dognumber').numberbox('setValue',s.substr(0,5));
					$('#dognumber1').val(s);
					$('#newversionhidden').val(msg.priceVersion);
					switch(msg.priceVersion){
						case 0:
							priceversion = state==0?'商业经典版':'汽车美容';
							break;
						case 1:
							priceversion = state==0?'商业标准版':'汽车美容(多店面)';
							break;
						case 2:
							priceversion = state==0?'商业增强版':'一站式(多店面)';
							break;
						case 3:
							priceversion = '商业全能版';
							break;
						case 4:
							priceversion = '工业经典版';
							break;
						case 5:
							priceversion = state==0?'工业标准版':'汽修';
							break;
						case 6:
							priceversion = '工业增强版';
							break;
						case 7:
							priceversion = state==0?'工业全能版':'一站式';
							break;
						case 8:
						    priceversion = '汽修(多店面)';
							break;
						default :
						    priceversion = msg.priceVersion;
					};
					
					$('#newversion').textbox('setValue',priceversion);
					$('#newnumber').textbox('setValue',msg.number);
					
					
					switch(msg.oldPriceVersion){
						case 0:
							oldpriceversion = '空';
							break;
						case 6:
							oldpriceversion =state==0? '商业经典版':'汽车美容';
							break;
						case 2:
							oldpriceversion = state==0?'商业标准版':'汽车美容(多店面)';
							break;
						case 1:
							oldpriceversion = state==0?'商业增强版':'一站式(多店面)';
							break;
						case 5:
							oldpriceversion = '商业全能版';
							break;
						case 9:
							oldpriceversion = '工业经典版';
							break;
						case 8:
							oldpriceversion = state==0?'工业标准版':'汽修';
							break;
						case 7:
							oldpriceversion = '工业增强版';
							break;
						case 4:
							oldpriceversion = state==0?'工业全能版':'一站式';
							break;
						case 3:
							oldpriceversion = '汽修(多店面)';
							break;
						default :
						    oldpriceversion = msg.oldPriceVersion;
					};
					
					$('#oldversion').textbox('setValue',oldpriceversion);
					$('#oldnumber').textbox('setValue',msg.oldNumber);
				}
                
            },'json')
                
		}
		function getRegisterCode(){
		
		if (($('#newversion').val()==$('#oldversion').val()) && ($('#oldnumber').val()==$('#newnumber').val())){
			            $.messager.show({
				style:{
                    right:'',
                    top:document.body.scrollTop+document.documentElement.scrollTop,
                    bottom:''
                },
                title:'提示',
                msg:'本次注册软件没有变化',
                showType:'show'
            });
			return;
		}
		
		if ($('#client').val().length > 25){
			 $.messager.show({
				style:{
                    right:'',
                    top:document.body.scrollTop+document.documentElement.scrollTop,
                    bottom:''
                },
                title:'提示',
                msg:'客户太长',
                showType:'show'
            });
			return;
		}
		
		$.post('getRegisterMoney.asp',{oldversion:$('#oldversion').val()
			,newnumber:$('#newnumber').val(),oldnumber:$('#oldnumber').val(),dogCode:$('#dognumber1').val(),newversion:$('#newversion').val()},
			function(msg){
					
					if (msg.state == 3)
					{
						$.messager.show({
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:''
							},
							title:'提示',
							msg:'注册版本不可低于老版本',
							showType:'show'
						});
					}
					else if (msg.state == 4){
						$.messager.show({
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:''
							},
							title:'提示',
							msg:'余额不足，请先联系济胜软件充值',
							showType:'show'
						}); 
					} 
					else if (msg.state == 2){
						$.messager.show({
							style:{
								right:'',
								top:document.body.scrollTop+document.documentElement.scrollTop,
								bottom:''
							},
							title:'提示',
							msg:'注册的老版本跟登记不符',
							showType:'show'
						}); 
					} 
					else{
					var message = '';
					if (msg.taskmoney == 0){
						message = '充值没有达到任务量,本次注册将按普通代理折扣,是否确认注册？';
					}
					else{
						message = '是否确认注册?';
					}
					$.messager.confirm('确认',message,function(r){
                        if (r){
							$('#registerCharge').val(msg.money);
							$('#discount').val(msg.discount);
                            $.post('getRegisterCode.asp',{dogCode:$('#dognumber1').val(),newversioncode:$('#newversionhidden').val(),newnumber:$('#newnumber').val(),
							client:$('#client').val(),remark:$('#remark').val(),oldversion:$('#oldversion').val(),newversion:$('#newversion').val(),
							oldnumber:$('#oldnumber').val(),registerCharge:$('#registerCharge').val(),
							discount:$('#discount').val(),state:$('#state').combobox('getValue')},
								function(msg){
									
									$('#registercode').textbox('setValue',msg);
								});
							}
                        });
                    } 
				},'json'
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