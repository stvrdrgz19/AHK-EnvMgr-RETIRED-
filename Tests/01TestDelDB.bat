@ECHO OFF
COLOR 0A
cls

SET SqlServer=STEVERODRIGUEZ\SQLSERVER2016
SET Username=sa
SET Password=sa
SET Tenant=%1

echo.
echo Deleting Database Test_%Tenant%_Api...
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [%Tenant%] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [%Tenant%]"

PAUSE