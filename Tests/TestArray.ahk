; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: Test Array

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force
/*
Test := "abc|def|ghi|jkl|mno"
Array1 := []
for a, b in StrSplit(Test, "`|")
    Array1.Insert(b)

Loop
MsgBox, % Array1(a_index)
*/

List := "abc|def|ghi|jkl|mno"
array := []
for a, b in StrSplit(List, "`|")
			array.Insert(b)
			
MsgBox, % array[1]
loop
	MsgBox, % array[a_index]




Return

ExitApp