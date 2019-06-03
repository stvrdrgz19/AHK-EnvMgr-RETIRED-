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

Gui, Add, Text, x30 y45, Enter the Number of Clicks:
Gui, Add, Edit, x30 y60 vNumOfClicksEdit, 
Gui, Add, UpDown, vNumOfClicks Range1-1000, 100
Gui, Add, Text, x30 y115, Enter the Pause time between clicks (ms):
Gui, Add, Edit, x30 y130 vLengthOfSleepEdit, 
Gui, Add, UpDown, vLengthOfSleep Range1-10000, 200
Gui, Add, Button, x80 y170 w100 h25 vSet gSet, Set
Gui, Add, Button, x80 y200 w100 h25 vtest gtest, Test
Gui, Show, w250 h230, Configure AutoClicks
Return

Test:
    Return

Set:
    GuiControlGet, NumOfClicksEdit
    GuiControlGet, LengthOfSleepEdit
    ;MsgBox, 0, Test, %NumOfClicksEdit% and %LengthOfSleepEdit%
    Return

F7::
    GuiControlGet, NumOfClicksEdit
    GuiControlGet, LengthOfSleepEdit
    i:=0
    While(i<NumOfClicksEdit)
    {
        if stop
            Break
        i++
        Send, {LButton}
        sleep LengthOfSleepEdit
    }
    Return

F8::
    stop=1
    Return

GuiClose:
ExitApp