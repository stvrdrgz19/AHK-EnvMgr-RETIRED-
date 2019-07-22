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

Gui, Add, Text, x30 y40, Please enter the location you would like to install the following build to:
Gui, Add, Edit, cgray x30 y60 w600 ReadOnly, %Instl%
Gui, Add, Edit, x30 y90 w600 vBuildLoc, C:\Program Files (x86)\SalesPad.Desktop\
Gui, Add, Text, x165 y120, Extended
Gui, Add, Text, x440 y120, Custom
Gui, Add, ListBox, 8 vExtList gExtList x70 y140 w250 r15
Gui, Add, ListBox, 8 vCustList gCustList x340 y140 w250 r15
Gui, Add, CheckBox, x30 y350 gGrizzlyDLL vGrizzlyDLL, Install with Grizzly DLLs
Gui, Add, Checkbox, x30 y370 gTPGDLL vTPGDLL, Install with TPG DLLs
Gui, Add, Button, x420 y360 w100 h25 gCan, Cancel
Gui, Add, Button, x531 y360 w100 h25 gOK, OK
Gui, Show, w660 h400, Install SalesPad GP
return

ExtList:
    Return

CustList:
    Return

GrizzlyDLL:
    Return

TPGDLL:
    Return

Can:
    Return

OK:
    Return

GuiClose:
    ExitApp