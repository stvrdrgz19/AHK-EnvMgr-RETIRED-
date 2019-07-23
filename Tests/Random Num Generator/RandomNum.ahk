; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: Random number generator, in the form of a Character Ability Score
;   generator for 5e Dungeons and Dragons.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

Gui, Add, Edit, x30 y30 w100 vStart, 1
Gui, Add, Edit, x150 y30 w100 vEnd, 100
Gui, Add, Button, x30 y60 w100 h25 gGenerate, Generate
Gui, Add, Edit, x30 y100 w100 vNumber cgray ReadOnly, 
Gui, Show, w300 h200, Random Num Generator
Return

Generate:
    GuiControl,, Number, 
    GuiControlGet, Start
    GuiControlGet, End
    Random, Rand, %Start%, %End%
    GuiControl,, Number, %Rand%
    Return

GuiClose:
    ExitApp