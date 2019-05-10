#SingleInstance, force

Gui, Add, Button, x30 y30 w100 h25, Click1
Gui, Add, Button, x30 y60 w100 h25, Click1
;Gui, Add, Edit, x30 y60 w300 vEdit, 
Gui, Show, w400 h300, Gui
Return

FromFolder = "\\sp-fileserv-01\Shares\Builds\SalesPad.GP\Release\4.6.4.3"

ButtonClick1:
    FileSelectFile, Test1, M3, %FromFolder%\ExtModules\WithOutCardControl\, Select any Custom DLLs needed (*.zip)
    return
    
ButtonClick2:
    FileSelectFile, Test1, M3, %FromFolder%\CustomModules\WithOutCardControl\, Select any Custom DLLs needed (*.zip)
    return

GuiClose:
ExitApp