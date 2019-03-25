@ECHO OFF
COLOR 0A
cls

SET SqlServer=SP-DEVSQL-01
SET Username=sa
SET Password=sa

echo.
echo Deleting Database SPC_SteveRodriguez04_Api. . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [SPC_SteveRodriguez04_Api] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [SPC_SteveRodriguez04_Api]"

echo.
echo Deleting Database SPC_SteveRodriguez04_Auth. . .
echo. 
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [SPC_SteveRodriguez04_Auth] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [SPC_SteveRodriguez04_Auth]"

echo.
echo Deleting Database SPC_SteveRodriguez04_Manager. . .
echo. 
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [SPC_SteveRodriguez04_Manager] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [SPC_SteveRodriguez04_Manager]"

echo.
echo Deleting Database SPC_SteveRodriguez04_Tenantless. . .
echo. 
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "DROP DATABASE [SPC_SteveRodriguez04_Tenantless]"

PAUSE