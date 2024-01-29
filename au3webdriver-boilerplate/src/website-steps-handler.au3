#include "common\webdriver-actions-handler.au3"
#include "page-objects\elements-page.au3"
#include "selectors\elements-sel.au3"

Func _Steps()
    _OpenDemoWebsite()
    _NavigateToTextBoxes()
    _FillFormTextBoxes()

    ConsoleWrite('Sleep(1500) and END!' & @CRLF)
    Sleep(1500)
EndFunc

Func _OpenDemoWebsite()
    _NavigateTo('https://demoqa.com/')
EndFunc
