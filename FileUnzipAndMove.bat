@ECHO OFF

SET home=C:\Program Files (x86)\SalesPad.Desktop\

for /R "C:\#EnvMgr\DLLs" %%I in ("*.zip") do (
  "%ProgramFiles%\7-Zip\7z.exe" x -y -aos -o"%%~dpI" "%%~fI"
  "if errorlevel 1 goto :error"
    del "%%~fI"
  ":error"
)

robocopy "C:\#EnvMgr\DLLs" "%home%%1%"

del /q "C:\#EnvMgr\DLLs\*"