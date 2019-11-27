@ECHO OFF 
REM COLOR 0A
COLOR 05
cls

SET SqlServer=%1
SET Username=%2
SET Password=%3
SET LocalFolder=%4
SET DataBases=%5
SET DB1=%6
SET DB2=%7
SET DB3=%8

echo.
echo Backing up %DB1% to %LocalFolder%\%~5. . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "Backup Database %db1% To Disk='%LocalFolder%\%~5\%db1%.bak' WITH INIT"

echo.
echo Backing up %DB2% to %LocalFolder%\%~5. . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "Backup Database %db2% To Disk='%LocalFolder%\%~5\%db2%.bak' WITH INIT"

echo.
echo Backing up %DB3% to %LocalFolder%\%~5. . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "Backup Database %db3% To Disk='%LocalFolder%\%~5\%db3%.bak' WITH INIT"

REM TIMEOUT 5