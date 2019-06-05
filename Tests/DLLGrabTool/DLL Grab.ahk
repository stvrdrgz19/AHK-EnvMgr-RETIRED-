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


; TODO ==========================================================================
;Reference FileUnzipAndMove.bat
;Modify this to accept arguments from ahk
;Need to pass the destination location from ahk to bat


Gui, Add, Text, x30 y30, Select a Location where you want to put the DLLs:
Gui, Add, Edit, ReadOnly x30 y50 w400 vDestination, 
Gui, Add, Button, x430 y49 w23 h23 gDest, ...
Gui, Add, Text, x30 y100, Select a SalesPad Install Folder you want to get DLLs from:
Gui, Add, Edit, ReadOnly x30 y120 w400 vFromBuild,
Gui, Add, Button, x430 y119 w23 h23 gFrom, ...
Gui, Add, Button, x243 y170 w100 h25 gExtended, Extended DLLs
Gui, Add, Button, x353 y170 w100 h25 gCustom, Custom DLLs
Gui, Show, w490 h210, DLL Grab
Return

Dest:
    FileSelectFolder, DestFolder, C:\, 3, Select where you want to put the DLLs:
    if DestFolder =
    {
        MsgBox, 0, ERROR, Nothing was selected.
        GuiControl,, Destination, 
        Return
    }
    Else
    {
        GuiControl,, Destination, %DestFolder%
        Return
    }

From:   
    FileSelectFolder, FromFolder, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, 3, Select a Build you want to get DLLs from:
    If FromFolder = 
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

Extended:
    GuiControlGet, FromFolder
    GuiControlGet, DestFolder
    FileSelectFile, AddExt, M3, %FromFolder%\ExtModules\WithOutCardControl\, Select any Extended DLLs needed, *.zip
        Array := StrSplit(AddExt, "`n")

        for index, file in Array
        {
        	if index = 1
        		FromFolder := file
        	else
        		FileCopy, % FromFolder "\" file, %DestFolder%
        }
    run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\FileUnzipAndMove.bat"
    Return

Custom:
    GuiControlGet, FromFolder
    GuiControlGet, DestFolder
    FileSelectFile, AddCust, M3, %FromFolder%\CustomModules\WithOutCardControl\, Select any Custom DLLs needed, *.zip
        Array := StrSplit(AddCust, "`n")

        for index, file in Array
        {
        	if index = 1
        		FromFolder := file
        	else
        		FileCopy, % FromFolder "\" file, %DestFolder%
        }
    run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\FileUnzipAndMove.bat"
    Return

GuiClose:
ExitApp