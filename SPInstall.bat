@ECHO OFF

REM SET /P InstallLocation=<C:\#EnvMgr\TEMPFILES\TEMP\BuildLocation.txt
SET Home=C:\Program Files (x86)\SalesPad.Desktop\
SET Build=C:\#EnvMgr\TEMPFILES\INSTALLERS

for /f "delims=" %%i in ('dir /b "%Build%"') do SET a=%%i

REM START "" "%Build%\%a%" /S /D=%Home%%InstallLocation%
START "" "%Build%\%a%" /S /D=%Home%%1%


TIMEOUT 5

START "" "%Home%%1%\SalesPad.exe"

PAUSE