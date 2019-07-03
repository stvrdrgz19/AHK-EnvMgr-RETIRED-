; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Script Function: Testin RunAs to see if it would work running installed DC/CC/Mobile builds as admin after install

#SingleInstance, force
#NoEnv
SendMode Input

Gui, Add, Button, x30 y30 w100 h25 gClick, Button
Gui, Add, Checkbox, x30 y60 vCheck, Is Admin
if A_IsAdmin = 1
{
    GuiControl,, Check, 1
}
if A_IsAdmin = 0
{
    GuiControl,, Check, 0
}
Gui, Show, w300 h300, Test RunAs
GuiControl, Disable, Check
Return

Click:
    Run *RunAs "C:\Program Files (x86)\DataCollection\release\4.4.7.3\DataCollection Extended Warehouse.exe"
    ;Run *RunAs "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\TestIsAdmin2.ahk"
    ;RunAs, Administrator, S@lespad1
    ;Run, "C:\Program Files (x86)\DataCollection\release\4.4.7.3\DataCollection Extended Warehouse.exe"
    ;RunAs
    Return

GuiClose:
    ExitApp

