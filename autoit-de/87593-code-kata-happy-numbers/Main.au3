Func _IsHappyNumbers($iNumber)
    Local $iIterationsToCheck = 15

    For $i = 1 To $iIterationsToCheck Step 1
        Local $iResult = _GetSumOfDigitsSquares($iNumber)

        If $iResult == 1 Then
            Return True
        EndIf

        $iNumber = $iResult
    Next

    Return False
EndFunc

Func _GetSumOfDigitsSquares($iNumber)
    Local $iDigitsCount = StringLen($iNumber)
    Local $iSum

    For $j = 1 To $iDigitsCount Step 1
        $iSum += _GetSquare($iNumber, $j)
    Next

    Return $iSum
EndFunc

Func _GetSquare($iNumber, $iStart)
    Return StringMid($iNumber, $iStart, 1) ^ 2
EndFunc

For $i = 1 To 100 Step 1
    If _IsHappyNumbers($i) Then
        ConsoleWrite($i & ' -> 1 :)' & @CRLF)
    EndIf
Next
