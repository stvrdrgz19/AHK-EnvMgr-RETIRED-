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
Gui, Show, w200 h200, Test GUI
Return

Click:
    IniRead, Test01, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company1
    ;MsgBox, 0, Test, You want to delete %Test01% DB.
    Run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\01TestDelDB.bat" %Test01%
    Return

GuiClose:
    ExitApp



