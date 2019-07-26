@echo off
COLOR F1

REM TASK LIST
REM 1.) Move variables over to new universal folders
REM 2.) Figure out how to silently uninstall - try copying msi over on install, then figure out how to target it
REM 3.) Continue to look into making the installer Silent

if not exist "C:\#BAKs" mkdir C:\#BAKs
if not exist "C:\#TEMPFILES" mkdir C:\#TEMPFILES
if not exist "C:\#TEMPFILES\DLLs" mkdir C:\#TEMPFILES\DLLs
if not exist "C:\#TEMPFILES\Installers" mkdir C:\#TEMPFILES\Installers

SET temp="C:\#TEMPFILES"
SET bin=C:\inetpub\wwwroot\SalesPadWebAPI\bin

REM MAKE THIS WORK - Uninstalls existing API build, need to load the installer (Copy it over when installing?)
REM ECHO Uninstalling Old Web Build...
REM msiexec /uninstall "C:\#TEMPFILES\Installers\SalesPad.GP.RESTV3.Setup.0.0.1.107.msi" /qn 

ECHO ------------------------------------------------------------------------------------------------------------------------
ECHO ------------------------------------------------- UNINSTALLING WEB API -------------------------------------------------
ECHO.
SET INSTALL=C:\inetpub\wwwroot\SalesPadWebAPI

FOR %%F IN ("%INSTALL%\*.msi") DO SET FILENAME=%%~nxF
ECHO Uninstalling Previous Web Build (%FILENAME%). . .

START "" C:\inetpub\wwwroot\SalesPadWebAPI\%FILENAME%
PAUSE

ECHO.
ECHO Deleting old installer. . .
del /Q "%INSTALL%\"
@RD /S /Q "C:\inetpub\wwwroot\SalesPadWebAPI\bin
PAUSE


ECHO ------------------------------------------------------------------------------------------------------------------------
ECHO ------------------------------------------------- INSTALLING WEB API ---------------------------------------------------
ECHO.
set /P source=Enter Build Path: 
set dest=C:\Users\steve.rodriguez\Desktop\BatchTesting\WebAPI

ECHO Grabbing Specified Installer...

pushd "%source%"
for /f "tokens=*" %%G in ('dir *.msi /b /a-d /on') do SET "newest=%%G"

REM copy "%newest%" "%dest%"
REM popd

copy "%newest%" "%install%"
popd

ECHO Launching WebAPI Installer. . .
REM MAY NOT BE ABLE TO SILENTLY INSTALL GPWEB BUILDS
REM msiexec /i "%dest%\%newest%" /qb /s /f1"C:\Temp\Setup.txt"
REM Start "" "%dest%\%newest%"
Start "" "%install%\%newest%"

ECHO.
ECHO ------------------------------------------------------------------------------------------------------------------------
PAUSE

:dll
set /P dll="Do you need any DLLs? [Y/N]: "
if /I "%dll%" EQU "Y" goto :num
if /I "%dll%" EQU "N" goto :complete
goto :dll

ECHO.
ECHO ------------------------------------------------------------------------------------------------------------------------
PAUSE

:num
set /P num="Enter Build Number: "
goto :needext

ECHO.
ECHO ------------------------------------------------------------------------------------------------------------------------
PAUSE

:needext
set /P needext="Do you need any Extended DLLs? [Y/N]: "
if /I "%needext%" EQU "Y" goto :extget
if /I "%needext%" EQU "N" goto :needcust
goto :needext

ECHO.
ECHO ------------------------------------------------------------------------------------------------------------------------
PAUSE

:needcust
set /P needcust="Do you need any Custom DLLs? [Y/N]: "
if /I "%needcust%" EQU "Y" goto :custget
if /I "%needcust%" EQU "N" goto :complete
goto :needcust

ECHO.
ECHO ------------------------------------------------------------------------------------------------------------------------
PAUSE

:extget 

ECHO Extended DLLs to Choose From: 
ECHO. 
for %%a in (%source%\ExtModules\*.zip) do echo %%~na
ECHO.
ECHO.
ECHO.
SET /P extdll=Enter DLL Name to Install: 

robocopy "%source%\ExtModules" "%temp%\DLLs" SalesPad.GP.RESTv3.%extdll%.%num%.zip 

for /R "%temp%\DLLs" %%I in ("*.zip") do (
  "%ProgramFiles%\7-Zip\7z.exe" x -y -aos -o"%%~dpI" "%%~fI"
  "if errorlevel 1 goto :error"
    del "%%~fI"
  ":error"
)

REM PAUSE

robocopy "%temp%\DLLs" "%bin%"

SET moreext=
SET /p moreext="Do you need any more Extended DLLs? [Y/N]: "
if /I "%moreext%" EQU "Y" goto :extget
if /I "%moreext%" EQU "N" goto :needcust

ECHO.
ECHO ------------------------------------------------------------------------------------------------------------------------
PAUSE

:custget 

ECHO Custom DLLs to Choose From: 
ECHO. 
for %%a in (%source%\CustomModules\*.zip) do echo %%~na
ECHO.
ECHO.
ECHO.
SET /P custdll=Enter DLL Name to Install: 

robocopy "%source%\CustomModules" "%temp%\DLLs" SalesPad.GP.RESTv3.%custdll%.%num%.zip 

for /R "%temp%\DLLs" %%I in ("*.zip") do (
  "%ProgramFiles%\7-Zip\7z.exe" x -y -aos -o"%%~dpI" "%%~fI"
  "if errorlevel 1 goto :error"
    del "%%~fI"
  ":error"
)

REM PAUSE

robocopy "%temp%\DLLs" "%bin%"

SET morecust=
SET /p morecust="Do you need any more Extended DLLs? [Y/N]: "
if /I "%morecust%" EQU "Y" goto :custget
if /I "%morecust%" EQU "N" goto :complete

ECHO.
ECHO ------------------------------------------------------------------------------------------------------------------------
PAUSE

:complete

del /q "%temp%\DLLs\*"
FOR /D %%p IN ("C%temp%\*.*") DO rmdir "%%p" /s /q

REM del "%dest%\%newest%"