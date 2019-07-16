; AutoHotkey Version:   1.1.30.03
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: 

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

Gui, Add, Button, x30 y30 w100 h25 gClick, Click
Gui, Show, w200 h200, Test Gui
Return

Click:
    If GetKeyState("Shift", "P")
        MsgBox, 0, Test1, Shift was pressed while clicking this button.
    Else If GetKeyState("Ctrl", "P")
        MsgBox, 0, Test2, Ctrl was pressed while clicking this button.
    Else
        MsgBox, 0, Test3, No modifiers were held while clicking this button.
    Return

GuiClose:
    ExitApp