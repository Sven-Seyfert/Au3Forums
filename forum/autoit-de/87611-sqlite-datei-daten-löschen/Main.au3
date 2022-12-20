; includes ---------------------------------------------------------------------
#include-once
#include <Array.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>



; declaration ------------------------------------------------------------------
Global $sSqliteDll = 'sqlite3_x64.dll'
Global $sDatabase  = 'places.sqlite'
Global $hDatabase



; processing -------------------------------------------------------------------
_Startup($sSqliteDll)
_OpenDatabase($sDatabase)

_ShowTableContent('moz_historyvisits')
_ExecuteQuery('delete from moz_historyvisits;')
_ShowTableContent('moz_historyvisits')

_TearDown()



; functions --------------------------------------------------------------------
Func _ShowTableContent($sTableName)
    $aQueryResult = _QueryResultToArray('select * from ' & $sTableName & ';')
    _ArrayDisplay($aQueryResult)
EndFunc

Func _Startup($sDll)
    _SQLite_Startup($sDll)

    If @error Then
        MsgBox(16, 'Error', 'File "' & $sDll & '" not found.')
        Exit -1
    EndIf
EndFunc

Func _OpenDatabase($sDatabase)
    $hDatabase = _SQLite_Open($sDatabase)

    If @error Then
        MsgBox(16, 'Error', 'Can not open database "' & $sDatabase & '".')
        Exit -1
    EndIf
EndFunc

Func _QueryResultToArray($sQuery)
    Local $aQueryResult, $iRows, $iColumns

    _SQLite_GetTable2d($hDatabase, $sQuery, $aQueryResult, $iRows, $iColumns)

    Return $aQueryResult
EndFunc

Func _ExecuteQuery($sQuery)
    _SQLite_Exec($hDatabase, $sQuery)
EndFunc

Func _TearDown()
    _SQLite_Close()
    _SQLite_Shutdown()
EndFunc
