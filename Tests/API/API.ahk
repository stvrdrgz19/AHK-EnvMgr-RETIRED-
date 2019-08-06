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

Gui, 1:Add, Button, x30 y30 w100 h25 gAPI, Get API
Gui, 1:Show, w200 h200, Getting API
Return

API:
    FileSelectFile, SelectedAPI , 1, \\sp-fileserv-01\Shares\Builds\SalesPad.WebApi, Select a WebAPI Build, *.msi
    if ErrorLevel
        return
    SplitPath, SelectedAPI, APIInstaller
    If FileExist("C:\inetpub\wwwroot\SalesPadWebAPI\*.msi")
    {
        Run, Uninstall.bat - Shortcut.lnk
        WinWaitActive, SalesPad WebAPI Setup
        Sleep 1000
        Click, 355, 360
        Sleep 500
        Click, 107, 264
        Sleep 500
        Click, 355, 360
        Sleep 500
        Sleep 1000
        Click, 355, 360
        Sleep 4500
        Click, 355, 360
        WinWaitClose, SalesPad WebAPI Setup
        FileDelete, C:\inetpub\wwwroot\SalesPadWebAPI\*.msi
        if FileExist("C:\inetpub\wwwroot\SalesPadWebAPI")
        {
            FileRemoveDir, C:\inetpub\wwwroot\SalesPadWebAPI, 1
        }
        FileCreateDir, C:\inetpub\wwwroot\SalesPadWebAPI
        FileCopy, %SelectedAPI%, C:\inetpub\wwwroot\SalesPadWebAPI
        Run, C:\inetpub\wwwroot\SalesPadWebAPI\%APIInstaller%
        WinActivate, SalesPad WebAPI Setup
        Sleep 1000
        Click, 354, 361
        Sleep 500
        Click, 34, 314
        Sleep 500
        Click, 355, 360
        Sleep 500
        Click, 355, 360
        Sleep 500
        MouseMove, 109, 134
        Click, 3
        Sleep 500
        Send, 10.50.0.45\SQLSERVER2016
        Sleep 500
        Click, 355, 361
        Sleep 1000
        MouseMove, 103, 173
        Click, 2
        Send, 49403
        Send, {Tab}
        Sleep 500
        Send, steve.rodriguez
        Sleep 500
        Send, {Tab}
        Sleep 500
        Send, S@lespad1
        Sleep 500
        Send, {Tab}
        Sleep 500
        Send, SALESPAD
        Sleep 500
        Click, 355, 360
        Sleep 500
        Click, 355, 360
        WinWaitClose, SalesPad WebAPI Setup
        MsgBox, 0, SUCCESSFUL, %APIInstaller% was successfully installed!
        Return
    }
    Else
    {
        if FileExist("C:\inetpub\wwwroot\SalesPadWebAPI")
        {
            FileRemoveDir, C:\inetpub\wwwroot\SalesPadWebAPI, 1
        }
        FileCreateDir, C:\inetpub\wwwroot\SalesPadWebAPI
        FileCopy, %SelectedAPI%, C:\inetpub\wwwroot\SalesPadWebAPI
        Run, C:\inetpub\wwwroot\SalesPadWebAPI\%APIInstaller%
        WinActivate, SalesPad WebAPI Setup
        Sleep 1000
        Click, 354, 361
        Sleep 500
        Click, 34, 314
        Sleep 500
        Click, 355, 360
        Sleep 500
        Click, 355, 360
        Sleep 500
        MouseMove, 109, 134
        Click, 3
        Sleep 500
        Send, 10.50.0.45\SQLSERVER2016
        Sleep 500
        Click, 355, 361
        Sleep 1000
        MouseMove, 103, 173
        Click, 2
        Send, 49403
        Send, {Tab}
        Sleep 500
        Send, steve.rodriguez
        Sleep 500
        Send, {Tab}
        Sleep 500
        Send, S@lespad1
        Sleep 500
        Send, {Tab}
        Sleep 500
        Send, SALESPAD
        Sleep 500
        Click, 355, 360
        Sleep 500
        Click, 355, 360
        WinWaitClose, SalesPad WebAPI Setup
        MsgBox, 0, SUCCESSFUL, %APIInstaller% was successfully installed!
        Return
    }

GuiClose:
    ExitApp