<%
'**********************************************
' File:		aes.asp
' Version:	Advanced Encryption StAndard Class Version 1.0 Build20051017
' Author:	LessBug
' Email:	LessBug@gmail.com
' Date:		10/17/2005
' Comments:	The code For the Advanced Encryption StAndard.
'			This can free usage, but please
'			not To delete this copyright inFormation.
'			If you have a ModIfication version,
'			Please sEnd out a duplicate To me.
'           Thank you! ^-^
'**********************************************
' 文件名:	aes.asp
' 版本:		Advanced Encryption StAndard Class Version 1.0 Build20051017
' 作者:		LessBug(小虫)
' 电子邮件:	LessBug@gmail.com
' 日期:		2005年10月17日
' 声明:		AES数据加密/解密类
'			本代码可以自由使用，但请保留此版权声明信息
'			如果您对本上传类进行修改增强，
'			请发送一份给我。
'           谢谢！^-^
'**********************************************

Class aes_class
'**********************************************
' 输入：keySize密钥长度(128、192、256),Src明文字符串，Key密钥字符串
'       明文字符串不能超过 &HFFFF长度
' 输出：密文十六进制字符串
Public Function CipherStrToHexStr(keySize, Src, Key)
	SetNbNkNr keySize
	InitKey Key
	Dim i, Result, str32, input(15), output(15)
	Dim HexString, iLen, sLen
	iLen = Len(Src)
	sLen = CStr(Hex(iLen))
	sLen = String(4-Len(sLen), "0")&sLen
	HexString = sLen & HexStr(Src)
	Result = ""
	i = 0
	str32 = Mid(HexString, 1, 32)
	Do While Len(str32) > 0
		HexStrToArray str32, input
		FCipher input, output
		Result = Result + ArrayToHexStr(output)
		i = i + Len(str32)
		str32 = Mid(HexString, i + 1, 32)
	Loop
	CipherStrToHexStr = Result
End Function

'**********************************************
' 输入：keySize密钥长度(128、192、256),Src明文十六进制符串，Key密钥字符串
'       明文十六进制字符串不能超过 2 * &HFFFF长度
' 输出：密文十六进制字符串
Public Function CipherHexStrToHexStr(keySize, Src, Key)
	SetNbNkNr keySize
	InitKey Key
	Dim i, Result, str32, input(15), output(15)
	Dim HexString, iLen, sLen
	iLen = Len(Src) \ 2
	if iLen > 2 * &HFFFF then Src = Left(Src, 2 * &HFFFF)
	sLen = CStr(Hex(iLen))
	sLen = String(4-Len(sLen), "0")&sLen
	HexString = sLen & Src
	Result = ""
	i = 0
	str32 = Mid(HexString, 1, 32)
	Do While Len(str32) > 0
		HexStrToArray str32, input
		FCipher input, output
		Result = Result + ArrayToHexStr(output)
		i = i + Len(str32)
		str32 = Mid(HexString, i + 1, 32)
	Loop
	CipherHexStrToHexStr = Result
End Function

'**********************************************
' 输入：keySize密钥长度(128、192、256),Src密文十六进制符串，Key密钥字符串
' 输出：解密后的字符串
Public Function InvCipherHexStrToStr(keySize, Src, Key)
	SetNbNkNr keySize
	InitKey Key
	Dim i, Result, str32, input(15), output(15)
	Dim HexString, iLen, sLen, str
	HexString = Src
	Result = ""
	i = 0
	str32 = Mid(HexString, 1, 32)
	i = i + Len(str32)
	HexStrToArray str32, input
	FInvCipher input, output
	str = ArrayToHexStr(output)
	sLen = Left(str, 4)
	iLen = HexToLng(sLen)
	str = ArrayToStr(output)
	Result = Right(str, 7)
	str32 = Mid(HexString, i + 1, 32)	
	Do While Len(str32) > 0
		HexStrToArray str32, input
		FInvCipher input, output
		Result = Result + ArrayToStr(output)
		i = i + Len(str32)
		str32 = Mid(HexString, i + 1, 32)
	Loop
	InvCipherHexStrToStr = Left(Result, iLen)
End Function

'**********************************************
' 输入：keySize密钥长度(128、192、256),Src密文十六进制符串，Key密钥字符串
' 输出：解密后的十六进制字符串
Public Function InvCipherHexStrToHexStr(keySize, Src, Key)
	SetNbNkNr keySize
	InitKey Key
	Dim i, Result, str32, input(15), output(15)
	Dim HexString, iLen, sLen, str
	HexString = Src
	Result = ""
	i = 0
	str32 = Mid(HexString, 1, 32)
	i = i + Len(str32)
	HexStrToArray str32, input
	FInvCipher input, output
	str = ArrayToHexStr(output)
	sLen = Left(str, 4)
	iLen = HexToLng(sLen)
	Result = Right(str, 28)
	str32 = Mid(HexString, i + 1, 32)	
	Do While Len(str32) > 0
		HexStrToArray str32, input
		FInvCipher input, output
		Result = Result + ArrayToHexStr(output)
		i = i + Len(str32)
		str32 = Mid(HexString, i + 1, 32)
	Loop
	InvCipherHexStrToHexStr = Left(Result, iLen * 4)
End Function

'**********************************************
' 类的实现

Private FSBox(15, 15)
Private FIsBox(15, 15)
Private FRcon(10, 3)
Private FNb, FNk, FNr
Private FKey(31)
Private FW(59, 3)
Private FState(3, 3)

Private Function ArrayToHexStr(Src)
	Dim i, Result
	Result = ""
	For I = LBound(Src) To UBound(Src)
		Result = Result&CStr(MyHex(Src(I)))
	Next
	ArrayToHexStr = Result
End Function

Private Function ArrayToStr(Src)
	Dim i, Result
	Result = ""
	For I = LBound(Src) To UBound(Src) \ 2
		Result = Result&ChrW(Src(2 * I) + Src(2 * I + 1) * &H100)
	Next
	ArrayToStr = Result
End Function

Private Function HexStr(Src)
	Dim i, HexString
	For i = 0 To LenB(Src) - 1
		HexString = HexString&CStr(MyHex(AscB(MidB(Src, i + 1, 1))))
	Next
	HexStr = HexString
End Function

Private Function HexToLng(H)
	HexToLng = CLng(Cstr("&H" & H))
End Function

Private Sub HexStrToArray(Src, Out)
	If IsNull(Src) then Src = ""
	Dim W, i, j
	i = 0
	j = 0
	For i = 0 To Len(Src) \ 2 - 1
		Out(i) = HexToLng(Mid(Src, 2*i + 1, 2))
	Next
	For i = Len(Src) \ 2 To 15
		Out(i) = 0
	Next
End Sub

Private Function CByte(B)
	CByte = B And &H00FF
End Function

Private Function MyHex(B)
	If B < &H10 then
		MyHex = "0"&CStr(Hex(B))
	Else
		MyHex = CStr(Hex(B))
	End If
End Function

'**********************************************
' 初始化工作Key，如果Key中包含Unicode 字符，则仅取Unicode字符的低字节
Private Sub InitKey(key)
	Dim i
	Dim j
	Dim K
	For i = 0 To 31
		FKey(i) = 0
	Next
	If Len(key) > FNk * 4 then
		For i = 0 To FNk * 4 - 1
			K = AscW(Mid(key, i + 1, 1))
			If K > &HFF then K = CByte(K)
			FKey(i) = K
		Next
	Else
		For i = 0 To len(key) - 1
			K = AscW(Mid(key, i + 1, 1))
			If K > &HFF then K = CByte(K)
			FKey(i) = K
		Next		
	End If
	KeyExpansion
End Sub


Private Sub Class_Initialize
	BuildSBox()
	BuildIsBox()
	BuildRcon()
End Sub

Private Sub Class_Terminate	

End Sub

Private Sub SetNbNkNr(keySize)
	FNb = 4
	Select Case keySize
		Case 192
			FNk = 6
			FNr = 12
		Case 256 
			FNk = 8
			FNr = 14
		Case Else '别的都按128 处理
			FNk = 4
			FNr = 10
	End Select
End Sub

Private Sub AddRoundKey(around)
	Dim r, c
	For r = 0 To 3
		For c = 0 To 3
			FState(r, c) = CByte((CLng(FState(r, c)) Xor (Fw((around * 4) + c, r))))
		Next
	Next
End Sub

Private Sub KeyExpansion()
	Dim row
	Dim temp(3)
	Dim i
	For row = 0 To FNk - 1 
		FW(row, 0) = FKey(4 * row)
		FW(row, 1) = FKey(4 * row + 1)
		FW(row, 2) = FKey(4 * row + 2)
		FW(row, 3) = FKey(4 * row + 3)
	Next
	For row = FNk To FNb * (FNr + 1) - 1
		temp(0) = FW(row - 1, 0)
		temp(1) = FW(row - 1, 1)
		temp(2) = FW(row - 1, 2)
		temp(3) = FW(row - 1, 3)
		If row Mod FNk = 0 then
			RotWord temp(0), temp(1), temp(2), temp(3)
			SubWord temp(0), temp(1), temp(2), temp(3)
			temp(0) = CByte((CLng(temp(0))) Xor (CLng(FRcon(row \ FNk, 0))))
			temp(1) = CByte((CLng(temp(1))) Xor (CLng(FRcon(row \ FNk, 1))))
			temp(2) = CByte((CLng(temp(2))) Xor (CLng(FRcon(row \ FNk, 2))))
			temp(3) = CByte((CLng(temp(3))) Xor (CLng(FRcon(row \ FNk, 3))))
		Else 
			If (FNK > 6) And ((row Mod FNk) = 4) then
				SubWord temp(0), temp(1), temp(2), temp(3)
			End If
		End If
		FW(row, 0) = CByte((CLng(FW(row-FNk, 0))) Xor (CLng(temp(0))))
		FW(row, 1) = CByte((CLng(FW(row-FNk, 1))) Xor (CLng(temp(1))))
		FW(row, 2) = CByte((CLng(FW(row-FNk, 2))) Xor (CLng(temp(2))))
		FW(row, 3) = CByte((CLng(FW(row-FNk, 3))) Xor (CLng(temp(3))))
	Next
End Sub

Private Sub SubBytes()
	Dim r, c
	For r = 0 To 3
		For c = 0 To 3
			FState(r, c) = FSBox(FState(r, c) \ 16, FState(r, c) And &H0F)
		Next
	Next
End Sub

Private Sub InvSubBytes()
	Dim r, c
	For r = 0 To 3
		For c = 0 To 3
			FState(r, c) = FIsBox(FState(r, c) \ 16, FState(r, c) And &H0F)
		Next
	Next
End Sub

Private Sub ShIftRows()
	Dim temp(3, 3)
	Dim r, c
	For r = 0 To 3
		For c = 0 To 3
			temp(r, c) = FState(r, c)
		Next
	Next
	For r = 1 To 3
		For c = 0 To 3
			FState(r, c) = temp(r, (c + r) Mod FNb)
		Next
	Next
End Sub

Private Sub InvShIftRows()
	Dim temp(3, 3)
	Dim r, c
	For r = 0 To 3
		For c = 0 To 3
			temp(r, c) = FState(r, c)
		Next
	Next
	For r = 1 To 3
		For c = 0 To 3
			FState(r, (c + r) Mod FNb) = temp(r, c)
		Next
	Next
End Sub

Private Sub MixColumns()
	Dim temp(3, 3)
	Dim r, c
	For r = 0 To 3
		For c = 0 To 3
			temp(r, c) = FState(r, c)
		Next
	Next
	For c = 0 To 3
		FState(0, c) = CByte(CInt(gfmultby02(temp(0, c))) Xor CInt(gfmultby03(temp(1, c))) Xor CInt(gfmultby01(temp(2, c))) Xor CInt(gfmultby01(temp(3, c))))
		FState(1, c) = CByte(CInt(gfmultby01(temp(0, c))) Xor CInt(gfmultby02(temp(1, c))) Xor CInt(gfmultby03(temp(2, c))) Xor CInt(gfmultby01(temp(3, c))))
		FState(2, c) = CByte(CInt(gfmultby01(temp(0, c))) Xor CInt(gfmultby01(temp(1, c))) Xor CInt(gfmultby02(temp(2, c))) Xor CInt(gfmultby03(temp(3, c))))
		FState(3, c) = CByte(CInt(gfmultby03(temp(0, c))) Xor CInt(gfmultby01(temp(1, c))) Xor CInt(gfmultby01(temp(2, c))) Xor CInt(gfmultby02(temp(3, c))))
	Next
End Sub

Private Sub InvMixColumns()
	Dim temp(3, 3)
	Dim r, c
	For r = 0 To 3
		For c = 0 To 3
			temp(r, c) = FState(r, c)
		Next
	Next
	For c = 0 To 3
		FState(0, c) = CByte(CInt(gfmultby0e(temp(0, c))) Xor CInt(gfmultby0b(temp(1, c))) Xor CInt(gfmultby0d(temp(2, c))) Xor CInt(gfmultby09(temp(3, c))))
		FState(1, c) = CByte(CInt(gfmultby09(temp(0, c))) Xor CInt(gfmultby0e(temp(1, c))) Xor CInt(gfmultby0b(temp(2, c))) Xor CInt(gfmultby0d(temp(3, c))))
		FState(2, c) = CByte(CInt(gfmultby0d(temp(0, c))) Xor CInt(gfmultby09(temp(1, c))) Xor CInt(gfmultby0e(temp(2, c))) Xor CInt(gfmultby0b(temp(3, c))))
		FState(3, c) = CByte(CInt(gfmultby0b(temp(0, c))) Xor CInt(gfmultby0d(temp(1, c))) Xor CInt(gfmultby09(temp(2, c))) Xor CInt(gfmultby0e(temp(3, c))))
	Next
End Sub

Private Function gfmultby01(b)
	gfmultby01 = b
End Function

Private Function gfmultby02(b)
	If (b < &H80) then
		gfmultby02 = CByte(CInt(b * 2))
	Else
		gfmultby02 = CByte((CInt(b * 2)) Xor (CInt(&H1b)))
	End If
End Function

Private Function gfmultby03(b)
	gfmultby03 = CByte((CInt(gfmultby02(b))) Xor (CInt(b)))
End Function

Private Function gfmultby09(b)
	gfmultby09 = CByte((CInt(gfmultby02(gfmultby02(gfmultby02(b))))) Xor (CInt(b)))
End Function

Private Function gfmultby0b(b)
	gfmultby0b = CByte((CInt(gfmultby02(gfmultby02(gfmultby02(b))))) Xor (CInt(gfmultby02(b))) Xor (CInt(b)))
End Function

Private Function gfmultby0d(b)
	gfmultby0d = CByte((CInt(gfmultby02(gfmultby02(gfmultby02(b))))) Xor (CInt(gfmultby02(gfmultby02(b)))) Xor (CInt(b)))
End Function

Private Function gfmultby0e(b)
	gfmultby0e = CByte((CInt(gfmultby02(gfmultby02(gfmultby02(b))))) Xor (CInt(gfmultby02(gfmultby02(b)))) Xor (CInt(gfmultby02(b))))
End Function

Private Sub SubWord(B1, B2, B3, B4)
	B4 = FSbox(B4 \ 16, B4 And &H0f )
	B3 = FSbox(B3 \ 16, B3 And &H0f )
	B2 = FSbox(B2 \ 16, B2 And &H0f )
	B1 = FSbox(B1 \ 16, B1 And &H0f )
End Sub

Private Sub RotWord(B1, B2, B3, B4)
	Dim B
	B = B1
	B1 = B2
	B2 = B3
	B3 = B4
	B4 = B
End Sub

Private Sub FCipher(input, output)
	Dim i, around
	For i = 0 To 4 * FNb - 1
		FState(i Mod 4, i \ 4) = input(i)
	Next
	AddRoundKey 0
	For around = 1 To FNr - 1
		SubBytes()
		ShIftRows()
		MixColumns()
		AddRoundKey around
	Next
	SubBytes()
	ShIftRows()
	AddRoundKey FNr
	For i = 0 To FNb * 4 - 1
		output(i) = FState(i Mod 4, i \ 4)
	Next
End Sub

Private Sub FInvCipher(input, output)
	Dim i, around
	For i = 0 To 4 * FNb - 1
		FState(i Mod 4, i \ 4) = input(i)
	Next
	AddRoundKey FNr
	around = FNr - 1
	Do While around >= 1
		InvShIftRows()
		InvSubBytes()
		AddRoundKey around
		InvMixColumns()
		around = around -1
	Loop
	InvShIftRows()
	InvSubBytes()
	AddRoundKey 0	
	For i = 0 To FNb * 4 - 1
		output(i) = FState(i Mod 4, i \ 4)
	Next
End Sub

Private Function BuildSBox()
	FSBox(00, 00) = &H63
	FSBox(00, 01) = &H7C
	FSBox(00, 02) = &H77
	FSBox(00, 03) = &H7B
	FSBox(00, 04) = &HF2
	FSBox(00, 05) = &H6B
	FSBox(00, 06) = &H6F
	FSBox(00, 07) = &HC5
	FSBox(00, 08) = &H30
	FSBox(00, 09) = &H01
	FSBox(00, 10) = &H67
	FSBox(00, 11) = &H2B
	FSBox(00, 12) = &HFE
	FSBox(00, 13) = &HD7
	FSBox(00, 14) = &HAB
	FSBox(00, 15) = &H76
	FSBox(01, 00) = &HCA
	FSBox(01, 01) = &H82
	FSBox(01, 02) = &HC9
	FSBox(01, 03) = &H7D
	FSBox(01, 04) = &HFA
	FSBox(01, 05) = &H59
	FSBox(01, 06) = &H47
	FSBox(01, 07) = &HF0
	FSBox(01, 08) = &HAD
	FSBox(01, 09) = &HD4
	FSBox(01, 10) = &HA2
	FSBox(01, 11) = &HAF
	FSBox(01, 12) = &H9C
	FSBox(01, 13) = &HA4
	FSBox(01, 14) = &H72
	FSBox(01, 15) = &HC0
	FSBox(02, 00) = &HB7
	FSBox(02, 01) = &HFD
	FSBox(02, 02) = &H93
	FSBox(02, 03) = &H26
	FSBox(02, 04) = &H36
	FSBox(02, 05) = &H3F
	FSBox(02, 06) = &HF7
	FSBox(02, 07) = &HCC
	FSBox(02, 08) = &H34
	FSBox(02, 09) = &HA5
	FSBox(02, 10) = &HE5
	FSBox(02, 11) = &HF1
	FSBox(02, 12) = &H71
	FSBox(02, 13) = &HD8
	FSBox(02, 14) = &H31
	FSBox(02, 15) = &H15
	FSBox(03, 00) = &H04
	FSBox(03, 01) = &HC7
	FSBox(03, 02) = &H23
	FSBox(03, 03) = &HC3
	FSBox(03, 04) = &H18
	FSBox(03, 05) = &H96
	FSBox(03, 06) = &H05
	FSBox(03, 07) = &H9A
	FSBox(03, 08) = &H07
	FSBox(03, 09) = &H12
	FSBox(03, 10) = &H80
	FSBox(03, 11) = &HE2
	FSBox(03, 12) = &HEB
	FSBox(03, 13) = &H27
	FSBox(03, 14) = &HB2
	FSBox(03, 15) = &H75
	FSBox(04, 00) = &H09
	FSBox(04, 01) = &H83
	FSBox(04, 02) = &H2C
	FSBox(04, 03) = &H1A
	FSBox(04, 04) = &H1B
	FSBox(04, 05) = &H6E
	FSBox(04, 06) = &H5A
	FSBox(04, 07) = &HA0
	FSBox(04, 08) = &H52
	FSBox(04, 09) = &H3B
	FSBox(04, 10) = &HD6
	FSBox(04, 11) = &HB3
	FSBox(04, 12) = &H29
	FSBox(04, 13) = &HE3
	FSBox(04, 14) = &H2F
	FSBox(04, 15) = &H84
	FSBox(05, 00) = &H53
	FSBox(05, 01) = &HD1
	FSBox(05, 02) = &H00
	FSBox(05, 03) = &HED
	FSBox(05, 04) = &H20
	FSBox(05, 05) = &HFC
	FSBox(05, 06) = &HB1
	FSBox(05, 07) = &H5B
	FSBox(05, 08) = &H6A
	FSBox(05, 09) = &HCB
	FSBox(05, 10) = &HBE
	FSBox(05, 11) = &H39
	FSBox(05, 12) = &H4A
	FSBox(05, 13) = &H4C
	FSBox(05, 14) = &H58
	FSBox(05, 15) = &HCF
	FSBox(06, 00) = &HD0
	FSBox(06, 01) = &HEF
	FSBox(06, 02) = &HAA
	FSBox(06, 03) = &HFB
	FSBox(06, 04) = &H43
	FSBox(06, 05) = &H4D
	FSBox(06, 06) = &H33
	FSBox(06, 07) = &H85
	FSBox(06, 08) = &H45
	FSBox(06, 09) = &HF9
	FSBox(06, 10) = &H02
	FSBox(06, 11) = &H7F
	FSBox(06, 12) = &H50
	FSBox(06, 13) = &H3C
	FSBox(06, 14) = &H9F
	FSBox(06, 15) = &HA8
	FSBox(07, 00) = &H51
	FSBox(07, 01) = &HA3
	FSBox(07, 02) = &H40
	FSBox(07, 03) = &H8F
	FSBox(07, 04) = &H92
	FSBox(07, 05) = &H9D
	FSBox(07, 06) = &H38
	FSBox(07, 07) = &HF5
	FSBox(07, 08) = &HBC
	FSBox(07, 09) = &HB6
	FSBox(07, 10) = &HDA
	FSBox(07, 11) = &H21
	FSBox(07, 12) = &H10
	FSBox(07, 13) = &HFF
	FSBox(07, 14) = &HF3
	FSBox(07, 15) = &HD2
	FSBox(08, 00) = &HCD
	FSBox(08, 01) = &H0C
	FSBox(08, 02) = &H13
	FSBox(08, 03) = &HEC
	FSBox(08, 04) = &H5F
	FSBox(08, 05) = &H97
	FSBox(08, 06) = &H44
	FSBox(08, 07) = &H17
	FSBox(08, 08) = &HC4
	FSBox(08, 09) = &HA7
	FSBox(08, 10) = &H7E
	FSBox(08, 11) = &H3D
	FSBox(08, 12) = &H64
	FSBox(08, 13) = &H5D
	FSBox(08, 14) = &H19
	FSBox(08, 15) = &H73
	FSBox(09, 00) = &H60
	FSBox(09, 01) = &H81
	FSBox(09, 02) = &H4F
	FSBox(09, 03) = &HDC
	FSBox(09, 04) = &H22
	FSBox(09, 05) = &H2A
	FSBox(09, 06) = &H90
	FSBox(09, 07) = &H88
	FSBox(09, 08) = &H46
	FSBox(09, 09) = &HEE
	FSBox(09, 10) = &HB8
	FSBox(09, 11) = &H14
	FSBox(09, 12) = &HDE
	FSBox(09, 13) = &H5E
	FSBox(09, 14) = &H0B
	FSBox(09, 15) = &HDB
	FSBox(10, 00) = &HE0
	FSBox(10, 01) = &H32
	FSBox(10, 02) = &H3A
	FSBox(10, 03) = &H0A
	FSBox(10, 04) = &H49
	FSBox(10, 05) = &H06
	FSBox(10, 06) = &H24
	FSBox(10, 07) = &H5C
	FSBox(10, 08) = &HC2
	FSBox(10, 09) = &HD3
	FSBox(10, 10) = &HAC
	FSBox(10, 11) = &H62
	FSBox(10, 12) = &H91
	FSBox(10, 13) = &H95
	FSBox(10, 14) = &HE4
	FSBox(10, 15) = &H79
	FSBox(11, 00) = &HE7
	FSBox(11, 01) = &HC8
	FSBox(11, 02) = &H37
	FSBox(11, 03) = &H6D
	FSBox(11, 04) = &H8D
	FSBox(11, 05) = &HD5
	FSBox(11, 06) = &H4E
	FSBox(11, 07) = &HA9
	FSBox(11, 08) = &H6C
	FSBox(11, 09) = &H56
	FSBox(11, 10) = &HF4
	FSBox(11, 11) = &HEA
	FSBox(11, 12) = &H65
	FSBox(11, 13) = &H7A
	FSBox(11, 14) = &HAE
	FSBox(11, 15) = &H08
	FSBox(12, 00) = &HBA
	FSBox(12, 01) = &H78
	FSBox(12, 02) = &H25
	FSBox(12, 03) = &H2E
	FSBox(12, 04) = &H1C
	FSBox(12, 05) = &HA6
	FSBox(12, 06) = &HB4
	FSBox(12, 07) = &HC6
	FSBox(12, 08) = &HE8
	FSBox(12, 09) = &HDD
	FSBox(12, 10) = &H74
	FSBox(12, 11) = &H1F
	FSBox(12, 12) = &H4B
	FSBox(12, 13) = &HBD
	FSBox(12, 14) = &H8B
	FSBox(12, 15) = &H8A
	FSBox(13, 00) = &H70
	FSBox(13, 01) = &H3E
	FSBox(13, 02) = &HB5
	FSBox(13, 03) = &H66
	FSBox(13, 04) = &H48
	FSBox(13, 05) = &H03
	FSBox(13, 06) = &HF6
	FSBox(13, 07) = &H0E
	FSBox(13, 08) = &H61
	FSBox(13, 09) = &H35
	FSBox(13, 10) = &H57
	FSBox(13, 11) = &HB9
	FSBox(13, 12) = &H86
	FSBox(13, 13) = &HC1
	FSBox(13, 14) = &H1D
	FSBox(13, 15) = &H9E
	FSBox(14, 00) = &HE1
	FSBox(14, 01) = &HF8
	FSBox(14, 02) = &H98
	FSBox(14, 03) = &H11
	FSBox(14, 04) = &H69
	FSBox(14, 05) = &HD9
	FSBox(14, 06) = &H8E
	FSBox(14, 07) = &H94
	FSBox(14, 08) = &H9B
	FSBox(14, 09) = &H1E
	FSBox(14, 10) = &H87
	FSBox(14, 11) = &HE9
	FSBox(14, 12) = &HCE
	FSBox(14, 13) = &H55
	FSBox(14, 14) = &H28
	FSBox(14, 15) = &HDF
	FSBox(15, 00) = &H8C
	FSBox(15, 01) = &HA1
	FSBox(15, 02) = &H89
	FSBox(15, 03) = &H0D
	FSBox(15, 04) = &HBF
	FSBox(15, 05) = &HE6
	FSBox(15, 06) = &H42
	FSBox(15, 07) = &H68
	FSBox(15, 08) = &H41
	FSBox(15, 09) = &H99
	FSBox(15, 10) = &H2D
	FSBox(15, 11) = &H0F
	FSBox(15, 12) = &HB0
	FSBox(15, 13) = &H54
	FSBox(15, 14) = &HBB
	FSBox(15, 15) = &H16
End Function

Private Function BuildIsBox()
	FIsBox(00, 00) = &H52
	FIsBox(00, 01) = &H09
	FIsBox(00, 02) = &H6A
	FIsBox(00, 03) = &HD5
	FIsBox(00, 04) = &H30
	FIsBox(00, 05) = &H36
	FIsBox(00, 06) = &HA5
	FIsBox(00, 07) = &H38
	FIsBox(00, 08) = &HBF
	FIsBox(00, 09) = &H40
	FIsBox(00, 10) = &HA3
	FIsBox(00, 11) = &H9E
	FIsBox(00, 12) = &H81
	FIsBox(00, 13) = &HF3
	FIsBox(00, 14) = &HD7
	FIsBox(00, 15) = &HFB
	FIsBox(01, 00) = &H7C
	FIsBox(01, 01) = &HE3
	FIsBox(01, 02) = &H39
	FIsBox(01, 03) = &H82
	FIsBox(01, 04) = &H9B
	FIsBox(01, 05) = &H2F
	FIsBox(01, 06) = &HFF
	FIsBox(01, 07) = &H87
	FIsBox(01, 08) = &H34
	FIsBox(01, 09) = &H8E
	FIsBox(01, 10) = &H43
	FIsBox(01, 11) = &H44
	FIsBox(01, 12) = &HC4
	FIsBox(01, 13) = &HDE
	FIsBox(01, 14) = &HE9
	FIsBox(01, 15) = &HCB
	FIsBox(02, 00) = &H54
	FIsBox(02, 01) = &H7B
	FIsBox(02, 02) = &H94
	FIsBox(02, 03) = &H32
	FIsBox(02, 04) = &HA6
	FIsBox(02, 05) = &HC2
	FIsBox(02, 06) = &H23
	FIsBox(02, 07) = &H3D
	FIsBox(02, 08) = &HEE
	FIsBox(02, 09) = &H4C
	FIsBox(02, 10) = &H95
	FIsBox(02, 11) = &H0B
	FIsBox(02, 12) = &H42
	FIsBox(02, 13) = &HFA
	FIsBox(02, 14) = &HC3
	FIsBox(02, 15) = &H4E
	FIsBox(03, 00) = &H08
	FIsBox(03, 01) = &H2E
	FIsBox(03, 02) = &HA1
	FIsBox(03, 03) = &H66
	FIsBox(03, 04) = &H28
	FIsBox(03, 05) = &HD9
	FIsBox(03, 06) = &H24
	FIsBox(03, 07) = &HB2
	FIsBox(03, 08) = &H76
	FIsBox(03, 09) = &H5B
	FIsBox(03, 10) = &HA2
	FIsBox(03, 11) = &H49
	FIsBox(03, 12) = &H6D
	FIsBox(03, 13) = &H8B
	FIsBox(03, 14) = &HD1
	FIsBox(03, 15) = &H25
	FIsBox(04, 00) = &H72
	FIsBox(04, 01) = &HF8
	FIsBox(04, 02) = &HF6
	FIsBox(04, 03) = &H64
	FIsBox(04, 04) = &H86
	FIsBox(04, 05) = &H68
	FIsBox(04, 06) = &H98
	FIsBox(04, 07) = &H16
	FIsBox(04, 08) = &HD4
	FIsBox(04, 09) = &HA4
	FIsBox(04, 10) = &H5C
	FIsBox(04, 11) = &HCC
	FIsBox(04, 12) = &H5D
	FIsBox(04, 13) = &H65
	FIsBox(04, 14) = &HB6
	FIsBox(04, 15) = &H92
	FIsBox(05, 00) = &H6C
	FIsBox(05, 01) = &H70
	FIsBox(05, 02) = &H48
	FIsBox(05, 03) = &H50
	FIsBox(05, 04) = &HFD
	FIsBox(05, 05) = &HED
	FIsBox(05, 06) = &HB9
	FIsBox(05, 07) = &HDA
	FIsBox(05, 08) = &H5E
	FIsBox(05, 09) = &H15
	FIsBox(05, 10) = &H46
	FIsBox(05, 11) = &H57
	FIsBox(05, 12) = &HA7
	FIsBox(05, 13) = &H8D
	FIsBox(05, 14) = &H9D
	FIsBox(05, 15) = &H84
	FIsBox(06, 00) = &H90
	FIsBox(06, 01) = &HD8
	FIsBox(06, 02) = &HAB
	FIsBox(06, 03) = &H00
	FIsBox(06, 04) = &H8C
	FIsBox(06, 05) = &HBC
	FIsBox(06, 06) = &HD3
	FIsBox(06, 07) = &H0A
	FIsBox(06, 08) = &HF7
	FIsBox(06, 09) = &HE4
	FIsBox(06, 10) = &H58
	FIsBox(06, 11) = &H05
	FIsBox(06, 12) = &HB8
	FIsBox(06, 13) = &HB3
	FIsBox(06, 14) = &H45
	FIsBox(06, 15) = &H06
	FIsBox(07, 00) = &HD0
	FIsBox(07, 01) = &H2C
	FIsBox(07, 02) = &H1E
	FIsBox(07, 03) = &H8F
	FIsBox(07, 04) = &HCA
	FIsBox(07, 05) = &H3F
	FIsBox(07, 06) = &H0F
	FIsBox(07, 07) = &H02
	FIsBox(07, 08) = &HC1
	FIsBox(07, 09) = &HAF
	FIsBox(07, 10) = &HBD
	FIsBox(07, 11) = &H03
	FIsBox(07, 12) = &H01
	FIsBox(07, 13) = &H13
	FIsBox(07, 14) = &H8A
	FIsBox(07, 15) = &H6B
	FIsBox(08, 00) = &H3A
	FIsBox(08, 01) = &H91
	FIsBox(08, 02) = &H11
	FIsBox(08, 03) = &H41
	FIsBox(08, 04) = &H4F
	FIsBox(08, 05) = &H67
	FIsBox(08, 06) = &HDC
	FIsBox(08, 07) = &HEA
	FIsBox(08, 08) = &H97
	FIsBox(08, 09) = &HF2
	FIsBox(08, 10) = &HCF
	FIsBox(08, 11) = &HCE
	FIsBox(08, 12) = &HF0
	FIsBox(08, 13) = &HB4
	FIsBox(08, 14) = &HE6
	FIsBox(08, 15) = &H73
	FIsBox(09, 00) = &H96
	FIsBox(09, 01) = &HAC
	FIsBox(09, 02) = &H74
	FIsBox(09, 03) = &H22
	FIsBox(09, 04) = &HE7
	FIsBox(09, 05) = &HAD
	FIsBox(09, 06) = &H35
	FIsBox(09, 07) = &H85
	FIsBox(09, 08) = &HE2
	FIsBox(09, 09) = &HF9
	FIsBox(09, 10) = &H37
	FIsBox(09, 11) = &HE8
	FIsBox(09, 12) = &H1C
	FIsBox(09, 13) = &H75
	FIsBox(09, 14) = &HDF
	FIsBox(09, 15) = &H6E
	FIsBox(10, 00) = &H47
	FIsBox(10, 01) = &HF1
	FIsBox(10, 02) = &H1A
	FIsBox(10, 03) = &H71
	FIsBox(10, 04) = &H1D
	FIsBox(10, 05) = &H29
	FIsBox(10, 06) = &HC5
	FIsBox(10, 07) = &H89
	FIsBox(10, 08) = &H6F
	FIsBox(10, 09) = &HB7
	FIsBox(10, 10) = &H62
	FIsBox(10, 11) = &H0E
	FIsBox(10, 12) = &HAA
	FIsBox(10, 13) = &H18
	FIsBox(10, 14) = &HBE
	FIsBox(10, 15) = &H1B
	FIsBox(11, 00) = &HFC
	FIsBox(11, 01) = &H56
	FIsBox(11, 02) = &H3E
	FIsBox(11, 03) = &H4B
	FIsBox(11, 04) = &HC6
	FIsBox(11, 05) = &HD2
	FIsBox(11, 06) = &H79
	FIsBox(11, 07) = &H20
	FIsBox(11, 08) = &H9A
	FIsBox(11, 09) = &HDB
	FIsBox(11, 10) = &HC0
	FIsBox(11, 11) = &HFE
	FIsBox(11, 12) = &H78
	FIsBox(11, 13) = &HCD
	FIsBox(11, 14) = &H5A
	FIsBox(11, 15) = &HF4
	FIsBox(12, 00) = &H1F
	FIsBox(12, 01) = &HDD
	FIsBox(12, 02) = &HA8
	FIsBox(12, 03) = &H33
	FIsBox(12, 04) = &H88
	FIsBox(12, 05) = &H07
	FIsBox(12, 06) = &HC7
	FIsBox(12, 07) = &H31
	FIsBox(12, 08) = &HB1
	FIsBox(12, 09) = &H12
	FIsBox(12, 10) = &H10
	FIsBox(12, 11) = &H59
	FIsBox(12, 12) = &H27
	FIsBox(12, 13) = &H80
	FIsBox(12, 14) = &HEC
	FIsBox(12, 15) = &H5F
	FIsBox(13, 00) = &H60
	FIsBox(13, 01) = &H51
	FIsBox(13, 02) = &H7F
	FIsBox(13, 03) = &HA9
	FIsBox(13, 04) = &H19
	FIsBox(13, 05) = &HB5
	FIsBox(13, 06) = &H4A
	FIsBox(13, 07) = &H0D
	FIsBox(13, 08) = &H2D
	FIsBox(13, 09) = &HE5
	FIsBox(13, 10) = &H7A
	FIsBox(13, 11) = &H9F
	FIsBox(13, 12) = &H93
	FIsBox(13, 13) = &HC9
	FIsBox(13, 14) = &H9C
	FIsBox(13, 15) = &HEF
	FIsBox(14, 00) = &HA0
	FIsBox(14, 01) = &HE0
	FIsBox(14, 02) = &H3B
	FIsBox(14, 03) = &H4D
	FIsBox(14, 04) = &HAE
	FIsBox(14, 05) = &H2A
	FIsBox(14, 06) = &HF5
	FIsBox(14, 07) = &HB0
	FIsBox(14, 08) = &HC8
	FIsBox(14, 09) = &HEB
	FIsBox(14, 10) = &HBB
	FIsBox(14, 11) = &H3C
	FIsBox(14, 12) = &H83
	FIsBox(14, 13) = &H53
	FIsBox(14, 14) = &H99
	FIsBox(14, 15) = &H61
	FIsBox(15, 00) = &H17
	FIsBox(15, 01) = &H2B
	FIsBox(15, 02) = &H04
	FIsBox(15, 03) = &H7E
	FIsBox(15, 04) = &HBA
	FIsBox(15, 05) = &H77
	FIsBox(15, 06) = &HD6
	FIsBox(15, 07) = &H26
	FIsBox(15, 08) = &HE1
	FIsBox(15, 09) = &H69
	FIsBox(15, 10) = &H14
	FIsBox(15, 11) = &H63
	FIsBox(15, 12) = &H55
	FIsBox(15, 13) = &H21
	FIsBox(15, 14) = &H0C
	FIsBox(15, 15) = &H7D
End Function

Private Function BuildRcon()
	FRcon(00, 00) = &H00
	FRcon(00, 01) = &H00
	FRcon(00, 02) = &H00
	FRcon(00, 03) = &H00
	FRcon(01, 00) = &H01
	FRcon(01, 01) = &H00
	FRcon(01, 02) = &H00
	FRcon(01, 03) = &H00
	FRcon(02, 00) = &H02
	FRcon(02, 01) = &H00
	FRcon(02, 02) = &H00
	FRcon(02, 03) = &H00
	FRcon(03, 00) = &H04
	FRcon(03, 01) = &H00
	FRcon(03, 02) = &H00
	FRcon(03, 03) = &H00
	FRcon(04, 00) = &H08
	FRcon(04, 01) = &H00
	FRcon(04, 02) = &H00
	FRcon(04, 03) = &H00
	FRcon(05, 00) = &H10
	FRcon(05, 01) = &H00
	FRcon(05, 02) = &H00
	FRcon(05, 03) = &H00
	FRcon(06, 00) = &H20
	FRcon(06, 01) = &H00
	FRcon(06, 02) = &H00
	FRcon(06, 03) = &H00
	FRcon(07, 00) = &H40
	FRcon(07, 01) = &H00
	FRcon(07, 02) = &H00
	FRcon(07, 03) = &H00
	FRcon(08, 00) = &H80
	FRcon(08, 01) = &H00
	FRcon(08, 02) = &H00
	FRcon(08, 03) = &H00
	FRcon(09, 00) = &H1B
	FRcon(09, 01) = &H00
	FRcon(09, 02) = &H00
	FRcon(09, 03) = &H00
	FRcon(10, 00) = &H36
	FRcon(10, 01) = &H00
	FRcon(10, 02) = &H00
	FRcon(10, 03) = &H00
End Function

End Class
%>