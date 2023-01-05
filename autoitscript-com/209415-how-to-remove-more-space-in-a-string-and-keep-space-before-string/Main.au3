; Input          : ....A....B..CD...E.....F..
; Expected output: ....A.B.CD.E.F

ConsoleWrite(_StripWhitespacesExceptPrefixedOnes('    A    B  CD   E     F  ') & @CRLF)

Func _StripWhitespacesExceptPrefixedOnes($sString)
    Local Const $sRegExPattern    = '(\s+).*?$'
    Local Const $iReturnMatchFlag = 1

    Local Const $sPrefixSpaces = StringRegExp($sString, $sRegExPattern, $iReturnMatchFlag)[0]
    Local Const $iStripLeadingTrailingDoubleFlag = 7

    Return $sPrefixSpaces & StringStripWS($sString, $iStripLeadingTrailingDoubleFlag)
EndFunc
