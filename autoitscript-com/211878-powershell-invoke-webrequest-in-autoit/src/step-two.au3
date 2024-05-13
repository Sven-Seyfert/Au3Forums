#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y

_Main()

Func _Main()
    ; Target ID (GUID)
    Local Const $sGuid = '1c09aabd-5134-4b57-9e50-454b6dd63ad0'

    ; Json body
    Local Const $sJson = 'updateIDs = [{ "uidInfo": "' & $sGuid & '", "updateID": "' & $sGuid & '", "size": 0 }]'

    ; POST request
    Local Const $sResponse = _POST('https://www.catalog.update.microsoft.com/DownloadDialog.aspx', $sJson)

    ; Write the response data to file (for debugging purposes).
    ; This isn't necessary, but to understand to RegEx below it's helpful.
    _WriteFile('result-autoit.html', $sResponse)

    ; Get only the download URL(s) for the cumulative update (based by the GUID on top).
    Local Const $sRegExPattern = '(?s)\.files?\[\d+\]\.url(\s+)?=(\s+)?''(.+?.msu)'
    Local Const $aMatches = StringRegExp($sResponse, $sRegExPattern, 3)
    ConsoleWrite($aMatches[_Length($aMatches)] & @CRLF)
EndFunc

Func _POST($sURL, $sJson)
    Local $oHTTP = ObjCreate('winhttp.winhttprequest.5.1')

    $oHTTP.Open('POST', $sURL, False)
    $oHTTP.SetRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    $oHTTP.Send(_UrlEncode($sJson))

    Local Const $iStatusCode = $oHTTP.Status

    If $iStatusCode <> 200 Then
        Local Const $iErrorIcon = 16
        Local Const $iTimeout   = 10

        MsgBox($iErrorIcon, 'Error', $iStatusCode, $iTimeout)
        Return
    EndIf

    Return $oHTTP.ResponseText
EndFunc

Func _UrlEncode($sText)
    Local Const $iUtf8Flag          = 4
    Local Const $iCaseSensitiveFlag = 1
    Local Const $sCharacters        = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!$&/()=?+*',;:.-_@"

    Local Const $sUtf8Binary = StringToBinary(StringReplace($sText, ' ', ''), $iUtf8Flag)
    Local Const $sUtf8String = StringReplace($sUtf8Binary, '0x', '', $iCaseSensitiveFlag)

    Local $sChar, $sEncodedText

    For $i = 1 To StringLen($sUtf8String) Step 2
        $sChar = StringMid($sUtf8String, $i, 2)

        If StringInStr($sCharacters, BinaryToString('0x' & $sChar, $iUtf8Flag)) Then
            $sEncodedText &= BinaryToString('0x' & $sChar)
        Else
            $sEncodedText &= '%' & $sChar
        EndIf
    Next

    Return $sEncodedText
EndFunc

Func _WriteFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndOverwriteCreationMode = 256 + 2 + 8

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndOverwriteCreationMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _Length($aList)
    Return UBound($aList) - 1
EndFunc
