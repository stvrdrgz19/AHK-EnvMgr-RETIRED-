@ECHO OFF

SET home=C:\Program Files (x86)\SalesPad.Desktop\

robocopy "%1\CustomModules\WithOutCardControl" "C:\#EnvMgr\TEMPFILES\DLLs" SalesPad.Module.ThePondGuy.*.zip SalesPad.Module.IntegrationToChannelAdvisor.*.zip SalesPad.Module.IntegrationToCommerceV3.*.zip
robocopy "%1\ExtModules\WithOutCardControl" "C:\#EnvMgr\TEMPFILES\DLLs" SalesPad.Module.AutomationAgent.*.zip SalesPad.Module.AutomationAgentService.*.zip SalesPad.Module.BlueMoonAdvancedUDF.*.zip SalesPad.Module.BlueMoonOperationsCore.*.zip SalesPad.Module.BusinessRules.*.zip SalesPad.Module.CaseTracker.*.zip SalesPad.Module.ConnectShip.*.zip SalesPad.Module.Nodus.*.zip 

for /R "C:\#EnvMgr\TEMPFILES\DLLs" %%I in ("*.zip") do (
  "%ProgramFiles%\7-Zip\7z.exe" x -y -aos -o"%%~dpI" "%%~fI"
  "if errorlevel 1 goto :error"
    del "%%~fI"
  ":error"
)