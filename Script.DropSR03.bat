@ECHO OFF
COLOR 0A
cls

SET SqlServer=SP-DEVSQL-01
SET Username=sa
SET Password=sa

echo.
echo Deleting Database SPC_SteveRodriguez03_Api. . .
echo.
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [SPC_SteveRodriguez03_Api] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [SPC_SteveRodriguez03_Api]"

PAUSE

echo.
echo Deleting Database SPC_SteveRodriguez03_Auth. . .
echo. 
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [SPC_SteveRodriguez03_Auth] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [SPC_SteveRodriguez03_Auth]"

PAUSE

echo.
echo Deleting Database SPC_SteveRodriguez03_Manager. . .
echo. 
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "ALTER DATABASE [SPC_SteveRodriguez03_Manager] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [SPC_SteveRodriguez03_Manager]"

PAUSE

echo.
echo Deleting Database SPC_SteveRodriguez03_Tenantless. . .
echo. 
SqlCmd -S %SqlServer% -U %Username% -P %Password% -Q "DROP DATABASE [SPC_SteveRodriguez03_Tenantless]"

PAUSE