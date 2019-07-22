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

Gui, Add, Edit, x30 y30 w100 h25 vEdit1, 
Gui, Add, Edit, x140 y30 w100 h25 vEdit2, 
Gui, Add, Button, x30 y60 w100 h25 gButton1, Multiply
Gui, Add, Button, x140 y60 w100 h25 gButton2, Add
Gui, Add, Edit, x30 y100 w210 cGray ReadOnly vEdit3, 
Gui, Show, w270 h140, Function Test 1
Return

MathFunction(Operator, aVar, bVar) {
    If (Operator = "Add")
    {
        Answer := aVar + bVar
        GuiControl,, Edit3, %Answer%
        Return
    }
    if (Operator = "Multiply")
    {
        Answer := aVar * bVar
        GuiControl,, Edit3, %Answer%
        Return
    }
}

Button2:
    GuiControlGet, Edit1
    GuiControlGet, Edit2
    MathFunction("Add",Edit1,Edit2)
    Return

Button1:
    GuiControlGet, Edit1
    GuiControlGet, Edit2
    MathFunction("Multiply",Edit1,Edit2)
    Return
    
GuiClose:
    ExitApp