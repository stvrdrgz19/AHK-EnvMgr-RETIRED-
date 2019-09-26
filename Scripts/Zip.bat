@echo off 
COLOR F1
setlocal EnableDelayedExpansion

REM This is zipping the existing database backups
for /d %%X in ("C:\#TEMPFILES\Baks\*") do "%ProgramFiles%\7-Zip\7z.exe" a -mx "%%X.zip" "%%X*"

REM This copies the zipped database copies to their bakup folder on the network drive
REM robocopy "C:\#TEMPFILES\Baks" "\\sp-fileserv-01\Shares\Shared Folders\SteveR\Database Backups" *.Zip

PAUSE