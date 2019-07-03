; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Script Function: 

#SingleInstance, force
#NoEnv
SendMode Input

Gui, Add, Checkbox, x30 y30 vCheck, Is Admin
if A_IsAdmin = 1
{
    GuiControl,, Check, 1
}
if A_IsAdmin = 0
{
    GuiControl,, Check, 0
}
Gui, Show, w300 h300, Is Admin
Return

GuiClose:
    ExitApp