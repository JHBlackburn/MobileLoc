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
import com.kms.katalon.core.util.KeywordUtil
import java.util.Iterator
import java.io.File
 

WebDriver driver = DriverFactory.getWebDriver()

WebUI.openBrowser('https://www.google.com/')

WebUI.navigateToUrl('https://www.ilco.us/ilco-en/support/ez-search/auto-truck-lookup')

iframe = findTestObject('Page_Auto Truck Lookup/iframe_AutoTruckLookup')
WebUI.switchToFrame(iframe, 100)

numberOfMakes = (WebUI.getNumberOfTotalOption(findTestObject('Page_Auto Truck Lookup/Select_Makes')) - 1)

//TESTING ONLY
numberOfMakes = 1

postPayloadData = '['

insertStatementData = ''

for (def thisMakeIndex : (1..numberOfMakes)) 
{
	
	if(thisMakeIndex == 1)
	{
		WebUI.selectOptionByIndex(findTestObject('Page_Auto Truck Lookup/Select_Makes'), thisMakeIndex, FailureHandling.STOP_ON_FAILURE)
	}
	else
	{
		WebUI.selectOptionByIndex(findTestObject('Page_Auto Truck Lookup/Select_Makes'), thisMakeIndex + 1, FailureHandling.STOP_ON_FAILURE)
	}
	
	makeName = WebUI.getAttribute(findTestObject('Page_Auto Truck Lookup/Select_Makes'),'value')
	KeywordUtil.logInfo('******************This Make Name: ' + makeName)
	
    numberOfModels = (WebUI.getNumberOfTotalOption(findTestObject('Page_Auto Truck Lookup/Select_Models')) - 1)
	

	//TESTING
	numberOfModels = 1

	
    thisModelIndex = 1
	
    for (def thisModelIndex : (1..numberOfModels)) 
	{
		
		if(thisMakeIndex == 1 && thisModelIndex == 1)
		{
			WebUI.selectOptionByIndex(findTestObject('Page_Auto Truck Lookup/Select_Models'), thisModelIndex, FailureHandling.STOP_ON_FAILURE)
		}
		else
		{
			WebUI.selectOptionByIndex(findTestObject('Page_Auto Truck Lookup/Select_Models'), thisModelIndex+1, FailureHandling.STOP_ON_FAILURE)
		}
		
        WebUI.selectOptionByIndex(findTestObject('Page_Auto Truck Lookup/Select_Models'), thisModelIndex, FailureHandling.STOP_ON_FAILURE)
		
		modelName = WebUI.getAttribute(findTestObject('Page_Auto Truck Lookup/Select_Models'),'value')
		KeywordUtil.logInfo('******************This Model Name: ' + modelName)
		
		List<WebElement> elements = driver.findElements(By.xpath('//div[@class="entry"]'))

		if( elements.isEmpty())
		{
			KeywordUtil.logInfo('EMPTY LIST! TRY HARDER!')
		}
		else
		{

			numberOfElements = elements.size()
			
			for (def i : (1..numberOfElements)) 
			{
				thisElement = elements.get(i-1);
				entryTitle = thisElement.findElement(By.tagName("h2"))
				keyBlankDetails = thisElement.findElement(By.tagName("h3"))
				
				CODE_SERIES_SEARCH_TEXT = 'Code Series'
				codeSeriesText = ""
				codeSeriesElement = (thisElement.findElements(By.xpath("//strong[contains(text(), '${CODE_SERIES_SEARCH_TEXT}')]/parent::p")))
				if(!codeSeriesElement.isEmpty())
				{
					codeSeriesText = codeSeriesElement[0].getText()
				}
				SUBSTITUTE_SEARCH_TEXT = 'Substitute'
				substituteText = ""
				substituteElement = thisElement.findElements(By.xpath("//strong[contains(text(), '${SUBSTITUTE_SEARCH_TEXT}')]/parent::p"))
				if(!substituteElement.isEmpty())
				{
					substituteText = substituteElement[0].getText()
				}
				PROGRAM_WITH_SEARCH_TEXT = 'Program wtih' //notice the typo!
				programWithText = ""
				programWithElement = thisElement.findElements(By.xpath("//strong[contains(text(), '${PROGRAM_WITH_SEARCH_TEXT}')]/parent::p"))
				if(!programWithElement.isEmpty())
				{
					programWithText = programWithElement[0].getText()
				}
				NOTES_SEARCH_TEXT = 'Notes'
				notesText = ""
				notesElement = thisElement.findElements(By.xpath("//strong[contains(text(), '${NOTES_SEARCH_TEXT}')]/parent::p"))
				if(!notesElement.isEmpty())
				{
					notesText = notesElement[0].getText()
				}

				
				postPayloadElement = "{\n"
				postPayloadElement += "\"makeName\": \"${makeName}\",\n"
				postPayloadElement += "\"modelName\": \"${modelName}\",\n"
				postPayloadElement += "\"entryTitle\": \"${entryTitle.getText()}\",\n"
				postPayloadElement += "\"keyBlankDetails\": \"${keyBlankDetails.getText()}\",\n"
				postPayloadElement += "\"codeSeriesText\": \"${codeSeriesText}\",\n"
				postPayloadElement += "\"substituteText\": \"${substituteText}\",\n"
				postPayloadElement += "\"programWithText\": \"${programWithText}\",\n"
				postPayloadElement += "\"notesText\": \"${notesText}\"\n"
				postPayloadElement += "}"
			
				if(postPayloadData == '[')
				{
					postPayloadData = postPayloadData + '\n' + postPayloadElement 
				}
				else
				{
					postPayloadData = postPayloadData + ',\n' + postPayloadElement
				}
				
				
				insertStatmentElement = "( '${makeName}',"
				insertStatmentElement += " '${modelName}',"
				insertStatmentElement += " '${entryTitle.getText()}',"
				insertStatmentElement += " '${keyBlankDetails.getText()}',"
				insertStatmentElement += " '${codeSeriesText}',"
				insertStatmentElement += " '${substituteText}',"
				insertStatmentElement += " '${programWithText}',"
				insertStatmentElement += " '${notesText}' )"
				
				if(insertStatementData == '')
				{
					insertStatementData = insertStatementData + '\n' + insertStatmentElement
				}
				else
				{
					insertStatementData = insertStatementData + ',\n' + insertStatmentElement
				}
				KeywordUtil.logInfo('*****************PostPayload: ' + postPayloadData)
				KeywordUtil.logInfo('*****************InsertStatementData: ' + insertStatementData)
				
			}

			
		}
		


    }
    
}

postPayloadData = postPayloadData + ']'

KeywordUtil.logInfo('*****************Stringified Objects: ' + postPayloadData)

f = new File("C://git/MobileLoc/LogFiles")
def valueA = insertStatementData
	
f.append(valueA)

