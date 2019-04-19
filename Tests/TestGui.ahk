#SingleInstance, force

Gui, Add, Button, x30 y30 w100 h25, Click
Gui, Add, Edit, x30 y60 w300 vEdit, 
Gui, Show, w400 h300, Gui
Return

ButtonClick:
    GuiControlGet, Edit
    Run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\test.bat" "%Edit%"
    return

GuiClose:
ExitApp