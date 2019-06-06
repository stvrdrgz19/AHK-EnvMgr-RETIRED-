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

Gui, Add, Button, x30 y30 w100 h25 gSelect, Click
Gui, Show, w200 h200, Test Gui
Return

Select:
    FileSelectFile, AddExt, M3, %FromFolder%\ExtModules\WithOutCardControl\, Select any Extended DLLs needed, *.zip
    if ErrorLevel = 1
    {
        MsgBox, 0, ERROR, Nothing was selected.
        Return
    }
    if ErrorLevel != 1
    {
        MsgBox, 0, CONTINUE, Continue to do other stuff
        Return
    }

GuiClose:
    ExitApp