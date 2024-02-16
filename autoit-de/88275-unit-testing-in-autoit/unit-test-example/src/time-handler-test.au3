#include "Math.au3"
#include "time-handler.au3"

_TestIsCurrentTimeWithinTimespan()

Func _TestIsCurrentTimeWithinTimespan()
    Local Const $sStartTime   = '15:00'
    Local Const $sEndTime     = '17:01'
    Local Const $sCurrentTime = '17:00'

    Local $aDataTable[][5] = _
        [ _
            ['Test', 'StartTime', 'EndTime', 'CurrentTime', 'Expected'], _
            ['1',    '15:00',     '17:00',   '14:59',       false], _
            ['2',    '15:00',     '17:00',   '15:00',       true], _
            ['3',    '15:00',     '17:00',   '15:01',       true], _
            ['4',    '15:00',     '17:00',   '16:00',       true], _
            ['5',    '15:00',     '17:00',   '16:59',       true], _
            ['6',    '15:00',     '17:00',   '17:00',       true], _
            ['7',    '15:00',     '17:00',   '17:01',       false], _
            ['8',    '23:10',     '01:23',   '23:09',       false], _
            ['9',    '23:10',     '01:23',   '23:10',       true], _
            ['10',   '23:10',     '01:23',   '23:11',       true], _
            ['11',   '23:10',     '01:23',   '00:00',       true], _
            ['12',   '23:10',     '01:23',   '01:22',       true], _
            ['13',   '23:10',     '01:23',   '01:23',       true], _
            ['14',   '23:10',     '01:23',   '01:24',       false] _
        ]

    For $i = 1 To UBound($aDataTable) - 1
        Local $bReceived = _IsCurrentTimeWithinTimespan($aDataTable[$i][1], $aDataTable[$i][2], $aDataTable[$i][3])
        Local $bExpected = $aDataTable[$i][4]

        If $bReceived == $bExpected Then
            ContinueLoop
        EndIf

        ; else failure
        ConsoleWrite(StringFormat( _
            'Failure for test %s. Expected: "%s", Received: "%s".', _
            $aDataTable[$i][0], _
            $bExpected, _
            $bReceived) & @CRLF)
    Next
EndFunc
