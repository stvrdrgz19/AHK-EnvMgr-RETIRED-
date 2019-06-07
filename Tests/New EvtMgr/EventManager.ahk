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

Menu, FileMenu, Add, E&xit, MenuHandler
Menu, FileMenu, Add, Settings tCtrl+S, SettingsScreen
Menu, HelpMenu, Add, &About, AboutScreen
Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Menu, MyMenuBar

Gui, Add, Button, x239 y465 w100 h25 gExit, Exit
Gui, Add, Text, x10 y470, IP Address:
Gui, Add, Edit, cGray ReadOnly x70 y467 w100 vIP, %A_IPAddress1%

Gui, Add, Tab3, x10 y10 w330 h450, Desktop|Dynamics GP|Cloud|Misc.|Scripts

Gui, Tab, 1

Gui, 1:Show, w350 h500, Environment Manager
Return

MenuHandler:
    Return

SettingsScreen:
    Return

AboutScreen:
    Return

Exit:
    ExitApp

GuiClose:
    ExitApp
