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

Gui, Add, Text, x30 y30, Select a Location where you want to put the DLLs:
Gui, Add, Edit, ReadOnly x30 y50 w400 vDestination, 
Gui, Add, Button, x430 y49 w23 h23 gDest, ...
Gui, Add, Button, x353 y80 w100 h25 gExtended, Get DLLs
Gui, Show, w490 h120, DLL Grab
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

Extended:  
    GuiControlGet, FromFolder
    GuiControlGet, Destination
    If Destination = 
    {
        MsgBox, 0, ERRPR, Please select a Folder to place the DLLs into.
        Return
    }
    Else
    {   
        FileSelectFile, AddExt, M3, %FromFolder%\ExtModules\WithOutCardControl\, Select any Extended DLLs needed, *.zip
        if ErrorLevel = 1
        {
            MsgBox, 0, ERROR, Nothing was selected.
            Return
        }
        If ErrorLevel != 1
        {
            Array := StrSplit(AddExt, "`n")

            for index, file in Array
            {
            	if index = 1
            		FromFolder := file
            	else
            		FileCopy, % FromFolder "\" file, %DestFolder%
            }

        }
        run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\DLLGrabTool\Unzip.bat" "%Destination%"
        Return
    }

GuiClose:
ExitApp