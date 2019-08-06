@echo off
COLOR F1

FOR %%F IN ("C:\inetpub\wwwroot\SalesPadWebAPI\*.msi") DO SET FILENAME=%%~nxF
ECHO Uninstalling Previous Web Build (%FILENAME%). . .

START "" C:\inetpub\wwwroot\SalesPadWebAPI\%FILENAME%

REM PAUSE