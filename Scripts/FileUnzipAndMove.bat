@ECHO OFF
COLOR 0A

REM SET home=C:\Program Files (x86)\SalesPad.Desktop\

for /R "C:\#EnvMgr\TEMPFILES\DLLs" %%I in ("*.zip") do (
  "%ProgramFiles%\7-Zip\7z.exe" x -y -aos -o"%%~dpI" "%%~fI"
  "if errorlevel 1 goto :error"
    del "%%~fI"
  ":error"
)

REM robocopy "C:\#EnvMgr\TEMPFILES\DLLs" "%home%%1%"
REM 
REM del /q "C:\#EnvMgr\TEMPFILES\DLLs\*"
