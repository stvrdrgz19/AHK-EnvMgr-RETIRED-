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

if A_IsAdmin = 0
{
    MsgBox, 0, NOT ADMIN, Please run this script as Admin.
    ExitApp
    Return
}

ControlSend,WindowsForms10.EDIT.app.0.3ce0bb8_r9_ad11,sa,ahk_exe SalesPad.exe
ControlClick,WindowsForms10.Window.b.app.0.3ce0bb8_r9_ad15,ahk_exe SalesPad.exe
Sleep, 3000
ControlClick,WindowsForms10.Window.b.app.0.3ce0bb8_r9_ad13,ahk_exe SalesPad.exe
Sleep, 3000
Control,Check,,WindowsForms10.Window.b.app.0.3ce0bb8_r9_ad114,ahk_exe SalesPad.exe
Sleep, 3000
Control,Check,,WindowsForms10.Window.b.app.0.3ce0bb8_r9_ad17,ahk_exe SalesPad.exe
Sleep, 3000
ControlClick,WindowsForms10.Window.b.app.0.3ce0bb8_r9_ad13,ahk_exe SalesPad.exe
Sleep, 3000


;Control, Check ,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText

;WindowsForms10.Window.8.app.0.3ce0bb8_r9_ad12

;ControlFocus, WindowsForms10.EDIT.app.0.3ce0bb8_r9_ad11,SalesPad ;ahk_exe SalesPad.exe
;Send, sa
;ControlSetText,WindowsForms10.EDIT.app.0.3ce0bb8_r9_ad11,sa,ahk_class WindowsForms10.Window.8.app.0.3ce0bb8_r9_ad1 ;ahk_exe SalesPad.exe
;ControlGetText,var,WindowsForms10.EDIT.app.0.3ce0bb8_r9_ad12,ahk_exe SalesPad.exe
;MsgBox % var

;ControlFocus,WindowsForms10.EDIT.app.0.3ce0bb8_r9_ad16,ahk_exe SalesPad.exe
;ControlSend,WindowsForms10.EDIT.app.0.3ce0bb8_r9_ad16,{raw}AARONFIT0001,ahk_exe SalesPad.exe
;ControlGetPos,x,y,width,height,WindowsForms10.EDIT.app.0.3ce0bb8_r9_ad16,ahk_exe SalesPad.exe
;MsgBox % x a_tab y a_tab width a_tab height

;F9::
;MouseGetPos,xvar,yvar
;MsgBox % xvar a_tab yvar

;ControlSetText,WindowsForms10.EDIT.app.0.3ce0bb8_r9_ad16,AARONFIT0001,ahk_exe SalesPad.exe
;Sleep, 500
;ControlClick,x116 y197,ahk_exe SalesPad.exe
