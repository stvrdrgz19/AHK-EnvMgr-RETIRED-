REM https://stackoverflow.com/questions/25229460/batch-script-to-install-msi
REM https://web.archive.org/web/20110214174542/http://technet.microsoft.com/en-us/library/cc759262(v=ws.10).aspx#BKMK_Uninstall
REM https://www.gpg4win.org/doc/en/gpg4win-compendium_35.html


@ECHO OFF
REM SET Build=C:\#EnvMgr\TEMPFILES\INSTALLERS

REM for /f "delims=" %%i in ('dir /b "%Build%"') do SET a=%%i

REM START "" "%Build%\%a%" /S /C=C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\WebAPI.ini /D=C:\inetpub\wwwroot\SalesPadWebAPI
msiexec.exe /a C:\#EnvMgr\TEMPFILES\INSTALLERS\SalesPad.GP.RESTv3.Setup.1.1.0.5.msi /QN /L*V "C:\#TEMPFILES\Logs\msilog.log"
REM PAUSE