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
/*
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
*/

If WinExist("SalesPad WebAPI Setup")
    WinActivate, SalesPad WebAPI Setup
    Click, 354, 361
    Sleep 500
    Click, 34, 314
    Sleep 500
    Click, 355, 360
    Sleep 500
    Click, 355, 360
    Sleep 500
    MouseMove, 109, 134
    Click, 3
    Sleep 500
    Send, 10.50.0.45\SQLSERVER2016
    Sleep 500
    Click, 355, 361
    Sleep 1000
    MouseMove, 103, 173
    Click, 2
    Send, 49403
    Send, {Tab}
    Sleep 500
    Send, steve.rodriguez
    Sleep 500
    Send, {Tab}
    Sleep 500
    Send, S@lespad1
    Sleep 500
    Send, {Tab}
    Sleep 500
    Send, SALESPAD
    Sleep 500
    Click, 355, 360
    Sleep 500
    Click, 355, 360

