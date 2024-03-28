REM Publish your App before running any tests
REM Configure Company Name, Server Instance and Codeunit ID
REM Tests will only be run on TestFunctions, make they're correctly marked as [Test]
REM Provide as much information as you can on the Test Scenarios
REM Identify correctly the GIVEN .. WHEN .. THEN when writting the Test Function
REM Use Helper Methods to initialize records, perform validations or operations
REM Keep the Test Functions as simple and clean as you can

$companyName = "CRONUS International Ltd."
$serverInstance = "BC200_DUMMY"
$codeUnit = "1000000"

ECHO Running Unit Tests..
Invoke-NAVCodeunit -ServerInstance $serverInstance -CompanyName $companyName -CodeunitId $codeUnit
ECHO Test Run Completed!