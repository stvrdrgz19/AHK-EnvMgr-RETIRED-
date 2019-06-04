; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: Generates random phone numbers with the 616 area code

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

Gui, Add, Button, x30 y30 w100 h25 gGenerate, Generate
Gui, Add, Edit, x30 y60 w100 vPhoneNum, 
Gui, Show, w300 h300, Test Gui
Return

Generate:
    GuiControlGet, PhoneNum
    Random, PhoneNumber, 0000000, 9999999
    GuiControl,, PhoneNum, 616%PhoneNumber%
    Return

GuiClose:
ExitApp