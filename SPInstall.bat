@ECHO OFF

SET Home=C:\Program Files (x86)\SalesPad.Desktop\
SET Build=C:\#EnvMgr\TEMPFILES\INSTALLERS

for /f "delims=" %%i in ('dir /b "%Build%"') do SET a=%%i

START "" "%Build%\%a%" /S /D=%Home%%1%
