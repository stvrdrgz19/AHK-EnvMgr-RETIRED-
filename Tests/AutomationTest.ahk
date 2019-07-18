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

Run, "C:\Program Files (x86)\SalesPad.Desktop\Release\4.6.4.9\SalesPad.exe"
Sleep 5000
if WinExist("SalesPad")
    WinActivate, SalesPad
    Click, 852, 612
    Send, sa
    Click, 1049, 666
    Sleep 6000
    WinWaitActive, TWO - SalesPad
    Click, 45, 33
    Sleep 1000
    Click, 107, 366