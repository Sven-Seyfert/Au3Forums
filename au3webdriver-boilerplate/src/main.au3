#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln

Opt('MustDeclareVars', 1)

#include-once
#include <File.au3>
#include "..\lib\au3WebDriver\wd_helper.au3"
#include "..\lib\au3WebDriver\wd_capabilities.au3"

OnAutoItExitRegister('_TeardownDriver')

Global $mConfig[]
Global $sSession

#include "helper.au3"
#include "webdriver-handler.au3"
#include "website-steps-handler.au3"

_Main()

Func _Main()
    _SetGlobalValues($mConfig)

    _GetNewestDriver() ; get the current webdriver version of the chosen browser
    _SetLogLevel()     ; set log level to error which is fine in my opinion (reset it in the function)
    _SetupDriver()     ; create webdriver session (for chrome or firefox)

    _Steps()           ; main website steps to automate (website automation flow)

    _TeardownDriver()  ; shutdown webdriver (and browser)
EndFunc

Func _SetGlobalValues(ByRef $mConfig)
    $mConfig.Driver         = 'chrome' ; chrome|firefox|msedge
    $mConfig.IsHeadlessMode = False    ; False|True
    $mConfig.Delay          = 300      ; delay for supporting a robust wait behavior (page load, clicks, texts)
    $mConfig.BrowserWidth   = 1423     ; 1920
    $mConfig.BrowserHeight  = 800      ; 1080

    ; HINT: This is the default installation path, change this in case it's another on your system.
    $mConfig.FirefoxBinary  = 'C:\Program Files\Mozilla Firefox\firefox.exe'
EndFunc


