#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#AutoIt3Wrapper_UseUpx=n
#Au3Stripper_Parameters=/sf /sv /mo /rm /rsln

Opt('MustDeclareVars', 1)

#include-once
#include <File.au3>
#include "..\lib\au3WebDriver\wd_helper.au3"
#include "..\lib\au3WebDriver\wd_capabilities.au3"



; initialization ---------------------------------------------------------------
Global Const $sDriver         = 'Firefox' ; Chrome|Firefox
Global Const $bIsHeadlessMode = False     ; False|True
Global Const $iDelay          = 1000      ; Nicht unter eine Sekunde gehen, da durch die Animationen das Skript nicht mehr robust wäre
Global $sSession              = null



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
    _OpenMyDriveTomTomWebsite()                 ; Webseite öffnen
    _AcceptsCookieConsent()                     ; Cookie consent bestätigen

    Local Const $sUsername = 'abcabcb@email.de' ; Hier die richtige Email eintragen
    Local Const $sPassword = 'abcabcabcab'      ; Hier das richtige Passwort eintragen

    _LoginToMyDrive($sUsername, $sPassword)     ; Login

    ; Testdaten (55 Einträge)
    Local $aTableOfAddresses[][2] = _           ; Diese Testdaten müssen natürlich mit deinen Echtdaten ersetzt werden
        [ _
            ['Test Name Landhotel', 'Westfälische Str. 52 57368 Lennestadt'], _
            ['Test Name München',   'Landsberger Straße 10 80339 München'], _
            ['Test Name Nürnberg',  'Hermannstrasse 9 90439 Nürnberg'], _
            ['Test Name Berlin',    'Pohlstrasse 67 10785 Berlin'], _
            ['Test Name Köln',      'Aachener Straße 300 50933 Köln'], _
            ['Test Name 06 Berlin', 'Alt-Lübars 11 13469 Berlin'], _
            ['Test Name 07 Berlin', 'Am Großen Wannsee 69 14109 Berlin'], _
            ['Test Name 08 Berlin', 'Am Studio 16 12489 Berlin'], _
            ['Test Name 09 Berlin', 'Am Zeppelinpark 51 13591 Berlin'], _
            ['Test Name 10 Berlin', 'Andreasstraße 21a 10243 Berlin'], _
            ['Test Name 11 Berlin', 'Berkaer Straße 5 14199 Berlin'], _
            ['Test Name 12 Berlin', 'Berliner Allee 187 13088 Berlin'], _
            ['Test Name 13 Berlin', 'Boothstraße 1C 12207 Berlin'], _
            ['Test Name 14 Berlin', 'Boxhagener Straße 97 10245 Berlin'], _
            ['Test Name 15 Berlin', 'Daumstraße 63 13599 Berlin'], _
            ['Test Name 16 Berlin', 'Dessauer Straße 13 10963 Berlin'], _
            ['Test Name 17 Berlin', 'Drei-Linien-Weg 39 13125 Berlin'], _
            ['Test Name 18 Berlin', 'Emser Straße 40 12051 Berlin'], _
            ['Test Name 19 Berlin', 'Fabeckstraße 9 14195 Berlin'], _
            ['Test Name 20 Berlin', 'Flurweg 72d 12357 Berlin'], _
            ['Test Name 21 Berlin', 'Freystadter Weg 73 12489 Berlin'], _
            ['Test Name 22 Berlin', 'Grünbergallee 300 12526 Berlin'], _
            ['Test Name 23 Berlin', 'Güldenhofer Ufer 4 12437 Berlin'], _
            ['Test Name 24 Berlin', 'Havelchaussee 83A 14193 Berlin'], _
            ['Test Name 25 Berlin', 'Helene-Weigel-Platz 14 12681 Berlin'], _
            ['Test Name 26 Berlin', 'Hoppestraße 30 13409 Berlin'], _
            ['Test Name 27 Berlin', 'Kolmarer Straße 2 10405 Berlin'], _
            ['Test Name 28 Berlin', 'Kommandantenstraße 95 12205 Berlin'], _
            ['Test Name 29 Berlin', 'Lehmusstraße 38 12524 Berlin'], _
            ['Test Name 30 Berlin', 'Lotosweg 26 13467 Berlin'], _
            ['Test Name 31 Berlin', 'Ludwigsburger Weg 2 12247 Berlin'], _
            ['Test Name 32 Berlin', 'Müggelseedamm 300 12587 Berlin'], _
            ['Test Name 33 Berlin', 'Neukladower Allee 12 14089'], _
            ['Test Name 34 Berlin', 'Niederheideweg 25 13589 Berlin'], _
            ['Test Name 35 Berlin', 'Nonnendammallee 175 13599 Berlin'], _
            ['Test Name 36 Berlin', 'Osdorfer Straße 59 12207 Berlin'], _
            ['Test Name 37 Berlin', 'Pembabogen 1 13587 Berlin'], _
            ['Test Name 38 Berlin', 'Petunienweg 46 12357 Berlin'], _
            ['Test Name 39 Berlin', 'Porzer Straße 15 12524 Berlin'], _
            ['Test Name 40 Berlin', 'Réaumurstraße 39A 12207 Berlin'], _
            ['Test Name 41 Berlin', 'Rehbrücker Weg 3 14165 Berlin'], _
            ['Test Name 42 Berlin', 'Ribbecker Straße 7 10315 Berlin'], _
            ['Test Name 43 Berlin', 'Rudolfstraße 16 10245 Berlin'], _
            ['Test Name 44 Berlin', 'Schleizer Straße 67 13055 Berlin'], _
            ['Test Name 45 Berlin', 'Steinauer Straße 9 13125 Berlin'], _
            ['Test Name 46 Berlin', 'Straße 101 5 13125 Berlin'], _
            ['Test Name 47 Berlin', 'Tillmannsweg 5b 14109 Berlin'], _
            ['Test Name 48 Berlin', 'Trachenbergring 8 12249 Berlin'], _
            ['Test Name 49 Berlin', 'Waldstraße 73 12621 Berlin'], _
            ['Test Name 50 Berlin', 'Weisestraße 10 12049 Berlin'], _
            ['Test Name 51 Berlin', 'Wikingerufer 9a 10555 Berlin'], _
            ['Test Name 52 Berlin', 'Windenweg 58a 12357 Berlin'], _
            ['Test Name 53 Berlin', 'Windmühlenweg 11 13469 Berlin'], _
            ['Test Name 54 Berlin', 'Yorckstraße 74 10965 Berlin'], _
            ['Test Name 55 Berlin', 'Zeisigweg 18 12209 Berlin'] _
        ]

    _AddAddressesToFavorites($aTableOfAddresses) ; Adress- und Namensdaten in Favoriten eintragen
EndFunc

Func _OpenMyDriveTomTomWebsite()
    _NavigateTo('https://mydrive.tomtom.com/de_de/#mode=viewport+viewport=49.9071,7.8184,13,0,-0+ver=3')
EndFunc

Func _AcceptsCookieConsent()
    Local Const $sAcceptCookieSelector = '//button[@id="cookie_banner_allow_button"][text()="Akzeptieren"]'

    _ClickElement($sAcceptCookieSelector)
EndFunc

Func _LoginToMyDrive($sUsername, $sPassword)
    Local Const $sLoginButtonSelector = '//button[contains(@id, "-loginButton")][text()="Anmelden"]'
    Local Const $sIframeSelector      = '//iframe[@id="iFrameResizer0"]'

    _ClickElement($sLoginButtonSelector)
    _EnterIFrame($sIframeSelector)

    Local Const $sEmailInputSelector    = '//input[@id="IDToken1"][@name="username"]'
    Local Const $sPasswordInputSelector = '//input[@id="IDToken2"][@name="password"]'
    Local Const $sLoginInputSelector    = '//input[@id="loginButton"][@value="Anmelden"]'

    _SetElementText($sEmailInputSelector, $sUsername)
    _SetElementText($sPasswordInputSelector, $sPassword)
    _ClickElement($sLoginInputSelector)

    _LeaveIFrame()
EndFunc

Func _AddAddressesToFavorites($aTableOfAddresses)
    Local Const $sMyPlacesSelector    = '//div[@id="my_places_menu_item"][contains(., "Meine Orte")]'
    Local Const $sFavoritesSelector   = '//span[@id="my_places_favourites"][text()="Favoriten"]'

    _ClickElement($sMyPlacesSelector)
    _ClickElement($sFavoritesSelector)

    Local Const $sAddNewPlaceSelector             = '//div[@id="favourites_view_add_favourite_button"]//div[text()="Neuen Ort hinzufügen"]'
    Local Const $sAddressInputSelector            = '//input[@id="favourite_location_search_input_box"]'
    Local Const $sNameInputSelector               = '//div[@id="favourite_name_input_box"]/input'
    Local Const $sFirstSuggestionListItemSelector = '//div[@id="favourite_search_suggestions_panel"]//div[contains(@id, "list_item_address_0")]'
    Local Const $sDoneButtonSelector              = '//button[@id="favourite_add_done_btn"][text()="Fertig"]'

    Local Const $iAddressCount = Ubound($aTableOfAddresses) - 1

    For $i = 0 To $iAddressCount Step 1
        _ClickElement($sAddNewPlaceSelector)

        Local $sName    = $aTableOfAddresses[$i][0]
        Local $sAddress = $aTableOfAddresses[$i][1]

        ConsoleWrite($i & '/' & $iAddressCount & ' ==> ' & $sAddress & @CRLF)

        _SetElementText($sAddressInputSelector, $sAddress)
        _SetElementText($sNameInputSelector, $sName)

        _ClickElement($sFirstSuggestionListItemSelector, $sAddress)
        _ClickElement($sDoneButtonSelector)
    Next
EndFunc



; webdriver functions ----------------------------------------------------------
Func _NavigateTo($sUrl)
    _WD_Navigate($sSession, $sUrl)
    _WD_LoadWait($sSession, $iDelay)
EndFunc

Func _FindElement($sSelector, $sMessage = '')
    Local $sElement = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector)
    If @error <> $_WD_ERROR_Success Then
        ConsoleWrite($sMessage & ' ==> Error for XPath selector ''' & $sSelector & '''.' & @CRLF)
        _TeardownDriver() ; WebDriver vorzeitig herunterfahren (bei Bedarf auskommentieren)
    EndIf

    Return $sElement
EndFunc

Func _ClickElement($sSelector, $sMessage = '')
    _WaitFor($sSelector)
    _WD_ElementAction($sSession, _FindElement($sSelector, $sMessage), 'click')
EndFunc

Func _EnterIFrame($sSelector)
    _WD_FrameEnter($sSession, _FindElement($sSelector))
EndFunc

Func _SetElementText($sSelector, $sValue)
    _WaitFor($sSelector)
    _WD_ElementAction($sSession, _FindElement($sSelector), 'value', $sValue)
EndFunc

Func _LeaveIFrame()
    _WD_FrameLeave($sSession)
    Sleep($iDelay)
EndFunc

Func _WaitFor($sSelector)
    Local Const $iTimeoutInMilliseconds = 5000
    Local Const $iElementVisibleFlag    = 1

    _WD_WaitElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector, $iDelay, $iTimeoutInMilliseconds, $iElementVisibleFlag)
EndFunc
