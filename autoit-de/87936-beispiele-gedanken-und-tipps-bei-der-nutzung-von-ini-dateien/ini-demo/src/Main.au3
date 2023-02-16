#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Outfile_x64=..\build\Main.exe
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln



; autoit options ---------------------------------------------------------------
Opt('MustDeclareVars', 1)



; includes ---------------------------------------------------------------------
#include-once
#include <File.au3>



; initialization ---------------------------------------------------------------
Global $hGui, $cFreeTextLabel, $cButton



; processing -------------------------------------------------------------------
_Actions()

Func _Actions()
    Local Const $sSettingsFilePath    = _PathFull('..\config\settings.ini')
    Local Const $sEnvironmentFilePath = _GetEnvironmentFilePath($sSettingsFilePath)

    $hGui = _CreateGui($sSettingsFilePath)

    _SetGuiDesign($sEnvironmentFilePath)
    _CreateDatabaseConnectionLabel($sEnvironmentFilePath)

    $cFreeTextLabel = _CreateFreeTextLabel()
    $cButton        = _CreateRefreshFreeTextButton()

    _ShowGui()
    _GuiEventListener($sEnvironmentFilePath)
EndFunc

Func _CreateGui($sSettingsFilePath)
    Local Const $iWidth  = IniRead($sSettingsFilePath, 'Gui', 'Width', Null)
    Local Const $iHeight = IniRead($sSettingsFilePath, 'Gui', 'Height', Null)

    Return GUICreate('ini-demo', $iWidth, $iHeight)
EndFunc

Func _GetEnvironmentFilePath($sSettingsFilePath)
    Local Const $sEnvironmentFilePath = IniRead($sSettingsFilePath, 'Settings', 'Environment', Null)

    Return _PathFull('..\config\' & $sEnvironmentFilePath & '.ini')
EndFunc

Func _SetGuiDesign($sEnvironmentFilePath)
    Local Const $iFontSize        = IniRead($sEnvironmentFilePath, 'Gui', 'FontSize', Null)
    Local Const $vBackgroundColor = IniRead($sEnvironmentFilePath, 'Gui', 'BackgroundColor', Null)

    GUISetFont($iFontSize)
    GUISetBkColor($vBackgroundColor, $hGui)
EndFunc

Func _CreateDatabaseConnectionLabel($sEnvironmentFilePath)
    Local Const $vLabelColor         = IniRead($sEnvironmentFilePath, 'Gui', 'LabelColor', Null)
    Local Const $sConnectionStringDb = IniRead($sEnvironmentFilePath, 'Database', 'ConnectionStringDb', Null)

    Local Const $cLabel1 = GUICtrlCreateLabel('Umgebung:' & @CRLF & _GetFileNameWithoutExtension($sEnvironmentFilePath), 30, 30)
    Local Const $cLabel2 = GUICtrlCreateLabel('ConnectionString:' & @CRLF & $sConnectionStringDb, 30, 90)

    GUICtrlSetColor($cLabel1, $vLabelColor)
    GUICtrlSetColor($cLabel2, $vLabelColor)
EndFunc

Func _GetFileNameWithoutExtension($sFilePath)
    Return StringRegExpReplace($sFilePath, '^.*\\|\..*$', '')
EndFunc

Func _CreateFreeTextLabel()
    Return GUICtrlCreateLabel('', 30, 300, 600, 200)
EndFunc

Func _CreateRefreshFreeTextButton()
    Return GUICtrlCreateButton('Text anzeigen', 30, 550)
EndFunc

Func _UpdateFreeTextLabel($sEnvironmentFilePath)
    Local Const $sText = IniRead($sEnvironmentFilePath, 'Whatever', 'FreeText', Null)
    ConsoleWrite($sText & @CRLF)
    GUICtrlSetData($cFreeTextLabel, $sText)
EndFunc

Func _ShowGui()
    GUISetState(@SW_SHOW, $hGui)
EndFunc

Func _DisposeAndExit()
    GUIDelete($hGui)
    Exit
EndFunc

Func _GuiEventListener($sEnvironmentFilePath)
    Local Const $iGuiCloseEvent = -3

    While True
        Switch GUIGetMsg()
            Case $iGuiCloseEvent
                ExitLoop
            Case $cButton
                _UpdateFreeTextLabel($sEnvironmentFilePath)
        EndSwitch
    WEnd

    _DisposeAndExit()
EndFunc
