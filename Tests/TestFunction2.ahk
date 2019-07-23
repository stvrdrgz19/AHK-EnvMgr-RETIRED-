; AutoHotkey Version:   1.1.30.03
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: Learning how to use functions with autohotkey. In this instance I couldn't
;   rely on the checkboxes as buttons to call the function, it wasn't getting the integer
;   value of the checkbox. Ended up having to write to the ini via the Save button.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

; > Creating the GUI
Gui, Add, Checkbox, x30 y30 vValue1, Disable the first thing.
Gui, Add, Checkbox, x30 y50 vValue2, Disable the second thing.
Gui, Add, Checkbox, x30 y70 vValue3, Disable the third thing.
Gui, Add, Button, x30 y100 gSave, Save
Gui, Show, w400 h200, Test Functions 2
Return

; > Functions
; REFERENCE - https://jacksautohotkeyblog.wordpress.com/2015/07/29/writing-autohotkey-functions-to-make-life-easier/
; REFERENCE - https://www.autohotkey.com/docs/Variables.htm#Operators
DisableCheckbox(Var1,Var2)
{
    IniWrite, %Var1%, TestFunction2.ini, Section1, %Var2%
}

; > Buttons
Save:
    GuiControlGet, Value1
    GuiControlGet, Value2
    GuiControlGet, Value3
    MsgBox, 0, Test, %Value1%, %Value2%, %Value3%
    DisableCheckbox(Value1,"One")
    DisableCheckbox(Value2,"Two")
    DisableCheckbox(Value3,"Three")
    Return

; > Exiting the application.
GuiClose:
    ExitApp