@ECHO OFF
COLOR 0A
cls

SET Destination=%1

REM ECHO %1 This is percent 1
ECHO %~1
REM ECHO %Destination% This is the variable

for /R "%Destination%" %%I in ("*.zip") do (
  "%ProgramFiles%\7-Zip\7z.exe" x -y -aos -o"%%~dpI" "%%~fI"
  "if errorlevel 1 goto :error"
    del "%%~fI"
  ":error"
)

PAUSE