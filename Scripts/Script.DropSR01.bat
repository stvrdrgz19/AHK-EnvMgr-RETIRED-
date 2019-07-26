@ECHO OFF
COLOR 0A
cls

SET SqlServer=SP-DEVSQL-01
SET Username=sa
SET Password=sa
SET Tenant=%1

echo.
echo Deleting Database SPC_%Tenant%_Api. . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [SPC_%Tenant%_Api] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [SPC_%Tenant%_Api]"

echo.
echo Deleting Database SPC_%Tenant%_Auth. . .
echo. 
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [SPC_%Tenant%_Auth] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [SPC_%Tenant%_Auth]"

echo.
echo Deleting Database SPC_%Tenant%_Manager. . .
echo. 
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [SPC_%Tenant%_Manager] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [SPC_%Tenant%_Manager]"

echo.
echo Deleting Database SPC_%Tenant%_Tenantless. . .
echo. 
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "DROP DATABASE [SPC_%Tenant%_Tenantless]"