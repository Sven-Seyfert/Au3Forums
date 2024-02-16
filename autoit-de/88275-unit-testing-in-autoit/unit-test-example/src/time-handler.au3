Func _IsCurrentTimeWithinTimespan($sTime, $eTime, $iCurrentTime = @HOUR & ':' & @MIN)
    $sTime        = Number(StringReplace($sTime, ':', ''))
    $eTime        = Number(StringReplace($eTime, ':', ''))
    $iCurrentTime = Number(StringReplace($iCurrentTime, ':', ''))

    Local $iLowestTime  = _Min($sTime, $eTime)
    Local $iHighestTime = _Max($sTime, $eTime)

    ; in case the timespan falls over midnight
    If $eTime < $sTime Then
        If $iCurrentTime <= $iLowestTime Or $iCurrentTime >= $iHighestTime Then
            Return True
        EndIf

        Return False
    EndIf

    ; in case the timespan is within the same day
    If $iCurrentTime <= $iHighestTime And $iCurrentTime >= $iLowestTime Then
        Return True
    EndIf

    Return False
EndFunc
