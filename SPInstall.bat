@ECHO OFF
REM PAUSE
REM SET Home=C:\Program Files (x86)\SalesPad.Desktop\
SET Home=%1
SET Build=C:\#EnvMgr\TEMPFILES\INSTALLERS

for /f "delims=" %%i in ('dir /b "%Build%"') do SET a=%%i

START "" "%Build%\%a%" /S /D=%~1
