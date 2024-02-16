; 👉 Unit testing in AutoIt

#pragma compile(FileVersion, 0.1.0)
#pragma compile(LegalCopyright, © Sven Seyfert (SOLVE-SMART))
#pragma compile(ProductVersion, 0.1.0 - 2024-02-15)

#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y

#include-once
#include <Math.au3>
#include "message-handler.au3"
#include "time-handler.au3"

_Main()

Func _Main()
    _SayHello()

    Local Const $sStartTime   = '15:00'
    Local Const $sEndTime     = '17:01'
    Local Const $sCurrentTime = '17:00'

    While True
        If _IsCurrentTimeWithinTimespan($sStartTime, $sEndTime, $sCurrentTime) Then
            _SayGoodbye()
            ExitLoop
        EndIf

        Sleep(250)
    WEnd
EndFunc
