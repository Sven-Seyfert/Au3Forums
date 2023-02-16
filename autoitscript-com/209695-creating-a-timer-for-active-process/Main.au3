#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln

_WaitForNotepad()
_WaitThirtySeconds()
_CloseNotepad()

Func _WaitForNotepad()
    Local Const $sNotepad = '[CLASS:Notepad]'

    While Not WinExists($sNotepad)
        Sleep(100)
    WEnd

    Return
EndFunc

Func _WaitThirtySeconds()
    Local Const $hTimer = TimerInit()
    Local Const $iTimeoutInSeconds = 30

    While TimerDiff($hTimer) < ($iTimeoutInSeconds * 1000)
        Sleep(500)
    WEnd
EndFunc

Func _CloseNotepad()
    Local Const $sNotepad        = '[CLASS:Notepad]'
    Local Const $sNotepadProcess = 'notepad.exe'

    If Not WinExists($sNotepad) Then
        Return
    EndIf

    ProcessClose($sNotepadProcess)
    MsgBox(48, 'Demo', 'You reached the time limit.')
EndFunc
