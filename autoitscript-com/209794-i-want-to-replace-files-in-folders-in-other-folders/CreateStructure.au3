#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln

_CreateStructure()

MsgBox('', 'DEMO', 'Folder and file structure created.')

Func _CreateStructure()
    Local Const $sRootFolder     = _AddTrailingBackslash(@DesktopDir & '\DEMO')
    Local Const $sOldTxtFile     = 'myTextFile.txt'
    Local Const $sNewTxtFile     = 'newTextFile.txt'
    Local Const $sNewTxtFilePath = _AddTrailingBackslash(@DesktopDir) & $sNewTxtFile

    Local Const $aFolderList[] = _
    [ _
        'Adam\Blake', _
        'Adam\Cedrick', _
        'Adam\Chaz', _
        'Adam\Christopher', _
        'Adam\Cierra', _
        'Clyde\Cristina', _
        'Clyde\Cynthia', _
        'Clyde\Dakota', _
        'Clyde\Damian', _
        'Clyde\Darwin', _
        'Emely\Florence', _
        'Emely\Frank', _
        'Emely\Grayce', _
        'Emely\Gregory', _
        'Emely\Hazle', _
        'Jacky\Jade', _
        'Jacky\Jewell', _
        'Jacky\Joannie', _
        'Jacky\Johathan', _
        'Jacky\Lavina', _
        'Mossie\Myrtle', _
        'Mossie\Octavia', _
        'Mossie\Oleta', _
        'Mossie\Rae', _
        'Mossie\Rafael' _
    ]

    Local Const $sFileContent = 'This is a demo.' ; Can also be '' if you don't need any content.

    For $sFolder In $aFolderList
        _WriteFile($sRootFolder & _AddTrailingBackslash($sFolder) & $sOldTxtFile, $sFileContent)
    Next

    _WriteFile($sNewTxtFilePath, $sFileContent)
EndFunc

Func _WriteFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndOverwriteCreationMode = 256 + 2 + 8

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndOverwriteCreationMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _AddTrailingBackslash($sPath)
    Return (StringRight($sPath, 1) == '\') ? $sPath : $sPath & '\'
EndFunc
