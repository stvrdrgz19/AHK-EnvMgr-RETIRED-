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
Gui, Add, Text, x125 y100, Extended
Gui, Add, Text, x400 y100, Custom
Gui, Add, ListBox, 8 vExtList gExtList x30 y120 w250 r15
Gui, Add, ListBox, 8 vCustList gCustList x300 y120 w250 r15
Gui, Add, Button, x240 y340 w100 h25 gMove, Move DLLs
Gui, Show, w580 h380, DLL Grab
Return

From:
    FileSelectFolder, FromFolder, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, 2, Select a SalesPad folder to pull DLLs from:
    if FromFolder =
    {
        MsgBox, 0, ERROR, Nothing was selected.
        GuiControl,, FromBuild, 
        GuiControl,, ExtList, |
        GuiControl,, CustList, |
        Return
    }
    Else
    {
        GuiControl,, FromBuild, %FromFolder%
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
        Return
    }

Move:
    if FileExist("C:\#DLLs")
        {
        GuiControlGet, ExtList
        GuiControlGet, CustList
        GuiControlGet, FromBuild
        DestFolder = "C:\#DLLs"
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
                    FileCopy, %FromBuild%\CustomModules\WithOutCardControl\%A_LoopField%, C:\#DLLs
                }
                run, "\\sp-fileserv-01\Team QA\Tools\Get DLLs\Scripts\Unzip.bat"
                run Explorer "C:\#DLLs"
                Return
            }
        }
        if ExtList != 
        {
            if CustList =
            {
                Loop, Parse, ExtList, |
                {
                    FileCopy, %FromBuild%\ExtModules\WithOutCardControl\%A_LoopField%, C:\#DLLs
                }
                run, "\\sp-fileserv-01\Team QA\Tools\Get DLLs\Scripts\Unzip.bat"
                run Explorer "C:\#DLLs"
                Return
            }
            if CustList != 
            {
                Loop, Parse, ExtList, |
                {
                    FileCopy, %FromBuild%\ExtModules\WithOutCardControl\%A_LoopField%, C:\#DLLs
                }
                Loop, Parse, CustList, |
                {
                    FileCopy, %FromBuild%\CustomModules\WithOutCardControl\%A_LoopField%, C:\#DLLs
                }
                run, "\\sp-fileserv-01\Team QA\Tools\Get DLLs\Scripts\Unzip.bat"
                run Explorer "C:\#DLLs"
                Return
            }
        }
    }
    Else
    {
        MsgBox, 4, CREATE DIRECTORY?, The path C:\#DLLs doesn't exist. The DLL Grab Tool requires this directory to function. Would you like DLL Grab Tool to create this directory and continue?
        ifMsgBox No
        {
            MsgBox, 0, CANCELED, The directory C:\#DLLs was not created, the Selected DLLs were not moved and extracted.
            return
        }
        ifMsgBox Yes
        {
            FileCreateDir, C:\#DLLs
            GuiControlGet, ExtList
            GuiControlGet, CustList
            GuiControlGet, FromBuild
            DestFolder = "C:\#DLLs"
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
                        FileCopy, %FromBuild%\CustomModules\WithOutCardControl\%A_LoopField%, C:\#DLLs
                    }
                    run, "\\sp-fileserv-01\Team QA\Tools\Get DLLs\Scripts\Unzip.bat"
                    run Explorer "C:\#DLLs"
                    Return
                }
            }
            if ExtList != 
            {
                if CustList =
                {
                    Loop, Parse, ExtList, |
                    {
                        FileCopy, %FromBuild%\ExtModules\WithOutCardControl\%A_LoopField%, C:\#DLLs
                    }
                    run, "\\sp-fileserv-01\Team QA\Tools\Get DLLs\Scripts\Unzip.bat"
                    run Explorer "C:\#DLLs"
                    Return
                }
                if CustList != 
                {
                    Loop, Parse, ExtList, |
                    {
                        FileCopy, %FromBuild%\ExtModules\WithOutCardControl\%A_LoopField%, C:\#DLLs
                    }
                    Loop, Parse, CustList, |
                    {
                        FileCopy, %FromBuild%\CustomModules\WithOutCardControl\%A_LoopField%, C:\#DLLs
                    }
                    run, "\\sp-fileserv-01\Team QA\Tools\Get DLLs\Scripts\Unzip.bat"
                    run Explorer "C:\#DLLs"
                    Return
                }
            }
        }
    }


ExtList:
    Return

CustList:
    Return

GuiClose:
    ExitApp