@echo off
COLOR F1
REM SET INSTALL=C:\Users\steve.rodriguez\Desktop\Test
SET INSTALL=C:\inetpub\wwwroot\SalesPadWebPortal
SET build=%1

REM FOR %%F IN ("%INSTALL%\*.js") DO SET FILENAME=%%~nxF
REM ECHO %FILENAME%. . .
REM 
REM PAUSE 

for /R "%INSTALL%\" %%f in (*) do (if not "%%~xf"==".js" del "%%~f")

RMDIR /S /Q "%INSTALL%\fonts" "%INSTALL%\images" "%INSTALL%\plugins" "%INSTALL%\src" "%INSTALL%\styles" 

ECHO ------------------------------------------------------------------------------------------------------------------------
ECHO ------------------------------------------------ INSTALLING WEB BUILD --------------------------------------------------
ECHO.

REM SET /P build=Enter Web Location: 
REM SET /P num=Enter Build Number: 
SET folder="C:\#TEMPFILES\Installers"

del /Q "%folder%\*"
RMDIR /S /Q "%folder%\fonts" "%folder%\images" "%folder%\plugins" "%folder%\src" "%folder%\styles" 

if not exist "C:\#TEMPFILES\Installerss" mkdir C:\#TEMPFILES\Installers

robocopy "%build%" "%folder%"
REM PAUSE

for /R "%folder%" %%I in ("*.zip") do (
  "%ProgramFiles%\7-Zip\7z.exe" x -y -aos -o"%%~dpI" "%%~fI"
  "if errorlevel 1 goto :error"
    del "%%~fI"
  ":error"
)

REM PAUSE

REM robocopy C:\Users\steve.rodriguez\Desktop\BatchTesting\GPWeb\FromBuild C:\inetpub\wwwroot\SalesPadWebPortal /E /XF C:\Users\steve.rodriguez\Desktop\BatchTesting\GPWeb\FromBuild\config.js
robocopy %folder% %INSTALL% /E /XF %folder%\config.js

REM PAUSE

del /Q "%folder%\"
RMDIR /S /Q "%folder%\fonts" "%folder%\images" "%folder%\plugins" "%folder%\src" "%folder%\styles" 
REM del /q "C:\Users\steve.rodriguez\Desktop\BatchTesting\GPWeb\FromBuild\*"
REM FOR /D %%p IN ("C:\Users\steve.rodriguez\Desktop\BatchTesting\GPWeb\FromBuild\*.*") DO rmdir "%%p" /s /q