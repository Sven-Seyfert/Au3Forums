_DrawTree(15)

Func _DrawTree($iRows)
    Local $iCountOfSpaces = $iRows - 1

    Local Const $sMaxPadding     = _CharacterRepeat(' ', $iCountOfSpaces)
    Local Const $sPeakCharacter  = '*'
    Local Const $sTreeCharacter  = 'X'
    Local Const $sTribeCharacter = '| |'

    Local $iCountOfTreeCharacters = 1

    _Print() ; only for design purposes

    For $i = 1 To $iRows Step 1
        Switch $i
            Case 1
                _Print($sMaxPadding & $sPeakCharacter & $sMaxPadding)

            Case 2
                _Print($sMaxPadding & $sTreeCharacter & $sMaxPadding)

            Case $iRows
                Local $sPadding = StringTrimRight($sMaxPadding, 1)
                _Print($sPadding & $sTribeCharacter & $sPadding)

            Case Else
                $iCountOfSpaces         -= 1
                $iCountOfTreeCharacters += 2

                Local $sPadding        = _CharacterRepeat(' ', $iCountOfSpaces)
                Local $sTreeCharacters = _CharacterRepeat($sTreeCharacter, $iCountOfTreeCharacters)

                _Print($sPadding & $sTreeCharacters & $sPadding)
        EndSwitch
    Next

    _Print() ; only for design purposes
EndFunc

Func _CharacterRepeat($sCharacter, $iOccurrence = 1)
    ; I know about _StringRepeat(), but I don't
    ; want to include a UDF only for one function of it

    Local $sCharacters = Null

    For $i = 1 To $iOccurrence Step 1
        $sCharacters &= $sCharacter
    Next

    Return $sCharacters
EndFunc

Func _Print($sText = '')
    ConsoleWrite($sText & @CRLF)
EndFunc
