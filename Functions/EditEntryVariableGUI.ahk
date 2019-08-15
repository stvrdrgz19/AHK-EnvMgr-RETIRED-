VariableGUI(Header,Option,Text,Title,Pass)
{
    global
    Gui, EditGui:Destroy
    Gui, EditGui:Add, Text, x10 y15, %Header%
    Gui, EditGui:Add, Edit, %Option% x10 y30 w218 vEdit3, %Text%
    Gui, EditGui:Add, Button, +Default x9 y60 w100 h25 gOK, OK
    Gui, EditGui:Add, Button, x129 y60 w100 h25 gCancel, Cancel
    Gui, EditGui:Show, w238 h90, %Title%
    WinWaitClose, %Title%
    return ReturnCode

    OK:
        GuiControlGet, ReturnCode, , Edit3
        GuiControl, 4:, %Pass%, %ReturnCode%
        Gui, EditGui:Destroy
        Return

    Cancel:
        Gui, EditGui:Destroy
        Return
}