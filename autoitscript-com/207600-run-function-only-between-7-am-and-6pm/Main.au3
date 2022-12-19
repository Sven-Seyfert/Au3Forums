HotKeySet('{F10}', '_Exit')

Func _Exit()
   Exit
EndFunc

Func _IsCurrentHourBetween($iBetweenFrom, $iBetweenTo)
    Local $iHour = Int(@HOUR)

    If $iHour >= $iBetweenFrom And $iHour <= $iBetweenTo Then
        Return True
    EndIf

    Return False
EndFunc

While True
    If _IsCurrentHourBetween(7, 18) Then
        Global $iRandomXPosition = Random(100, 600, 1)
        Global $iRandomYPosition = Random(200, 500, 1)

        MouseMove($iRandomXPosition, $iRandomYPosition)
    EndIf

    Sleep(1000)
WEnd
