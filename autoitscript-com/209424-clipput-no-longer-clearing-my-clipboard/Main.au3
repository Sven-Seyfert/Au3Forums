#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_UseUpx=n



; init -------------------------------------------------------------------------
Opt('MustDeclareVars', 1)
HotKeySet('{ESC}', '_Terminate')



; processing -------------------------------------------------------------------
_Run()



; functions --------------------------------------------------------------------
Func _Terminate()
    Exit
EndFunc

Func _Run()
    Local Const $sExcel   = '279.xlsx - Excel'
    Local Const $sGenesis = 'Session A - Genesis'
    Local Const $sCopy    = '^c'
    Local Const $sPaste   = '^v'

    For $i = 1 To 2                     ; Run two times
        WinActivate($sExcel)
        WinWaitActive($sExcel, '', 2)   ; Wait max. two seconds until the window is active

        _Clear()
        _SendWithDelay($sCopy)

        WinActivate($sGenesis)
        WinWaitActive($sGenesis, '', 2)

        _SendWithDelay("{I}")
        _SendWithDelay($sPaste)
        _SendWithDelay("{ENTER}")
        _SendWithDelay("C")
        _SendWithDelay("{TAB}")

        WinActivate($sExcel)
        WinWaitActive($sExcel, '', 2)

        _SendWithDelay("{RIGHT}")
        _Clear()
        _SendWithDelay($sCopy)
        _SendWithDelay("{DOWN}{LEFT}")

        WinActivate($sGenesis)
        WinWaitActive($sGenesis, '', 2)

        _SendWithDelay($sPaste)
        _SendWithDelay("{DOWN 2}{NUMPADADD}")
        _SendWithDelay("{ENTER 6}")
    Next
EndFunc

Func _SendWithDelay($sKey, $iHowOften = 1, $iDelay = 120)
    For $i = 1 To $iHowOften Step 1
        Send($sKey)
        Sleep($iDelay)
    Next
EndFunc

Func _Clear()
    ClipPut('')
EndFunc
