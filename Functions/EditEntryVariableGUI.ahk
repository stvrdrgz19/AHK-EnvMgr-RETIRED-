VariableGUI(Header,Option,Text,Title,Pass)
{
    global
<<<<<<< HEAD
    Gui, +LastFound
    Gui, 2:Destroy
    Gui, 2:Add, Text, x10 y15, %Header%
    Gui, 2:Add, Edit, %Option% x10 y30 w218 vEdit3, %Text%
    Gui, 2:Add, Button, +Default x9 y60 w100 h25 gOK, OK
    Gui, 2:Add, Button, x129 y60 w100 h25 gCancel, Cancel
    Gui, 2:Show, w238 h90, %Title%
    WinWaitClose, %Title%
    return ReturnCode
;
    OK:
        GuiControlGet, ReturnCode, , Edit3
        GuiControl, 1:, %Pass%, %ReturnCode%
        Gui, 2:Destroy
        Return

    Cancel:
        Gui, 2:Destroy
=======
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
>>>>>>> 6bc620b0abfc40ca7b1774583cb78766418be7de
        Return
}