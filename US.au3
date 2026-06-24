Global Const $0 = -3
Global Const $1 = 262144
Global Const $2 = 2097152
Global Const $3 = -2134245376
Global Const $4 = 64
Global Const $5 = 2048
Global Const $6 = 16
Global Const $7 = 262144
Func _35($8, $9, $A)
	$8 = StringLeft($8, 1)
	If StringInStr("a,d,m,y,w,h,n,s", $8) = 0 Or $8 = "" Then
		Return SetError(1, 0, 0)
	EndIf
	If Not _39($9) Then
		Return SetError(2, 0, 0)
	EndIf
	If Not _39($A) Then
		Return SetError(3, 0, 0)
	EndIf
	Local $B[4], $C[4], $D[4], $E[4]
	_3I($9, $B, $C)
	_3I($A, $D, $E)
	Local $F = _3L($D[1], $D[2], $D[3]) - _3L($B[1], $B[2], $B[3])
	Local $G, $H, $I, $J
	If $C[0] > 1 And $E[0] > 1 Then
		$I = $C[1] * 3600 + $C[2] * 60 + $C[3]
		$J = $E[1] * 3600 + $E[2] * 60 + $E[3]
		$G = $J - $I
		If $G < 0 Then
			$F = $F - 1
			$G = $G + 24 * 60 * 60
		EndIf
	Else
		$G = 0
	EndIf
	Select
		Case $8 = "a"
			Local $K[4]
			$K[0] = $F
			$K[1] = $F * 24 + Int($G / 3600)
			$K[2] = Int($G / 60) - $K[1] * 60
			$K[3] = $G - $K[1] * 3600 - $K[2] * 60
			Return $K
		Case $8 = "d"
			Return $F
		Case $8 = "m"
			$H = $D[1] - $B[1]
			Local $L = $D[2] - $B[2] + $H * 12
			If $D[3] < $B[3] Then $L = $L - 1
			$I = $C[1] * 3600 + $C[2] * 60 + $C[3]
			$J = $E[1] * 3600 + $E[2] * 60 + $E[3]
			$G = $J - $I
			If $D[3] = $B[3] And $G < 0 Then $L = $L - 1
			Return $L
		Case $8 = "y"
			Return _36($B, $C, $D, $E)
		Case $8 = "w"
			Return Int($F / 7)
		Case $8 = "h"
			Return $F * 24 + Int($G / 3600)
		Case $8 = "n"
			Return $F * 24 * 60 + Int($G / 60)
		Case $8 = "s"
			Return $F * 24 * 60 * 60 + $G
	EndSelect
EndFunc
Func _36($B, $C, $D, $E)
	Local $H = $D[1] - $B[1]
	If $D[2] < $B[2] Then $H = $H - 1
	If $D[2] = $B[2] And $D[3] < $B[3] Then $H = $H - 1
	Local $I = $C[1] * 3600 + $C[2] * 60 + $C[3]
	Local $J = $E[1] * 3600 + $E[2] * 60 + $E[3]
	Local $G = $J - $I
	If $D[2] = $B[2] And $D[3] = $B[3] And $G < 0 Then $H = $H - 1
	Return $H
EndFunc
Func _37($M)
	If StringIsInt($M) Then
		Select
			Case Mod($M, 4) = 0 And Mod($M, 100) <> 0
				Return 1
			Case Mod($M, 400) = 0
				Return 1
			Case Else
				Return 0
		EndSelect
	EndIf
	Return SetError(1, 0, 0)
EndFunc
Func _39($N)
	Local $O[4], $P[4]
	_3I($N, $O, $P)
	If @error Then Return 0
	If Not StringIsInt($O[1]) Then Return 0
	If Not StringIsInt($O[2]) Then Return 0
	If Not StringIsInt($O[3]) Then Return 0
	$O[1] = Int($O[1])
	$O[2] = Int($O[2])
	$O[3] = Int($O[3])
	Local $Q = _41($O[1])
	If $O[1] < 1000 Or $O[1] > 2999 Then Return 0
	If $O[2] < 1 Or $O[2] > 12 Then Return 0
	If $O[3] < 1 Or $O[3] > $Q[$O[2]] Then Return 0
	If $P[0] < 1 Then Return 1
	If $P[0] < 2 Then Return 0
	If $P[0] = 2 Then $P[3] = "00"
	If Not StringIsInt($P[1]) Then Return 0
	If Not StringIsInt($P[2]) Then Return 0
	If Not StringIsInt($P[3]) Then Return 0
	$P[1] = Int($P[1])
	$P[2] = Int($P[2])
	$P[3] = Int($P[3])
	If $P[1] < 0 Or $P[1] > 23 Then Return 0
	If $P[2] < 0 Or $P[2] > 59 Then Return 0
	If $P[3] < 0 Or $P[3] > 59 Then Return 0
	Return 1
EndFunc
Func _3I($N, ByRef $R, ByRef $S)
	Local $T = StringSplit($N, " T")
	If $T[0] > 0 Then $R = StringSplit($T[1], "/-.")
	Local $U = UBound($R)
	If $U <> 4 Then Return SetError(1, 0, 0)
	If $T[0] > 1 Then
		$S = StringSplit($T[2], ":")
		$U = UBound($S)
		If ($U < 3) Or ($U > 4) Then Return SetError(2, 0, 0)
		If $U < 4 Then
			ReDim $S[4]
			$S[3] = 0
		EndIf
	Else
		Dim $S[4]
		$S[0] = 0
	EndIf
	For $V = 1 To 3
		$R[$V] = Int($R[$V])
		$S[$V] = Int($S[$V])
	Next
	Return 1
EndFunc
Func _3L($M, $W, $X)
	If Not _39(StringFormat("%04d/%02d/%02d", $M, $W, $X)) Then
		Return SetError(1, 0, "")
	EndIf
	If $W < 3 Then
		$W = $W + 12
		$M = $M - 1
	EndIf
	Local $Y = Int($M / 100)
	Local $0Z = Int($Y / 4)
	Local $10 = 2 - $Y + $0Z
	Local $11 = Int(1461 * ($M + 4716) / 4)
	Local $12 = Int(153 * ($W + 1) / 5)
	Local $13 = $10 + $X + $11 + $12 - 1524.5
	Return $13
EndFunc
Func _41($M)
	Local $14 = [12, 31, (_37($M) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	Return $14
EndFunc
Global Const $15 = "2026/01/05"
Func _53($16, $17 = 8)
	If $17 < 1 Then $17 = 1
	If $17 > 64 Then $17 = 64
	Local $18 = @YEAR & "/" & @MON & "/" & @MDAY
	Local $19 = _35("w", $15, $18)
	Local $1A = $16 & $19
	Local $1B = StringLen($1A)
	Local $1C = DllStructCreate("byte[" & $1B & "]")
	DllStructSetData($1C, 1, $1A)
	Local $1D = 0, $1E = 0
	Local $1F = DllCall("Advapi32.dll", "bool", "CryptAcquireContext", "handle*", $1D, "ptr", 0, "ptr", 0, "dword", 24, "dword", -268435456)
	If @error Or Not $1F[0] Then Return ""
	$1D = $1F[1]
	$1F = DllCall("Advapi32.dll", "bool", "CryptCreateHash", "handle", $1D, "uint", 32780, "uint", 0, "dword", 0, "handle*", $1E)
	If @error Or Not $1F[0] Then
		DllCall("Advapi32.dll", "bool", "CryptReleaseContext", "handle", $1D, "dword", 0)
		Return ""
	EndIf
	$1E = $1F[5]
	DllCall("Advapi32.dll", "bool", "CryptHashData", "handle", $1E, "struct*", $1C, "dword", $1B, "dword", 0)
	Local $1G = DllStructCreate("dword")
	DllStructSetData($1G, 1, 32)
	Local $1H = DllStructCreate("byte[32]")
	DllCall("Advapi32.dll", "bool", "CryptGetHashParam", "handle", $1E, "dword", 2, "struct*", $1H, "struct*", $1G, "dword", 0)
	DllCall("Advapi32.dll", "bool", "CryptDestroyHash", "handle", $1E)
	DllCall("Advapi32.dll", "bool", "CryptReleaseContext", "handle", $1D, "dword", 0)
	Local $1I = ""
	For $1J = 1 To 32
		$1I &= Hex(DllStructGetData($1H, 1, $1J), 2)
	Next
	Return StringLeft(StringLower($1I), $17)
EndFunc
Func _54($16, $1K, $1L, $17 = 8)
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
	Return True
EndFunc
_54("usercheck", "uslr", "usp", 8)
Global $1R = @AppDataDir & "\NGdata\User.log"
_55()
Func _55()
	Local $1S = GUICreate("Log Viewer - System Event", 600, 400, -1, -1, BitOR($3, $1))
	GUISetBkColor(15790320)
	Local $1T = GUICtrlCreateEdit("Đang tải dữ liệu...", 10, 10, 580, 340, BitOR($4, $2, $5))
	GUICtrlSetFont($1T, 10, 400, 0, "Consolas")
	Local $1U = GUICtrlCreateButton("Làm mới (Refresh)", 10, 360, 120, 30)
	Local $1V = GUICtrlCreateButton("Xóa File Log", 140, 360, 120, 30)
	_56($1T)
	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $0
				Exit
			Case $1U
				_56($1T)
			Case $1V
				_57($1T)
		EndSwitch
	WEnd
EndFunc
Func _56($1W)
	If FileExists($1R) Then
		Local $1X = FileRead($1R)
		If $1X = "" Then
			GUICtrlSetData($1W, "[Log trống]")
		Else
			GUICtrlSetData($1W, $1X)
		EndIf
	Else
		GUICtrlSetData($1W, "[Lỗi] Không tìm thấy data")
	EndIf
EndFunc
Func _57($1W)
	If FileExists($1R) Then
		Local $1Y = MsgBox(36, "Xác nhận", "Bạn có chắc chắn muốn xóa vĩnh viễn file log này không?")
		If $1Y = 6 Then
			If FileDelete($1R) Then
				MsgBox(64, "Thông báo", "Đã xóa file log thành công.")
				_56($1W)
			Else
				MsgBox(16, "Lỗi", "Không thể xóa file. File có thể đang được mở bởi chương trình khác.")
			EndIf
		EndIf
	Else
		MsgBox(48, "Thông báo", "File log không tồn tại để xóa.")
	EndIf
EndFunc
; DeTokenise by myAut2Exe >The Open Source AutoIT/AutoHotKey script decompiler< 2.16 build(215)