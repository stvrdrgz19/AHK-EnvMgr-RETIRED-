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

WinGet, list,list,,, Program Manager

Loop, %list%
{
	  this_id := list%A_Index%
	  WinGettitle,Title,ahk_id %this_id%
    MsgBox, 4, , Shall I move %Title%?
    IfMsgBox, NO, break

    WinMove,ahk_id %this_id%,,50,50
}

