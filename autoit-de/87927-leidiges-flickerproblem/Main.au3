#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln

Opt('MustDeclareVars', 1)

Global Const $iGuiCloseFlag       = -3
Global Const $iControlTransparent = -2
Global Const $iControlShowFlag    = 16
Global Const $iControlHideFlag    = 32
Global Const $iControlEnableFlag  = 64
Global Const $iControlDisableFlag = 128

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
    Local Const $iWidth  = 270
    Local Const $iHeight = 150

    Local Const $hGui = GUICreate('Test', $iWidth, $iHeight)

    Local Const $sImageFilePath = 'C:\Windows\Web\Wallpaper\Windows\img0.jpg'
    Local Const $cBackgoundImage = GUICtrlCreatePic($sImageFilePath, 0, 0, $iWidth, $iHeight)

    $cLabel        = GUICtrlCreateLabel('Label-Test', 10, 20, 250)
    $cToggleButton = GUICtrlCreateButton('Anzeigen', 10, 80, 250)

    GUICtrlSetState($cBackgoundImage, $iControlDisableFlag)
    GUICtrlSetState($cLabel, $iControlHideFlag)
    GUICtrlSetBkColor($cLabel, $iControlTransparent)
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
