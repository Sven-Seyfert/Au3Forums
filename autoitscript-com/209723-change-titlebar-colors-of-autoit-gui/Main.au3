#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln

#include-once
#include <GUIConstants.au3>
#include <Misc.au3>

Global $mGui[], $mTitleBar[]
Global $mClosingCrossIcon[], $mMinimizeIcon[]

Global $mTitleBarColor[]
$mTitleBarColor.background    = 0xD9534F
$mTitleBarColor.font          = 0xFBEDED
$mTitleBarColor.faviconIcon   = $GUI_BKCOLOR_TRANSPARENT
$mTitleBarColor.hoverMinimize = 0xE5E5E5
$mTitleBarColor.hoverClose    = 0xE81123

_Actions()

Func _Actions()
    _CreateGui()
    _CreateTitleBar()
    _AddTitleBarButtons()
    _ShowGui()
    _GuiEventListener()
EndFunc

Func _CreateGui()
    $mGui.Width  = 600
    $mGui.Height = 350
    $mGui.Style  = $WS_POPUP
    $mGui.Handle = GUICreate('', $mGui.Width, $mGui.Height, Default, Default, $mGui.Style)
EndFunc

Func _CreateTitleBar()
    ; background
    $mTitleBar.X            = 0
    $mTitleBar.Y            = 0
    $mTitleBar.W            = ($mGui.Width - 137)
    $mTitleBar.H            = 26
    $mTitleBar.ButtonWidth  = 25
    $mTitleBar.ButtonHeight = $mTitleBar.ButtonWidth

    $mTitleBar.cId = GUICtrlCreateLabel('', $mTitleBar.X, $mTitleBar.Y, $mTitleBar.W, $mTitleBar.H)
    GUICtrlSetBkColor($mTitleBar.cId, $mTitleBarColor.background)
    GUICtrlSetStyle($mTitleBar.cId, -1, $GUI_WS_EX_PARENTDRAG)

    ; favicon icon
    GUICtrlCreateLabel('🎲', 4, 5.5) ; I used the cube icon as example which can be pasted in by pressing [WIN] + [.]
    GUICtrlSetBkColor(-1, $mTitleBarColor.faviconIcon)
    GUICtrlSetFont(-1, 11)

    ; title
    GUICtrlCreateLabel('GUI with custom title bar', 24, 5.5, ($mGui.Width / 2))
    GUICtrlSetColor(-1, $mTitleBarColor.font)
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
    GUICtrlSetFont(-1, 9)
EndFunc

Func _AddTitleBarButtons()
    _AddClosingCrossIcon()
    _AddMaximizeIcon()
    _AddMinimizeIcon()
EndFunc

Func _AddClosingCrossIcon()
    ; background
    $mClosingCrossIcon.X = ($mGui.Width - 45)
    $mClosingCrossIcon.Y = 0
    $mClosingCrossIcon.W = $mTitleBar.ButtonWidth + 20
    $mClosingCrossIcon.H = $mTitleBar.ButtonHeight + 1

    $mClosingCrossIcon.cId = GUICtrlCreateLabel('', $mClosingCrossIcon.X, $mClosingCrossIcon.Y, $mClosingCrossIcon.W, $mClosingCrossIcon.H)
    GUICtrlSetBkColor($mClosingCrossIcon.cId, $mTitleBarColor.background)

    ; icon
    GUICtrlCreateLabel('Í', ($mGui.Width - 31), 5.5, $mTitleBar.ButtonWidth, $mTitleBar.ButtonHeight)
    GUICtrlSetFont(-1, 14, 100, Default, 'Wingdings 2')
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
EndFunc

Func _AddMaximizeIcon()
    ; background
    GUICtrlCreateLabel('', ($mGui.Width - 92), 0, $mTitleBar.ButtonWidth + 22, $mTitleBar.ButtonHeight + 1)
    GUICtrlSetBkColor(-1, $mTitleBarColor.background)

    ; icon
    GUICtrlCreateLabel('£', ($mGui.Width - 75), 6.5, $mTitleBar.ButtonWidth, $mTitleBar.ButtonHeight)
    GUICtrlSetFont(-1, 11, 100, Default, 'Wingdings 2')
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
    GUICtrlSetColor(-1, 0xCCCCCC)
EndFunc

Func _AddMinimizeIcon()
    ; background
    $mMinimizeIcon.X = ($mGui.Width - 137)
    $mMinimizeIcon.Y = 0
    $mMinimizeIcon.W = $mTitleBar.ButtonWidth + 20
    $mMinimizeIcon.H = $mTitleBar.ButtonHeight + 1

    $mMinimizeIcon.cId = GUICtrlCreateLabel('', $mMinimizeIcon.X, $mMinimizeIcon.Y, $mMinimizeIcon.W, $mMinimizeIcon.H)
    GUICtrlSetBkColor($mMinimizeIcon.cId, $mTitleBarColor.background)

    ; icon
    GUICtrlCreateLabel('—', ($mGui.Width - 119), 6.5, $mTitleBar.ButtonWidth, $mTitleBar.ButtonHeight)
    GUICtrlSetFont(-1, 8, 100, Default, 'Segoe UI')
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
EndFunc

Func _ShowGui()
    GUISetState(@SW_SHOW, $mGui.Handle)
EndFunc

Func _GuiEventListener()
    AdlibRegister('_HoverActions', 100)
    Local Const $iGuiEventClose = -3

    While True
        Switch GUIGetMsg()
            Case $iGuiEventClose, $mClosingCrossIcon.cId
                ExitLoop
            Case $mMinimizeIcon.cId
                GUISetState(@SW_MINIMIZE, $mGui.Handle)
        EndSwitch
    WEnd

    _GuiDisposeAndExit()
EndFunc

Func _GuiDisposeAndExit()
    AdlibUnRegister('_HoverActions')
    GUIDelete($mGui.Handle)
    Exit
EndFunc

Func _HoverActions()
    Local $aMouseData = MouseGetPos()
    Local $aGuiData   = WinGetPos($mGui.Handle)

    If Not _HoverTitleBar($aMouseData, $aGuiData) Then
        _ResetHoverColor()
        Return
    EndIf

    Select
        Case _HoverMinimizeIcon($aMouseData, $aGuiData)
            GUICtrlSetBkColor($mMinimizeIcon.cId, $mTitleBarColor.hoverMinimize)
            GUICtrlSetBkColor($mClosingCrossIcon.cId, $mTitleBarColor.background)

        Case _HoverClosingCrossIcon($aMouseData, $aGuiData)
            GUICtrlSetBkColor($mClosingCrossIcon.cId, $mTitleBarColor.hoverClose)
            GUICtrlSetBkColor($mMinimizeIcon.cId, $mTitleBarColor.background)

        Case Else
            _ResetHoverColor()
    EndSelect
EndFunc

Func _ResetHoverColor()
    GUICtrlSetBkColor($mClosingCrossIcon.cId, $mTitleBarColor.background)
    GUICtrlSetBkColor($mMinimizeIcon.cId, $mTitleBarColor.background)
EndFunc

Func _HoverTitleBar($aMouseData, $aGuiData)
    Return _IsMouseOnControl( _
        $aMouseData[0] - $aGuiData[0], _
        $aMouseData[1] - $aGuiData[1], _
        $mTitleBar.X, $mTitleBar.Y, $mGui.Width, $mTitleBar.H)
EndFunc

Func _HoverMinimizeIcon($aMouseData, $aGuiData)
    Return _IsMouseOnControl( _
        $aMouseData[0] - $aGuiData[0], _
        $aMouseData[1] - $aGuiData[1], _
        $mMinimizeIcon.X, $mMinimizeIcon.Y, $mMinimizeIcon.W, $mMinimizeIcon.H)
EndFunc

Func _HoverClosingCrossIcon($aMouseData, $aGuiData)
    Return _IsMouseOnControl( _
        $aMouseData[0] - $aGuiData[0], _
        $aMouseData[1] - $aGuiData[1], _
        $mClosingCrossIcon.X, $mClosingCrossIcon.Y, $mClosingCrossIcon.W, $mClosingCrossIcon.H)
EndFunc

Func _IsMouseOnControl($iXMouse, $iYMouse, $iXControl, $iYControl, $iWidthControl, $iHeightControl)
    If $iXMouse >= $iXControl And _
       $iYMouse >= $iYControl And _
       $iXMouse <= $iXControl + $iWidthControl  And _
       $iYMouse <= $iYControl + $iHeightControl Then
       Return True
    Else
        Return False
    EndIf
EndFunc
