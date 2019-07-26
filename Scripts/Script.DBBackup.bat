@ECHO OFF 
COLOR 0A
cls

SET SqlServer=%1
SET Username=%2
SET Password=%3
SET LocalFolder=%4
SET DataBases=%5
SET DB1=%6
SET DB2=%7
SET DB3=%8

if not exist "%LocalFolder%\%~5" mkdir "%LocalFolder%\%~5"

echo.
echo Backing up %DB1% to "%LocalFolder%\%~5". . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "Backup Database %DB1% To Disk='%LocalFolder%\%~5\%DB1%.bak' WITH INIT"

echo.
echo Backing up %DB2% to "%LocalFolder%\%~5". . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "Backup Database %DB2% To Disk='%LocalFolder%\%~5\%DB2%.bak' WITH INIT"

echo.
echo Backing up %DB3% to "%LocalFolder%\%~5". . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "Backup Database %DB3% To Disk='%LocalFolder%\%~5\%DB3%.bak' WITH INIT"

REM TIMEOUT 5
