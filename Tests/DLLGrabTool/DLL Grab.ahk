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

Gui, Add, Text, x30 y30, From Location ;Please select a SalesPad Build to pull DLLs from:
Gui, Add, Text, x30 y50, Example: \\sp-fileserv-01\Shares\Builds\SalesPad.GP\Release\4.6.4.6
Gui, Add, Edit, ReadOnly x30 y70 w498 vFromBuild, ;\\sp-fileserv-01\Shares\Builds\SalesPad.GP\Release\4.6.4.6
Gui, Add, Button, x528 y69 w23 h23 gFrom, ...
Gui, Add, Button, x240 y100 w100 h25 gRun, List DLLs
Gui, Add, Text, x125 y130, Extended
Gui, Add, Text, x400 y130, Custom
Gui, Add, ListBox, 8 vExtList gExtList x30 y150 w250 r15
Gui, Add, ListBox, 8 vCustList gCustList x300 y150 w250 r15
Gui, Add, Text, x30 y370, To Location ;Please select a path to store the DLLs In:
Gui, Add, Edit, ReadOnly x30 y390 w498 vDestFolder, ;C:\Users\steve.rodriguez\Downloads\xTest
Gui, Add, Button, x528 y389 w23 h23 gDest, ...
Gui, Add, Button, x451 y420 w100 h25 gMove, Move DLLs
Gui, Show, w580 h460, DLL Grab
MsgBox, 0x40000, WARNING, WARNING!`n`nPressing the "Move DLLs" button will attempt to unzip any zipped files in the specified To Location. If this concerns you then it's recommended that you set your To Location to one that doesn't have any existing zipped files, then manually copy them over to your SalesPad Install folder once complete.
Return

From:
    FileSelectFolder, FromFolder, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, 2, Select a SalesPad folder to pull DLLs from:
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
    GuiControlGet, FromBuild
    If DestFolder = 
    {
        MsgBox, 0, ERROR, Please enter a Folder to move the selected DLLs to.
        Return
    }
    if DestFolder != 
    {
        if ExtList = 
        {
            If CustList = 
            {
                MsgBox, 0, ERROR, No DLLs were selected
                Return
            }
            if CustList != 
            {
                Loop, Parse, CustList, |
                {
                    FileCopy, %FromBuild%\CustomModules\WithOutCardControl\%A_LoopField%, %DestFolder%
                }
                run, "\\sp-fileserv-01\Team QA\Tools\Get DLLs\Scripts\Unzip.bat" "%DestFolder%"
                Return
            }
        }
        if ExtList != 
        {
            if CustList =
            {
                Loop, Parse, ExtList, |
                {
                    FileCopy, %FromBuild%\ExtModules\WithOutCardControl\%A_LoopField%, %DestFolder%
                }
                run, "\\sp-fileserv-01\Team QA\Tools\Get DLLs\Scripts\Unzip.bat" "%DestFolder%"
                Return
            }
            if CustList != 
            {
                Loop, Parse, ExtList, |
                {
                    FileCopy, %FromBuild%\ExtModules\WithOutCardControl\%A_LoopField%, %DestFolder%
                }
                Loop, Parse, CustList, |
                {
                    FileCopy, %FromBuild%\CustomModules\WithOutCardControl\%A_LoopField%, %DestFolder%
                }
                run, "\\sp-fileserv-01\Team QA\Tools\Get DLLs\Scripts\Unzip.bat" "%DestFolder%"
                Return
            }
        }
    }

ExtList:
    Return

CustList:
    Return

GuiClose:
    ExitApp