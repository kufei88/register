<%
'Database类

Class Class_OpenWBS_DB
	Private Pv_SystemPath,Pv_Rs,Pv_ii
	Private Pv_FieldPre
	Private s_pageParam, s_pageSpName
	Private i_QueryType, i_errNumber, i_pageIndex, i_pageSize, i_pageCount, i_recordCount, i_SqlQueryNum, i_ShowSQL, Pv_SetSqlQueryNumCount
	Private Conn, o_pageDic
	Private S_DB_Type, S_DB_Server, S_DB_Port, S_DB_Name, S_DB_Username, S_DB_Password
	
	Private Sub Class_Initialize()
		
		i_QueryType = 0
		i_ShowSQL   = 0
		Pv_SetSqlQueryNumCount = True '统计查询记录数量
		Pv_FieldPre = "c_"'自定义字段前缀
	End Sub
	
	Private Sub Class_Terminate()
		On Error Resume Next
		If LCase(TypeName(Conn)) = "connection" Then
			If Conn.State = 1 Then Conn.Close()
			Set Conn = Nothing
		End If
		Err.Clear()
	End Sub
	
	Public Property Let DB_Type(ByVal Str)
		Str = UCase(Trim(Cstr(Str)))
		Select Case Str
			Case "0","ACCESS" : S_DB_Type = "ACCESS"
			Case "1","MSSQL"  : S_DB_Type = "MSSQL"
			Case "2","MYSQL"  : S_DB_Type = "MYSQL"
			Case "3","ORACLE" : S_DB_Type = "ORACLE"
		End Select
	End Property
	
	Public Property Get SystemPath()
		SystemPath = Pv_SystemPath
	End Property
	Public Property Let SystemPath(ByVal BV_Path)
		Pv_SystemPath = BV_Path
	End Property
	
	Public Property Get DB_Type()
		DB_Type=S_DB_Type
	End Property
	
	Public Property Let DB_Server(ByVal Str)
		S_DB_Server=Str
	End Property
	Public Property Get DB_Server()
		DB_Server=S_DB_Server
	End Property
	
	Public Property Let DB_Port(ByVal Str)
		S_DB_Port=Str
	End Property
	Public Property Get DB_Port()
		DB_Port=S_DB_Port
	End Property
	
	Public Property Let DB_Name(ByVal Str)
		S_DB_Name=Str
	End Property
	Public Property Get DB_Name()
		DB_Name=S_DB_Name
	End Property
	
	Public Property Let DB_Username(ByVal Str)
		S_DB_Username=Str
	End Property
	Public Property Get DB_Username()
		DB_Username=S_DB_Username
	End Property
	
	Public Property Let DB_Password(ByVal Str)
		S_DB_Password=Str
	End Property
	Public Property Get DB_Password()
		DB_Password=S_DB_Password
	End Property
	
	Public Property Let SqlQueryNum(ByVal Str)
		i_SqlQueryNum=Str
	End Property
	Public Property Get SqlQueryNum()
		If i_SqlQueryNum &""="" Then i_SqlQueryNum=0
		SqlQueryNum=i_SqlQueryNum
	End Property
	
	Public Property Let ShowSQL(ByVal Str)
		i_ShowSQL=Str
	End Property
	Public Property Get ShowSQL()
		ShowSQL=i_ShowSQL
	End Property
	
	Public Property Get FieldPre()
		FieldPre=Pv_FieldPre
	End Property

	'设置用ADO获取记录集的方式，此属性为只写. 为0或"recordset"时，ADO用ADODB.RecordSet方式获取记录集; 为1或"command"时，ADO用ADODB.Command方式获取记录集
	Public Property Let QueryType(ByVal Str)
		Str = Lcase(Str)
		If Str = "1" or Str = "command" Then
			i_QueryType = 1
		Else
			i_QueryType = 0
		End If
	End Property
	
	'连接数据库
	Public Function ConnectionDatabase()
		CreatConn S_DB_Type, S_DB_Server&":"&S_DB_Port, S_DB_Name, S_DB_Username, S_DB_Password
	End Function
	
	'根据 数据库连接字符串 建立数据库连接对象
	Public Function OpenConn(ByVal ConnStr)
		On Error Resume Next
		If TypeName(Conn) = "Connection" Then Exit Function
		Dim objConn
		Set objConn = Server.CreateObject("ADODB.Connection")
		objConn.Open ConnStr
		
		If Err.Number <> 0 Then
			OpenWBS.Error.Msg = "OpenWBS.DB.OpenConn: Error!"'ConnStr
			OpenWBS.Error.Raise 21
			Err.Clear
			objConn.Close
			Set objConn = Nothing
		End If
		Set Conn = objConn
	End Function
	
	'生成数据库连接字符串
	Public Function CreatConn(ByVal Str_DBType, ByVal Str_DBServer, ByVal Str_Database, ByVal Str_Username, ByVal Str_Password)
		Dim ConnStr,Port
		S_DB_Type = UCase(Cstr(Str_DBType))
		Str_DBServer = Trim(Cstr(Str_DBServer))
		If InStr(Str_DBServer,":") > 0 then
			Port = Trim(Mid(Str_DBServer,InStr(Str_DBServer,":")+1))
			Str_DBServer = Left(Str_DBServer,InStr(Str_DBServer,":")-1)
		End If
		Str_Database = Trim(Cstr(Str_Database))
		Str_Username = Trim(Cstr(Str_Username))
		Str_Password = Trim(Cstr(Str_Password))
		Select Case S_DB_Type
			Case "0","ACCESS"
				If OpenWBS.Data.IsNul(Str_Password) Then
					ConnStr = "Provider = Microsoft.Jet.OLEdb.4.0;Data Source="& Server.MapPath(Pv_SystemPath & Str_DBServer)
					
				Else
					ConnStr = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source="& Server.MapPath(Pv_SystemPath & Str_DBServer) &";Jet OLEDB:Database Password="& Str_Password &";"
				End If
			Case "1","MSSQL" '若 User Id 等于零长度字符串，则使用 Windows 验证。
				If Not(OpenWBS.Data.IsNul(Port)) Then Str_DBServer = Str_DBServer &","& Port
				If OpenWBS.Data.IsNul(Str_Username) Then
					ConnStr = "Provider=SQLOLEDB;Data Source="& Str_DBServer &";Initial Catalog="& Str_Database &";Integrated Security=SSPI;"
				Else
					ConnStr = "Provider=SQLOLEDB;Data Source="& Str_DBServer &";Initial Catalog="& Str_Database &";User Id="& Str_Username &";Password="& Str_Password &";"
				End If
				
			Case "2","MYSQL"
				If OpenWBS.Data.IsNul(Port) Then Port = "3306"
				ConnStr = "Driver={mySQL};Server="& Str_DBServer &";Port="& Port &";Option=131072;Stmt=;Database="& Str_Database& ";Uid="& Str_Username &";Pwd="& Str_Password &";"
				
			Case "3","ORACLE"
				ConnStr = "Provider=msdaora;Data Source="& Str_DBServer & ";User Id="& Str_Username &";Password="& Str_Password &";"
		End Select
		'echo ConnStr
		'Set CreatConn = OpenConn(ConnStr)
		OpenConn(ConnStr)
	End Function
	
	'执行指定的SQL语句
	Public Function Execute(ByVal Command)
		Command=Trim(Command)
		If TypeName(Conn) <> "Connection" then ConnectionDatabase
		If UCase(Left(Command,6)) = "SELECT" Then
		   '返回记录集
			Dim Fn_i : Fn_i   = i_QueryType
			i_QueryType = 1
			Set Execute = GetRecordBySQL(Command)
			i_QueryType = Fn_i
		Else
		   '返回 1 or 0
			On Error Resume Next
			Execute = 1
			Dim Fn_cmd : Set Fn_cmd = Server.CreateObject("ADODB.Command")
			With Fn_cmd
				 Fn_cmd.ActiveConnection = Conn
				 Fn_cmd.CommandText = Command
				 Fn_cmd.Execute
			End With
			Set Fn_cmd = Nothing
			If Pv_SetSqlQueryNumCount Then i_SqlQueryNum = i_SqlQueryNum + 1
			If i_ShowSQL Then Echo "<br>"& Command &"<br>"
			If Err.Number <> 0 Then
			  Execute = 0
			  OpenWBS.Error.Msg = "OpenWBS.DB.Execute: "&Command
			  OpenWBS.Error.Raise 23
			  Err.Clear
			End If
		End If
	End Function
	
	'GetRecord(Table[:TopNum][:FieldsList], Condition, OtherCondition)
	'取得符合条件的纪录集
	Public Function GetRecord(ByVal DB_Table, ByVal Condition, ByVal OtherCondition)
		Dim TempSQL : TempSQL=wGetRecordSQL(DB_Table,Condition,OtherCondition)
		Set GetRecord=GetRecordBySQL(TempSQL)
	End Function
	Public Function wGetRecordSQL(ByVal DB_Table, ByVal Condition, ByVal OtherCondition)
		If Left(DB_Table,1)="[" Then
			DB_Table=Trim(Mid(DB_Table,2,Len(DB_Table-2)))
		End If
		Dim TableName,ArrTable,ArrFields,FieldsList,ShowNum,TmpCondition,Fn_SQL
		    ShowNum=0
			ArrTable = OpenWBS.Param(DB_Table)
		    TableName = Trim(ArrTable(0))
		If Not(OpenWBS.Data.IsNul(ArrTable(1))) Then
			ArrFields=OpenWBS.Param(ArrTable(1))
			If OpenWBS.Data.IsNum(ArrFields(0)) Then
				ShowNum = ArrFields(0)
			Else
				FieldsList=Trim(ArrFields(0))
			End If
			If Not(OpenWBS.Data.IsNul(ArrFields(1))) Then
				FieldsList=Trim(ArrFields(1))
			End If
		End If
		If IsArray(Condition) Then
			TmpCondition=ValueToSql(1,TableName,Condition)
		Else
			TmpCondition=Condition
		End If
		Fn_SQL="SELECT "
		If ShowNum > 0 then Fn_SQL = Fn_SQL & "TOP "& ShowNum &" "
		Fn_SQL = Fn_SQL & OpenWBS.IIF(FieldsList <> "", FieldsList, "*") & " FROM ["& TableName &"] "
		If Trim(TmpCondition) <> "" Then Fn_SQL = Fn_SQL & "WHERE " & TmpCondition &" "
		If Trim(OtherCondition) <> "" Then Fn_SQL = Fn_SQL & OtherCondition
		wGetRecordSQL=Fn_SQL
	End Function
	
	'根据SQL语句获取记录集
	Public Function GetRecordBySQL(ByVal SQLString)
		On Error Resume Next
		If TypeName(Conn) <> "Connection" then ConnectionDatabase
		If i_ShowSQL Then Echo "<br>"& SQLString &"<br>"
		If i_QueryType = 1 Then
			Dim Fn_cmd : Set Fn_cmd = Server.CreateObject("ADODB.Command")
			With Fn_cmd
				Fn_cmd.ActiveConnection = Conn
				Fn_cmd.CommandText = SQLString
				Set GetRecordBySQL = Fn_cmd.Execute
			End With
			Set Fn_cmd = Nothing
		Else
			Set Pv_Rs = Server.CreateObject("Adodb.Recordset")
			With Pv_Rs
				Pv_Rs.ActiveConnection = Conn
				Pv_Rs.CursorType = 1
				Pv_Rs.LockType = 1
				Pv_Rs.Source = SQLString
				Pv_Rs.Open
			End With
			Set GetRecordBySQL = Pv_Rs
			Set Pv_Rs = Nothing
		End If
		If Pv_SetSqlQueryNumCount Then i_SqlQueryNum = i_SqlQueryNum + 1
		If Err.number <> 0 Then
			OpenWBS.Error.Msg = "OpenWBS.DB.GetRecordBySQL: "& SQLString
			OpenWBS.Error.Raise 22
			Err.Clear
		End If
	End Function
	
	'OpenWBS.DB.AddRecord("OWBS_SysUser",Array("Username:"&Username,"Password:"&Password))
	'
	'往指定数据表中插入一条新的记录。ValueList 为 要插入表的字段和值，只能是数组且应遵循"数组参数约定(字段名:值)" 
	'如果要插入的字段为数字型但插入的值为空，则将把NULL值插入该字段。
	Public Function AddRecord(ByVal DB_Table, ByVal ValueList)
		On Error Resume Next
		Dim Fn_SQL : Fn_SQL = wAddRecordSQL(DB_Table,ValueList)
		'Echo Fn_SQL
		Execute(Fn_SQL)
		If Err.number <> 0 Then
			OpenWBS.Error.Msg = "OpenWBS.DB.AddRecord: " & Fn_SQL
			OpenWBS.Error.Raise 24
			Err.Clear
			AddRecord = 0
			Exit Function
		End If
		AddRecord = 1
	End Function
	Public Function wAddRecordSQL(ByVal DB_Table, ByVal ValueList)
		Dim TmpSQL, TmpFiled, TmpValue
		TmpFiled = ValueToSQL(2,DB_Table,ValueList)
		TmpValue = ValueToSQL(3,DB_Table,ValueList)
		TmpSQL = "INSERT INTO ["& DB_Table &"] ("& TmpFiled &") VALUES ("& TmpValue &")"
		wAddRecordSQL = TmpSQL
		'Die wAddRecordSQL
	End Function
	
	'OpenWBS.DB.DeleteRecord("OWBS_SysUser","Username='phenex' AND Degree < 5")
	'OpenWBS.DB.DeleteRecord("OWBS_SysUser",Array("Username:phenex","Password:OpenWBS","Recycle:null"))
	'删除指定条件的记录
	'Condition可以为字符串条件和数组条件
	Public Function DeleteRecord(ByVal DB_Table, ByVal Condition)
		On Error Resume Next
		Dim Fn_SQL : Fn_SQL = wDeleteRecordSQL(DB_Table,Condition)
		'Echo Fn_SQL
		Execute Fn_SQL
		If Err.number <> 0 Then
			DeleteRecord = 0
			OpenWBS.Error.Msg = "OpenWBS.DB.DeleteRecord: "&Fn_SQL
			OpenWBS.Error.Raise 27
			Err.Clear
			Exit Function
		End If
		DeleteRecord = 1
	End Function
	Public Function wDeleteRecordSQL(ByVal DB_Table, ByVal Condition)
		Dim TmpCondition, ArrStr, TmpSQL
		If IsArray(Condition) Then
			TmpCondition=ValueToSql(1,DB_Table,Condition)
		Else
			TmpCondition=Condition
		End If
		TmpSQL = "DELETE FROM ["&DB_Table&"]"
		If Trim(TmpCondition) <> "" Then TmpSQL = TmpSQL &" WHERE "& TmpCondition &""
		wDeleteRecordSQL = TmpSQL
	End Function
	
	'更新指定条件的记录
	'Call OpenWBS.DB.UpdateRecord(DBTable_SysUser,Array("LoginTimes=LoginTimes+1","LastLoginTime:"& SysTime),Array("ID:"& SysUserID))
	Public Function UpdateRecord(ByVal DB_Table, ByVal ValueList, ByVal Condition)
		On Error Resume Next
		Dim Fn_SQL : Fn_SQL = wUpdateRecordSQL(DB_Table,ValueList,Condition)
		'Echo Fn_SQL
		Execute Fn_SQL
		If Err.number <> 0 Then
			UpdateRecord = 0
			OpenWBS.Error.Msg = "OpenWBS.DB.UpdateRecord: "&Fn_SQL
			OpenWBS.Error.Raise 26
			Exit Function
		End If
		UpdateRecord = 1
	End Function
	Public Function wUpdateRecordSQL(ByVal DB_Table, ByVal ValueList, ByVal Condition)
		Dim TmpValueList,TmpCondition,TmpSQL
		    TmpValueList=OpenWBS.IIF(IsArray(ValueList),ValueToSql(4,DB_Table,ValueList),ValueList)
		If Not(OpenWBS.Data.IsNul(Condition)) Then
			TmpCondition=OpenWBS.IIF(IsArray(Condition),ValueToSql(1,DB_Table,Condition),Condition)
			TmpCondition = " WHERE "& TmpCondition
		End If
		TmpSQL = "Update ["& DB_Table &"] SET " & TmpValueList & TmpCondition
		wUpdateRecordSQL = TmpSQL
	End Function
	
	Private Function ValueToSQL(ByVal CSQL_Type, ByVal DB_Table, ByVal ValueList)
		On Error Resume Next
		'生成语句片段类型CSQL_Type 1: (查询) Username='phenex' AND (Len([Email])=0 OR [Email] IS NULL)    2: ([添加]字段) Username,Password      3: ([添加]值) 'phenex','OpenWBS',0,52
		'                          4: (更新) Username='phenex' AND Password='' / Username='phenex' AND Password=NULL
		CSQL_Type=Int(CSQL_Type)
		Dim TmpStr : TmpStr = ValueList
		Dim Fn_TempArray
		If IsArray(ValueList) Then
			TmpStr = ""
			
			Dim TmpRs, CurrentField, CurrentValue, tmpTF, tmpTFV, Fn_i
			'Pv_SetSqlQueryNumCount = False
			Set TmpRs = GetRecordBySQL("SELECT TOP 1 * FROM ["& DB_Table &"] WHERE 1=0")
			'Set TmpRs = OpenWBS.DB.Execute("SELECT TOP 1 * FROM ["& DB_Table &"] WHERE 1=0")
			If Pv_SetSqlQueryNumCount Then i_SqlQueryNum = i_SqlQueryNum + 1
			
			For Fn_i=0 to Ubound(ValueList)
				If Fn_i<>0 Then TmpStr = TmpStr & OpenWBS.IIF(CSQL_Type=1, " AND ", ",")
				If Instr(ValueList(Fn_i),":")>0 Then
					'"LastLoginTime:5"形式
					Fn_TempArray = OpenWBS.Param(ValueList(Fn_i))
					CurrentField = Trim(Fn_TempArray(0))
				    CurrentValue = Trim(Fn_TempArray(1))
					If CSQL_Type = 1 Or CSQL_Type = 3 Or CSQL_Type = 4 Then CurrentValue=Replace(CurrentValue,"'","''")
					If CSQL_Type = 2 Then
						TmpStr = Trim(TmpStr)
						TmpStr = TmpStr &"["& CurrentField &"]"
					Else
						Select Case TmpRs.Fields(CurrentField).Type
						
							'字符数据 char,varchar,text,nchar,nvarchar,ntext,
							Case      129 , 200   ,201 ,130  ,202     ,203  ,  8, 133, 134
								If CSQL_Type = 1 Then
									If OpenWBS.Data.IsNul(CurrentValue) Then
										TmpStr = TmpStr & "(Len(["& CurrentField &"])=0 OR ["& CurrentField &"] IS NULL)"
									Else
										TmpStr = TmpStr & OpenWBS.IIF(LCase(CurrentValue)="null","["& CurrentField &"] IS NULL","["& CurrentField &"]='"& CurrentValue &"'")
									End If
								End If
								If CSQL_Type = 3 Or CSQL_Type = 4 Then
									If CSQL_Type = 4 Then TmpStr = TmpStr & "["& CurrentField &"]="
									If OpenWBS.Data.IsNul(CurrentValue) Then
										TmpStr = TmpStr & "''"
									Else
										TmpStr = TmpStr & OpenWBS.IIF(LCase(CurrentValue)="null","NULL","'"& CurrentValue &"'")
									End If
								End If
								
							'日期和时间数据 datetime,smalldatetime,
							Case            135                   ,7
								If CSQL_Type = 1 Then
									If OpenWBS.Data.IsNul(CurrentValue) Then
										TmpStr = TmpStr & "(Len(["& CurrentField &"])=0 OR ["& CurrentField &"] IS NULL)"
									Else
										TmpStr = TmpStr & OpenWBS.IIF(LCase(CurrentValue)="null","["& CurrentField &"] IS NULL","["& CurrentField &"]='"& CurrentValue &"'")
									End If
								End If
								If CSQL_Type = 3 Or CSQL_Type = 4 Then
									If CSQL_Type = 4 Then TmpStr = TmpStr & "["& CurrentField &"]="
									If OpenWBS.Data.IsNul(CurrentValue) Then
										TmpStr = TmpStr & OpenWBS.IIF(S_DB_Type="ACCESS","0","''")
									Else
										TmpStr = TmpStr & OpenWBS.IIF(LCase(CurrentValue)="null","NULL","'"& CurrentValue &"'")
									End If
								End If
								
							'特殊数据 bit(只能包括 0 或 1)
							Case      11
								tmpTFV = LCase(Cstr(CurrentValue))
								If CSQL_Type = 1 Then
									If OpenWBS.Data.IsNul(CurrentValue) Then
										TmpStr = TmpStr & "( Len(["& CurrentField &"])=0 OR ["& CurrentField &"] IS NULL )"
									Else
										TmpStr = TmpStr & OpenWBS.IIF(LCase(CurrentValue)="null","["& CurrentField &"] IS NULL","["& CurrentField &"]='"& CurrentValue &"'")
									End If
								End If
								If CSQL_Type = 3 Or CSQL_Type = 4 Then
									'CurrentValue为空时添加false(ACCESS) 或 0(MSSQL)
									If CSQL_Type = 4 Then TmpStr = TmpStr & "["& CurrentField &"]="
									If OpenWBS.Data.IsNul(CurrentValue) Then
										TmpStr = TmpStr & "''"
									Elseif tmpTFV="true" Or tmpTFV = "1" Then
										TmpStr = TmpStr & OpenWBS.IIF(S_DB_Type="ACCESS","true","1")
									Elseif tmpTFV="false" Or tmpTFV = "0" Then
										TmpStr = TmpStr & OpenWBS.IIF(S_DB_Type="ACCESS","false","0")
									Else
										TmpStr = TmpStr & OpenWBS.IIF(tmpTFV="null","NULL", CurrentValue )
									End If
								End If
	
							'二进制数据, 数字数据(整型数据,小数数据), 货币数据
							Case Else
								If CSQL_Type = 1 Then
									If OpenWBS.Data.IsNul(CurrentValue) Then
										TmpStr = TmpStr & "(Len(["& CurrentField &"])=0 OR ["& CurrentField &"] IS NULL)"
									Else
										TmpStr = TmpStr & OpenWBS.IIF(LCase(CurrentValue)="null","["& CurrentField &"] IS NULL","["& CurrentField &"]="& CurrentValue &"")
									End If
								End If
								If CSQL_Type = 3 Or CSQL_Type = 4 Then
									If CSQL_Type = 4 Then TmpStr = TmpStr & "["& CurrentField &"]="
									If OpenWBS.Data.IsNul(CurrentValue) Then
										TmpStr = TmpStr & OpenWBS.IIF(S_DB_Type="ACCESS","0","''")
									Else
										TmpStr = TmpStr & OpenWBS.IIF(LCase(CurrentValue)="null","NULL", CurrentValue )
									End If
								End If
						End Select
					End If
				Else
					'"LoginTimes=LoginTimes+1"形式
					TmpStr = TmpStr & ValueList(Fn_i)
				End If
			Next
			TmpRs.Close()
			Set TmpRs = Nothing
			If Err.number <> 0 Then
				OpenWBS.Error.Msg = "OpenWBS.DB.ValueToSQL: "& TmpStr
				OpenWBS.Error.Raise 25
				Err.Clear
			End If
		End If
		ValueToSQL = TmpStr
	End Function
	
	'判断某个表是否已经存在
	Public Function IsDBTableExist(ByVal BV_DBTable)
		On Error Resume Next
		If TypeName(Conn) <> "Connection" Then ConnectionDatabase
		Dim Fn_Rs,Fn_Result : Fn_Result = True
		Set Fn_Rs = Server.CreateObject("Adodb.Recordset")
		With Fn_Rs
			Fn_Rs.ActiveConnection = Conn
			Fn_Rs.CursorType = 1
			Fn_Rs.LockType = 1
			Fn_Rs.Source = "SELECT * FROM ["& BV_DBTable &"]"
			Fn_Rs.Open
		End With
		Set Fn_Rs = Nothing
		If Err.number <> 0 Then
			Fn_Result = False
			Err.Clear
		End If
		IsDBTableExist = Fn_Result
	End Function
	
	'增加一个字段
	Public Function AddColumn(ByVal BV_DBTable, ByVal BV_Column)
		Select Case S_DB_Type
		Case "ACCESS"
			AddColumn = OpenWBS.DB.Execute("ALTER TABLE ["& BV_DBTable &"] ADD COLUMN "& BV_Column &"")
		Case "MSSQL"
			AddColumn = OpenWBS.DB.Execute("ALTER TABLE ["& BV_DBTable &"] ADD "& BV_Column &"")
		End Select
	End Function
	
	'增加一个字段
	Public Function EditColumn(ByVal BV_DBTable, ByVal BV_OldColumn, ByVal BV_NewColumn)
		Select Case S_DB_Type
		Case "ACCESS"
			EditColumn = 0
		Case "MSSQL"
			EditColumn = OpenWBS.DB.Execute("exec sp_rename '"& BV_DBTable &"."& BV_OldColumn &"','"& BV_NewColumn &"','column'")
		End Select
	End Function
	
	'删除表里的某个字段
	Public Function DeleteColumn(ByVal BV_DBTable, ByVal BV_Column)
		DeleteColumn = OpenWBS.DB.Execute("ALTER TABLE ["& BV_DBTable &"] DROP COLUMN "& BV_Column &"")
	End Function
	
	'复制字段的值到另一个字段
	Public Function CopyColumnData(ByVal BV_DBTable, ByVal BV_From_Column, ByVal BV_To_Column)
		CopyColumnData = OpenWBS.DB.Execute("UPDATE "& BV_DBTable &" SET "& BV_To_Column &" = "& BV_From_Column &"")
	End Function
	
	'获取自定义字段
	'OpenWBS.DB.GetField("owbs_Content_product","a")
	'OpenWBS.DB.GetField("owbs_Goods","a")
	Public Function GetField(ByVal BV_DBTable,ByVal BV_DBTableAs)
		Dim Fn_Field,Fn_Result
		If BV_DBTableAs<>"" Then BV_DBTableAs = Trim(BV_DBTableAs) &"."
		Set Pv_Rs = OpenWBS.DB.GetRecordBySQL("SELECT * FROM ["& BV_DBTable &"]")
		For Pv_ii=0 To Pv_Rs.Fields.Count-1 
			Fn_Field = Pv_Rs.Fields(Pv_ii).Name
			If UCASE(Left(Fn_Field,Len(Pv_FieldPre))) = UCASE(Pv_FieldPre) Then
				Fn_Field  = BV_DBTableAs & Fn_Field
				If Fn_Result="" Then
					Fn_Result=Fn_Field
				Else
					Fn_Result=Fn_Result&","&Fn_Field
				End If
			End If
		Next
		OpenWBS.DB.CloseRs Pv_Rs
		GetField = Fn_Result
	End Function
	
	'返回字段BV_Field在字段数组中的位置,不存在返回0,
	Public Function FieldLoc(ByVal BV_Field,ByVal BV_FieldArray)
		Dim Fn_Result:Fn_Result=0
		BV_Field = UCASE(Trim(BV_Field))
		For Pv_ii=0 To Ubound(BV_FieldArray)
			If BV_Field=UCASE(BV_FieldArray(Pv_ii)) Then
				Fn_Result=Pv_ii+1
			End If
		Next
		FieldLoc=Fn_Result
	End Function
	
	'判断某个表里是否存在某个字段
	Public Function IsColumnExist(ByVal BV_DBTable, ByVal BV_Column)
		Dim Fn_Result : Fn_Result = False
		Set Pv_Rs = OpenWBS.DB.GetRecordBySQL("SELECT * FROM ["& BV_DBTable &"]")
		For Pv_ii=0 To Pv_Rs.Fields.Count-1 
			If UCASE(Pv_Rs.Fields(Pv_ii).Name) = UCASE(BV_Column) Then
				Fn_Result = True
				Exit for
			End If
		Next
		OpenWBS.DB.CloseRs Pv_Rs
		IsColumnExist = Fn_Result
	End Function
	
	'OpenWBS.DB.CheckIsRecordExistByID(DBTable_Order,ID)
	Public Function CheckIsRecordExistByID(ByVal BV_DBTable, ByVal BV_ID)
		Set Pv_Rs = GetRecord("SELECT * FROM "& BV_DBTable &" WHERE ID="& BV_ID &"")
		If Not(Pv_Rs.Eof) Then
			CheckIsRecordExistByID = True
		Else
			CheckIsRecordExistByID = False
		End If
		OpenWBS.DB.CloseRs Pv_Rs
	End Function
	
	'OpenWBS.DB.CheckIsRecordExistByField(DBTable_Order,Array("SysID:"& Fn_SysID))
	Public Function CheckIsRecordExistByField(ByVal DB_Table, ByVal BV_Field)
		Dim Fn_ReturnString : Fn_ReturnString = false
		Set Pv_Rs = GetRecord(DB_Table,BV_Field,"")
		If Not(Pv_Rs.Eof) Then Fn_ReturnString = true
		OpenWBS.DB.CloseRs Pv_Rs
		CheckIsRecordExistByField = Fn_ReturnString
	End Function
	
	Public Function CheckIsRecordExist(ByVal DB_Table, ByVal Condition, ByVal OtherCondition)
		Dim Fn_ReturnString : Fn_ReturnString = false
		Set Pv_Rs = GetRecord(DB_Table,Condition,OtherCondition)
		If Not(Pv_Rs.Eof) Then Fn_ReturnString = true
		OpenWBS.DB.CloseRs Pv_Rs
		CheckIsRecordExist = Fn_ReturnString
	End Function
	
	Public Function GetFieldBySysID(ByVal DB_Table, ByVal BV_Field, ByVal BV_SysID)
		Dim Fn_ReturnString
		Set Pv_Rs = GetRecordBySQL("SELECT "& BV_Field &" FROM ["& DB_Table &"] WHERE SysID='"& BV_SysID &"'")
		If Not(Pv_Rs.Eof) Then Fn_ReturnString = Pv_Rs(0)
		OpenWBS.DB.CloseRs Pv_Rs
		GetFieldBySysID = Fn_ReturnString
	End Function
	
	Public Function GetFieldByID(ByVal DB_Table, ByVal BV_Field, ByVal BV_ID)
		Dim Fn_ReturnString
		Set Pv_Rs = GetRecord(DB_Table &":"& BV_Field,Array("ID:"& BV_ID),"")
		If Not(Pv_Rs.Eof) Then Fn_ReturnString = Pv_Rs(0)
		OpenWBS.DB.CloseRs Pv_Rs
		GetFieldByID = Fn_ReturnString
	End Function
	
	Public Function GetFieldByField(ByVal DB_Table, ByVal BV_Field, ByVal BV_FieldString, ByVal BV_FieldValue)
		GetFieldByField = GetFieldByArrayField(DB_Table,BV_Field,Array(BV_FieldString &":"& BV_FieldValue))
	End Function
	
	Public Function GetFieldByArrayField(ByVal DB_Table, ByVal BV_Field, ByVal BV_ArrayField)
		Dim Fn_ReturnString
		Set Pv_Rs = GetRecord(DB_Table &":"& BV_Field,BV_ArrayField,"")
		If Not(Pv_Rs.Eof) Then Fn_ReturnString = Pv_Rs(0)
		OpenWBS.DB.CloseRs Pv_Rs
		GetFieldByArrayField = Trim(Fn_ReturnString)
	End Function
	
	Public Function GetFieldByMaxID(ByVal DB_Table, ByVal BV_Field)
		Dim Fn_ReturnString
		Set Pv_Rs = GetRecordBySql("SELECT TOP 1 "& BV_Field &" FROM ["& DB_Table &"] ORDER BY ID DESC")
		If Not(Pv_Rs.Eof) Then Fn_ReturnString = Pv_Rs(0)
		OpenWBS.DB.CloseRs Pv_Rs
		GetFieldByMaxID = Fn_ReturnString
	End Function
	
	Public Function GetMaxID(ByVal BV_DBTable)
		Dim Fn_MaxID : Fn_MaxID = 0
		Set Pv_Rs = GetRecordBySql("SELECT MAX(ID) FROM ["& BV_DBTable &"]")
		If Not(Pv_Rs.Eof) Then Fn_MaxID = Pv_Rs(0)
		OpenWBS.DB.CloseRs Pv_Rs
		GetMaxID = Fn_MaxID
	End Function
	
	Public Sub Close()
        On Error Resume Next
		Conn.Close
		Set Conn = Nothing
		Err.Clear()
		On Error Goto 0
	End Sub

	Public Sub CloseRs(ByRef Obj_Rs)
		If IsObject(Obj_Rs) Then
			On Error Resume Next
			Obj_Rs.Close
			Set Obj_Rs = Nothing
			Err.Clear()
			On Error Goto 0
		End If
	End Sub
End Class
%>