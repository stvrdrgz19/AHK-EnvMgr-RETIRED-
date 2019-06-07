; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: 

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force
;MouseGetPos, OutputVarX, OutputVarY
Gui, Add, DropDownList, x10 y10 w200 vList, Development||Staging|Steve01|Steve02|Steve03|Steve04|Steve05
Gui, Add, Button, +Default x111 y35 w100 h25 gRun, Run ; +Default allows the Run key to be pressed when pressing the Enter key even if the Run button isn't currently selected
F7::
;Gui, Show, x%OutputVarX% y%OutputVarY% w220 h70, Run
Gui, Show, w220 h70, Run
Return

Run:
    GuiControlGet, List
    if List = Development
    {
        Run, https://cloud-development.salespad.com
        ;;MsgBox, 0, List value, https://cloud-development.salespad.com
        Return
    }
    if List = Staging
    {
        Run, https://cloud-staging.salespad.com/
        ;MsgBox, 0, List value, https://cloud-staging.salespad.com/
        Return
    }
    if List = Steve01
    {
        Run, http://cloud-steverodriguez01.salespad.com
        ;MsgBox, 0, List value, http://cloud-steverodriguez01.salespad.com
        Return
    }
    if List = Steve02
    {
        Run, http://cloud-steverodriguez02.salespad.com
        ;MsgBox, 0, List value, http://cloud-steverodriguez02.salespad.com
        Return
    }
    if List = Steve03
    {
        Run, http://cloud-steverodriguez03.salespad.com
        ;MsgBox, 0, List value, http://cloud-steverodriguez03.salespad.com
        Return
    }
    if List = Steve04
    {
        Run, http://cloud-steverodriguez04.salespad.com
        ;MsgBox, 0, List value, http://cloud-steverodriguez04.salespad.com
        Return
    }
    if List = Steve05
    {
        Run, http://cloud-steverodriguez05.salespad.com
        ;MsgBox, 0, List value, http://cloud-steverodriguez05.salespad.com
        Return
    }

F8::ExitApp