; autoit options ---------------------------------------------------------------
Opt('MustDeclareVars', 1)



; initialization ---------------------------------------------------------------
Global Const $sEdgeExe = 'msedge.exe'



; processing -------------------------------------------------------------------
HotKeySet('{F10}', '_CloseEdge')

_StartEdge()

While True
    Sleep(150)
WEnd



; functions --------------------------------------------------------------------
Func _StartEdge()
    Local Const $sEdgeFolder = 'C:\Program Files (x86)\Microsoft\Edge\Application\'
    Local Const $sUrl        = 'https://autoit.de/thread/87895-ms-edge-im-kioskmodus-beenden/?postID=709084#post709084'

    ShellExecute('"' & $sEdgeFolder & $sEdgeExe & '"', '--kiosk ' & $sUrl)
EndFunc

Func _CloseEdge()
    ProcessClose($sEdgeExe)

    Exit
EndFunc
