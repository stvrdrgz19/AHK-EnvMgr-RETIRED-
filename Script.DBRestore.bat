@ECHO OFF 
COLOR 0A
cls

SET SqlServer=%COMPUTERNAME%.salespad.com
SET Username=sa
SET Password=sa
SET LocalFolder=C:\#EnvMgr\BACKUPS
SET DataBases=%1

echo.
echo Restoring %DataBases% to TWO . . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE TWO SET SINGLE_USER WITH ROLLBACK IMMEDIATE; RESTORE DATABASE TWO FROM DISK='%LocalFolder%\%DataBases%\TWO.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE; ALTER DATABASE TWO SET MULTI_USER;"

echo.
echo Restoring %DataBases% to DYNAMICS16 . . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE DYNAMICS16 SET SINGLE_USER WITH ROLLBACK IMMEDIATE; RESTORE DATABASE DYNAMICS16 FROM DISK='%LocalFolder%\%DataBases%\DYNAMICS16.bak' WITH  FILE = 1,  NOUNLOAD,  REPLACE; ALTER DATABASE DYNAMICS16 SET MULTI_USER;"

TIMEOUT 5