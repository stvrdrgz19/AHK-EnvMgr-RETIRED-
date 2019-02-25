Gui, add, button,, OK
Gui, add, button,, Custom
Gui, add, button,, Exit
Gui, Show, x2478 y337 w800 h486, Environment Mananger
return

ButtonOK:
FileSelectFile, SelectedFile, 1, C:\Users\stvrd\Desktop\AutohotkeyTesting, Select a SalesPad Build, *.bat ;https://autohotkey.com/docs/commands/FileSelectFile.htm
InputBox, InstallFolder, Install To, Where would you like to install `n`n%SelectedFile%?, , 640, 200
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    if FileExist("C:\Users\stvrd\Desktop\AutohotkeyTesting\#TEMPFILES\test1.txt")
        FileDelete, C:\Users\stvrd\Desktop\AutohotkeyTesting\#TEMPFILES\test1.txt
    FileAppend,%InstallFolder%,C:\Users\stvrd\Desktop\AutohotkeyTesting\#TEMPFILES\test1.txt
;    MsgBox, %InstallFolder%
run, "C:\Users\stvrd\Desktop\AutohotkeyTesting\InstallBuild.bat"
return

ButtonCustom:
FileSelectFile, CustomDLL, M, C:\Users\stvrd\Desktop\AutohotkeyTesting\ProductDev\TMorehead\4.6.3.17.123\Custom, Select any Custom DLLs needed, *.rar
;MsgBox, %CustomDLL%
FileCopy, %CustomDLL%, C:\Users\stvrd\Desktop\AutohotkeyTesting\DLLs
return

GuiClose:
ButtonExit:
ExitApp