@echo off
COLOR 0A
cls

set SqlServer=STEVERODRIGUEZ\SQLSERVER2016
set Username=sa
set Password=sa
set db1=TWO

echo.
echo Running sppresetdatabase against TWO. . .
echo.
SqlCmd -S %SqlServer% -d %db1% -U %Username% -P %Password% -Q "exec dbo.sppResetDatabase"