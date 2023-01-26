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
Global Const $iDelay          = 300       ; Verzögerung als Unterstützung für ein robustes Warteverhalten (Seitenaufbau, Klicks, Texte)
Global $sSession              = Null



; processing -------------------------------------------------------------------
_GetNewestDriver()  ; Dient zum aktualisieren des WebDrivers, kann später auskommentiert werden
_SetLogLevel()      ; Log level auf error ($_WD_DEBUG_Error) reicht meiner Meinung nach, kann natürlich variiert werden
_SetupDriver()      ; Session für chrome oder firefox (WebDriver) erstellen

_Actions()          ; Steuerung der Artikel-mit-Preise Webseite

_TeardownDriver()   ; WebDriver wieder herunterfahren



; setup and teardown functions -------------------------------------------------
Func _GetNewestDriver()
    _WD_UpdateDriver(StringLower($sDriver), _PathFull('..\util\webDriver'))
EndFunc

Func _SetLogLevel()
    ;~ $_WD_DEBUG = $_WD_DEBUG_None ; no logging
    $_WD_DEBUG = $_WD_DEBUG_Error   ; logging in case of Error
    ;~ $_WD_DEBUG = $_WD_DEBUG_Info ; logging with additional information
    ;~ $_WD_DEBUG = $_WD_DEBUG_Full ; logging with full details for developers
EndFunc

Func _SetupDriver()
    _SetDriverOptions()

    _WD_Startup()
    _WD_CapabilitiesStartup()

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

    Local Const $sDriverPath        = _PathFull('..\util\webDriver')
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
    Local Const $sCsvFilePath = _CreateArticlesAndPricesCsvFile() ; CSV Datei anlegen

    _OpenArticlesWebsite()                                        ; Webseite öffnen

    Local Const $iMaxSiteCount = _GetPaginationMaxSiteCount()     ; Anzahl der Seiten ermitteln, durch die navigiert werden muss,
                                                                  ; um alle Artikel/Preise zu berücksichtigen (nicht nur die der ersten Seite)

    For $i = 1 To $iMaxSiteCount - 1 Step 1                       ; Hier "- 1" da wir uns bereits auf der ersten Seite befinden
        Local $aListOfArticles          = _GetListOfArticles()    ; Artikel der jeweiligen Seite holen
        Local $aListOfPrices            = _GetListOfPrices()      ; Preise der jeweiligen Seite holen

        ; Dieser Schritt dient nur der Sicherheit, dass zu jedem Artikel auch ein dazugehöriger Preis gefunden wurde
        Local $aListOfArticlesAndPrices = _VerifyArticleCountAndPriceCountMatches($aListOfArticles, $aListOfPrices)

        ; CSV Datei mit gefundenen Werte füllen
        _WriteArticlesAndPricesToCsvFile($sCsvFilePath, $aListOfArticles, $aListOfPrices)
        _ChooseNextArticlePage()                                  ; Zur nächsten Seite navigieren
                                                                  ; und von vorn (Daten sammeln und in CSV schreiben)
    Next
EndFunc

Func _CreateArticlesAndPricesCsvFile()
    Local Const $sFilePath       = @ScriptDir & '\' & @YEAR & @MON & @MDAY & '-' & @HOUR & @MIN & @SEC & '-artikelnummer-verkaufspreis.csv'
    Local Const $sCsvColumnNames = 'Artikelnummer;Verkaufspreis' & @CRLF

    _WriteFile($sFilePath, $sCsvColumnNames)

    Return $sFilePath
EndFunc

Func _OpenArticlesWebsite()
    _NavigateTo('https://richner.teamonline.ch/waschtische-bidets-badezimmermoebel/aufsatzwaschtische-keramik')
EndFunc

Func _GetPaginationMaxSiteCount()
    Local Const $sPaginationTextSelector = '(//ul[@class="pagination"])[1]/li[contains(@class, "label")]'

    Local Const $sPaginationText             = _GetElementText($sPaginationTextSelector)
    Local Const $sRegExPatternOfMaxSiteCount = ' von (\d+)'
    Local Const $iReturnMatchesFlag          = 1

    Return StringRegExp($sPaginationText, $sRegExPatternOfMaxSiteCount, $iReturnMatchesFlag)[0]
EndFunc

Func _GetListOfArticles()
    Local Const $sArticleDescriptionSelector = '//h6[@class="product-itemnumber-desc"]'

    Local $aListOfElementsTexts = _GetElementsTexts($sArticleDescriptionSelector)

    Return _RemoveUnnecessaryTextsFromList($aListOfElementsTexts)
EndFunc

Func _RemoveUnnecessaryTextsFromList($aList)
    Local Const $iCount = _GetCount($aList)

    For $i = 0 To $iCount Step 1
        $aList[$i] = StringReplace($aList[$i], 'Artikel-Nr.: ', '')
        $aList[$i] = StringReplace($aList[$i], 'Farbe: ',       '')
        $aList[$i] = StringReplace($aList[$i], 'Ausführung: ',  '')
        $aList[$i] = StringReplace($aList[$i], @LF, '')
    Next

    Return $aList
EndFunc

Func _GetListOfPrices()
    Local Const $sArticlePriceSelector = '//div[@class="product-price "]/span'

    Return _GetElementsTexts($sArticlePriceSelector)
EndFunc

Func _VerifyArticleCountAndPriceCountMatches($aArticles, $aPrices)
    If _GetCount($aArticles) == _GetCount($aPrices) Then
        Return
    EndIf

    Local Const $iErrorIconFlag    = 16
    Local Const $sTimeoutInSeconds = 10
    Local Const $sErrorMessage     = 'Anzahl gefundener Artikel und die Anzahl der gefundenen Preise stimmt nicht überein.'

    MsgBox($iErrorIconFlag, 'Error', $sErrorMessage, $sTimeoutInSeconds)

    _TeardownDriver() ; WebDriver vorzeitig herunterfahren (bei Bedarf auskommentieren)
EndFunc

Func _WriteArticlesAndPricesToCsvFile($sFile, $aArticles, $aPrices)
    For $i = 0 To _GetCount($aArticles) Step 1
        _AppendToFile($sFile, $aArticles[$i] & ';' & $aPrices[$i] & @CRLF)
    Next
EndFunc

Func _ChooseNextArticlePage()
    Local Const $sPaginationArrowNextSelector = '(//ul[@class="pagination"])[1]//li[@class="arrow next "]'

    _ClickElement($sPaginationArrowNextSelector)
EndFunc



; webdriver functions ----------------------------------------------------------
Func _NavigateTo($sUrl)
    _WD_Navigate($sSession, $sUrl)
    _WD_LoadWait($sSession, $iDelay)
EndFunc

Func _FindElement($sSelector)
    Local $sElement = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector)
    If @error <> $_WD_ERROR_Success Then
        ConsoleWrite('Error for XPath selector ''' & $sSelector & '''.' & @CRLF)
        _TeardownDriver() ; WebDriver vorzeitig herunterfahren (bei Bedarf auskommentieren)
    EndIf

    Return $sElement
EndFunc

Func _FindElements($sSelector)
    Return _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector, Default, True)
EndFunc

Func _WaitFor($sSelector)
    Local Const $iTimeoutInMilliseconds = 5000
    Local Const $iElementVisibleFlag    = 1

    _WD_WaitElement($sSession, $_WD_LOCATOR_ByXPath, $sSelector, $iDelay, $iTimeoutInMilliseconds, $iElementVisibleFlag)
EndFunc

Func _GetElementText($sSelector)
    _WaitFor($sSelector)

    Return _WD_ElementAction($sSession, _FindElement($sSelector), 'text')
EndFunc

Func _GetElementsTexts($sSelector)
    Local Const $aListOfElements = _FindElements($sSelector)
    Local Const $iCount          = _GetCount($aListOfElements)

    Local $aListOfElementsTexts[$iCount + 1]

    For $i = 0 To $iCount Step 1
        $aListOfElementsTexts[$i] = _WD_ElementAction($sSession, $aListOfElements[$i], 'text')
    Next

    Return $aListOfElementsTexts
EndFunc

Func _ClickElement($sSelector)
    _WaitFor($sSelector)
    _WD_ElementAction($sSession, _FindElement($sSelector), 'click')
EndFunc



; helper functions -------------------------------------------------------------
Func _WriteFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndOverwriteCreationMode = 256 + 2 + 8

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndOverwriteCreationMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _GetCount($aList)
    Return UBound($aList) - 1
EndFunc

Func _AppendToFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndAppendMode = 256 + 1

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndAppendMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc
