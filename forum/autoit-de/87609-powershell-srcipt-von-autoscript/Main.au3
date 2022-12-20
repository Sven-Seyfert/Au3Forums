Global $sPowershellFilePath = @ScriptDir & '\PowershellScript.ps1'
Global $sPowershellCode     = 'Get-Process | Select-Object -Property Id, ProcessName | Set-Clipboard'
Global $sPowershellResult   = _ExecutePowershellCode($sPowershellCode)

ConsoleWrite($sPowershellResult & @CRLF)

Func _ExecutePowershellCode($sCode)
    _DeleteTempFile()
    _WriteFile($sPowershellFilePath, $sCode)
    _ExecutePowershell()
    _DeleteTempFile()

    Return ClipGet()
EndFunc

Func _DeleteTempFile()
    FileDelete($sPowershellFilePath)
EndFunc

Func _WriteFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndOverwriteCreationMode = 256 + 2 + 8

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndOverwriteCreationMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _ExecutePowershell()
    Local $sPowershellCall = 'powershell -executionpolicy bypass -File'
    ShellExecuteWait(@ComSpec, '/C ' & $sPowershellCall  & ' "' & $sPowershellFilePath & '"', '', '', @SW_HIDE)
EndFunc
