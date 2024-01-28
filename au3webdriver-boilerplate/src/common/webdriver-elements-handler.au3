Func _NavigateTo($sUrl)
    _WD_Navigate($sSession, $sUrl)
    _WD_LoadWait($sSession, $mConfig.Delay)
EndFunc

Func _ClickElement($sSelector)
    _WaitFor($sSelector)
    _WD_ElementAction($sSession, _FindElement($sSelector), 'click')
EndFunc

Func _WaitFor($sSelector)
    Local Const $iTimeoutInMilliseconds = 5000
    Local Const $iElementVisibleFlag    = 1

    _WD_WaitElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector, $mConfig.Delay, $iTimeoutInMilliseconds, $iElementVisibleFlag)
EndFunc

Func _FindElement($sSelector)
    Local $sElement = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector)
    If @error <> $_WD_ERROR_Success Then
        ConsoleWrite('Error for XPath selector ''' & $sSelector & '''.' & @CRLF)
        _TeardownDriver() ; HINT: Shutdown webdriver on error (optional, comment out if necessary).
    EndIf

    Return $sElement
EndFunc

Func _FindElements($sSelector)
    Return _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector, Default, True)
EndFunc

Func _GetElementText($sSelector)
    _WaitFor($sSelector)

    Return _WD_ElementAction($sSession, _FindElement($sSelector), 'text')
EndFunc

Func _GetElementsTexts($sSelector)
    Local Const $aListOfElements = _FindElements($sSelector)
    Local Const $iCount          = _GetCount($aListOfElements)

    Local $aListOfElementsTexts[$iCount + 1]

    For $i = 0 To $iCount Step 1
        $aListOfElementsTexts[$i] = _WD_ElementAction($sSession, $aListOfElements[$i], 'text')
    Next

    Return $aListOfElementsTexts
EndFunc

Func _SetElementText($sSelector, $sValue)
    _WaitFor($sSelector)
    _WD_ElementAction($sSession, _FindElement($sSelector), 'value', $sValue)
EndFunc

Func _TakeElementScreenshot($sSelector)
    Local Const $sResponse = _WD_ElementAction($sSession, _FindElement($sSelector), 'screenshot')
    _CreateScreenshotFile($sResponse)
EndFunc

Func _TakeScreenshot()
    Local Const $sResponse = _WD_Window($sSession, 'screenshot')
    _CreateScreenshotFile($sResponse)
EndFunc

Func _CreateScreenshotFile($sResponse)
    Local Const $bDecode         = __WD_Base64Decode($sResponse)
    Local Const $sTimestamp      = @YEAR & @MON & @MDAY & '-' & @HOUR & @MIN & @SEC
    Local Const $sScreenshotPath = _PathFull('..\data\output\')
    ConsoleWrite($sScreenshotPath & @CRLF)

    Local $hFile = FileOpen(_Backslash($sScreenshotPath) & $sTimestamp & '.png', $FO_BINARY + $FO_OVERWRITE)
    FileWrite($hFile, $bDecode)
    FileClose($hFile)
EndFunc

Func _EnterIFrame($sSelector)
    _WD_FrameEnter($sSession, _FindElement($sSelector))
EndFunc

Func _LeaveIFrame()
    _WD_FrameLeave($sSession)
    Sleep($mConfig.Delay)
EndFunc
