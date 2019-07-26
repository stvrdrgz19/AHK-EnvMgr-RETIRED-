@ECHO OFF
SET Build=C:\#EnvMgr\TEMPFILES\INSTALLERS

for /f "delims=" %%i in ('dir /b "%Build%"') do SET a=%%i

START "" "%Build%\%a%" /S /D=%~1
REM PAUSE