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

#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\GuiButtonIcon.ahk

If A_IsAdmin = 0
{
    if A_IsCompiled
        Run *RunAs "%A_ScriptFullPath%"
    else
        Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

Menu, FileMenu, Add, E&xit, MenuHandler
Menu, FileMenu, Add, Settings`tCtrl+S, SettingsScreen

Menu, ToolsMenu, Add, &Utilities, Utilities
Menu, ToolsMenu, Add, &Reset Database Version, sppResetDB
Menu, ToolsMenu, Add, &Button Counters, ButtonCounters
Menu, ToolsMenu, Add, &Install Log, Log

Menu, HelpMenu, Add, &About, AboutScreen

Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Tools, :ToolsMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu

Gui, Menu, MyMenuBar

Gui, Font, s10
Gui, Add, GroupBox, w443 h235 cBlue, Database Management
Gui, Font, s9
Gui, Add, ComboBox, x25 y30 w359 vCombo1 gCombo1, Select a Database||
Gui, Add, Button, x24 y202 w100 h25 gRestore, Restore DB
Gui, Add, Button, x129 y202 w100 h25 gOverwrite, Overwrite DB
Gui, Add, Button, x234 y202 w100 h25 gNewDB, New Backup
Gui, Add, Button, x339 y202 w100 h25 gDelete, Delete Backup
Gui, Add, Edit, ReadOnly cGray x25 y55 w413 r10 vDBDesc, =================================================================`nSelect a Database Backup to load it's description.
Gui, Add, Button, x386 y28 w26 h26 gDBFolder hwndIconDBFolder,
GuiButtonIcon(IconDBFolder, "imageres.dll", 4, "s26")
Gui, Add, Button, x413 y28 w26 h26 gAddDesc hwndIconAdd,
GuiButtonIcon(IconAdd, "imageres.dll", 278, "s26")

Gui, Font, s10
Gui, Add, GroupBox, x12 y249 w443 h85 cBlue, Build Management
Gui, Font, s9
Gui, Add, ComboBox, x25 y270 w413 vCombo2, Select a Product to Install||SalesPad Desktop|SalesPad Mobile|DataCollection
Gui, Add, Button, x24 y300 w100 h25 gLaunchBuild, Launch Build
Gui, Add, Button, x129 y300 w100 h25 gAddDLL, Add DLLs 
Gui, Add, Button, x234 y300 w100 h25 gBuildFolder, Build Folder
Gui, Font, s9 bold
Gui, Add, Button, x339 y300 w100 h25 gInstall, Install
Gui, Font, s9 norm

Gui, Font, s10
Gui, Add, GroupBox, x12 y339 w214 h85 cBlue, Launch GP
Gui, Font, s9
Gui, Add, ComboBox, x25 y360 w184 vCombo3, Select GP to Launch||Dynamics GP 2010|Dynamics GP 2013|Dynamics GP 2015|Dynamics GP 2016|Dynamics GP 2018
Gui, Add, Button, x110 y390 w100 h25 gLaunchGP, Launch

Gui, Font, s10
Gui, Add, GroupBox, x241 y339 w214 h85 cBlue, Delete Cloud DB
Gui, Font, s9
Gui, Add, ComboBox, x254 y360 w184 vCombo4, Select Cloud to Delete||SteveRodriguez01|SteveRodriguez02|SteveRodriguez03|SteveRodriguez04|SteveRodriguez05
Gui, Add, Button, x339 y390 w100 h25 gDeleteCloud, Delete

Gui, Add, Checkbox, x12 y430, Always On Top
Gui, Add, Text, x294 y430 gIPText vIPText, IP Address:
Gui, Add, Edit, x354 y427 w100 vIP cgray ReadOnly, %A_IPAddress1%
Gui, Color, f9f9f9 ;FFFFFF is pure white
Gui, Show

;GuiControl, Hide, Drop1

Loop, C:\#DBBackups\*, 2
{
    GuiControl,, Combo1, %A_LoopFileName%
}
Loop, C:\#DBBackups\*, 2
{
    GuiControl,, Drop1, %A_LoopFileName%
}
Return

;=================================================================================================================================
;   FILEMENU STUFF
;=================================================================================================================================
MenuHandler:
    Return

SettingsScreen:
    Return

Utilities:
    Return

sppResetDB:
    Return

ButtonCounters:
    Return

Log:
    Return

AboutScreen:
    Return

;=================================================================================================================================
;   GUIButtons
;=================================================================================================================================
Combo1:
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        GuiControl,, DBDesc, =================================================================`nSelect a Database Backup to load it's description.
        Return
    }
    If FileExist("C:\#DBBackups\" Combo1 "\Description.txt")
    {
        FileRead, SelectedX, C:\#DBBackups\%Combo1%\Description.txt
        GuiControl,, DBDesc, %SelectedX%
        Return
    }
    Else
    {
        GuiControl,, DBDesc, This Database Backup has no description.`n`nTo add a description, select a Database Backup from the list and then click the "Add Description" button above.
        Return
    }

DBFolder:
    Return

AddDesc:
    Return

Restore:
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        MsgBox, 16, ERROR, Please select a database backup to restore.
        Return
    }
    MsgBox, 20, RESTORE, Are you sure you want to restore "%Combo1%" over your current dataset?
    IfMsgBox, Yes
    {
        MsgBox, 0, test, Yes
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 0, test, No
        Return
    }
    Return

Overwrite:
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        MsgBox, 16, ERROR, Please select a database backup to restore.
        Return
    }
    MsgBox, 20, OVERWRITE, Are you sure you want to overwrite "%Combo1%" with your current dataset?
    IfMsgBox, Yes
    {
        MsgBox, 0, test, Yes
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 0, test, No
        Return
    }
    Return

NewDB:
    MsgBox, 20, NEW BACKUP, Are you sure you want to create a new database backup?
    IfMsgBox, Yes
    {
        MsgBox, 0, test, Yes
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 0, test, No
        Return
    }
    Return

Delete:
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        MsgBox, 16, ERROR, Please select a database backup to restore.
        Return
    }
    MsgBox, 20, DELETE, Are you sure you want to delete "%Combo1%"?
    IfMsgBox, Yes
    {
        MsgBox, 0, test, Yes
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 0, test, No
        Return
    }
    Return

Install:
    GuiControlGet, Combo2
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a SalesPad Product to install.
        Return
    }
    MsgBox, 0, test, %Combo2%
    Return

LaunchBuild:
    MsgBox, 0, test, Add a FileSelectFile here with the SalesPad GP Install file path defaulted.
    Return

AddDLL:
    MsgBox, 0, test, Run the Add DLL application - or implement the implication into this file.
    Return

BuildFolder:
    MsgBox, 0, test, Run the SPGP Install build folder.
    Return

LaunchGP:
    GuiControlGet, Combo3
    If Combo3 = Select GP to Launch
    {
        MsgBox, 16, ERROR, Please select a version of GP to launch.
        Return
    }
    MsgBox, 0, test, %Combo3%
    Return

DeleteCloud:
    GuiControlGet, Combo4
    If Combo4 = Select Cloud to Delete
    {
        MsgBox, 16, ERROR, Please select a Cloud Tenant to clear tables.
        Return
    }
    MsgBox, 0, test, %Combo4%
    Return

IPText:
    GuiControl,, IP, %A_IPAddress1%
    GuiControl, +cblue +Redraw, IPText
    GuiControl, +cblue +Redraw, IP
    Sleep 50
    GuiControl, +cblack +Redraw, IPText
    GuiControl, +cgray +Redraw, IP
    Return

;=================================================================================================================================
;   END
;=================================================================================================================================
GuiClose:
    ExitApp