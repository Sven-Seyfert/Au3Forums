#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln



#include-once
#include <File.au3>
#include "..\lib\au3WebDriver\wd_helper.au3"
#include "..\lib\au3WebDriver\wd_capabilities.au3"



; initialization ---------------------------------------------------------------
Global Const $sDriver            = 'Firefox' ; Chrome|Firefox
Global Const $bIsHeadlessMode    = False     ; False|True
Global Const $iDelay             = 500       ; Hier kannst du bei Bedarf etwas probieren ob du weniger als die halbe Sekunde einstellen kannst und es trotzdem robust läuft
Global $sSession                 = null
Global $bAlreadyCookiesConfirmed = False
Global $bAlreadLoginIn           = False



; processing -------------------------------------------------------------------
_GetNewestDriver()  ; Dient zum Aktualisieren, kann später auskommentiert werden
_SetLogLevel()      ; Log level auf error ($_WD_DEBUG_Error) reicht meiner Meinung nach, kann natürlich variiert werden
_SetupDriver()      ; Session für chrome oder firefox (WebDriver) erstellen

_Actions()          ; Steuerung der MyDriveTomTom Webseite

_TeardownDriver()   ; WebDriver wieder herunterfahren



; setup and teardown functions -------------------------------------------------
Func _GetNewestDriver()
    _WD_UpdateDriver(StringLower($sDriver), _PathFull('..\util\webDriver'))
EndFunc

Func _SetLogLevel()
    ;~ $_WD_DEBUG = $_WD_DEBUG_None  ; no logging
    $_WD_DEBUG = $_WD_DEBUG_Error ; logging in case of Error
    ;~ $_WD_DEBUG = $_WD_DEBUG_Info  ; logging with additional information
    ;~ $_WD_DEBUG = $_WD_DEBUG_Full  ; logging with full details for developers
EndFunc

Func _SetupDriver()
    _SetDriverOptions()
    _WD_Startup()

    Local $sCapabilities = _
        (StringLower($sDriver) == 'chrome') _
            ? _CreateChromeDriverCapabilities() _
            : _CreateFirefoxDriverCapabilities()

    $sSession = _WD_CreateSession($sCapabilities)
EndFunc

Func _SetDriverOptions()
    Local Const $sDriverExe = _
        (StringLower($sDriver) == 'chrome') _
            ? 'chromedriver.exe' _
            : 'geckodriver.exe'

    Local Const $sDriverPath = _PathFull('..\util\webDriver')
    Local Const $sDriverExeFilePath = $sDriverPath & '\' & $sDriverExe

    Local Const $iPort = _
        (StringLower($sDriver) == 'chrome') _
            ? 9515 _
            : 4444

    Local Const $sDriverParams = _
        (StringLower($sDriver) == 'chrome') _
            ? '--verbose --log-path="' & $sDriverPath & '\chromedriver.log"' _
            : '--log trace'

    _WD_Option('Driver', $sDriverExeFilePath)
    _WD_Option('Port', $iPort)
    _WD_Option('DriverParams', $sDriverParams)
EndFunc

Func _CreateChromeDriverCapabilities()
    _WD_CapabilitiesStartup()

    _WD_CapabilitiesAdd('alwaysMatch', 'chrome')
    _WD_CapabilitiesAdd('w3c', True)
    _WD_CapabilitiesAdd('excludeSwitches', 'enable-automation')
    _WD_CapabilitiesAdd('args', '--window-size=1366,768')

    If $bIsHeadlessMode Then
        _WD_CapabilitiesAdd('args', '--headless')
    EndIf

    Return _WD_CapabilitiesGet()
EndFunc

Func _CreateFirefoxDriverCapabilities()
    _WD_CapabilitiesStartup()

    _WD_CapabilitiesAdd('alwaysMatch', 'firefox')
    _WD_CapabilitiesAdd('browserName', 'firefox')
    _WD_CapabilitiesAdd('acceptInsecureCerts', True)
    _WD_CapabilitiesAdd('binary', 'C:\Program Files\Mozilla Firefox\firefox.exe') ; Ggf. einmalig diesen Pfad anpassen
    _WD_CapabilitiesAdd('args', '--window-size=1366,768')

    If $bIsHeadlessMode Then
        _WD_CapabilitiesAdd('args', '--headless')
    EndIf

    Return _WD_CapabilitiesGet()
EndFunc

Func _TeardownDriver()
    _WD_DeleteSession($sSession)
    _WD_Shutdown()
EndFunc



; website functions ------------------------------------------------------------
Func _Actions()
    ; Diese Testdaten müssen natürlich mit deinen Echtdaten ersetzt werden
    Local $aDataTable[][5] = _
        [ _
            ['01.) Test Rosen Apotheke',           '49.9435,7.77146',  '55442', 'Stromberg',       'Staatsstr. 6'], _
            ['02.) Test Frank Seckler',            '49.92707,7.79999', '55444', 'Schweppenhausen', 'Naheweinstraße 38'], _
            ['03.) Test KLUG Kellereibedarf GmbH', '49.89656,7.90462', '55450', 'Langenlonsheim',  'An den Nahewiesen 5'], _
            ['04.) Test Ernst Schmitt',            '49.89001,7.84818', '55452', 'Guldental',       'Naheweinstr. 27'], _
            ['05.) Test Karl Muster',              '49.89559,7.83601', '55452', 'Guldental',       'Brunnengasse 6'], _
            ['06.) Test Weingut Thomas Rickes',    '49.89566,7.83476', '55452', 'Guldental',       'Brunnengasse 3'], _
            ['07.) Test Weingut Jäckel',           '49.88758,7.76685', '55595', 'Wallhausen',      'Traubenstr. 12'] _
        ]

    _AddColumnToTable($aDataTable)

    ; Achtung! Die Schleife startet bei $i = 0, nicht bei $i = 1.
    ; Falls du die "Column3;Column8;Column9;Column10;Column11" Zeile
    ; mit im Array hast, dann bitte $i = 1 setzen.
    For $i = 0 To _GetCount($aDataTable) Step 1
        _AddUrlToLastColumnOfTable($aDataTable, $i)
    Next

    ; Hier kannst du dir die Daten mit URL als letzte Spalte anschauen.
    ; _ArrayDisplay($aDataTable)

    Local Const $iUrlColumn = UBound($aDataTable, 2) - 1
    Local Const $sUsername = 'abcabcb@email.de'                 ; Hier die richtige Email eintragen
    Local Const $sPassword = 'abcabcabcab'                      ; Hier das richtige Passwort eintragen

    For $i = 0 To _GetCount($aDataTable) Step 1
        _OpenPlanTomTomWebsite($aDataTable[$i][$iUrlColumn])    ; Url öffnen

        _ConfirmWelcomeDialog()                                 ; "Jetzt planen" bestätigen
        _AcceptsCookieConsent()                                 ; Cookie consent bestätigen (nur beim 1. Mal)

        _LoginToPlanTomTom($sUsername, $sPassword)              ; Login (nur beim 1. Mal)
        _ChooseFavoriteStarIcon()                               ; Stern anklicken
        _SaveFavorite($aDataTable[$i][0])                       ; Favoriten speichern

        Sleep(1000)                                             ; Hier kurz warten, bevor die nächste Url aufgerufen wird
    Next

    MsgBox('', 'Ende', 'Fertig mit den Eingaben.', 10)          ; Kann auskommentiert werden
EndFunc

Func _AddColumnToTable(ByRef $aDataTable)
    Local Const $iMaxColumn = UBound($aDataTable, 2)
    _ArrayColInsert($aDataTable, $iMaxColumn)
EndFunc

Func _GetCount($aList)
    Return UBound($aList) - 1
EndFunc

Func _AddUrlToLastColumnOfTable(ByRef $aDataTable, $i)
    Local Const $sCoords    = _RemoveUnnecessaryWhitespaces($aDataTable[$i][1])
    Local Const $sZipCode   = _RemoveUnnecessaryWhitespaces($aDataTable[$i][2])
    Local Const $sCity      = _RemoveUnnecessaryWhitespaces($aDataTable[$i][3])
    Local Const $sStreet    = _RemoveUnnecessaryWhitespaces($aDataTable[$i][4])
    Local Const $iUrlColumn = UBound($aDataTable, 2) - 1

    Local $sUrl = _
        'https://plan.tomtom.com/de/location/addr/%s-%s_%s/49_92708~7_79999?p=49.92708,7.79902,16z&' & _
        'q=%s#mode=viewport viewport=%s,12.43,0,-0 ver=3'

    $sUrl = StringFormat($sUrl, $sStreet, $sZipCode, $sCity, $sStreet, $sCoords)

    $aDataTable[$i][1]           = $sCoords
    $aDataTable[$i][2]           = $sZipCode
    $aDataTable[$i][3]           = $sCity
    $aDataTable[$i][4]           = $sStreet
    $aDataTable[$i][$iUrlColumn] = $sUrl
EndFunc

Func _RemoveUnnecessaryWhitespaces($sString)
    Local Const $iLeadingAndTrailingWhitespaceFlag = 3
    Return StringStripWS($sString, $iLeadingAndTrailingWhitespaceFlag)
EndFunc

Func _OpenPlanTomTomWebsite($sUrl)
    _NavigateTo($sUrl)
EndFunc

Func _ConfirmWelcomeDialog()
    Local Const $sLetsPlanButtonSelector = '//button[contains(@class, "modal")]/span[text()="Jetzt planen"]/parent::*'

    _ClickElement($sLetsPlanButtonSelector)
EndFunc

Func _AcceptsCookieConsent()
    If $bAlreadyCookiesConfirmed Then
        Return
    EndIf

    Local Const $sAcceptCookieSelector = '//div[@class="cookie-panel"]//button/span[text()="Alle akzeptieren"]/parent::*'

    _ClickElement($sAcceptCookieSelector)

    $bAlreadyCookiesConfirmed = True
EndFunc

Func _LoginToPlanTomTom($sUsername, $sPassword)
    If $bAlreadLoginIn Then
        Return
    EndIf

    Local Const $sLoginButtonSelector = '//button[@data-qa-id="login-component__login-button"]//span[text()="Anmelden"]/parent::*/parent::button'

    _ClickElement($sLoginButtonSelector)

    Local Const $sEmailInputSelector    = '//div[@data-qa-id="login-email"]/input'
    Local Const $sPasswordInputSelector = '//div[@data-qa-id="login-password"]/input'
    Local Const $sLoginInputSelector    = '//button[@data-qa-id="login-modal__login" and text()="Anmelden"]'

    _SetElementText($sEmailInputSelector, $sUsername)
    _SetElementText($sPasswordInputSelector, $sPassword)
    _ClickElement($sLoginInputSelector)

    $bAlreadLoginIn = True
EndFunc

Func _ChooseFavoriteStarIcon()
    Local Const $sFavoriteStarIconSelector = '//button[@data-qa-id="card-heading__favorite--location-details"]'

    _ClickElement($sFavoriteStarIconSelector)
EndFunc

Func _SaveFavorite($sName)
    Local Const $sLocationRadioButtonSelector = '//div[contains(@class, "modal")]//input[@data-qa-id="favourite-edit-modal__pin-as-generic"]'
    Local Const $sNameInputSelector           = '//div[contains(@class, "modal")]//input[@id="favourite-edit-name"]'
    Local Const $sSaveButtonSelector          = '//div[contains(@class, "modal")]//button[@data-qa-id="favourite-edit-modal__save"]/span[text()="Speichern"]/parent::*'

    _CheckModalIsVisible($sLocationRadioButtonSelector)

    _ClearElementsText($sNameInputSelector)
    _SetElementText($sNameInputSelector, $sName)
    _ClickElement($sSaveButtonSelector)
EndFunc

Func _CheckModalIsVisible($sSelector)
    For $i = 1 To 3 Step 1
        If _ExistsElement($sSelector) Then
            ExitLoop
        EndIf

        Sleep(1000)

        If Not _ExistsElement($sSelector) Then
            _ChooseFavoriteStarIcon()
        EndIf
    Next
EndFunc



; webdriver functions ----------------------------------------------------------
Func _NavigateTo($sUrl)
    _WD_Navigate($sSession, $sUrl)
    _WD_LoadWait($sSession, $iDelay)
EndFunc

Func _FindElement($sSelector)
    Local $sElement = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector)
    If @error <> $_WD_ERROR_Success Then
        ;~ _TeardownDriver() ; !!! WebDriver vorzeitig herunterfahren (bei Bedarf ein- oder aus-kommentieren)
    EndIf

    Return $sElement
EndFunc

Func _ExistsElement($sSelector)
    Return _FindElement($sSelector) <> ''
EndFunc

Func _ClickElement($sSelector)
    _WaitFor($sSelector)
    _WD_ElementAction($sSession, _FindElement($sSelector), 'click')
EndFunc

Func _ClearElementsText($sSelector)
    _WaitFor($sSelector)
    _WD_ElementAction($sSession, _FindElement($sSelector), 'clear')
EndFunc

Func _SetElementText($sSelector, $sValue)
    _WaitFor($sSelector)
    _WD_ElementAction($sSession, _FindElement($sSelector), 'value', $sValue)
EndFunc

Func _WaitFor($sSelector)
    Local Const $iTimeoutInMilliseconds = 5000
    Local Const $iElementVisibleFlag    = 1

    _WD_WaitElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector, $iDelay, $iTimeoutInMilliseconds, $iElementVisibleFlag)
EndFunc
