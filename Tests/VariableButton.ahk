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

IniRead, ButtonX, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\VariableButton.ini, Buttons, Var1
Gui, Add, Button, x30 y30 w100 h25 vVarButton, %ButtonX% 
Gui, Add, Edit, x30 y60 w200 vEdit1, 
Gui, Add, Button, x30 y90 w100 h25 gClick, Button
Gui, Show, w300 h300, Test Gui
Return

Click:
    GuiControlGet, Edit1
    IniWrite, %Edit1%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\VariableButton.ini, Buttons, Var1
    GuiControl,, VarButton, %Edit1%
    Return

GuiClose:
    ExitApp