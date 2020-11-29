import static com.kms.katalon.core.checkpoint.CheckpointFactory.findCheckpoint
import static com.kms.katalon.core.testcase.TestCaseFactory.findTestCase
import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
import static com.kms.katalon.core.testobject.ObjectRepository.findTestObject
import static com.kms.katalon.core.testobject.ObjectRepository.findWindowsObject
import com.kms.katalon.core.checkpoint.Checkpoint as Checkpoint
import com.kms.katalon.core.cucumber.keyword.CucumberBuiltinKeywords as CucumberKW
import com.kms.katalon.core.mobile.keyword.MobileBuiltInKeywords as Mobile
import com.kms.katalon.core.model.FailureHandling as FailureHandling
import com.kms.katalon.core.testcase.TestCase as TestCase
import com.kms.katalon.core.testdata.TestData as TestData
import com.kms.katalon.core.testobject.TestObject as TestObject
import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
import com.kms.katalon.core.webui.keyword.WebUiBuiltInKeywords as WebUI
import com.kms.katalon.core.windows.keyword.WindowsBuiltinKeywords as Windows
import internal.GlobalVariable as GlobalVariable
import org.openqa.selenium.Keys as Keys
import org.openqa.selenium.By as By
import org.openqa.selenium.WebDriver as WebDriver
import org.openqa.selenium.WebElement as WebElement
import com.kms.katalon.core.webui.driver.DriverFactory as DriverFactory
import com.kms.katalon.core.util.KeywordUtil as KeywordUtil
import java.util.Iterator as Iterator
import java.io.File as File

WebUI.openBrowser('https://www.google.com/')

WebDriver driver = DriverFactory.getWebDriver()

WebUI.navigateToUrl('https://www.ilco.us/ilco-en/support/ez-search/auto-truck-lookup')

iframe = findTestObject('Page_Auto Truck Lookup/iframe_AutoTruckLookup')

WebUI.switchToFrame(iframe, 100)

numberOfMakes = (WebUI.getNumberOfTotalOption(findTestObject('Page_Auto Truck Lookup/Select_Makes')) - 1)

//TESTING ONLY
//numberOfMakes = 7

//Initialize File
SQL_FILE_ABS_PATH = "C://git/MobileLoc/LogFiles/InsertKeyBlanks.txt"

DROP_TEMP_TABLE_TEXT = "DROP TABLE IF EXISTS #ilcoKeyBlankEntry\n\n"
CREATE_TEMP_TABLE_TEXT = "CREATE TABLE #ilcoKeyBlankEntry\n(\nMakeName NVARCHAR(1000),\nModelName NVARCHAR(1000),\nEntryTitle NVARCHAR(1000),\nKeyBlankDetails NVARCHAR(1000),\nCodeSeriesText NVARCHAR(1000),\nSubstituteText NVARCHAR(1000),\nProgramWithText NVARCHAR(1000),\nNotesText NVARCHAR(1000)\n)\n\n"
INSERT_HEADER_TEXT = "\n\nINSERT INTO #ilcoKeyBlankEntry\n(\nMakeName,\nModelName,\nEntryTitle,\nKeyBlankDetails,\nCodeSeriesText,\nSubstituteText,\nProgramWithText,\nNotesText\n) \n\nVALUES\n"
setupText = DROP_TEMP_TABLE_TEXT + CREATE_TEMP_TABLE_TEXT

outputFile = new File(SQL_FILE_ABS_PATH)
outputFile.append(setupText)


//Get Data from Web
insertStatementData = ''

makeName = ''
modelName = ''

thisMakeIndex = 1

for (def thisMakeIndex : (1..numberOfMakes-1)) {
    if (thisMakeIndex == 1) {
        WebUI.selectOptionByIndex(findTestObject('Page_Auto Truck Lookup/Select_Makes'), thisMakeIndex, FailureHandling.STOP_ON_FAILURE)
    } else {
        WebUI.selectOptionByIndex(findTestObject('Page_Auto Truck Lookup/Select_Makes'), thisMakeIndex + 1, FailureHandling.STOP_ON_FAILURE)
    }
    
    makeName = WebUI.getAttribute(findTestObject('Page_Auto Truck Lookup/Select_Makes'), 'value')
	
    KeywordUtil.logInfo('******************This Make Name: ' + makeName)

    numberOfModels = (WebUI.getNumberOfTotalOption(findTestObject('Page_Auto Truck Lookup/Select_Models')) - 1)
	
	if(numberOfModels > 0){
		outputFile.append(INSERT_HEADER_TEXT)
	}
	
    //TESTING
    //numberOfModels = 2

    thisModelIndex = 1

    for (def thisModelIndex : (1..numberOfModels-1)) 
	{
        if ((thisMakeIndex == 1) && (thisModelIndex == 1)) 
		{
            WebUI.selectOptionByIndex(findTestObject('Page_Auto Truck Lookup/Select_Models'), thisModelIndex, FailureHandling.STOP_ON_FAILURE)
        } 
		else 
		{
            WebUI.selectOptionByIndex(findTestObject('Page_Auto Truck Lookup/Select_Models'), thisModelIndex + 1, FailureHandling.STOP_ON_FAILURE)
        }
		WebUI.delay(1)
		
		modelName = WebUI.getAttribute(findTestObject('Page_Auto Truck Lookup/Select_Models'), 'value')
        KeywordUtil.logInfo('******************This Model Name: ' + modelName)

        List<WebElement> elements = driver.findElements(By.xpath('//div[@class="entry"]'))

        if (elements.isEmpty()) 
		{
            KeywordUtil.logInfo('EMPTY LIST! TRY HARDER!')
        } 
		else 
		{
            numberOfElements = elements.size()

            for (def i : (1..numberOfElements)) {
                thisElement = elements.get(i - 1)

                entryTitle = thisElement.findElement(By.tagName('h2'))

                keyBlankDetails = thisElement.findElement(By.tagName('h3'))

                CODE_SERIES_SEARCH_TEXT = 'Code Series'

                codeSeriesText = ''

                codeSeriesElement = thisElement.findElements(By.xpath("//strong[contains(text(), '$CODE_SERIES_SEARCH_TEXT')]/parent::p"))

                if (!(codeSeriesElement.isEmpty())) {
                    codeSeriesText = (codeSeriesElement[0]).getText()
                    codeSeriesText = codeSeriesText.replace("$CODE_SERIES_SEARCH_TEXT: ", "")
                }
                
                SUBSTITUTE_SEARCH_TEXT = 'Substitute'

                substituteText = ''

                substituteElement = thisElement.findElements(By.xpath("//strong[contains(text(), '$SUBSTITUTE_SEARCH_TEXT')]/parent::p"))

                if (!(substituteElement.isEmpty())) {
                    substituteText = (substituteElement[0]).getText()
                    substituteText = substituteText.replace("$SUBSTITUTE_SEARCH_TEXT: ", "")
                }
                
                PROGRAM_WITH_SEARCH_TEXT = 'Program wtih'

                programWithText = ''

                programWithElement = thisElement.findElements(By.xpath("//strong[contains(text(), '$PROGRAM_WITH_SEARCH_TEXT')]/parent::p"))

                if (!(programWithElement.isEmpty())) {
                    programWithText = (programWithElement[0]).getText()
                    programWithText = programWithText.replace("$PROGRAM_WITH_SEARCH_TEXT: ", "")
                }
                
                NOTES_SEARCH_TEXT = 'Notes'

                notesText = ''

                notesElement = thisElement.findElements(By.xpath("//strong[contains(text(), '$NOTES_SEARCH_TEXT')]/parent::p"))

                if (!(notesElement.isEmpty())) {
                    notesText = (notesElement[0]).getText()
                    notesText = notesText.replace("$NOTES_SEARCH_TEXT: ", "")
                }
                
                insertStatmentElement = "( '$makeName',"

                insertStatmentElement += " '$modelName',"

                insertStatmentElement += " '$entryTitle.text',"

                insertStatmentElement += " '$keyBlankDetails.text',"

                insertStatmentElement += " '$codeSeriesText',"

                insertStatmentElement += " '$substituteText',"

                insertStatmentElement += " '$programWithText',"

                insertStatmentElement += " '$notesText' )"

                insertStatementData = ((insertStatementData + '\n') + insertStatmentElement)

				if(!(thisModelIndex+1 == numberOfModels && i == numberOfElements))
				{
					insertStatementData = insertStatementData + ','
				}
				else 
				{
					insertStatementData + '\n\n'
				}
                KeywordUtil.logInfo('*****************InsertStatementData: ' + insertStatementData)
            }
        }
		
		outputFile.append(insertStatementData)
		insertStatementData = ''

    } // models
	
} // makes




