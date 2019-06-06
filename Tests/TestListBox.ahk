; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: A small tool designed to help grab and unzip dlls

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

Gui, Add, Text, x30 y30, Please select a SalesPad Build to pull DLLs from:
Gui, Add, Edit, ReadOnly x30 y50 w498 vFromBuild,
Gui, Add, Button, x528 y49 w23 h23 gFrom, ...
Gui, Add, Button, x240 y80 w100 h25 gRun, Run
Gui, Add, ListBox, 8 vExtList gExtList x30 y110 w250 r15
Gui, Add, ListBox, 8 vCustList gCustList x300 y110 w250 r15
Gui, Add, Text, x30 y350, Please select a path to store the DLLs In:
Gui, Add, Edit, ReadOnly x30 y370 w498 vDestFolder,
Gui, Add, Button, x528 y369 w23 h23 gDest, ...
Gui, Add, Button, x451 y400 w100 h25 gMove, Move DLLs
Gui, Show, w580 h440, DLL Grab
Return

From:
    FileSelectFolder, FromFolder, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, 3, Select a SalesPad folder to pull DLLs from:
    if FromFolder =
    {
        MsgBox, 0, ERROR, Nothing was selected.
        GuiControl,, FromBuild, 
        Return
    }
    Else
    {
        GuiControl,, FromBuild, %FromFolder%
        Return
    }

Run:
    GuiControlGet, FromBuild
    GuiControl,, ExtList, |
    GuiControl,, CustList, |
    If FromBuild = 
    {
        MsgBox, 0, ERROR, Please select a SalesPad Build to pull DLLs from.
        Return
    }
    If FromBuild != 
    {
        Loop, %FromBuild%\ExtModules\WithOutCardControl\*.*
        {
            GuiControl,, ExtList, %A_LoopFileName%
        }
        Loop, %FromBuild%\CustomModules\WithOutCardControl\*.*
        {
            GuiControl,, CustList, %A_LoopFileName%
        }
        Return
    }

Dest:
    FileSelectFolder, DestSelect, C:\, 3, Select where you want to put the DLLs:
    if DestSelect = 
    {
        MsgBox, 0, ERROR, Nothing was selected.
        GuiControl,, DestFolder,
        Return
    }
    if DestSelect != 
    {
        GuiControl,, DestFolder, %DestSelect%
        Return
    }

Move:
    GuiControlGet, ExtList
    GuiControlGet, CustList
    GuiControlGet, DestFolder
    Array := StrSplit(ExtList, "`n")

    for index, file in Array
    {
        if index = 1
            FromBuild := file
        Else
            FileCopy, % FromBuild "\" file, %DestFolder%
    }
    Return


ExtList:
    Return

CustList:
    Return

GuiClose:
    ExitApp