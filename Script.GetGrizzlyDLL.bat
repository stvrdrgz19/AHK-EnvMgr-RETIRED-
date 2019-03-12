@ECHO OFF

REM SET home=C:\Program Files (x86)\SalesPad.Desktop\
REM 
REM robocopy "%1\CustomModules\WithOutCardControl" "C:\#EnvMgr\TEMPFILES\DLLs" SalesPad.Module.Grizzly.*.zip SalesPad.Module.IntegrationToGrizzly.*.zip SalesPad.Module.IntegrationToPayFabric.*.zip SalesPad.Module.OSCO.*.zip
REM robocopy "%1\ExtModules\WithOutCardControl" "C:\#EnvMgr\TEMPFILES\DLLs" SalesPad.Module.AutomationAgent.*.zip SalesPad.Module.AutomationAgentService.*.zip SalesPad.Module.BlueMoonAdvancedUDF.*.zip SalesPad.Module.BlueMoonOperationsCore.*.zip SalesPad.Module.BusinessRules.*.zip SalesPad.Module.CaseTracker.*.zip SalesPad.Module.ConnectShip.*.zip SalesPad.Module.Nodus.*.zip 
REM 
REM for /R "C:\#EnvMgr\TEMPFILES\DLLs" %%I in ("*.zip") do (
REM   "%ProgramFiles%\7-Zip\7z.exe" x -y -aos -o"%%~dpI" "%%~fI"
REM   "if errorlevel 1 goto :error"
REM     del "%%~fI"
REM   ":error"
REM )
REM 
REM robocopy "C:\#EnvMgr\TEMPFILES\DLLs" "%home%%2%"
REM 
REM del /q "C:\#EnvMgr\TEMPFILES\DLLs\*"

ECHO Argument 1 %1
ECHO Argument 2 %2

PAUSE