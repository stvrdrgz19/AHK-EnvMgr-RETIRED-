#SingleInstance, force
InstallLoc = \\sp-fileserv-01\Shares\Builds\SalesPad.GP\ProductDev\TrevorMorehead\SPGP-1980\4.6.4.1.18
Gui, Add, Button, x30 y30 w100 h25, Click

Gui, 2:Add, Text, x30 y40, Please enter the location you would like to install the following build to:
Gui, 2:Add, Edit, cgray x30 y60 w600 ReadOnly, %InstallLoc%
Gui, 2:Add, Edit, x30 y90 w600 vBuildLoc, 
Gui, 2:Add, Button, x420 y120 w100 h25 gCan, Cancel
Gui, 2:Add, Button, x531 y120 w100 h25 gOK, OK

Gui, Show, w800 h600, Test First GUI
Return

ButtonClick:
    Gui, 2:Show, w660 h160, Test Second GUI
    Return

OK:
    GuiControlGet, BuildLoc
    MsgBox, This is what you entered %BuildLoc%.
    Return

Can:
    Gui, 2:Destroy
    Return

GuiClose:
ExitApp