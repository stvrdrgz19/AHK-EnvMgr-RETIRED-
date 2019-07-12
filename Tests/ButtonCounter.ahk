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
Gui, Show, w200 h200, TestGui
Return

Button1:
    IniRead, One, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\ButtonCounter.ini, ButtonClicks, First
    One := %One% + 1
    IniWrite, %One%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\ButtonCounter.ini, ButtonClicks, First
    MsgBox, 0, Test, First button was clicked! %One%
    Return

Button2:
    IniRead, Two, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\ButtonCounter.ini, ButtonClicks, Second
    Two := %Two% + 1
    IniWrite, %Two%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\ButtonCounter.ini, ButtonClicks, Second
    MsgBox, 0, Test, Second button was clicked! %Two%
    Return

Button3:
    IniRead, Three, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\ButtonCounter.ini, ButtonClicks, Third
    %Three% := %Three% + 1
    IniWrite, %Three%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\ButtonCounter.ini, ButtonClicks, Third
    MsgBox, 0, Test, Third button was clicked! %Three%
    Return

GuiClose:
    ExitApp