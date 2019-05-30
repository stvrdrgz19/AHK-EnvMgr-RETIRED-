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

Gui, Add, Button, x30 y30 w100 h25 gButton, Button
Gui, Add, Button, x30 y60 w100 h25 gAdmin, Admin
Gui, Show, w300 h300, Test Gui
Return

Admin:
    A_IsAdmin = 1
    return

Button:
    MsgBox, 0, Is Admin?, %A_IsAdmin%
    Return

GuiClose:
ExitApp