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
Gui, Add, ComboBox, x25 y270 w413 vCombo2, Select a Product to Install||SalesPad Desktop|SalesPad Mobile|DataCollection|Windows Mobile|Ship Center|Card Control ;|Web API|Web Portal
Gui, Add, Button, x24 y300 w100 h25 gLaunchBuild, Launch Build
Gui, Add, Button, x129 y300 w100 h25 gAddDLL, Add DLLs 
Gui, Add, Button, x234 y300 w100 h25 gBuildFolder, Build Folder
Gui, Font, s9 bold
Gui, Add, Button, x339 y300 w100 h25 gInstall, Install
Gui, Font, s9 norm

IniRead, GP1, Settings\Settings.ini, GPButtonLabels, GPButton1
IniRead, GP2, Settings\Settings.ini, GPButtonLabels, GPButton2
IniRead, GP3, Settings\Settings.ini, GPButtonLabels, GPButton3
IniRead, GP4, Settings\Settings.ini, GPButtonLabels, GPButton4
IniRead, GP5, Settings\Settings.ini, GPButtonLabels, GPButton5
Gui, Font, s10
Gui, Add, GroupBox, x12 y339 w214 h85 cBlue, Launch GP
Gui, Font, s9
Gui, Add, ComboBox, x25 y360 w184 vCombo3, Select GP to Launch||%GP1%|%GP2%|%GP3%|%GP4%|%GP5%
Gui, Add, Button, x110 y390 w100 h25 gLaunchGP, Launch

IniRead, SPC1, Settings\Settings.ini, CloudButtonNames, 01
IniRead, SPC2, Settings\Settings.ini, CloudButtonNames, 02
IniRead, SPC3, Settings\Settings.ini, CloudButtonNames, 03
IniRead, SPC4, Settings\Settings.ini, CloudButtonNames, 04
IniRead, SPC5, Settings\Settings.ini, CloudButtonNames, 05
Gui, Font, s10
Gui, Add, GroupBox, x241 y339 w214 h85 cBlue, Delete Cloud DB
Gui, Font, s9
Gui, Add, ComboBox, x254 y360 w184 vCombo4, Select Cloud to Delete||%SPC1%|%SPC2%|%SPC3%|%SPC4%|%SPC5%
Gui, Add, Button, x339 y390 w100 h25 gDeleteCloud, Delete

Gui, Add, Checkbox, x12 y430 vAlways gAlways, Always On Top
Gui, Add, Text, x294 y430 gIPText vIPText, IP Address:
Gui, Add, Edit, x354 y427 w100 vIP cgray ReadOnly, %A_IPAddress1%
Gui, Color, f9f9f9 ;FFFFFF is pure white
Gui, Show

LoadDBList:
    IniRead, DBBakPath, Settings\Settings.ini, BackupFolder, path
    Loop, %DBBakPath%\*, 2
    {
        GuiControl,, Combo1, %A_LoopFileName%
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
    MsgBox, 36, OPEN FOLDER, Are you sure you want to open the DB Backup folder?
    IfMsgBox, Yes
    {
        IniRead, DBBakPath, Settings\Settings.ini, BackupFolder, path
        Run, %DBBakPath%
        Return
    }
    IfMsgBox, No
    {
        Return
    }

AddDesc:
    MsgBox, 0, test, Add desc.
    Return

Restore:
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        MsgBox, 16, ERROR, Please select a database backup to restore.
        Return
    }
    MsgBox, 36, RESTORE, Are you sure you want to restore "%Combo1%" over your current dataset?
    IfMsgBox, Yes
    {
        MsgBox, 0, test, Yes
        Return
    }
    IfMsgBox, No
    {
        ;RestoreDB()
        ;ButtonCounters("RestoreDB")
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
    MsgBox, 36, INSTALL, Are you sure you want to install a %Combo2% build?
    IfMsgBox, Yes
    {
        MsgBox, 0, test, Yes was selected`n`nInstalling %Combo2%
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 0, test, NO Was selected`n`n%Combo2% will NOT be installed.
        Return
    }

LaunchBuild:
    MsgBox, 0, test, Add FileSelectFile to all options but the default.
    Return

AddDLL:
    GuiControlGet, Combo2
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a SalesPad Product to install.
        Return
    }
    If Combo2 = SalesPad Desktop
    {
        MsgBox, 0, test, Run the ADD DLLs app.
        Return
    }
    If Combo2 != SalesPad Desktop & Combo2 != Select a Product to Install
    {
        MsgBox, 0, test, No dll's for this product.
        Return
    }

BuildFolder:
    GuiControlGet, Combo2
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a SalesPad Product whose install folder you would like to launch.
        Return
    }
    If Combo2 = SalesPad Desktop
    {
        Run, C:\Program Files (x86)\SalesPad.Desktop
        Return
    }
    If Combo2 = SalesPad Mobile
    {
        Run, C:\Program Files (x86)\SalesPad.GP.Mobile.Server
        Return
    }
    If Combo2 = DataCollection
    {
        Run, C:\Program Files (x86)\DataCollection
        Return
    }
    If Combo2 = Windows Mobile
    {
        MsgBox, 16, ERROR, There is no %Combo2% folder to run.
        Return
    }
    If Combo2 = Ship Center
    {
        Run, C:\Program Files (x86)\ShipCenter
        Return
    }
    If Combo2 = Card Control
    {
        Run, C:\Program Files (x86)\CardControl
        Return
    }

LaunchGP:
    GuiControlGet, Combo3
    If Combo3 = Select GP to Launch
    {
        MsgBox, 16, ERROR, Please select a version of GP to launch.
        Return
    }
    IniRead, GPLabel1, Settings\Settings.ini, GPButtonLabels, GPButton1
    IniRead, GPLabel2, Settings\Settings.ini, GPButtonLabels, GPButton2
    IniRead, GPLabel3, Settings\Settings.ini, GPButtonLabels, GPButton3
    IniRead, GPLabel4, Settings\Settings.ini, GPButtonLabels, GPButton4
    IniRead, GPLabel5, Settings\Settings.ini, GPButtonLabels, GPButton5
    IniRead, GPLaunchPath1, Settings\Settings.ini, GPLaunchFile, GPLaunch1
    IniRead, GPLaunchPath2, Settings\Settings.ini, GPLaunchFile, GPLaunch2
    IniRead, GPLaunchPath3, Settings\Settings.ini, GPLaunchFile, GPLaunch3
    IniRead, GPLaunchPath4, Settings\Settings.ini, GPLaunchFile, GPLaunch4
    IniRead, GPLaunchPath5, Settings\Settings.ini, GPLaunchFile, GPLaunch5
    If Combo3 = %GPLabel1%
    {
        Run, %GPLaunchPath1%
        Return
    }
    If Combo3 = %GPLabel2%
    {
        Run, %GPLaunchPath2%
        Return
    }
    If Combo3 = %GPLabel3%
    {
        Run, %GPLaunchPath3%
        Return
    }
    If Combo3 = %GPLabel4%
    {
        MsgBox, 0, test, %GPLabel4%`n%GPLaunchPath4%
        Run, %GPLaunchPath4%
        Return
    }
    If Combo3 = %GPLabel5%
    {
        Run, %GPLaunchPath5%
        Return
    }
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

Always:
    GuiControlGet, Always
    If Always = 0
    {
        Gui, -AlwaysOnTop
        Return
    }
    If Always = 1
    {
        Gui, +AlwaysOnTop
        Return
    }

;=================================================================================================================================
;   END
;=================================================================================================================================
GuiClose:
    ExitApp