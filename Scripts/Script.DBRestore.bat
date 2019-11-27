@ECHO OFF 
REM COLOR 0A
COLOR 0D
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
echo Restoring "%~5" to %DB1% . . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE %DB1% SET SINGLE_USER WITH ROLLBACK IMMEDIATE; RESTORE DATABASE %DB1% FROM DISK='%LocalFolder%\%~5\%DB1%.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE; ALTER DATABASE %DB1% SET MULTI_USER;"

echo.
echo Restoring "%~5" to %DB2% . . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE %DB2% SET SINGLE_USER WITH ROLLBACK IMMEDIATE; RESTORE DATABASE %DB2% FROM DISK='%LocalFolder%\%~5\%DB2%.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE; ALTER DATABASE %DB2% SET MULTI_USER;"

echo.
echo Restoring "%~5" to %DB3% . . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE %DB3% SET SINGLE_USER WITH ROLLBACK IMMEDIATE; RESTORE DATABASE %DB3% FROM DISK='%LocalFolder%\%~5\%DB3%.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE; ALTER DATABASE %DB3% SET MULTI_USER;"

REM PAUSE

REM TIMEOUT 5