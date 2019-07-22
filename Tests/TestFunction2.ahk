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

; > Creating the GUI
Gui, Add, Checkbox, x30 y30 gCheck1 vValue1, Disable the first thing.
Gui, Add, Checkbox, x30 y50 gCheck2 vValue2, Disable the second thing.
Gui, Add, Checkbox, x30 y70 gCheck3 vValue3, Disable the third thing.
Gui, Add, Button, x30 y100 gSave, Save
Gui, Show, w400 h200, Test Functions 2
Return

; > Functions
; REFERENCE - https://jacksautohotkeyblog.wordpress.com/2015/07/29/writing-autohotkey-functions-to-make-life-easier/
DisableCheckbox(Var1, Var2) {
    GuiControlGet, Var1
    MsgBox, 0, Test, %Var1% %Var2%
    ;GuiControlGet, Var1
    ;IniWrite, %Var1%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\TestFunction2.ini, Section1, %Var2%
}

; > Buttons
Check1:
    DisableCheckbox(Value1, One)
    Return

Check2:
    DisableCheckbox(Value2, Two)
    Return

Check3:
    DisableCheckbox(Value3, Three)
    Return

Save:
    Return

; > Exiting the application.
GuiClose:
    ExitApp