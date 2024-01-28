Func _Backslash($sPath)
    Return (StringRight($sPath, 1) == '\') ? $sPath : $sPath & '\'
EndFunc

Func _GetCount($aList)
    Return UBound($aList) - 1
EndFunc
