#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln

#include-once
#include <File.au3>

_ReplaceFiles()

MsgBox('', 'DEMO', 'New files are in the folders.')

Func _ReplaceFiles()
    Local Const $sRootFolder     = _AddTrailingBackslash(@DesktopDir & '\DEMO')
    Local Const $sNewTxtFile     = 'newTextFile.txt'
    Local Const $sNewTxtFilePath = _AddTrailingBackslash(@DesktopDir) & $sNewTxtFile

    Local $aFileList = _GetFiles($sRootFolder)

    For $sFile In $aFileList
        FileDelete($sFile)
        FileCopy($sNewTxtFilePath, _AddTrailingBackslash(_GetPath($sFile)) & $sNewTxtFile)
    Next
EndFunc

Func _GetFiles($sRootFolder)
    Local Const $iFilesOnlyFlag = 1
    Local Const $iRecursiveFlag = 1
    Local Const $iNoSortFlag    = 0
    Local Const $iFullPathFlag  = 2

    Return _FileListToArrayRec($sRootFolder, '*.txt', $iFilesOnlyFlag, $iRecursiveFlag, $iNoSortFlag, $iFullPathFlag)
EndFunc

Func _AddTrailingBackslash($sPath)
    Return (StringRight($sPath, 1) == '\') ? $sPath : $sPath & '\'
EndFunc

Func _GetPath($sFile)
    Return StringRegExpReplace($sFile, '(^.*\\)(.*)', '\1')
EndFunc
