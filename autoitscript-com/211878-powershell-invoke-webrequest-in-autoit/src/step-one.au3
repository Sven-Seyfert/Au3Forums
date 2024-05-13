#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y

#include-once
#include <Array.au3>

_Main()

Func _Main()
    Local Const $sTargetMaschine     = '2024-04 21H2 Server'
    Local Const $sUrlMsUpdateCatalog = 'https://www.catalog.update.microsoft.com/Search.aspx?q=' & $sTargetMaschine
    Local Const $sFile               = 'step-one-result.html'

    ; In your case, you can simply get the information by InetGet() instead of using WinHTTP.au3.
    ; When it comes to auth., I recommend WinHTTP.au3.
    InetGet($sUrlMsUpdateCatalog, $sFile)

    Local Const $sContent = _GetFileContent($sFile)
    Local Const $aList    = _GetListOfIdsAndNames($sContent)

    _ArrayDisplay($aList, 'List of IDs (GUIDs) and Names')
EndFunc

Func _GetListOfIdsAndNames($sContent)
    Local Const $sRegExPattern      = '(?s)onclick=''goToDetails\("(.+?)".+?>(.+?)</a>'
    Local Const $sGlobalMatchesFlag = 3
    Local $aListOfIdsAndNames       = StringRegExp($sContent, $sRegExPattern, $sGlobalMatchesFlag)

    Local Const $iLeadingTrailingDoubleFlag = 7

    For $i = 0 To _Length($aListOfIdsAndNames)
        $aListOfIdsAndNames[$i] = StringStripWS($aListOfIdsAndNames[$i], $iLeadingTrailingDoubleFlag)
    Next

    Return $aListOfIdsAndNames
EndFunc

Func _GetFileContent($sFile)
    Local Const $iUtf8WithoutBomMode = 256

    Local $hFile        = FileOpen($sFile, $iUtf8WithoutBomMode)
    Local $sFileContent = FileRead($hFile)
    FileClose($hFile)

    Return $sFileContent
EndFunc

Func _Length($aList)
    Return UBound($aList) - 1
EndFunc
