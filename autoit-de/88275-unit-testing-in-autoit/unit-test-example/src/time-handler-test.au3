#include "Math.au3"
#include "time-handler.au3"

_TestIsCurrentTimeWithinTimespan()

Func _TestIsCurrentTimeWithinTimespan()
    Global Const $sStartTime   = '15:00'
    Global Const $sEndTime     = '17:01'
    Global Const $sCurrentTime = '17:00'

    Global $aList[][4] = _
        [ _
            ['StartTime', 'EndTime', 'CurrentTime', 'Expected'], _
            ['15:00',     '17:00',   '14:59',       false], _
            ['15:00',     '17:00',   '15:00',       true], _
            ['15:00',     '17:00',   '15:01',       true], _
            ['15:00',     '17:00',   '16:00',       true], _
            ['15:00',     '17:00',   '16:59',       true], _
            ['15:00',     '17:00',   '17:00',       true], _
            ['15:00',     '17:00',   '17:01',       false], _
            ['23:10',     '01:23',   '23:09',       false], _
            ['23:10',     '01:23',   '23:10',       true], _
            ['23:10',     '01:23',   '23:11',       true], _
            ['23:10',     '01:23',   '00:00',       true], _
            ['23:10',     '01:23',   '01:22',       true], _
            ['23:10',     '01:23',   '01:23',       true], _
            ['23:10',     '01:23',   '01:24',       false] _
        ]

    For $i = 1 To UBound($aList) - 1
        ConsoleWrite( _
            StringFormat( _
                'Expected: "%s", Received: %s', _
                $aList[$i][3], _
                _IsCurrentTimeWithinTimespan($aList[$i][0], $aList[$i][1], $aList[$i][2])) & @CRLF)
    Next
EndFunc
