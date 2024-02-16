Func _Print($sData)
    Local Const $iAnsiFlag = 1
    Local Const $iUtf8Flag = 4

    ConsoleWrite(BinaryToString(StringToBinary($sData & @LF, $iUtf8Flag), $iAnsiFlag))
EndFunc
