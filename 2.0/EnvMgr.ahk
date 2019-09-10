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
#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\LoadFromSettings.ahk
#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\LoadSettingsScreen.ahk
#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\SaveSettingsCheckbox.ahk
#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\SaveSettingsEdit.ahk
#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\SaveSettingsEditAndButton.ahk
#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\EditEntryVariableGUI.ahk
#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\FileSelectFile.ahk
#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\FileSelectFolder.ahk

#Include, Modules\SettingsScreen.ahk

;============================================================================================================================================
;   Running the app as Admin if not explicitly run as admin
;============================================================================================================================================
If A_IsAdmin = 0
{
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}
;============================================================================================================================================
;   Menu Bar options
;============================================================================================================================================

Menu, FileMenu, Add, E&xit, ExitMenu
Menu, FileMenu, Add, Settings`tCtrl+S, SettingsScreen

Menu, ToolsMenu, Add, &Build Origin Paths, BuildOriginPath
Menu, ToolsMenu, Add, &Utilities, Utilities
Menu, ToolsMenu, Add, &Move Current Files, MoveChanges

Menu, HelpMenu, Add, &About, AboutScreen
Menu, HelpMenu, Add, &Counters, ButtonCountersScreen
Menu, HelpMenu, Add, &Log, OpenLog

Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Tools, :ToolsMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu

Gui, Menu, MyMenuBar 

;============================================================================================================================================
;   The main GUI
;============================================================================================================================================
Gui, Add, GroupBox, x15 y5 w640 h256, Database Management
Gui, Add, Text, x134 y31, Select a Database:
Gui, Add, ListBox, vGPBackupsList gGPBackupsList x135 y52 w220 r15
Gui, Add, Text, x369 y31, Backup Description:
Gui, Add, Edit, ReadOnly vDBDescEdit x370 y52 w275 h199,
Gui, Add, Button, x25 y51 w100 h25 gRefresh vRefresh, Refresh
Gui, Add, Button, x25 y81 w100 h25 gRestore vRestore, Restore DB
Gui, Add, Button, x25 y111 w100 h25 gOverwrite vOverwrite, Overwrite DB
Gui, Add, Button, x25 y141 w100 h25 gNew vNew, New Backup
Gui, Add, Button, x25 y171 w100 h25 gDelete vDelete, Delete Backup
Gui, Add, Button, x25 y227 w100 h25 gBackups vBackups, Backups Folder

Gui, Add, GroupBox, x15 y263 w340 h256, Build Management
Gui, Add, Text, x25 y289, Select a SalesPad Product to Install:
Gui, Add, Button, x25 y309 w155 h25 gDesktop vDesktop, SalesPad Desktop
Gui, Add, Button, x25 y339 w155 h25 gDataCollection vDataCollection, Data Collection
Gui, Add, Button, x25 y369 w155 h25 gWindowsMobile vWindowsMobile, Windows Mobile
Gui, Add, Button, x25 y399 w155 h25 gShipCenter vShipCenter, Ship Center
Gui, Add, Button, x190 y309 w155 h25 gMobile vMobile, SalesPad Mobile
Gui, Add, Button, x190 y339 w155 h25 gAPI vAPI, Web API
Gui, Add, Button, x190 y369 w155 h25 gWebPortal vWebPortal, Web Portal
Gui, Add, Button, x190 y399 w155 h25 gCardControl vCardControl, Card Control

Gui, Add, Text, x26 y432 w321 0x10 ;Horizontal Line
Gui, Add, Text, x25 y439, Existing Builds:
Gui, Add, Button, x25 y455 w320 h25 gLaunchBuild vLaunchBuild, Launch Build
Gui, Add, Button, x25 y485 w155 h25 gAddDLLs vAddDLLs, Add DLL
Gui, Add, Button, x190 y485 w155 h25 gBuildFolder vBuildFolder, Build Folder

IniRead, GP01, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton1
IniRead, GP02, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton2
IniRead, GP03, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton3
IniRead, GP04, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton4
IniRead, GP05, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton5
Gui, Add, GroupBox, x370 y263 w285 h200, Dynamics/Cloud
Gui, Add, Text, x380 y289,Launch GP:
Gui, Add, Button, x380 y309 w126 h25 gGP1 vGP1, %GP01%
Gui, Add, Button, x380 y339 w126 h25 gGP2 vGP2, %GP02%
Gui, Add, Button, x380 y369 w126 h25 gGP3 vGP3, %GP03%
Gui, Add, Button, x380 y399 w126 h25 gGP4 vGP4, %GP04%
Gui, Add, Button, x380 y429 w126 h25 gGP5 vGP5, %GP05%

IniRead, SPC01, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 01
IniRead, SPC02, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 02
IniRead, SPC03, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 03
IniRead, SPC04, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 04
IniRead, SPC05, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 05
Gui, Add, Text, x517 y289,Delete Cloud DB:
Gui, Add, Button, x517 y309 w126 h25 gSPC1 vSPC1, %SPC01%
Gui, Add, Button, x517 y339 w126 h25 gSPC2 vSPC2, %SPC02%
Gui, Add, Button, x517 y369 w126 h25 gSPC3 vSPC3, %SPC03%
Gui, Add, Button, x517 y399 w126 h25 gSPC4 vSPC4, %SPC04%
Gui, Add, Button, x517 y429 w126 h25 gSPC5 vSPC5, %SPC05%

Gui, Add, Text, x430 y484 gIPText, IP Address: 
Gui, Add, Edit, cgray x490 y481 w100 ReadOnly vIP, %A_IPAddress1%

;============================================================================================================================================
;   Loads the values/state of the buttons/fields from Settings, then shows the GUI
;============================================================================================================================================
LoadFromSettings("RestoreLoad","DBManagement","Rest","CheckRestore","BRest")
LoadFromSettings("OverwriteLoad","DBManagement","Over","CheckOverwrite","BOver")
LoadFromSettings("DeleteLoad","DBManagement","Delete","CheckDelete","Delete")
LoadFromSettings("NewLoad","DBManagement","New","CheckNew","Bak")

LoadFromSettings("DesktopLoad","BuildManagement","SalesPad","DisableSP","BDesktop")
LoadFromSettings("MobileLoad","BuildManagement","Mobile","DisableMOB","BMobile")
LoadFromSettings("DataCollectionLoad","BuildManagement","DataCollection","DisableDC","BDataCollection")
LoadFromSettings("ShipCenterLoad","BuildManagement","ShipCenter","DisableSC","BShipCenter")
LoadFromSettings("CardControlLoad","BuildManagement","CardControl","DisableCC","BCardControl")
LoadFromSettings("GPAPILoad","BuildManagement","API","DisableAPI","GPAPI")
LoadFromSettings("GPWEBLoad","BuildManagement","Web","DisableWeb","GPWEB")
LoadFromSettings("LaunchLoad","BuildManagement","Launch","DisableLaunch","BLaunch")
LoadFromSettings("AddLoad","BuildManagement","Add","DisableAdd","AddDLLs")
LoadFromSettings("BuildLoad","BuildManagement","Build","DisableBuild","BBuild")

LoadFromSettings("Dyn10Load","GPButtons","Dynamics10","CheckDyn10","GP1")
LoadFromSettings("Dyn13Load","GPButtons","Dynamics13","CheckDyn13","GP2")
LoadFromSettings("Dyn15Load","GPButtons","Dynamics15","CheckDyn15","GP3")
LoadFromSettings("Dyn16Load","GPButtons","Dynamics16","CheckDyn16","GP4")
LoadFromSettings("Dyn18Load","GPButtons","Dynamics18","CheckDyn18","GP5")

LoadFromSettings("Cloud01Load","SPCButtons","Cloud1","CheckSPC1","SPC1")
LoadFromSettings("Cloud02Load","SPCButtons","Cloud2","CheckSPC2","SPC2")
LoadFromSettings("Cloud03Load","SPCButtons","Cloud3","CheckSPC3","SPC3")
LoadFromSettings("Cloud04Load","SPCButtons","Cloud4","CheckSPC4","SPC4")
LoadFromSettings("Cloud05Load","SPCButtons","Cloud5","CheckSPC5","SPC5")

Gui, Color, f9f9f9
Gui, Show

;============================================================================================================================================
;   This loads the database list into the listbox - reference main EnvMgr to pull from Setting
;============================================================================================================================================
Loop, C:\#DBBackups\*, 2
{
    GuiControl,, GPBackupsList, %A_LoopFileName%
}
Return

;============================================================================================================================================
;   Menu Actions
;============================================================================================================================================
ExitMenu:
    ExitApp

SettingsScreen:
    Settings()
    Return

BuildOriginPath:
    Return

Utilities:
    Return

MoveChanges:
    Return

AboutScreen:
    Return
    
ButtonCountersScreen:
    Return

OpenLog:
    Return

;============================================================================================================================================
;   Database Management Buttons
;============================================================================================================================================
GPBackupsList:
    GuiControlGet, ListBox1
    FileRead, SelectedX, C:\#DBBackups\%ListBox1%\Description.txt
    GuiControl,, DBDescEdit, %SelectedX%
    Return

Refresh:
    Return

Restore:
    Return

Overwrite:
    Return

New:
    Return

Delete:
    Return

Backups:
    Return

;============================================================================================================================================
;   Build Management Buttons
;============================================================================================================================================
Desktop:
    Return

DataCollection:
    Return

WindowsMobile:
    Return

ShipCenter:
    Return

Mobile:
    Return

API:
    Return

WebPortal:
    Return

CardControl:
    Return

LaunchBuild:
    Return

AddDLLs:
    Return

BuildFolder:
    Return

;============================================================================================================================================
;   GP Launch Buttons
;============================================================================================================================================
GP1:
    Return

GP2:
    Return

GP3:
    Return

GP4:
    Return

GP5:
    Return

;============================================================================================================================================
;   SPC Tenant Clear Buttons
;============================================================================================================================================
SPC1:
    Return

SPC2:
    Return

SPC3:
    Return

SPC4:
    Return

SPC5:
    Return

;============================================================================================================================================
;   Reloads the current IP Address
;============================================================================================================================================
IPText:
    Return

;============================================================================================================================================
;   End of script - close GUI
;============================================================================================================================================
GuiClose:
    ExitApp