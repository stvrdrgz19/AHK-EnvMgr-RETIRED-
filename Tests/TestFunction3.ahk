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

Gui, Add, Button, x30 y30 w100 h25 gButton1, Click
Gui, Add, Button, x30 y60 w100 h25 gButton2, Click
Gui, Add, Button, x30 y90 w100 h25 gButton3, Click
Gui, Add, Button, x30 y120 w100 h25 gButton4, Click
Gui, Show, w200 h200, TestGUI
Return

FunctionLog(Section,Key)
 {
 IniRead, UseageCount, TestFunction2.ini, %Section%, %Key%
 UseageCount++
 iniwrite, %UseageCount%, TestFunction2.ini, %Section%, %Key%
 }

Button1:
    FunctionLog("TotalUses","Count")
    Return

Button2:
    FunctionLog("TotalUses","PA Review")
    Return

Button3:
    FunctionLog(A_UserName,"Total Uses")
    Return

Button4:
    FunctionLog(A_UserName,"PA Review")
    Return

GuiClose:
    ExitApp