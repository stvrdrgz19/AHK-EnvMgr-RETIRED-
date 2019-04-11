#SingleInstance, force

Gui, Add, Button, x30 y30 w100 h25 gClick vClick, Click
Gui, Add, Button, x150 y30 w100 h25 gTest, Test
Gui, Add, Button, x30 y100 w100 h25, Settings
Gui, Show, w300 h200, GUI
return

ButtonSettings:
    Gui, 2:Destroy
    Gui, 2:Add, Checkbox, x30 y30 vCheck gUpdateCheck, Disable that button?
    Gui, 2:Add, Button, x150 y30 gDis, Dis
    Gui, 2:Add, Button, x30 y100 w100 h25 gSave, Save
    Gui, 2:Add, Button, x150 y100 w100 h25 gClose, Close
    Gui, 2:Show, w300 h200, Second GUI
    IniRead, CheckB, C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\TestSettings.ini, Checkboxes, One
    GuiControl, 2:, Check, %CheckB%
    return

Close:
    Gui, 2:Destroy
    return

UpdateCheck:
    Gui, Submit, NoHide
    If Check = 1
    {
        Check1 = 1
        return
    }
    Else
    {
        Check1 = 0
        return
    }

Save:
    GuiControlGet, Check, 2:
    IniWrite, %Check%, C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\TestSettings.ini, Checkboxes, One
    MsgBox, Value of Check1 is %Check1%!
    If Check1 = 1
    {
        GuiControl, Disable, Click
        return
    }
    If Check1 = 0
    {
        GuiControl, Enable, Click
        return
    }

Dis:
    GuiControl, Disable, Click
    return

Click:
    MsgBox, Button was clicked %Click%!
    return

Test:
    GuiControl, Disable, Click
    return

GuiClose:
ExitApp