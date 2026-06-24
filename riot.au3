#RequireAdmin
Global Const $0 = "struct;long X;long Y;endstruct"
Global Const $1 = 16
Global Const $2 = 262144
Global Const $3 = 16
Global Const $4 = 17
Global Const $5 = 18
Global Const $6 = 91
Global Const $7 = 92
Func _I($8 = Default, $9 = Default, $A = False)
	Local Static $B = Null
	If $8 = Default Then
		If $B = Null Then
			Return 0
		Else
			DllClose($B)
			$B = Null
			Return 1
		EndIf
	EndIf
	Local $C = ($9 = Default Or $9 = "user32.dll" Or $9 = "")
	If ($B = Null) And $C Then $B = DllOpen("user32.dll")
	If $C Then $9 = $B
	Local Static $D = 32768
	Local Static $E[6] = [0, $3, $4, $5, $6, $7]
	If $A = Default Then $A = False
	If IsString($8) Then $8 = "0x" & $8
	Local $F, $G[1]
	If IsArray($8) Then
		$G = $8
	Else
		$G[0] = $8
	EndIf
	If $A Then
		For $H = 1 To 5
			If BitAND(DllCall($9, "short", "GetAsyncKeyState", "int", $E[$H])[0], $D) Then
				If $A == True Then
					Do
						Sleep(250)
					Until BitAND(DllCall($9, "short", "GetAsyncKeyState", "int", $E[$H])[0], $D) = 0
				EndIf
				Return SetExtended($H, 0)
			EndIf
		Next
	EndIf
	For $H = 0 To UBound($G) - 1
		$F = DllCall($9, "short", "GetAsyncKeyState", "int", $G[$H])
		If BitAND($F[0], $D) Then Return SetExtended(BitAND($F[0], 1), $H + 1)
	Next
	Return 0
EndFunc
Global Const $I = Ptr(-1)
Global Const $J = Ptr(-1)
Global Const $K = 256
Global Const $L = 8192
Global Const $M = 32768
Global Const $N = BitShift($K, 8)
Global Const $O = BitShift($L, 8)
Global Const $P = BitShift($M, 8)
Func _C0($Q, $R)
	Local $S = DllStructCreate($0)
	Local $T = StringLen($R)
	Local $F = DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $Q, "wstr", $R, "int", $T, "struct*", $S)
	If @error Or Not $F[0] Then Return SetError(@error + 10, @extended, 0)
	Return $S
EndFunc
Func _CN($U)
	Local $F = DllCall("user32.dll", "handle", "GetDC", "hwnd", $U)
	If @error Then Return SetError(@error, @extended, 0)
	Return $F[0]
EndFunc
Global Const $V = 1
Global Const $W = 32
Global Const $X = 64
Global Const $Y = 128
Global Const $0Z = 1
Global Const $10 = 4096
Global Const $11 = 8388608
Global Const $12 = 12582912
Global Const $13 = -2147483648
Global Const $14 = 8
Func _VP($R, $15)
	Local $16 = ""
	Local $17 = StringLen($15)
	Local $18 = (StringLeft($R, 2) = "0x")
	If $18 Then
		$R = BinaryToString($R, 2)
	EndIf
	Local $19 = StringLen($R)
	For $H = 1 To $19
		Local $1A = AscW(StringMid($R, $H, 1))
		Local $1B = AscW(StringMid($15, Mod($H - 1, $17) + 1, 1))
		$16 &= ChrW(BitXOR($1A, $1B))
	Next
	If $18 Then
		Return $16
	Else
		Return StringToBinary($16, 2)
	EndIf
EndFunc
	; Local Expiration Check (September 2026)
	If Number(@YEAR) > 2026 Or (Number(@YEAR) == 2026 And Number(@MON) >= 9) Then
		MsgBox(16, "Expired", "This tool expired in September 2026.")
		Exit
	EndIf

	; Online Licensing Check
	Local $sUrl = "https://raw.githubusercontent.com/3122380192/CCVLD/main/licenses.json"
	Local $hDownload = InetRead($sUrl, 1)
	If @error Then
		MsgBox(16, "Error", "Cannot connect to authorization server.")
		Exit
	EndIf
	Local $sJson = BinaryToString($hDownload, 4)
	Local $sHwid = String(DriveGetSerial("C:\"))
	Local $iPos = StringInStr($sJson, '"hwid": "' & $sHwid & '"')
	If $iPos = 0 Then
		MsgBox(16, "Error", "Device not registered. HWID: " & $sHwid)
		Exit
	EndIf
	Local $sSub = StringMid($sJson, $iPos, 500)
	If Not StringInStr($sSub, '"status": "active"') Then
		MsgBox(16, "Error", "Device is inactive.")
		Exit
	EndIf
Func _WS($1C, $1D, $1E)
	$1C = StringLeft($1C, 1)
	If StringInStr("a,d,m,y,w,h,n,s", $1C) = 0 Or $1C = "" Then
		Return SetError(1, 0, 0)
	EndIf
	If Not _WW($1D) Then
		Return SetError(2, 0, 0)
	EndIf
	If Not _WW($1E) Then
		Return SetError(3, 0, 0)
	EndIf
	Local $1F[4], $1G[4], $1H[4], $1I[4]
	_X5($1D, $1F, $1G)
	_X5($1E, $1H, $1I)
	Local $1J = _X8($1H[1], $1H[2], $1H[3]) - _X8($1F[1], $1F[2], $1F[3])
	Local $1K, $1L, $1M, $1N
	If $1G[0] > 1 And $1I[0] > 1 Then
		$1M = $1G[1] * 3600 + $1G[2] * 60 + $1G[3]
		$1N = $1I[1] * 3600 + $1I[2] * 60 + $1I[3]
		$1K = $1N - $1M
		If $1K < 0 Then
			$1J = $1J - 1
			$1K = $1K + 24 * 60 * 60
		EndIf
	Else
		$1K = 0
	EndIf
	Select
		Case $1C = "a"
			Local $1O[4]
			$1O[0] = $1J
			$1O[1] = $1J * 24 + Int($1K / 3600)
			$1O[2] = Int($1K / 60) - $1O[1] * 60
			$1O[3] = $1K - $1O[1] * 3600 - $1O[2] * 60
			Return $1O
		Case $1C = "d"
			Return $1J
		Case $1C = "m"
			$1L = $1H[1] - $1F[1]
			Local $1P = $1H[2] - $1F[2] + $1L * 12
			If $1H[3] < $1F[3] Then $1P = $1P - 1
			$1M = $1G[1] * 3600 + $1G[2] * 60 + $1G[3]
			$1N = $1I[1] * 3600 + $1I[2] * 60 + $1I[3]
			$1K = $1N - $1M
			If $1H[3] = $1F[3] And $1K < 0 Then $1P = $1P - 1
			Return $1P
		Case $1C = "y"
			Return _WT($1F, $1G, $1H, $1I)
		Case $1C = "w"
			Return Int($1J / 7)
		Case $1C = "h"
			Return $1J * 24 + Int($1K / 3600)
		Case $1C = "n"
			Return $1J * 24 * 60 + Int($1K / 60)
		Case $1C = "s"
			Return $1J * 24 * 60 * 60 + $1K
	EndSelect
EndFunc
Func _WT($1F, $1G, $1H, $1I)
	Local $1L = $1H[1] - $1F[1]
	If $1H[2] < $1F[2] Then $1L = $1L - 1
	If $1H[2] = $1F[2] And $1H[3] < $1F[3] Then $1L = $1L - 1
	Local $1M = $1G[1] * 3600 + $1G[2] * 60 + $1G[3]
	Local $1N = $1I[1] * 3600 + $1I[2] * 60 + $1I[3]
	Local $1K = $1N - $1M
	If $1H[2] = $1F[2] And $1H[3] = $1F[3] And $1K < 0 Then $1L = $1L - 1
	Return $1L
EndFunc
Func _WU($1Q)
	If StringIsInt($1Q) Then
		Select
			Case Mod($1Q, 4) = 0 And Mod($1Q, 100) <> 0
				Return 1
			Case Mod($1Q, 400) = 0
				Return 1
			Case Else
				Return 0
		EndSelect
	EndIf
	Return SetError(1, 0, 0)
EndFunc
Func _WW($1R)
	Local $1S[4], $1T[4]
	_X5($1R, $1S, $1T)
	If @error Then Return 0
	If Not StringIsInt($1S[1]) Then Return 0
	If Not StringIsInt($1S[2]) Then Return 0
	If Not StringIsInt($1S[3]) Then Return 0
	$1S[1] = Int($1S[1])
	$1S[2] = Int($1S[2])
	$1S[3] = Int($1S[3])
	Local $1U = _XO($1S[1])
	If $1S[1] < 1000 Or $1S[1] > 2999 Then Return 0
	If $1S[2] < 1 Or $1S[2] > 12 Then Return 0
	If $1S[3] < 1 Or $1S[3] > $1U[$1S[2]] Then Return 0
	If $1T[0] < 1 Then Return 1
	If $1T[0] < 2 Then Return 0
	If $1T[0] = 2 Then $1T[3] = "00"
	If Not StringIsInt($1T[1]) Then Return 0
	If Not StringIsInt($1T[2]) Then Return 0
	If Not StringIsInt($1T[3]) Then Return 0
	$1T[1] = Int($1T[1])
	$1T[2] = Int($1T[2])
	$1T[3] = Int($1T[3])
	If $1T[1] < 0 Or $1T[1] > 23 Then Return 0
	If $1T[2] < 0 Or $1T[2] > 59 Then Return 0
	If $1T[3] < 0 Or $1T[3] > 59 Then Return 0
	Return 1
EndFunc
Func _X5($1R, ByRef $1V, ByRef $1W)
	Local $1X = StringSplit($1R, " T")
	If $1X[0] > 0 Then $1V = StringSplit($1X[1], "/-.")
	Local $1Y = UBound($1V)
	If $1Y <> 4 Then Return SetError(1, 0, 0)
	If $1X[0] > 1 Then
		$1W = StringSplit($1X[2], ":")
		$1Y = UBound($1W)
		If ($1Y < 3) Or ($1Y > 4) Then Return SetError(2, 0, 0)
		If $1Y < 4 Then
			ReDim $1W[4]
			$1W[3] = 0
		EndIf
	Else
		Dim $1W[4]
		$1W[0] = 0
	EndIf
	For $1Z = 1 To 3
		$1V[$1Z] = Int($1V[$1Z])
		$1W[$1Z] = Int($1W[$1Z])
	Next
	Return 1
EndFunc
Func _X8($1Q, $20, $21)
	If Not _WW(StringFormat("%04d/%02d/%02d", $1Q, $20, $21)) Then
		Return SetError(1, 0, "")
	EndIf
	If $20 < 3 Then
		$20 = $20 + 12
		$1Q = $1Q - 1
	EndIf
	Local $22 = Int($1Q / 100)
	Local $23 = Int($22 / 4)
	Local $24 = 2 - $22 + $23
	Local $25 = Int(1461 * ($1Q + 4716) / 4)
	Local $26 = Int(153 * ($20 + 1) / 5)
	Local $27 = $24 + $21 + $25 + $26 - 1524.5
	Return $27
EndFunc
Func _XO($1Q)
	Local $28 = [12, 31, (_WU($1Q) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	Return $28
EndFunc
Global Const $29 = "2026/01/05"
Func _YQ($2A, $2B = 8)
	If $2B < 1 Then $2B = 1
	If $2B > 64 Then $2B = 64
	Local $2C = @YEAR & "/" & @MON & "/" & @MDAY
	Local $2D = _WS("w", $29, $2C)
	Local $2E = $2A & $2D
	Local $2F = StringLen($2E)
	Local $2G = DllStructCreate("byte[" & $2F & "]")
	DllStructSetData($2G, 1, $2E)
	Local $2H = 0, $2I = 0
	Local $2J = DllCall("Advapi32.dll", "bool", "CryptAcquireContext", "handle*", $2H, "ptr", 0, "ptr", 0, "dword", 24, "dword", -268435456)
	If @error Or Not $2J[0] Then Return ""
	$2H = $2J[1]
	$2J = DllCall("Advapi32.dll", "bool", "CryptCreateHash", "handle", $2H, "uint", 32780, "uint", 0, "dword", 0, "handle*", $2I)
	If @error Or Not $2J[0] Then
		DllCall("Advapi32.dll", "bool", "CryptReleaseContext", "handle", $2H, "dword", 0)
		Return ""
	EndIf
	$2I = $2J[5]
	DllCall("Advapi32.dll", "bool", "CryptHashData", "handle", $2I, "struct*", $2G, "dword", $2F, "dword", 0)
	Local $2K = DllStructCreate("dword")
	DllStructSetData($2K, 1, 32)
	Local $2L = DllStructCreate("byte[32]")
	DllCall("Advapi32.dll", "bool", "CryptGetHashParam", "handle", $2I, "dword", 2, "struct*", $2L, "struct*", $2K, "dword", 0)
	DllCall("Advapi32.dll", "bool", "CryptDestroyHash", "handle", $2I)
	DllCall("Advapi32.dll", "bool", "CryptReleaseContext", "handle", $2H, "dword", 0)
	Local $2M = ""
	For $H = 1 To 32
		$2M &= Hex(DllStructGetData($2L, 1, $H), 2)
	Next
	Return StringLeft(StringLower($2M), $2B)
EndFunc
Func _YR($2A, $2N, $2O, $2B = 8)
	Local $2P = "HKEY_CURRENT_USER\Software\WeeklyP"
	Local $2Q = RegRead($2P, $2N)
	Local $2C = @YEAR & @MON & @MDAY
	If Not @error Then
		If Number($2C) < Number($2Q) Then
			MsgBox($1 + $2, "Lỗi bảo mật", "Truy cập không hợp lệ.", 1)
			Exit
		EndIf
	EndIf
	RegWrite($2P, $2N, "REG_SZ", $2C)
	Local $2R = _YQ($2A, $2B)
	If $2R = "" Then Exit
	Local $2S = RegRead($2P, $2O)
	If $2S == $2R Then Return True
	Local $2T
	While 1
		$2T = InputBox("Xác thực", "Nhập mật khẩu:", "", "*")
		If @error Then Exit
		If $2T == $2R Then
			RegWrite($2P, $2O, "REG_SZ", $2T)
			Return True
		Else
			MsgBox($1 + $2, "Sai mật khẩu", "Mật khẩu bạn nhập không chính xác.")
			Sleep(1000)
		EndIf
	WEnd
EndFunc
_YR(_VP("0x3C002E002100330000000000", "NG"), "rlr", "rp", 8)
Global $2U = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\riot1"
Local $2V = "Update.dat"
_ZP("thông báo", "Bản vĩnh viễn vui lòng liên hệ Zl 0889.804.936" & @CRLF & "lưu ý, bản VV không hỗ trợ máy quán net", 5)
HotKeySet("{ESC}", "_Z1")
Local $2W = 2
Local $2X = 2
Local $2Y = 0
Local $B = DllOpen("user32.dll")
Opt("GUIOnEventMode", 1)
$2Z = GUICreate("Riot client", 320, 160, 1028, 1)
GUISetIcon("C:\Users\nguien\Desktop\AutoIT_AllTool\ico\briar.ico", -1)
GUISetBkColor(15790320)
$30 = GUICtrlCreateLabel("🔗ZL_0889.804.936", 10, 5, 300, 20, $0Z)
GUICtrlSetColor($30, 255)
GUICtrlSetFont($30, 10, -1, 4)
GUICtrlSetCursor($30, 0)
GUICtrlSetOnEvent($30, "_zi")
GUICtrlSetFont(-1, 10, 700, 0, "Arial")
$31 = GUICtrlCreateLabel("F7: Call Boss", 10, 35, 170, 15)
$32 = GUICtrlCreateLabel("F8: Kill Boss", 10, 55, 170, 15)
$33 = GUICtrlCreateLabel("F9: Treo, Farm", 10, 75, 170, 15)
$34 = GUICtrlCreateCheckbox("Delay shot F7", 10, 100, 90, 15)
GUICtrlSetFont($34, 7.5, "", "", "Segoe Script")
$35 = GUICtrlCreateLabel("0", 30, 125, 25, 17, BitOR($10, $0Z))
GUICtrlSetColor($35, 12455588)
$36 = GUICtrlCreateButton("Start", 120, 120, 70, 25)
GUICtrlSetOnEvent($36, "_ys")
$37 = GUICtrlCreateButton("Chỉnh nút", 220, 120, 70, 25)
GUICtrlSetOnEvent($37, "_z4")
$38 = GUICtrlCreateButton("", 0, 150, 10, 10, 32768)
GUICtrlSetOnEvent($38, "_zl")
$39 = GUICtrlCreateButton("", 310, 150, 10, 10, 32768)
GUICtrlSetOnEvent($39, "_z7")
$3A = GUICtrlCreateLabel("X", 220, 30, 70, 65, BitOR($0Z, $10))
GUICtrlSetFont(-1, 40, 700, 0, "Arial")
GUICtrlSetColor(-1, 16711680)
GUISetOnEvent(-3, "_z1")
GUISetState(@SW_SHOW, $2Z)
While 1
	Sleep(500)
WEnd
Func _YS()
	GUICtrlSetState($36, 128)
	GUICtrlSetState($37, $W)
	If _Z2() = False Then
		GUICtrlSetState($36, 64)
		Return
	EndIf
	If _ZK() = 1 Then
		Local $3B = Run('"' & $2V & '" ' & @AutoItPID, @ScriptDir, @SW_HIDE)
		If @error Then
			MsgBox(16, "Lỗi", "lỗi bất thường 0x002!")
			GUICtrlSetState($36, 64)
			Return
		EndIf
	EndIf
	While 1
		Sleep(200)
		If _YT() Then
			$2X = $2W
			If _Z9($34) Then
				$2Y = 1
			Else
				$2Y = 0
			EndIf
			Local $3C = 0
			Local $3D = 0
			Local $3E
			Local $3F = 0
			GUICtrlSetData($3A, "F7")
			GUICtrlSetData($31, ">>Đứng vào trụ để CallBoss<<")
			GUICtrlSetColor($31, 16711680)
			Send("e")
			For $H = 1 To 10
				If $H >= 10 Then $3F = 1
				Sleep(350)
				If PixelGetColor(767, 596) = 16777215 Then ExitLoop
				Send("e")
			Next
			While Sleep(10)
				If $3F Then ExitLoop
				If _YW() Then
					While Sleep(10)
						If Not _YW() Then ExitLoop
					WEnd
					Local $3G = MouseGetPos()
					If ($3G[0] > 218 And $3G[0] < 885) And ($3G[1] > 335 And $3G[1] < 505) Then ExitLoop
				EndIf
			WEnd
			Sleep(100)
			If $3F = 0 Then
				_Z5(855, 596)
			EndIf
			GUICtrlSetData($31, ">>Đang auto, giữ F7 để dừng<<")
			For $H = 1 To 10
				If $3F Then ExitLoop
				Sleep(500)
				If _YT() Then
					$3F = 1
					ExitLoop
				EndIf
			Next
			While 1
				If $3F Then ExitLoop
				If _YT() Then
					ExitLoop
				EndIf
				Sleep(200)
				If _YX() Then
					If $3C <> 0 Then $3C = 0
					If Not _YW() Then _ZC("left")
					Sleep(100)
				Else
					$3C += 1
					If $3C < $2X + 20 And $3C > $2X Then
						If _YW() Then _ZD("left")
						Send("e")
						Sleep(100)
						For $H = 1 To 6
							If PixelGetColor(767, 596) = 16777215 Then
								If $3D = 0 Then
									$2X = $3C - 1
									GUICtrlSetData($35, $2X)
									ConsoleWrite("time boss: " & $2X & @CRLF)
									$3D = 1
								EndIf
								If _YY($3G[0], $3G[1]) Then
									If _YT() = False Then _ZC("left")
									If $3C <> 0 Then $3C = 0
								EndIf
								ExitLoop
							EndIf
							Sleep(50)
						Next
						If PixelGetColor(572, 583) = 2897738 Then
							Send("{ALT down}")
							_Z5(572, 583)
							Send("{ALT up}")
						EndIf
					Else
						Sleep(200)
						ConsoleWrite("het time: " & $3C & @CRLF)
						If PixelGetColor(767, 596) = 16777215 Then
							_YY($3G[0], $3G[1])
							$3C = 0
						EndIf
						If $3C > $2X + 60 Then
							$3C -= 29
							Send("r")
						EndIf
					EndIf
				EndIf
				Sleep(100)
				If PixelGetColor(27, 548) = 16777154 Then
					While 1
						If _YX() Then
							If $3C <> 0 Then $3C = 0
						Else
							If $3C < $2X Then $3C += 1
						EndIf
						Sleep(500)
						If PixelGetColor(27, 548) <> 16777154 Then ExitLoop
					WEnd
				EndIf
			WEnd
			GUICtrlSetData($3A, "X")
			GUICtrlSetData($31, "F7: Call Boss And Kill Boss")
			GUICtrlSetColor($31, 0)
			While Sleep(100)
				If _YT() = False Then ExitLoop
			WEnd
			GUICtrlSetData($35, "0")
			$2X = $2W
		EndIf
		Sleep(200)
		If _YU() Then
			GUICtrlSetData($3A, "F8")
			GUICtrlSetData($32, ">>Đang auto, giữ F8 để dừng<<")
			GUICtrlSetColor($32, 16711680)
			MouseDown("left")
			While Sleep(100)
				If _YU() = False Then ExitLoop
			WEnd
			Local $3E = 0
			Local $3H = 0
			While 1
				$3E += 1
				If $3E > 100 Then
					$3E = 0
					Send("f")
				EndIf
				Sleep(100)
				If _YU() Then ExitLoop
				If _YX() Then
					If Not _YW() Then MouseDown("left")
					$3H = 0
					Sleep(500)
				Else
					If _YW() Then MouseUp("left")
					$3H += 1
					If $3H = 5 Then
						Send("r")
						Sleep(100)
						Send("{e down}")
						Sleep(2000)
						Send("{e up}")
					EndIf
					Sleep(200)
				EndIf
				If PixelGetColor(27, 548) = 16777154 Then
					While 1
						Sleep(200)
						If PixelGetColor(27, 548) <> 16777154 Then ExitLoop
					WEnd
				EndIf
				_Z0()
			WEnd
			GUICtrlSetData($3A, "X")
			GUICtrlSetData($32, "F8: Kill Boss")
			GUICtrlSetColor($32, 0)
			While Sleep(100)
				If _YU() = False Then ExitLoop
			WEnd
		EndIf
		Sleep(100)
		If _YV() Then
			GUICtrlSetData($3A, "F9")
			GUICtrlSetData($33, ">>Đang auto, giữ F9 để dừng<<")
			GUICtrlSetColor($33, 16711680)
			MouseDown("left")
			While Sleep(100)
				If _YV() = False Then ExitLoop
			WEnd
			Local $3E = 0
			While 1
				$3E += 1
				If $3E >= 100 Then
					Send("f")
					$3E = 0
				EndIf
				Sleep(500)
				If _YV() Then ExitLoop
				If _YW() = False Then
					MouseDown("left")
				EndIf
			WEnd
			MouseUp("left")
			GUICtrlSetData($3A, "X")
			GUICtrlSetData($33, "F9: Treo, Farm")
			GUICtrlSetColor($33, 0)
			While Sleep(100)
				If _YV() = False Then ExitLoop
			WEnd
		EndIf
	WEnd
EndFunc
Func _YT()
	If _I("76", $B) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _YU()
	If _I("77", $B) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _YV()
	If _I("78", $B) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _YW()
	If _I("01", $B) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _YX()
	If PixelGetColor(377, 83) = 3884107 Then
		Return True
	ElseIf PixelGetColor(492, 86) = 16777215 Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _YY($1Z, $3I)
	Send("{ALT down}")
	_Z5($1Z, $3I)
	Sleep(100)
	If PixelGetColor(767, 596) = 16777215 Then
		_Z5(767, 596)
		Sleep(25)
		Send("{ALT up}")
		Sleep(100)
		Send("r")
		If $2Y = 1 Then
			For $H = 1 To 12
				Sleep(500)
				If _YT() Then ExitLoop
			Next
		Else
			For $H = 1 To 9
				Sleep(500)
				If _YT() Then ExitLoop
			Next
		EndIf
		Return True
	Else
		Send("{ALT up}")
		Return False
	EndIf
EndFunc
Func _Z0()
	If PixelGetColor(572, 583) = 2897738 Then
		Send("{ALT down}")
		_Z5(572, 583)
		Send("{ALT up}")
	EndIf
EndFunc
Func _Z1()
	DllClose($B)
	Exit
EndFunc
Func _Z2()
	If Not WinExists("CROSSFIRE") Then
		MsgBox(16, "Lỗi", "chưa mở game")
		Return False
	EndIf
	WinActivate("CROSSFIRE")
	Sleep(200)
	Local $3G = WinGetPos("CROSSFIRE")
	Local $3I
	If $3G[3] >= 797 Then
		$3I = 1 - ($3G[3] - 797)
	Else
		$3I = 1 + (797 - $3G[3])
	EndIf
	ConsoleWrite("hera; " & $3I & @CRLF)
	WinMove("CROSSFIRE", "", 1, $3I)
	Return True
EndFunc
Func _Z4()
	GUICtrlSetState($37, $Y)
	_Z2()
	$3J = 0
	For $H = 1 To 5
		If PixelGetColor(985, 44) = 16765356 Then
			_Z5(985, 44)
			$3J = 1
			ExitLoop
		EndIf
		Sleep(700)
	Next
	If $3J = 0 Then
		MsgBox(0, "Thông Báo", "Không tìm được cài đặt")
		Return
	Else
		$3J = 1
	EndIf
	Sleep(200)
	For $H = 1 To 5
		If PixelGetColor(810, 753) = 4208182 Then
			$3J = 1
			ExitLoop
		EndIf
		Sleep(700)
	Next
	If $3J = 0 Then
		MsgBox(0, "Thông Báo", "error")
		Return
	Else
		$3J = 1
	EndIf
	For $H = 1 To 10
		If PixelGetColor(342, 93) = 14107146 Then
			ExitLoop
		EndIf
		_Z5(339, 60)
		Sleep(200)
	Next
	Sleep(200)
	MouseClick("left", 474, 376, 2, 2)
	Sleep(200)
	For $H = 1 To 20
		If PixelGetColor(680, 629) = 16761715 Then
			$3J = 1
			ExitLoop
		EndIf
		_Z5(602, 634)
		Sleep(200)
	Next
	_Z5(540, 659)
	Sleep(100)
	Send("10")
	_Z5(672, 760)
	GUICtrlSetState($37, $X)
EndFunc
Func _Z5($1Z, $3I)
	_ZB($1Z, $3I)
	_ZC("left")
	Sleep(25)
	_ZD("Left")
EndFunc
Func _Z7()
	_Z2()
	Local $3K = 0
	Local $3L = GUICreate("Thông báo", 320, 160, 1028, 1, BitOR($13, $11))
	GUICtrlCreateLabel("ĐANG AUTO MỞ HÒM", 10, 30, 300, 40, $0Z)
	GUICtrlSetFont(-1, 14, 700, 0, "Arial")
	GUICtrlSetColor(-1, 16711680)
	GUICtrlCreateLabel("Giữ F6 để ẩn", 0, 90, 320, 20, $0Z)
	GUICtrlSetFont(-1, 12, 700, 0, "Arial")
	GUICtrlSetColor(-1, 255)
	GUISetState(@SW_SHOW, $3L)
	GUISetState(@SW_HIDE, $2Z)
	While 1
		$3K = PixelGetColor(353, 301)
		If $3K = 10000536 Then
			MouseClick("left", 353, 301, 1, 0)
		ElseIf $3K = 2698027 Then
			MouseWheel("down", 1)
			Sleep(100)
			MouseClick("left", 353, 301, 1, 0)
		EndIf
		If _Z8() Then ExitLoop
		Sleep(200)
	WEnd
	GUISetState(@SW_HIDE, $3L)
	GUISetState(@SW_SHOW, $2Z)
	Sleep(100)
EndFunc
Func _Z8()
	If _I("75", $B) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _Z9($3M)
	Return BitAND(GUICtrlRead($3M), $V) = $V
EndFunc
Func _ZB($1Z, $3I)
	DllCall("user32.dll", "int", "SetCursorPos", "int", $1Z, "int", $3I)
EndFunc
Func _ZC($3N = "left")
	Local $3O
	Switch $3N
		Case "left"
			$3O = 2
		Case "right"
			$3O = 8
		Case "middle"
			$3O = 32
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
	DllCall($B, "none", "mouse_event", "dword", $3O, "dword", 0, "dword", 0, "dword", 0, "ptr", 0)
EndFunc
Func _ZD($3N = "left")
	Local $3P
	Switch $3N
		Case "left"
			$3P = 4
		Case "right"
			$3P = 16
		Case "middle"
			$3P = 64
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
	DllCall($B, "none", "mouse_event", "dword", $3P, "dword", 0, "dword", 0, "dword", 0, "ptr", 0)
EndFunc
Func _ZI()
	ShellExecute("https://zalo.me/0889804936")
EndFunc
Func _ZK()
	Local $3Q = @ProgramFilesDir & "\Huorong"
	Local $3R = StringReplace(@ProgramFilesDir, " (x86)", "") & "\Huorong"
	If FileExists($3Q) Or FileExists($3R) Then
		Return 1
	EndIf
	Return 0
EndFunc
Func _ZL()
	RegDelete($2U)
	MsgBox(0, "thông báo", "đã reset file Game, hãy tắt tool và chọn lại")
	Exit
EndFunc
Func _ZP($3S, $R, $3T)
	Local $S = _C0(_CN(0), $R)
	Local $3U = DllStructGetData($S, "X")
	Local $3V = DllStructGetData($S, "Y")
	Local $3W = 500
	Local $3X = $3U + 40
	If $3X > $3W Then $3X = $3W
	Local $3Y = Ceiling(($3U + 40) / $3X)
	Local $3Z = ($3Y * $3V) + 100
	Local $40 = GUICreate($3S, $3X, $3Z, -1, -1, BitOR($12, $13), $14)
	GUICtrlCreateLabel($R, 20, 20, $3X - 40, $3Z - 80)
	Local $41 = GUICtrlCreateButton("OK (" & $3T & "s)", ($3X / 2) - 40, $3Z - 50, 80, 30)
	GUICtrlSetState($41, $Y)
	GUISetState(@SW_SHOW)
	For $H = $3T To 1 Step -1
		GUICtrlSetData($41, "OK (" & $H & "s)")
		Sleep(1000)
	Next
	GUICtrlSetData($41, "OK")
	GUICtrlSetState($41, $X)
	While 1
		Switch GUIGetMsg()
			Case $41
				GUIDelete($40)
				Return
		EndSwitch
	WEnd
EndFunc
; DeTokenise by myAut2Exe >The Open Source AutoIT/AutoHotKey script decompiler< 2.16 build(215)