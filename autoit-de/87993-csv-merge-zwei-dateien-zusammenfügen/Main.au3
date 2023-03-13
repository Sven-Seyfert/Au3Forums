#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln

#include-once
#include <Array.au3>

_Actions()

Exit

Func _Actions()
    Local Const $sCsvFolder     = '.\output\'
    Local Const $sFileName      = 'demo-file-'
    Local Const $sFirstCsvFile  = $sFileName & '1.csv'
    Local Const $sSecondCsvFile = $sFileName & '2.csv'
    Local Const $sMergedCsvFile = $sCsvFolder & 'merged.csv'

    Local Const $sFirstCsvContent  = _GetFileContent($sCsvFolder & $sFirstCsvFile)
    Local Const $sSecondCsvContent = _GetFileContent($sCsvFolder & $sSecondCsvFile)

    Local Const $aFirstCsvList     = _MultilineCsvContentToArray($sFirstCsvContent)
    Local Const $aSecondCsvList    = _MultilineCsvContentToArray($sSecondCsvContent)

    _RemoveFile($sMergedCsvFile)
    _WriteMergedCsvFile($aFirstCsvList, $aSecondCsvList, $sMergedCsvFile)
EndFunc

Func _GetFileContent($sFile)
    Local Const $iUtf8WithoutBomMode = 256

    Local $hFile        = FileOpen($sFile, $iUtf8WithoutBomMode)
    Local $sFileContent = FileRead($hFile)
    FileClose($hFile)

    Return $sFileContent
EndFunc

Func _MultilineCsvContentToArray($sCsvContent)
    Local Const $sRegExPattern      = '(?m)^(?>"(?>[^"]++|"")*+"|[^"\v]*)*+$' ; credits to @AspirinJunkie
    Local Const $iGlobalMatchesFlag = 3

    Return StringRegExp($sCsvContent, $sRegExPattern, $iGlobalMatchesFlag)
EndFunc

Func _RemoveFile($sFile)
    If Not FileExists($sFile) Then
        Return
    EndIf

    FileDelete($sFile)
EndFunc

Func _WriteMergedCsvFile($aFirstList, $aSecondList, $sFile)
    If _GetCount($aFirstList) <> _GetCount($aSecondList) Then
        MsgBox(48, 'Warning', 'CSV lines differ between first and second CSV files.')
        Return
    EndIf

    For $i = 0 To _GetCount($aFirstList) Step 1
        _AppendToFile($sFile, $aFirstList[$i] & ';' & $aSecondList[$i] & @CRLF)
    Next
EndFunc

Func _GetCount($aList)
    Return UBound($aList) - 1
EndFunc

Func _AppendToFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndAppendMode = 256 + 1

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndAppendMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc
