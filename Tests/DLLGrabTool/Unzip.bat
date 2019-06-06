@ECHO OFF
COLOR 0A
cls

SET Destination=%1

for /R "%1" %%I in ("*.zip") do (
  "%ProgramFiles%\7-Zip\7z.exe" x -y -aos -o"%%~dpI" "%%~fI"
  "if errorlevel 1 goto :error"
    del "%%~fI"
  ":error"
)

PAUSE