#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln

Opt('MustDeclareVars', 1)

Global Const $iGuiCloseFlag      = -3
Global Const $iControlShowFlag   = 16
Global Const $iControlHideFlag   = 32
Global Const $iControlEnableFlag = 64

Global $cLabel, $cToggleButton

_CreateGui()

While True
    Switch GUIGetMsg()
        Case $iGuiCloseFlag
            Exit
        Case $cToggleButton
            _ToggleLabel()
    EndSwitch
WEnd

Func _CreateGui()
    Local Const $hGui = GUICreate('Test', 270, 150)

    $cLabel        = GUICtrlCreateLabel('Label-Test', 10, 20, 250)
    $cToggleButton = GUICtrlCreateButton('Anzeigen', 10, 80, 250)

    GUICtrlSetState($cLabel, $iControlHideFlag)
    GUICtrlSetFont($cLabel, 13)
    GUISetState(@SW_SHOW, $hGui)
EndFunc

Func _ToggleLabel()
    If GUICtrlGetState($cLabel) == $iControlHideFlag + $iControlEnableFlag Then
        GUICtrlSetState($cLabel, $iControlShowFlag)
        GUICtrlSetData($cToggleButton, 'Verstecken')
    Else
        GUICtrlSetState($cLabel, $iControlHideFlag)
        GUICtrlSetData($cToggleButton, 'Anzeigen')
    EndIf
EndFunc
