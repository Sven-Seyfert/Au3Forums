#include "common\webdriver-elements-handler.au3"
#include "page-objects\elements-page.au3"
#include "steps\elements-steps.au3"

Func _Steps()
    _OpenDemoWebsite()
    _NavigateToTextBoxes()
    _FillFormTextBoxes()

    ConsoleWrite('Sleep' & @CRLF)
    Sleep(1500)
EndFunc

Func _OpenDemoWebsite()
    _NavigateTo('https://demoqa.com/')
EndFunc
