#RequireAdmin
Global Const $0 = 16
Global Const $1 = 17
Global Const $2 = 18
Global Const $3 = 91
Global Const $4 = 92
Func _I($5 = Default, $6 = Default, $7 = False)
	Local Static $8 = Null
	If $5 = Default Then
		If $8 = Null Then
			Return 0
		Else
			DllClose($8)
			$8 = Null
			Return 1
		EndIf
	EndIf
	Local $9 = ($6 = Default Or $6 = "user32.dll" Or $6 = "")
	If ($8 = Null) And $9 Then $8 = DllOpen("user32.dll")
	If $9 Then $6 = $8
	Local Static $A = 32768
	Local Static $B[6] = [0, $0, $1, $2, $3, $4]
	If $7 = Default Then $7 = False
	If IsString($5) Then $5 = "0x" & $5
	Local $C, $D[1]
	If IsArray($5) Then
		$D = $5
	Else
		$D[0] = $5
	EndIf
	If $7 Then
		For $E = 1 To 5
			If BitAND(DllCall($6, "short", "GetAsyncKeyState", "int", $B[$E])[0], $A) Then
				If $7 == True Then
					Do
						Sleep(250)
					Until BitAND(DllCall($6, "short", "GetAsyncKeyState", "int", $B[$E])[0], $A) = 0
				EndIf
				Return SetExtended($E, 0)
			EndIf
		Next
	EndIf
	For $E = 0 To UBound($D) - 1
		$C = DllCall($6, "short", "GetAsyncKeyState", "int", $D[$E])
		If BitAND($C[0], $A) Then Return SetExtended(BitAND($C[0], 1), $E + 1)
	Next
	Return 0
EndFunc
Global Const $F = Ptr(-1)
Global Const $G = Ptr(-1)
Global Const $H = 256
Global Const $I = 8192
Global Const $J = 32768
Global Const $K = BitShift($H, 8)
Global Const $L = BitShift($I, 8)
Global Const $M = BitShift($J, 8)
Global Const $N = 1
Global Const $O = 32
Global Const $P = 64
Global Const $Q = 128
Global Const $R = 1
Global Const $S = 4096
Global Const $T = 8388608
Global Const $U = -2147483648
Global $V = ""
Global $W = ""
Global $X = ""
Global $Y = ""
Global $0Z = @ScriptDir & "\NG.dll"
Func _TO($10)
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
	$W = "ACTIVE"
	$V = "ACTIVE"
	$X = "https://raw.githubusercontent.com/3122380192/CCVLD/main/"
EndFunc
Func _TP($19, $1A)
	Local $1B = ""
	Local $1C = StringLen($1A)
	Local $1D = (StringLeft($19, 2) = "0x")
	If $1D Then
		$19 = BinaryToString($19, 2)
	EndIf
	Local $1E = StringLen($19)
	For $E = 1 To $1E
		Local $1F = AscW(StringMid($19, $E, 1))
		Local $1G = AscW(StringMid($1A, Mod($E - 1, $1C) + 1, 1))
		$1B &= ChrW(BitXOR($1F, $1G))
	Next
	If $1D Then
		Return $1B
	Else
		Return StringToBinary($1B, 2)
	EndIf
EndFunc
; EnvGet check bypassed
Local $V = "error"
Local $W = -1
Local $Y = -1
Local $1H = DriveGetSerial("C:\")
_TO(8)
ConsoleWrite("user: " & $V & " - id: " & $W & @CRLF)
HotKeySet("{ESC}", "_U2")
Local $1I = 0
Local $1J = 2
Local $1K = 0
Local $8 = DllOpen("user32.dll")
Opt("GUIOnEventMode", 1)
$1L = GUICreate("Bliz premium", 320, 160, 1028, 1)
GUISetIcon("C:\Users\nguien\Desktop\AutoIT_AllTool\ico\briar.ico", -1)
GUISetBkColor(15790320)
$1M = GUICtrlCreateLabel("Key: " & $W & "-" & $V, 10, 5, 300, 20, $R)
GUICtrlSetColor($1M, 16711680)
GUICtrlSetFont($1M, 10, -1, 4)
GUICtrlSetCursor($1M, 0)
GUICtrlSetOnEvent($1M, "_uf")
GUICtrlSetFont(-1, 10, 700, 0, "Arial")
$1N = GUICtrlCreateLabel("F7: Call Boss", 10, 35, 170, 15)
$1O = GUICtrlCreateLabel("F8: Kill Boss", 10, 55, 170, 15)
$1P = GUICtrlCreateLabel("F9: Treo, Farm", 10, 75, 170, 15)
$1Q = GUICtrlCreateCheckbox("Delay shot F7", 10, 100, 90, 15)
GUICtrlSetFont($1Q, 7.5, "", "", "Segoe Script")
$1R = GUICtrlCreateLabel("0", 10, 125, 25, 17, BitOR($S, $R))
$1S = GUICtrlCreateCheckbox("DT", 50, 122)
GUICtrlSetColor($1R, 12455588)
GUICtrlSetState($1R, $O)
$1T = GUICtrlCreateCheckbox("EF", 10, 125, 30, 17)
GUICtrlSetState($1T, $N)
$1U = GUICtrlCreateButton("▶ RUN", 120, 120, 70, 25)
GUICtrlSetTip($1U, "Bắt đầu chạy")
GUICtrlSetFont($1U, 9)
GUICtrlSetBkColor($1U, 7457838)
GUICtrlSetColor($1U, 16777215)
GUICtrlSetCursor($1U, 0)
GUICtrlSetOnEvent($1U, "_tq")
$1V = GUICtrlCreateButton("Chỉnh nút", 220, 120, 70, 25)
GUICtrlSetOnEvent($1V, "_u5")
$1W = GUICtrlCreateButton("", 0, 150, 10, 10, 32768)
GUICtrlSetOnEvent($1W, "_u7")
$1X = GUICtrlCreateButton("", 310, 150, 10, 10, 32768)
GUICtrlSetOnEvent($1X, "_u8")
$1Y = GUICtrlCreateLabel("X", 220, 30, 70, 65, BitOR($R, $S))
GUICtrlSetFont(-1, 40, 700, 0, "Arial")
GUICtrlSetColor(-1, 16711680)
GUISetOnEvent(-3, "_u2")
GUISetState(@SW_SHOW, $1L)
While 1
	Sleep(500)
WEnd
Func _TQ()
	GUICtrlSetState($1U, 128)
	GUICtrlSetState($1U, $O)
	GUICtrlSetState($1V, $O)
	_U3()
	While 1
		Sleep(200)
		If _TR() Then
			If _UA($1S) Then
				_TT()
			Else
				_TS()
			EndIf
		EndIf
		Sleep(200)
		If _TU() Then
			GUICtrlSetData($1Y, "F8")
			GUICtrlSetData($1O, ">>Đang auto, giữ F8 để dừng<<")
			GUICtrlSetColor($1O, 16711680)
			MouseDown("left")
			While Sleep(100)
				If _TU() = False Then ExitLoop
			WEnd
			Local $1Z = 0
			Local $20 = 0
			While 1
				$1Z += 1
				If $1Z > 100 Then
					$1Z = 0
					Send("z")
				EndIf
				Sleep(100)
				If _TU() Then ExitLoop
				If _TX() Then
					If GUICtrlRead($1T) = $N Then
						Local $21 = Send("ef")
						If @error Then
							ConsoleWrite("Send(F) failed" & @CRLF)
						EndIf
					EndIf
					If Not _TW() Then MouseDown("left")
					$20 = 0
					Sleep(500)
				Else
					If _TW() Then MouseUp("left")
					$20 += 1
					If $20 = 5 Then
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
				_U1()
			WEnd
			GUICtrlSetData($1Y, "X")
			GUICtrlSetData($1O, "F8: Kill Boss")
			GUICtrlSetColor($1O, 0)
			While Sleep(100)
				If _TU() = False Then ExitLoop
			WEnd
		EndIf
		Sleep(100)
		If _TV() Then
			GUICtrlSetData($1Y, "F9")
			GUICtrlSetData($1P, ">>Đang auto, giữ F9 để dừng<<")
			GUICtrlSetColor($1P, 16711680)
			MouseDown("left")
			While Sleep(100)
				If _TV() = False Then ExitLoop
			WEnd
			Local $1Z = 0
			While 1
				$1Z += 1
				If $1Z >= 100 Then
					Send("ef")
					$1Z = 0
				EndIf
				Sleep(200)
				If _TV() Then ExitLoop
				_U1()
				If Not _TW() Then MouseDown("left")
				If PixelGetColor(504, 337) = 9475734 Then
					If _TW() Then MouseUp("left")
					Sleep(500)
					Send("r")
					Sleep(3000)
					If Not _TW() Then MouseDown("left")
					$20 = 0
				EndIf
			WEnd
			MouseUp("left")
			GUICtrlSetData($1Y, "X")
			GUICtrlSetData($1P, "F9: Treo, Farm")
			GUICtrlSetColor($1P, 0)
			While Sleep(100)
				If _TV() = False Then ExitLoop
			WEnd
		EndIf
	WEnd
EndFunc
Func _TR()
	If _I("76", $8) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _TS()
	$1J = $1I
	If _UA($1Q) Then
		$1K = 1
	Else
		$1K = 0
	EndIf
	Local $22 = 0
	Local $23 = 0
	Local $24 = 0
	GUICtrlSetData($1Y, "F7")
	GUICtrlSetData($1N, ">>Đứng vào trụ để CallBoss<<")
	GUICtrlSetColor($1N, 16711680)
	Send("e")
	For $E = 1 To 10
		If $E >= 10 Then $24 = 1
		Sleep(350)
		If PixelGetColor(767, 596) = 16777215 Then ExitLoop
		Send("e")
	Next
	While Sleep(10)
		If $24 Then ExitLoop
		If _TW() Then
			While Sleep(10)
				If Not _TW() Then ExitLoop
			WEnd
			Local $25 = MouseGetPos()
			If ($25[0] > 218 And $25[0] < 885) And ($25[1] > 335 And $25[1] < 505) Then ExitLoop
		EndIf
	WEnd
	Sleep(100)
	If $24 = 0 Then
		_U6(855, 596)
	EndIf
	GUICtrlSetData($1N, ">>Đang auto, giữ F7 để dừng<<")
	For $E = 1 To 10
		If $24 Then ExitLoop
		Sleep(500)
		If _TR() Then
			$24 = 1
			ExitLoop
		EndIf
	Next
	While 1
		If $24 Then ExitLoop
		If _TR() Then
			ExitLoop
		EndIf
		Sleep(200)
		If _TX() Then
			If $22 <> 0 Then $22 = 0
			If Not _TW() Then _UD("left")
			If GUICtrlRead($1T) = $N Then
				Local $21 = Send("ef")
				If @error Then
					ConsoleWrite("Send(F) failed" & @CRLF)
				EndIf
			EndIf
			Sleep(100)
		Else
			$22 += 1
			If $22 < $1J + 20 And $22 > $1J Then
				If _TW() Then _UE("left")
				Send("e")
				Sleep(100)
				For $E = 1 To 6
					If PixelGetColor(767, 596) = 16777215 Then
						If $23 = 0 Then
							$1J = $22 - 1
							GUICtrlSetData($1R, $1J)
							ConsoleWrite("time boss: " & $1J & @CRLF)
							$23 = 1
						EndIf
						If _TY($25[0], $25[1]) Then
							If _TR() = False Then _UD("left")
							If $22 <> 0 Then $22 = 0
						EndIf
						ExitLoop
					EndIf
					Sleep(50)
				Next
				If PixelGetColor(572, 583) = 2897738 Then
					Send("{ALT down}")
					_U6(572, 583)
					Send("{ALT up}")
					Sleep(100)
					_UD("left")
				EndIf
			Else
				Sleep(200)
				ConsoleWrite("het time: " & $22 & @CRLF)
				If PixelGetColor(767, 596) = 16777215 Then
					_TY($25[0], $25[1])
					$22 = 0
				EndIf
				If $22 > $1J + 60 Then
					$22 -= 29
					Send("r")
				EndIf
			EndIf
		EndIf
		Sleep(100)
		If PixelGetColor(27, 548) = 16777154 Then
			While 1
				If _TX() Then
					If $22 <> 0 Then $22 = 0
				Else
					If $22 < $1J Then $22 += 1
				EndIf
				Sleep(500)
				If PixelGetColor(27, 548) <> 16777154 Then ExitLoop
			WEnd
		EndIf
	WEnd
	GUICtrlSetData($1Y, "X")
	GUICtrlSetData($1N, "F7: Call Boss And Kill Boss")
	GUICtrlSetColor($1N, 0)
	While Sleep(100)
		If _TR() = False Then ExitLoop
	WEnd
	GUICtrlSetData($1R, "0")
	$1J = $1I
EndFunc
Func _TT()
	Local $22 = 0
	Local $23 = 0
	Local $24 = 0
	GUICtrlSetData($1Y, "F7")
	GUICtrlSetData($1N, ">>Mode đấu trường, hãy lại trụ<<")
	GUICtrlSetColor($1N, 16711680)
	Send("e")
	For $E = 1 To 10
		If $E >= 10 Then $24 = 1
		Sleep(350)
		If PixelGetColor(483, 630) = 16777215 Then
			Sleep(50)
			_U6(513, 390)
			Sleep(50)
			ExitLoop
		EndIf
		Send("e")
	Next
	While Sleep(10)
		If $24 Then ExitLoop
		If _TW() Then
			While Sleep(10)
				If Not _TW() Then ExitLoop
			WEnd
			Local $25 = MouseGetPos()
			If ($25[0] > 56 And $25[0] < 954) And ($25[1] > 242 And $25[1] < 516) Then ExitLoop
		EndIf
	WEnd
	Sleep(100)
	If $24 = 0 Then
		_U6(506, 635)
	EndIf
	GUICtrlSetData($1N, ">>Đấu trường, giữ F7 để dừng<<")
	For $E = 1 To 10
		If $24 Then ExitLoop
		Sleep(500)
		If _TR() Then
			$24 = 1
			ExitLoop
		EndIf
	Next
	While 1
		If $24 Then ExitLoop
		If _TR() Then
			ExitLoop
		EndIf
		Sleep(200)
		If _TX() Then
			If $22 <> 0 Then $22 = 0
			If Not _TW() Then _UD("left")
			If GUICtrlRead($1T) = $N Then
				Local $21 = Send("ef")
				If @error Then
					ConsoleWrite("Send(F) failed" & @CRLF)
				EndIf
			EndIf
			Sleep(100)
		Else
			$22 += 1
			If $22 < $1J + 30 And $22 > $1J Then
				If _TW() Then _UE("left")
				Send("e")
				Sleep(100)
				For $E = 1 To 6
					If PixelGetColor(276, 171) = 10385749 Then
						If $23 = 0 Then
							$1J = 2
							GUICtrlSetData($1R, $1J)
							ConsoleWrite("time boss: " & $1J & @CRLF)
							$23 = 1
						EndIf
						If _TZ($25[0], $25[1]) Then
							If _TR() = False Then _UD("left")
							If $22 <> 0 Then $22 = 0
						EndIf
						ExitLoop
					EndIf
					Sleep(50)
				Next
				If PixelGetColor(572, 583) = 2897738 Then
					Send("{ALT down}")
					_U6(572, 583)
					Send("{ALT up}")
				EndIf
			Else
				Sleep(200)
				ConsoleWrite("het time: " & $22 & @CRLF)
				If PixelGetColor(276, 171) = 10385749 Then
					_TZ($25[0], $25[1])
					$22 = 0
				EndIf
				If $22 > $1J + 60 Then
					$22 -= 29
					Send("r")
				EndIf
			EndIf
		EndIf
		Sleep(100)
		If PixelGetColor(27, 548) = 16777154 Then
			While 1
				If _TX() Then
					If $22 <> 0 Then $22 = 0
				Else
					If $22 < $1J Then $22 += 1
				EndIf
				Sleep(500)
				If PixelGetColor(27, 548) <> 16777154 Then ExitLoop
			WEnd
		EndIf
	WEnd
	GUICtrlSetData($1Y, "X")
	GUICtrlSetData($1N, "F7: Call Boss And Kill Boss")
	GUICtrlSetColor($1N, 0)
	While Sleep(100)
		If _TR() = False Then ExitLoop
	WEnd
	GUICtrlSetData($1R, "0")
	$1J = $1I
EndFunc
Func _TU()
	If _I("77", $8) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _TV()
	If _I("78", $8) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _TW()
	If _I("01", $8) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _TX()
	If PixelGetColor(441, 87) = 4035535 Then
		Return True
	ElseIf PixelGetColor(492, 86) = 16777215 Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _TY($26, $27)
	Send("{ALT down}")
	_U6($26, $27)
	Sleep(100)
	If PixelGetColor(767, 596) = 16777215 Then
		_U6(767, 596)
		Sleep(25)
		Send("{ALT up}")
		Sleep(100)
		Send("r")
		If $1K = 1 Then
			For $E = 1 To 12
				Sleep(500)
				If _TR() Then ExitLoop
			Next
		Else
			For $E = 1 To 8
				Sleep(500)
				If _TR() Then ExitLoop
			Next
		EndIf
		Return True
	Else
		Send("{ALT up}")
		Return False
	EndIf
EndFunc
Func _TZ($26, $27)
	Send("{ALT down}")
	_U6(513, 390)
	Sleep(200)
	_U6($26, $27)
	Sleep(100)
	If PixelGetColor(527, 306) = 2603668 Then
		_U6(506, 635)
		Sleep(25)
		Send("{ALT up}")
		Sleep(100)
		Send("r")
		If $1K = 1 Then
			For $E = 1 To 12
				Sleep(500)
				If _TR() Then ExitLoop
			Next
		Else
			For $E = 1 To 8
				Sleep(500)
				If _TR() Then ExitLoop
			Next
		EndIf
		Return True
	Else
		Send("{ALT up}")
		Return False
	EndIf
EndFunc
Func _U1()
	If PixelGetColor(572, 583) = 2897738 Then
		Send("{ALT down}")
		_U6(572, 583)
		Send("{ALT up}")
	EndIf
EndFunc
Func _U2()
	DllClose($8)
	Exit
EndFunc
Func _U3()
	WinActivate("CROSSFIRE")
	Sleep(200)
	Local $25 = WinGetPos("CROSSFIRE")
	Local $27
	If $25[3] >= 797 Then
		$27 = 1 - ($25[3] - 797)
	Else
		$27 = 1 + (797 - $25[3])
	EndIf
	ConsoleWrite("hera; " & $27 & @CRLF)
	WinMove("CROSSFIRE", "", 1, $27)
EndFunc
Func _U5()
	GUICtrlSetState($1V, $Q)
	_U3()
	$28 = 0
	For $E = 1 To 5
		If PixelGetColor(985, 44) = 16765356 Then
			_U6(985, 44)
			$28 = 1
			ExitLoop
		EndIf
		Sleep(700)
	Next
	If $28 = 0 Then
		MsgBox(0, "Thông Báo", "Không tìm được cài đặt")
		Return
	Else
		$28 = 1
	EndIf
	Sleep(200)
	For $E = 1 To 5
		If PixelGetColor(810, 753) = 4208182 Then
			$28 = 1
			ExitLoop
		EndIf
		Sleep(700)
	Next
	If $28 = 0 Then
		MsgBox(0, "Thông Báo", "error")
		Return
	Else
		$28 = 1
	EndIf
	For $E = 1 To 10
		If PixelGetColor(342, 93) = 14107146 Then
			ExitLoop
		EndIf
		_U6(339, 60)
		Sleep(200)
	Next
	Sleep(200)
	MouseClick("left", 474, 376, 2, 2)
	Sleep(200)
	For $E = 1 To 20
		If PixelGetColor(680, 629) = 16761715 Then
			$28 = 1
			ExitLoop
		EndIf
		_U6(602, 634)
		Sleep(200)
	Next
	_U6(540, 659)
	Sleep(100)
	Send("10")
	_U6(672, 760)
	GUICtrlSetState($1V, $P)
EndFunc
Func _U6($26, $27)
	_UC($26, $27)
	_UD("left")
	Sleep(25)
	_UE("Left")
EndFunc
Func _U7()
	Local $29 = InputBox("TimeBoss", "Nhập số time boss thấp nhất.")
	$1I = $29
	$1J = $1I
	GUICtrlSetData($1R, $1J)
EndFunc
Func _U8()
	_U3()
	Local $2A = 0
	Local $2B = GUICreate("Thông báo", 320, 160, 1028, 1, BitOR($U, $T))
	GUICtrlCreateLabel("ĐANG AUTO MỞ HÒM", 10, 30, 300, 40, $R)
	GUICtrlSetFont(-1, 14, 700, 0, "Arial")
	GUICtrlSetColor(-1, 16711680)
	GUICtrlCreateLabel("Giữ F6 để ẩn", 0, 90, 320, 20, $R)
	GUICtrlSetFont(-1, 12, 700, 0, "Arial")
	GUICtrlSetColor(-1, 255)
	GUISetState(@SW_SHOW, $2B)
	GUISetState(@SW_HIDE, $1L)
	While 1
		$2A = PixelGetColor(353, 301)
		If $2A = 10000536 Then
			MouseClick("left", 353, 301, 1, 0)
		ElseIf $2A = 2698027 Then
			MouseWheel("down", 1)
			Sleep(100)
			MouseClick("left", 353, 301, 1, 0)
		EndIf
		If _U9() Then ExitLoop
		Sleep(200)
	WEnd
	GUISetState(@SW_HIDE, $2B)
	GUISetState(@SW_SHOW, $1L)
	Sleep(100)
EndFunc
Func _U9()
	If _I("75", $8) Then
		Return True
	Else
		Return False
	EndIf
EndFunc
Func _UA($2C)
	Return BitAND(GUICtrlRead($2C), $N) = $N
EndFunc
Func _UC($26, $27)
	DllCall("user32.dll", "int", "SetCursorPos", "int", $26, "int", $27)
EndFunc
Func _UD($2D = "left")
	Local $2E
	Switch $2D
		Case "left"
			$2E = 2
		Case "right"
			$2E = 8
		Case "middle"
			$2E = 32
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
	DllCall($8, "none", "mouse_event", "dword", $2E, "dword", 0, "dword", 0, "dword", 0, "ptr", 0)
EndFunc
Func _UE($2D = "left")
	Local $2F
	Switch $2D
		Case "left"
			$2F = 4
		Case "right"
			$2F = 16
		Case "middle"
			$2F = 64
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
	DllCall($8, "none", "mouse_event", "dword", $2F, "dword", 0, "dword", 0, "dword", 0, "ptr", 0)
EndFunc
Func _UF()
	ShellExecute("https://zalo.me/0889804936")
EndFunc
; DeTokenise by myAut2Exe >The Open Source AutoIT/AutoHotKey script decompiler< 2.16 build(215)