@ECHO OFF 
COLOR 0A
cls

SET SqlServer=%COMPUTERNAME%.salespad.com
SET Username=sa
SET Password=sa
SET db1=TWO
SET db2=DYNAMICS16
SET LocalFolder=C:\#EnvMgr\BACKUPS
SET DataBases=%1

if not exist "%LocalFolder%\%DataBases%" mkdir %LocalFolder%\%DataBases%

echo.
echo Backing up %db1% to %LocalFolder%\%DataBases%. . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "Backup Database %db1% To Disk='%LocalFolder%\%DataBases%\%db1%.bak' WITH INIT"

echo.
echo Backing up %db2% to %LocalFolder%\%DataBases%. . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "Backup Database %db2% To Disk='%LocalFolder%\%DataBases%\%db2%.bak' WITH INIT"

TIMEOUT 5
