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

;#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\GuiButtonIcon.ahk
;#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\ButtonCounters.ahk
;#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\EnvMgrClose.ahk

;#Include, C:\Users\stvrd\Desktop\EnvMgr\Functions\GuiButtonIcon.ahk
;#Include, C:\Users\stvrd\Desktop\EnvMgr\Functions\ButtonCounters.ahk
;#Include, C:\Users\stvrd\Desktop\EnvMgr\Functions\EnvMgrClose.ahk
#Include, Functions\GuiButtonIcon.ahk
#Include, Functions\ButtonCounters.ahk
#Include, Functions\EnvMgrClose.ahk
#Include, Functions\LoadFromSettings.ahk
#Include, Functions\LoadSettingsScreen.ahk
#Include, Functions\SaveSettingsCheckbox.ahk
#Include, Functions\SaveSettingsCheckbox2.ahk
#Include, Functions\SaveSettingsEdit.ahk
#Include, Functions\SaveSettingsEditAndButton.ahk
#Include, Functions\EditEntryVariableGUI.ahk
#Include, Functions\FileSelectFile.ahk
#Include, Functions\FileSelectFolder.ahk
#Include, Functions\LoadGPEnabled.ahk
#Include, Functions\SPGPInstall.ahk
#Include, Functions\LaunchBuild.ahk
#Include, Functions\LaunchBuildFolder.ahk
#Include, Functions\InstallBuilds.ahk
#Include, Functions\LoadSPCEnabled.ahk
#Include, Functions\LoadProductEnabled.ahk
#Include, Functions\SaveSettingsGPCheckbox.ahk
#Include, Functions\SaveSettingsProductCheckbox.ahk
#Include, Functions\SaveSettingsSPCCheckbox.ahk
#Include, Functions\InstallLogs.ahk

If A_IsAdmin = 0
{
    if A_IsCompiled
        Run *RunAs "%A_ScriptFullPath%"
    else
        Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

Menu, FileMenu, Add, E&xit, MenuHandler
Menu, FileMenu, Add, Settings`tCtrl+S, SettingsScreen

If A_UserName = steve.rodriguez
{
    Menu, ToolsMenu, Add, &F8 Scripts, F8Utils
    Menu, ToolsMenu, Add, &Utilities, Utilities
    Menu, ToolsMenu, Add, &Reset Database Version, sppResetDB
    Menu, ToolsMenu, Add, &Button Counters, ButtonCounters
    Menu, ToolsMenu, Add, &Database Log, Log
}
Menu, ToolsMenu, Add, &Add Dll(s), AddDLLs
Menu, ToolsMenu, Add, &Get Installed DLL(s), GetInstalledDLLs
Menu, ToolsMenu, Add, &OneSource Manager, OneSourceManager 
Menu, ToolsMenu, Add, &Ticket Hyperlink Maker (THM), THM 

If A_UserName = steve.rodriguez
{
    Menu, ToolsMenu, Add, &Tool Metrics, ToolMetrics
    Menu, ToolsMenu, Add, &Update Projects, UpdateProjects
}

Menu, HelpMenu, Add, &About, AboutScreen

Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Tools, :ToolsMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu

Gui, Menu, MyMenuBar

;Gui, Font, s10
Gui, Add, GroupBox, x12 w443 h235 cBlue, Database Management
;Gui, Font, s9
Gui, Add, ComboBox, x25 y30 w359 vCombo1 gCombo1, Select a Database||
Gui, Add, Button, x24 y202 w100 h25 vRestore gRestore, Restore DB
Gui, Add, Button, x129 y202 w100 h25 vOverwrite gOverwrite, Overwrite DB
Gui, Add, Button, x234 y202 w100 h25 vNewDB gNewDB, New Backup
Gui, Add, Button, x339 y202 w100 h25 vDelete gDelete, Delete Backup
Gui, Add, Edit, ReadOnly x25 y55 w413 r10 vDBDesc, =================================================================`n========SELECT A DATABASE BACKUP TO LOAD A DESCRIPTION========`n=================================================================`n=================================================================`n=================================================================`n=================================================================`n=================================================================`n=================================================================`n=================================================================`n=================================================================
Gui, Add, Button, x386 y28 w25 h25 vDBFolder gDBFolder hwndIconDBFolder,
GuiButtonIcon(IconDBFolder, "imageres.dll", 4, "s21")
Gui, Add, Button, x413 y28 w25 h25 vAddDesc gAddDesc hwndIconAdd,
GuiButtonIcon(IconAdd, "imageres.dll", 278, "s21")

;Gui, Font, s10
Gui, Add, GroupBox, x12 y249 w443 h85 cBlue, Build Management
;Gui, Font, s9
Gui, Add, ComboBox, x25 y270 w413 vCombo2, Select a Product to Install||
;Gui, Font, s9 bold
Gui, Add, Button, x24 y300 w100 h25 vInstall gInstall, Install
;Gui, Font, s9 norm
Gui, Add, Button, x129 y300 w100 h25 vLaunchBuild gLaunchBuild, Launch Build
Gui, Add, Button, x234 y300 w100 h25 vAddDLL gAddDLL, Add DLLs 
Gui, Add, Button, x339 y300 w100 h25 vBuildFolder gBuildFolder, Build Folder

;Gui, Font, s10
Gui, Add, GroupBox, x12 y339 w214 h85 cBlue, Launch GP
;Gui, Font, s9
Gui, Add, ComboBox, x25 y360 w184 vCombo3, Select GP to Launch||
Gui, Add, Button, x110 y390 w100 h25 vLaunchGP gLaunchGP, Launch
Gui, Add, Button, x80 y390 w25 h25 vGPFolder gGPFolder hwndIconGP
GuiButtonIcon(IconGP, "C:\Program Files (x86)\Microsoft Dynamics\GP2016\GPIcons.dll", 159,"s21")

;Gui, Font, s10
Gui, Add, GroupBox, x241 y339 w214 h85 cBlue, Delete Cloud DB
;Gui, Font, s9
Gui, Add, ComboBox, x254 y360 w184 vCombo4, Select Cloud Tenant to Delete||
Gui, Add, Button, x339 y390 w100 h25 vDeleteCloud gDeleteCloud, Delete
Gui, Add, Button, x309 y390 w25 h25 vOctopush gOctopush hwndIconSPC
GuiButtonIcon(IconSPC, "imageres.dll", 232,"s21")

Gui, Add, Checkbox, x12 y430 vAlways gAlways, Always On Top
Gui, Add, Text, x294 y430 gIPText vIPText, IP Address:
Gui, Add, Edit, x354 y427 w100 vIP cgray ReadOnly, %A_IPAddress1%
;LoadFromSettings("IniReadVariable","Section","Key","SettingsCheckboxName","MainGuiButtonName")
LoadFromSettings("RestoreLoad","DBManagement","Rest","CheckRestore","Restore")
LoadFromSettings("OverwriteLoad","DBManagement","Over","CheckOverwrite","Overwrite")
LoadFromSettings("DeleteLoad","DBManagement","Delete","CheckDelete","Delete")
LoadFromSettings("NewLoad","DBManagement","New","CheckNew","NewDB")
LoadFromSettings("BackupsFolderLoad","DBManagement","BackupsFolder","CheckBackupsFolder","DBFolder")
LoadFromSettings("AddDescriptionLoad","DBManagement","AddDescription","CheckAddDesc","AddDesc")
LoadFromSettings("LaunchLoad","BuildManagement","Launch","DisableLaunch","LaunchBuild")
LoadFromSettings("AddLoad","BuildManagement","Add","DisableAdd","AddDLL")
LoadFromSettings("BuildLoad","BuildManagement","Build","DisableBuild","BuildFolder")
LoadFromSettings("InstallLoad","BuildManagement","Install","DisableInstall","Install")
LoadGPEnabled()
LoadSPCEnabled()
LoadProductEnabled()

IniRead, xLoc, Settings\Settings.ini, Position, xPOS
IniRead, yLoc, Settings\Settings.ini, Position, yPOS
Gui, Color, f9f9f9 ;FFFFFF is pure white
Gui, Show, x%xLoc% y%yLoc%, Environment Manager

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
    EnvMgrClose()
    Return

Utilities:
    Run, "C:\Users\steve.rodriguez\Desktop\Scripts\SteveUtilities.ahk"
    Return

Log:
    Gui, DBLog:Destroy
    Gui, DBLog:Add, Edit, x30 y30 w500 h500 ReadOnly cGray vEdit1,
    WinGetPos, xVarEnv, yVarEnv, varEnvWidth, varEnvHeight, Environment Manager
    xVarEnv -= 44
    yVarEnv -= 28
    Gui, DBLog:Show, x%xVarEnv% y%yVarEnv% w560 h560, Database Management Log
    FileRead, Log, Settings\Log.txt
    GuiControl, DBLog:, Edit1, %Log%
    Return

sppResetDB:
    MsgBox, 36, RESET DATABASE?, Are you sure you want to run the sppResetDatabase proc against TWO?
    IfMsgBox, Yes
    {
        Run, C:\Users\steve.rodriguez\Desktop\Scripts\sppresetdatabase.bat
        Return
    }
    IfMsgBox, No
    {
        Return
    }

ButtonCounters:
    IniRead, Restore, Settings\ButtonCounters.ini, ButtonCounters, RestoreDB
    IniRead, Overwrite, Settings\ButtonCounters.ini, ButtonCounters, OverwriteDB
    IniRead, New, Settings\ButtonCounters.ini, ButtonCounters, NewBackup
    IniRead, Delete, Settings\ButtonCounters.ini, ButtonCounters, DeleteBackup
    IniRead, Desktop, Settings\ButtonCounters.ini, ButtonCounters, SalesPadDesktop
    IniRead, Mobile, Settings\ButtonCounters.ini, ButtonCounters, SalesPadMobile
    IniRead, DC, Settings\ButtonCounters.ini, ButtonCounters, DataCollection
    IniRead, SC, Settings\ButtonCounters.ini, ButtonCounters, ShipCenter
    IniRead, API, Settings\ButtonCounters.ini, ButtonCounters, WebAPI
    IniRead, Web, Settings\ButtonCounters.ini, ButtonCounters, WebPortal
    IniRead, CC, Settings\ButtonCounters.ini, ButtonCounters, CardControl
    IniRead, Launch, Settings\ButtonCounters.ini, ButtonCounters, LaunchBuild
    IniRead, CabWM, Settings\ButtonCounters.ini, ButtonCounters, Cab
    IniRead, GP1CounterScreen, Settings\ButtonCounters.ini, ButtonCounters, GP1
    IniRead, GP2CounterScreen, Settings\ButtonCounters.ini, ButtonCounters, GP2
    IniRead, GP3CounterScreen, Settings\ButtonCounters.ini, ButtonCounters, GP3
    IniRead, GP4CounterScreen, Settings\ButtonCounters.ini, ButtonCounters, GP4
    IniRead, GP5CounterScreen, Settings\ButtonCounters.ini, ButtonCounters, GP5
    IniRead, SPCCounterScreen1, Settings\ButtonCounters.ini, ButtonCounters, SPC1
    IniRead, SPCCounterScreen2, Settings\ButtonCounters.ini, ButtonCounters, SPC2
    IniRead, SPCCounterScreen3, Settings\ButtonCounters.ini, ButtonCounters, SPC3
    IniRead, SPCCounterScreen4, Settings\ButtonCounters.ini, ButtonCounters, SPC4
    IniRead, SPCCounterScreen5, Settings\ButtonCounters.ini, ButtonCounters, SPC5
    Gui, ButtonC:Add, Text, x65 y55, Restore
    Gui, ButtonC:Add, Text, x65 y85, Overwrite
    Gui, ButtonC:Add, Text, x65 y115, New
    Gui, ButtonC:Add, Text, x65 y145, Delete
    Gui, ButtonC:Add, Edit, x30 y50 w30 cgray ReadOnly, %Restore%
    Gui, ButtonC:Add, Edit, x30 y80 w30 cgray ReadOnly, %Overwrite%
    Gui, ButtonC:Add, Edit, x30 y110 w30 cgray ReadOnly, %New%
    Gui, ButtonC:Add, Edit, x30 y140 w30 cgray ReadOnly, %Delete%
    Gui, ButtonC:Add, Text, x200 y55, Desktop
    Gui, ButtonC:Add, Text, x200 y85, Mobile
    Gui, ButtonC:Add, Text, x200 y115, DC
    Gui, ButtonC:Add, Text, x200 y145, SC
    Gui, ButtonC:Add, Text, x200 y175, API
    Gui, ButtonC:Add, Edit, x165 y50 w30 cgray ReadOnly, %Desktop%
    Gui, ButtonC:Add, Edit, x165 y80 w30 cgray ReadOnly, %Mobile%
    Gui, ButtonC:Add, Edit, x165 y110 w30 cgray ReadOnly, %DC%
    Gui, ButtonC:Add, Edit, x165 y140 w30 cgray ReadOnly, %SC%
    Gui, ButtonC:Add, Edit, x165 y170 w30 cgray ReadOnly, %API%
    Gui, ButtonC:Add, Text, x335 y55, Web
    Gui, ButtonC:Add, Text, x335 y85, CC
    Gui, ButtonC:Add, Text, x335 y115, Launch
    Gui, ButtonC:Add, Text, x335 y145, Windows Mobile
    Gui, ButtonC:Add, Edit, x300 y50 w30 cgray ReadOnly, %Web%
    Gui, ButtonC:Add, Edit, x300 y80 w30 cgray ReadOnly, %CC%
    Gui, ButtonC:Add, Edit, x300 y110 w30 cgray ReadOnly, %Launch%
    Gui, ButtonC:Add, Edit, x300 y140 w30 cgray ReadOnly, %CabWM%
    Gui, ButtonC:Add, Text, x470 y55, GP1
    Gui, ButtonC:Add, Text, x470 y85, GP2
    Gui, ButtonC:Add, Text, x470 y115, GP3
    Gui, ButtonC:Add, Text, x470 y145, GP4
    Gui, ButtonC:Add, Text, x470 y175, GP5
    Gui, ButtonC:Add, Edit, x435 y50 w30 cgray ReadOnly, %GP1CounterScreen%
    Gui, ButtonC:Add, Edit, x435 y80 w30 cgray ReadOnly, %GP2CounterScreen%
    Gui, ButtonC:Add, Edit, x435 y110 w30 cgray ReadOnly, %GP3CounterScreen%
    Gui, ButtonC:Add, Edit, x435 y140 w30 cgray ReadOnly, %GP4CounterScreen%
    Gui, ButtonC:Add, Edit, x435 y170 w30 cgray ReadOnly, %GP5CounterScreen%
    Gui, ButtonC:Add, Text, x605 y55, SCP1
    Gui, ButtonC:Add, Text, x605 y85, SCP2
    Gui, ButtonC:Add, Text, x605 y115, SCP3
    Gui, ButtonC:Add, Text, x605 y145, SCP4
    Gui, ButtonC:Add, Text, x605 y175, SCP5
    Gui, ButtonC:Add, Edit, x570 y50 w30 cgray ReadOnly, %SPCCounterScreen1%
    Gui, ButtonC:Add, Edit, x570 y80 w30 cgray ReadOnly, %SPCCounterScreen2%
    Gui, ButtonC:Add, Edit, x570 y110 w30 cgray ReadOnly, %SPCCounterScreen3%
    Gui, ButtonC:Add, Edit, x570 y140 w30 cgray ReadOnly, %SPCCounterScreen4%
    Gui, ButtonC:Add, Edit, x570 y170 w30 cgray ReadOnly, %SPCCounterScreen5%
    WinGetPos, xVarEnv, yVarEnv, varEnvWidth, varEnvHeight, Environment Manager
    xVarEnv -= 105
    yVarEnv += 126
    Gui, ButtonC:Show, x%xVarEnv% y%yVarEnv% w680 h250, Button Counters
    Return

AboutScreen:    ;https://autohotkey.com/board/topic/80739-editboxtextbox-without-border/
    Iniread, VersionX, C:\Users\steve.rodriguez\Desktop\Scripts\Projects\Core Projects\#Project Updater\Versions.ini, Versions, EnvMgr
    Gui, ABOUTS:Add, Progress, x0 y0 w400 h310 BackgroundFFFFFF Disabled,
    Gui, ABOUTS:Add, Progress, x0 y311 w400 h40 BackgroundF0F0F0 Disabled,
    Gui, ABOUTS:Add, Progress, x0 y0 w400 h45 BackGroundF0F0F0 Disabled,
    Gui, ABOUTS:Font, s15
    Gui, ABOUTS:Add, Text, +BackgroundTrans x15 y15, Environment Manager v%VersionX%
    Gui, ABOUTS:Font, s9
    Gui, ABOUTS:Add, Text, +BackgroundTrans x15 y55 w370, Environment Manager is a tool designed to quicken both the database and build management process. With Environment Manager, the user is able to quickly Backup/Restore/Overwrite database backups, as well as install and launch SalesPad Products. Some additional features are:
    Gui, ABOUTS:Add, Text, +BackgroundTrans x15 y115, - Adding/Listing DLLs`n- Launching Dynamics GP`n- Clearing out Cloud Tenant Databases`n- Displaying the current IP Address
    Gui, ABOUTS:Add, Text, +BackgroundTrans x15 y180, Possible future features:`n- Installing different GP/SQL versions`n- Deploying SPC Builds
    Gui, ABOUTS:Add, Text, +BackgroundTrans x15 y240, Product Page: 
    Gui, ABOUTS:Font, Underline cBlue
    Gui, ABOUTS:Add, Text, +BackgroundTrans x85 y240 glink1, https://github.com/stvrdrgz19/AHK-EnvMgr-RETIRED-
    Gui, ABOUTS:Font
    Gui, ABOUTS:Add, Text, +BackgroundTrans x15 y255, Issues:
    Gui, ABOUTS:Font, Underline cBlue
    Gui, ABOUTS:Add, Text, +BackgroundTrans x50 y255 glink2, https://github.com/stvrdrgz19/AHK-EnvMgr-RETIRED-/projects/1
    Gui, ABOUTS:Font
    Gui, ABOUTS:Add, Text, +BackgroundTrans x15 y275, Environment Manager Team:
    Gui, ABOUTS:Add, Text, +BackgroundTrans x35 y290, stvrdrgz19 (Steve Rodriguez)
    Gui, ABOUTS:Add, Picture, x15 y290 w15 h15 gHubIcon, Icons\GitHubIcon.png
    Gui, ABOUTS:Add, Button, x295 y320 w100 h25 gClose1, Close 
    WinGetPos, xVarEnv, yVarEnv, varEnvWidth, varEnvHeight, Environment Manager
    xVarEnv += 35
    yVarEnv += 76
    Gui, ABOUTS:Show, x%xVarEnv% y%yVarEnv% w400 h350, About
    Return

    Close1: ; Close the about screen
        Gui, ABOUTS:Destroy
        Return

    link1:
        Run, chrome.exe https://github.com/stvrdrgz19/AHK-EnvMgr-RETIRED-
        Return

    link2:
        Run, chrome.exe https://github.com/stvrdrgz19/AHK-EnvMgr-RETIRED-/projects/1
        Return

    HubIcon:
        Run, chrome.exe https://github.com/stvrdrgz19
        Return

AddDLLs:
    Loop, \\sp-fileserv-01\Team QA\Tools\Add DLLs\*.exe
    {
        Run *RunAs %A_LoopFilePath%
    }
    Return

GetInstalledDLLs:
    Loop, \\sp-fileserv-01\Team QA\Tools\Get Installed DLLs\*.exe
    {
        Run *RunAs %A_LoopFilePath%
    }
    Return

OneSourceManager:
    Loop, \\sp-fileserv-01\Team QA\Tools\OneSource Management\*.exe
    {
        Run *RunAs %A_LoopFilePath%
    }
    Return

THM:
    Loop, \\sp-fileserv-01\Team QA\Tools\Ticket Hyperlink Maker\*.exe
    {
        Run *RunAs %A_LoopFilePath%
    }
    Return

ToolMetrics:
    Run, C:\Users\steve.rodriguez\Desktop\Scripts\Projects\Metrics\Metrics.ahk
    Return

UpdateProjects:
    Run, C:\Users\steve.rodriguez\Desktop\Scripts\Projects\Core Projects\#Project Updater\Updater.ahk
    Return

SettingsScreen:
    Gui, 4:Destroy
    Gui, 4:Add, Button, x459 y220 w100 h25 gSave, Save
    Gui, 4:Add, Button, x569 y220 w100 h25 gCan2, Exit
    Gui, 4:Add, Tab3, x10 y10 w660 h206, Connection|Desktop DBs|Build Management|Dynamics GP|SPC DBs|Other
    Gui, 4:Tab, 1
    Gui, 4:Add, Text, x30 y55, Select a Database Backup Folder:
    Gui, 4:Add, Edit, cgray x30 y75 w600 Readonly vBackupPath,
    Gui, 4:Add, Button, x630 y74 w23 h23 vBackPath gBackPath, ...
    Gui, 4:Add, Text, x30 y115, SQL Server Name:
    Gui, 4:Add, Text, x30 y145, SQL Username:
    Gui, 4:Add, Text, x30 y175, SQL Password:
    Gui, 4:Add, Edit, cgray x125 y110 w200 Readonly vServName,
    Gui, 4:Add, Edit, cgray x125 y140 w200 Readonly vServUN,
    Gui, 4:Add, Edit, cgray x125 y170 w200 Password Readonly vServPW,
    Gui, 4:Add, Button, x325 y109 w23 h23 vSQLServ gSQLServ, ...
    Gui, 4:Add, Button, x325 y139 w23 h23 vSQLUN gSQLUN, ...
    Gui, 4:Add, Button, x325 y169 w23 h23 vSQLPW gSQLPW, ...
    Gui, 4:Add, Text, x370 y115, Dynamics Database:
    Gui, 4:Add, Text, x370 y145, Non-MB Company:
    Gui, 4:Add, Text, x370 y175, MB Company:
    Gui, 4:Add, Edit, cgray x475 y110 w155 Readonly vDynamicsDB,
    Gui, 4:Add, Edit, cgray x475 y140 w155 Readonly vRegDB,
    Gui, 4:Add, Edit, cgray x475 y170 w155 Readonly vMBDB,
    Gui, 4:Add, Button, x630 y109 w23 h23 vDYN gDYN, ...
    Gui, 4:Add, Button, x630 y139 w23 h23 vREG gREG, ...
    Gui, 4:Add, Button, x630 y169 w23 h23 vMB gMB, ...
    Gui, 4:Tab, 2
    Gui, 4:Add, Checkbox, x30 y55 vCheckRestore, Disable Restore DB Button
    Gui, 4:Add, Checkbox, x30 y85 vCheckOverwrite, Disable Overwrite DB Button
    Gui, 4:Add, Checkbox, x30 y115 vCheckNew, Disable New Backup Button
    Gui, 4:Add, Checkbox, x30 y145 vCheckDelete, Disable Delete Backup Button
    Gui, 4:Add, Checkbox, x260 y55 vCheckBackupsFolder, Disable Backups Folder Button
    Gui, 4:Add, Checkbox, x260 y85 vCheckAddDesc, Disable Add Description Button
    Gui, 4:Tab, 3
    Gui, 4:Add, Checkbox, x30 y55 vDisableSP, Disable SalesPad Desktop
    Gui, 4:Add, Checkbox, x30 y85 vDisableMOB, Disable SalesPad Mobile
    Gui, 4:Add, Checkbox, x30 y115 vDisableDC, Disable DataCollection
    Gui, 4:Add, Checkbox, x30 y145 vDisableDCMOB, Disable Windows Mobile
    Gui, 4:Add, Checkbox, x260 y55 vDisableSC, Disable Ship Center
    Gui, 4:Add, Checkbox, x260 y85 vDisableCC, Disable Card Control
    Gui, 4:Add, Checkbox, x260 y115 vDisableAPI, Disable Web API
    Gui, 4:Add, Checkbox, x260 y145 vDisableWeb, Disable Web Portal
    Gui, 4:Add, Checkbox, x490 y55 vDisableInstall, Disable Install Button
    Gui, 4:Add, Checkbox, x490 y85 vDisableLaunch, Disable Launch Build Button
    Gui, 4:Add, Checkbox, x490 y115 vDisableAdd, Disable Add DLLs Button
    Gui, 4:Add, Checkbox, x490 y145 vDisableBuild, Disable Build Folder Button
    Gui, 4:Add, Text, x30 y181, Shared Folder:
    Gui, 4:Add, Edit, x105 y178 w312 cGray ReadOnly vSharedF,
    Gui, 4:Add, Button, x417 y177 w23 h23 gShared, ...
    ;Gui, 4:Add, Checkbox, x490 y115 vDisableGrizz, Disable Grizzly Checkbox
    ;Gui, 4:Add, Checkbox, x490 y145 vDisableTPG, Disable TPG Checkbox
    ;Gui, 4:Add, Checkbox, x490 y175 vDisableDB, Disable DBUpdate Checkbox
    Gui, 4:Tab, 4
    Gui, 4:Add, Text, x38 y45, Disabled
    Gui, 4:Add, Checkbox, x50 y70 vCheckDyn10
    Gui, 4:Add, Checkbox, x50 y100 vCheckDyn13
    Gui, 4:Add, Checkbox, x50 y130 vCheckDyn15
    Gui, 4:Add, Checkbox, x50 y160 vCheckDyn16
    Gui, 4:Add, Checkbox, x50 y190 vCheckDyn18
    Gui, 4:Add, Text, x140 y45, Button Labels
    Gui, 4:Add, Edit, x110 y65 w120 cGray ReadOnly vGPLabel1,
    Gui, 4:Add, Edit, x110 y95 w120 cGray ReadOnly vGPLabel2,
    Gui, 4:Add, Edit, x110 y125 w120 cGray ReadOnly vGPLabel3,
    Gui, 4:Add, Edit, x110 y155 w120 cGray ReadOnly vGPLabel4,
    Gui, 4:Add, Edit, x110 y185 w120 cGray ReadOnly vGPLabel5,
    Gui, 4:Add, Button, x230 y64 w23 h23 gSelectGPLabel1, ...
    Gui, 4:Add, Button, x230 y94 w23 h23 gSelectGPLabel2, ...
    Gui, 4:Add, Button, x230 y124 w23 h23 gSelectGPLabel3, ...
    Gui, 4:Add, Button, x230 y154 w23 h23 gSelectGPLabel4, ...
    Gui, 4:Add, Button, x230 y184 w23 h23 gSelectGPLabel5, ...
    Gui, 4:Add, Text, x400 y45, GP Launcher Files
    Gui, 4:Add, Edit, x270 y65 w360 cGray ReadOnly vGP1Loc, 
    Gui, 4:Add, Edit, x270 y95 w360 cGray ReadOnly vGP2Loc,
    Gui, 4:Add, Edit, x270 y125 w360 cGray ReadOnly vGP3Loc,
    Gui, 4:Add, Edit, x270 y155 w360 cGray ReadOnly vGP4Loc,
    Gui, 4:Add, Edit, x270 y185 w360 cGray ReadOnly vGP5Loc,
    Gui, 4:Add, Button, x630 y64 w23 h23 gSelectGP1, ...
    Gui, 4:Add, Button, x630 y94 w23 h23 gSelectGP2, ...
    Gui, 4:Add, Button, x630 y124 w23 h23 gSelectGP3, ...
    Gui, 4:Add, Button, x630 y154 w23 h23 gSelectGP4, ...
    Gui, 4:Add, Button, x630 y184 w23 h23 gSelectGP5, ...
    Gui, 4:Tab, 5
    Gui, 4:Add, Text, x70 y45, Disabled
    Gui, 4:Add, Checkbox, x30 y70 vCheckSPC1, Disable Cloud Tenant 01
    Gui, 4:Add, Checkbox, x30 y100 vCheckSPC2, Disable Cloud Tenant 02
    Gui, 4:Add, Checkbox, x30 y130 vCheckSPC3, Disable Cloud Tenant 03
    Gui, 4:Add, Checkbox, x30 y160 vCheckSPC4, Disable Cloud Tenant 04
    Gui, 4:Add, Checkbox, x30 y190 vCheckSPC5, Disable Cloud Tenant 05
    Gui, 4:Add, Text, x300 y45, Please enter the name of your tenants (Ex. SteveRodriguez01)
    Gui, 4:Add, Edit, x250 y65 w380 cGray ReadOnly vCloudLabel01, 
    Gui, 4:Add, Edit, x250 y95 w380 cGray ReadOnly vCloudLabel02, 
    Gui, 4:Add, Edit, x250 y125 w380 cGray ReadOnly vCloudLabel03, 
    Gui, 4:Add, Edit, x250 y155 w380 cGray ReadOnly vCloudLabel04, 
    Gui, 4:Add, Edit, x250 y185 w380 cGray ReadOnly vCloudLabel05, 
    Gui, 4:Add, Button, x630 y64 w23 h23 gSelectCloudLabel01, ...
    Gui, 4:Add, Button, x630 y94 w23 h23 gSelectCloudLabel02, ...
    Gui, 4:Add, Button, x630 y124 w23 h23 gSelectCloudLabel03, ...
    Gui, 4:Add, Button, x630 y154 w23 h23 gSelectCloudLabel04, ...
    Gui, 4:Add, Button, x630 y184 w23 h23 gSelectCloudLabel05, ...
    Gui, 4:Tab, 6
    Gui, 4:Add, Checkbox, x30 y55 vPromptCloseBox, Prompt user when closing Environment Manager 
    WinGetPos, xVarEnv, yVarEnv, varEnvWidth, varEnvHeight, Environment Manager
    xVarEnv -= 104
    yVarEnv += 126
    Gui, 4:Show, x%xVarEnv% y%yVarEnv% w680 h250, Settings

    LoadSettingsScreen("BackPathLoad","BackupFolder","path","BackupPath")
    LoadSettingsScreen("ServLoad","SQLCreds","Server","ServName")
    LoadSettingsScreen("UserLoad","SQLCreds","User","ServUN")
    LoadSettingsScreen("PasswordLoad","SQLCreds","Password","ServPW")
    LoadSettingsScreen("DynamicLoad","Databases","Dynamics","DynamicsDB")
    LoadSettingsScreen("Company1Load","Databases","Company1","RegDB")
    LoadSettingsScreen("Company2Load","Databases","Company2","MBDB")
    LoadSettingsScreen("RestoreLoad","DBManagement","Rest","CheckRestore")
    LoadSettingsScreen("OverwriteLoad","DBManagement","Over","CheckOverwrite")
    LoadSettingsScreen("DeleteLoad","DBManagement","Delete","CheckDelete")
    LoadSettingsScreen("NewLoad","DBManagement","New","CheckNew")
    LoadSettingsScreen("RefreshLoad","DBManagement","Refresh","CheckRefresh")
    LoadSettingsScreen("BackupsFolderLoad","DBManagement","BackupsFolder","CheckBackupsFolder")
    LoadSettingsScreen("AddDescriptionLoad","DBManagement","AddDescription","CheckAddDesc")
    LoadSettingsScreen("DesktopLoad","BuildManagement","SalesPad","DisableSP")
    LoadSettingsScreen("MobileLoad","BuildManagement","Mobile","DisableMOB")
    LoadSettingsScreen("DataCollectionLoad","BuildManagement","DataCollection","DisableDC")
    LoadSettingsScreen("ShipCenterLoad","BuildManagement","ShipCenter","DisableSC")
    LoadSettingsScreen("CardControlLoad","BuildManagement","CardControl","DisableCC")
    LoadSettingsScreen("GPAPILoad","BuildManagement","API","DisableAPI")
    LoadSettingsScreen("GPWEBLoad","BuildManagement","Web","DisableWeb")
    LoadSettingsScreen("InstallLoad","BuildManagement","Install","DisableInstall")
    LoadSettingsScreen("LaunchLoad","BuildManagement","Launch","DisableLaunch")
    LoadSettingsScreen("AddLoad","BuildManagement","Add","DisableAdd")
    LoadSettingsScreen("SharedLoad","BuildManagement","SharedLocation","SharedF")
    LoadSettingsScreen("BuildLoad","BuildManagement","Build","DisableBuild")
    ;LoadSettingsScreen("GrizzLoad","BuildManagement","Grizz","DisableGrizz")
    ;LoadSettingsScreen("TPGLoad","BuildManagement","TPG","DisableTPG")
    ;LoadSettingsScreen("DBUpdateLoad","BuildManagement","DBUpdate","DisableDBUpdate")
    LoadSettingsScreen("Dyn10Load","GPButtons","Dynamics10","CheckDyn10")
    LoadSettingsScreen("Dyn13Load","GPButtons","Dynamics13","CheckDyn13")
    LoadSettingsScreen("Dyn15Load","GPButtons","Dynamics15","CheckDyn15")
    LoadSettingsScreen("Dyn16Load","GPButtons","Dynamics16","CheckDyn16")
    LoadSettingsScreen("Dyn18Load","GPButtons","Dynamics18","CheckDyn18")
    LoadSettingsScreen("Cloud01Load","SPCButtons","Cloud1","CheckSPC1")
    LoadSettingsScreen("Cloud02Load","SPCButtons","Cloud2","CheckSPC2")
    LoadSettingsScreen("Cloud03Load","SPCButtons","Cloud3","CheckSPC3")
    LoadSettingsScreen("Cloud04Load","SPCButtons","Cloud4","CheckSPC4")
    LoadSettingsScreen("Cloud05Load","SPCButtons","Cloud5","CheckSPC5")
    LoadSettingsScreen("Other1Load","PromptClose","Close","PromptCloseBox")
    LoadSettingsScreen("CloudButtonLabel01","CloudButtonNames","01","CloudLabel01")
    LoadSettingsScreen("CloudButtonLabel02","CloudButtonNames","02","CloudLabel02")
    LoadSettingsScreen("CloudButtonLabel03","CloudButtonNames","03","CloudLabel03")
    LoadSettingsScreen("CloudButtonLabel04","CloudButtonNames","04","CloudLabel04")
    LoadSettingsScreen("CloudButtonLabel05","CloudButtonNames","05","CloudLabel05")
    LoadSettingsScreen("GPButtonLabel1","GPButtonLabels","GPButton1","GPLabel1")
    LoadSettingsScreen("GPButtonLabel2","GPButtonLabels","GPButton2","GPLabel2")
    LoadSettingsScreen("GPButtonLabel3","GPButtonLabels","GPButton3","GPLabel3")
    LoadSettingsScreen("GPButtonLabel4","GPButtonLabels","GPButton4","GPLabel4")
    LoadSettingsScreen("GPButtonLabel5","GPButtonLabels","GPButton5","GPLabel5")
    LoadSettingsScreen("GPLaunchPath1","GPLaunchFile","GPLaunch1","GP1Loc")
    LoadSettingsScreen("GPLaunchPath2","GPLaunchFile","GPLaunch2","GP2Loc")
    LoadSettingsScreen("GPLaunchPath3","GPLaunchFile","GPLaunch3","GP3Loc")
    LoadSettingsScreen("GPLaunchPath4","GPLaunchFile","GPLaunch4","GP4Loc")
    LoadSettingsScreen("GPLaunchPath5","GPLaunchFile","GPLaunch5","GP5Loc")
    Return

    Save: ; Saves the Settings fields to the Settings.ini file
        GuiControlGet, BackupPath   ; Might have to add GuiControl for other controls that are being cleared out.
        GuiControlGet, CheckRestore
        GuiControlGet, CloudLabel01
        SaveSettingsEdit(BackupPath,"BackupFolder","path")
        SaveSettingsEdit(ServName,"SQLCreds","Server")
        SaveSettingsEdit(ServUN,"SQLCreds","User")
        SaveSettingsEdit(ServPW,"SQLCreds","Password")
        SaveSettingsEdit(DynamicsDB,"Databases","Dynamics")
        SaveSettingsEdit(RegDB,"Databases","Company1")
        SaveSettingsEdit(MBDB,"Databases","Company2")
        SaveSettingsEdit(GP1Loc,"GPLaunchFile","GPLaunch1")
        SaveSettingsEdit(GP2Loc,"GPLaunchFile","GPLaunch2")
        SaveSettingsEdit(GP3Loc,"GPLaunchFile","GPLaunch3")
        SaveSettingsEdit(GP4Loc,"GPLaunchFile","GPLaunch4")
        SaveSettingsEdit(GP5Loc,"GPLaunchFile","GPLaunch5")
        SaveSettingsEdit(PromptCloseBox,"PromptClose","Close")
        SaveSettingsEdit(SharedF,"BuildManagement","SharedLocation")
        SaveSettingsCheckbox(CheckRestore,"DBManagement","Rest","Restore")
        SaveSettingsCheckbox(CheckOverwrite,"DBManagement","Over","Overwrite")
        SaveSettingsCheckbox(CheckDelete,"DBManagement","Delete","Delete")
        SaveSettingsCheckbox(CheckNew,"DBManagement","New","NewDB")
        SaveSettingsCheckbox(CheckBackupsFolder,"DBManagement","BackupsFolder","DBFolder")
        SaveSettingsCheckbox(CheckAddDesc,"DBManagement","AddDescription","AddDesc")
        SaveSettingsProductCheckbox()
        SaveSettingsCheckbox(DisableInstall,"BuildManagement","Install","Install")
        SaveSettingsCheckbox(DisableLaunch,"BuildManagement","Launch","LaunchBuild")
        SaveSettingsCheckbox(DisableAdd,"BuildManagement","Add","AddDLL")
        SaveSettingsCheckbox(DisableBuild,"BuildManagement","Build","BuildFolder")
        SaveSettingsGPCheckbox()
        SaveSettingsSPCCheckbox()

        ; Gotta hook these guys up someday ;SaveSettingsCheckboxNoButton(DisableGrizz,"BuildManagement","Grizz")
        ; Gotta hook these guys up someday ;SaveSettingsCheckboxNoButton(DisableTPG,"BuildManagement","TPG")
        ; Gotta hook these guys up someday ;SaveSettingsCheckboxNoButton(DisableDBUpdate,"BuildManagement","DBUpdate")
        SaveSettingsEditAndButton(CloudLabel01,"CloudButtonNames","01","Cloud01")
        SaveSettingsEditAndButton(CloudLabel02,"CloudButtonNames","02","Cloud02")
        SaveSettingsEditAndButton(CloudLabel03,"CloudButtonNames","03","Cloud03")
        SaveSettingsEditAndButton(CloudLabel04,"CloudButtonNames","04","Cloud04")
        SaveSettingsEditAndButton(CloudLabel05,"CloudButtonNames","05","Cloud05")
        SaveSettingsEditAndButton(GPLabel1,"GPButtonLabels","GPButton1","D10")
        SaveSettingsEditAndButton(GPLabel2,"GPButtonLabels","GPButton2","D13")
        SaveSettingsEditAndButton(GPLabel3,"GPButtonLabels","GPButton3","D15")
        SaveSettingsEditAndButton(GPLabel4,"GPButtonLabels","GPButton4","D16")
        SaveSettingsEditAndButton(GPLabel5,"GPButtonLabels","GPButton5","D18")
        MsgBox, 48, RELOAD, You may have to reload the application to see changes.
        Return

    Can2:   ; Cancel the GUI screen
        Gui, 4:Destroy
        sleep 1000
        GuiControl, 1:, Combo1, |
        IniRead, DBListDisplay, Settings\Settings.ini, BackupFolder, path
        Loop, %DBListDisplay%\*, 2
        {
            GuiControl, 1:, Combo1, %A_LoopFileName%
        }
        Return

    4GuiClose: ; Close the GUI screen
        Gui, 4:Destroy
        return

    BackPath:
        GuiControlGet, BackupPath
        FolderSelect("C:\","Select your Database Backups Folder:",BackupPath)
        Return

    SQLServ:
        Gui, Submit, NoHide
        VariableGUI("Enter your SQL Server Name:","",ServName,"SQL Server","ServName")
        Return

    SQLUN:
        Gui, Submit, NoHide
        VariableGUI("Enter your SQL Server Username:","",ServUN,"SQL Server Username","ServUN")
        Return

    SQLPW:
        Gui, Submit, NoHide
        VariableGUI("Enter your SQL Server Password:","Password",ServPW,"SQL Server Password","ServPW")
        Return

    DYN:
        Gui, Submit, NoHide
        VariableGUI("Enter your Dynamics GP Database:","",DynamicsDB,"Dynamics GP Database","DynamicsDB")
        Return

    REG:
        Gui, Submit, NoHide
        VariableGUI("Enter your Non-Multibin DB:","",RegDB,"Non-Multibin","RegDB")
        Return

    MB:
        Gui, Submit, NoHide
        VariableGUI("Enter your Multibin DB:","",MBDB,"Multibin","MBDB")
        Return

    SelectCloudLabel01:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your 01 Tenant:","",CloudLabel01,"Tenant 01","CloudLabel01")
        Return

    SelectCloudLabel02:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your 02 Tenant:","",CloudLabel02,"Tenant 02","CloudLabel02")
        Return

    SelectCloudLabel03:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your 03 Tenant:","",CloudLabel03,"Tenant 03","CloudLabel03")
        Return

    SelectCloudLabel04:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your 04 Tenant:","",CloudLabel04,"Tenant 04","CloudLabel04")
        Return

    SelectCloudLabel05:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your 05 Tenant:","",CloudLabel05,"Tenant 05","CloudLabel05")
        Return

    SelectGP1:
        FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File","GP1Loc")
        Return

    SelectGP2:
        FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File","GP2Loc")
        Return

    SelectGP3:
        FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File","GP3Loc")
        Return

    SelectGP4:
        FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File","GP4Loc")
        Return

    SelectGP5:
        FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File","GP5Loc")
        Return

    SelectGPLabel1:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your selected GP Instance:","",GPLabel1,"GP 1 Button Label","GPLabel1")
        Return

    SelectGPLabel2:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your selected GP Instance:","",GPLabel2,"GP 2 Button Label","GPLabel2")
        Return

    SelectGPLabel3:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your selected GP Instance:","",GPLabel3,"GP 3 Button Label","GPLabel3")
        Return

    SelectGPLabel4:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your selected GP Instance:","",GPLabel4,"GP 4 Button Label","GPLabel4")
        Return

    SelectGPLabel5:
        Gui, Submit, NoHide
        VariableGUI("Enter the name of your selected GP Instance:","",GPLabel5,"GP 5 Button Label","GPLabel5")
        Return

    Shared:
        GuiControlGet, SharedF
        FolderSelect("C:\","Select your Shared Folder location:",SharedF)
        Return

;=================================================================================================================================
;   DATABASE MANAGEMENT
;=================================================================================================================================
Combo1:
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        GuiControl,, DBDesc, =================================================================`n========SELECT A DATABASE BACKUP TO LOAD A DESCRIPTION========`n=================================================================`n=================================================================`n=================================================================`n=================================================================`n=================================================================`n=================================================================`n=================================================================`n=================================================================
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
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        MsgBox, 16, ERROR, Please select a Database Backup.
        Return
    }
    If FileExist("C:\#DBBackups\" Combo1 "\Description.txt")
    {
        Gui, Desc:Destroy
        Gui, Desc:Add, Progress, x0 y0 w400 h60 BackgroundFFFFFF Disabled, ; TOP WHITE
        Gui, Desc:Add, Progress, x0 y61 w400 h40 BackgroundF0F0F0 Disabled, ; BOTTOM GRAY
        Gui, Desc:Add, Text, +BackgroundTrans x15 y15 w350, A description for the selected Backup exists. Do you want to overwrite the existing description? Or add to it? 
        Gui, Desc:Add, Button, x136 y67 w75 h23 gDescOverwrite, Overwrite
        Gui, Desc:Add, Button, x223 y67 w75 h23 gDescAdd, Add
        Gui, Desc:Add, Button, x310 y67 w75 H23 gDescCancel, Cancel
        Gui, Desc:Show, w400 h100, ERROR
        Return

        DescOverwrite:
            Gui, Desc:Destroy
            Gui, DESCOVERWRITEDESC:Add, Text, x15 y15, Enter Description/Notes:
            Gui, DESCOVERWRITEDESC:Add, Edit, x15 y15 w300 r10 vOverDesc,
            Gui, DESCOVERWRITEDESC:Add, Button, x100 y160 w100 h25 +Default gDescOverOK, OK
            Gui, DESCOVERWRITEDESC:Add, Button, x215 y160 w100 h25 gDescOverCancel, Cancel
            Gui, DESCOVERWRITEDESC:Show, w330 h190, Overwrite Description
            Return

            DescOverOK:
                GuiControlGet, OverDesc
                Gui, DESCOVERWRITEDESC:Destroy
                IniRead, DBPath, Settings\Settings.ini, BackupFolder, path
                If FileExist(DBPath "\" Combo1 "\Description.txt")
                {
                    FileDelete, %DBPath%\%Combo1%\Description.txt
                    FileAppend, =================================================================`nBACKUP - %Combo1%`nUPDATED - {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}`n%OverDesc%, %DBPath%\%Combo1%\Description.txt
                    FileRead, TestXD, %DBPath%\%Combo1%\Description.txt
                    GuiControl, 1:, DBDesc, %TestXD% 
                    Return
                }
                Else
                {
                    MsgBox, 16, ERROR, ERROR - Description to overwrite didn't exist.
                    Return
                }

            DescOverCancel:
                Gui, DESCOVERWRITEDESC:Destroy
                Return

        DescAdd:
            Gui, Desc:Destroy
            Gui, DESCADDDESC:Add, Text, x15 y15, Enter Description/Notes:
            Gui, DESCADDDESC:Add, Edit, x15 y15 w300 r10 vAddDesc,
            Gui, DESCADDDESC:Add, Button, x100 y160 w100 h25 +Default gDescAddOK, OK
            Gui, DESCADDDESC:Add, Button, x215 y160 w100 h25 gDescAddCancel, Cancel
            Gui, DESCADDDESC:Show, w330 h190, Append description
            Return

            DescAddOK:
                GuiControlGet, AddDesc
                Gui, DESCADDDESC:Destroy
                IniRead, DBPath, Settings\Settings.ini, BackupFolder, path
                FileAppend, `n`n=================================================================`nBACKUP - %Combo1%`nUPDATED - {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}`n%AddDesc%, %DBPath%\%Combo1%\Description.txt
                FileRead, TestXD, %DBPath%\%Combo1%\Description.txt
                GuiControl, 1:, DBDesc, %TestXD% 
                Return

            DescAddCancel:
                Gui, DESCADDDESC:Destroy
                Return

        DescCancel:
            Gui, Desc:Destroy
            Return
    }
    Else
    {
        Gui, Desc:Destroy
        Gui, NEWDESC:Destroy
        Gui, NEWDESC:Add, Text, x15 y15, Enter Description/Notes:
        Gui, NEWDESC:Add, Edit, x15 y15 w300 r10 vNewDesc,
        Gui, NEWDESC:Add, Button, x100 y160 w100 h25 +Default gDescNewOK, OK
        Gui, NEWDESC:Add, Button, x215 y160 w100 h25 gDescNewCancel, Cancel
        Gui, NEWDESC:Show, w330 h190, New description
        Return

        DescNewOK:
            GuiControlGet, NewDesc
            Gui, NEWDESC:Destroy
            IniRead, DBPath, Settings\Settings.ini, BackupFolder, path
            FileAppend, =================================================================`nBACKUP - %Combo1%`nUPDATED - {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}`n%NewDesc%, %DBPath%\%Combo1%\Description.txt
            FileRead, TestXD, %DBPath%\%Combo1%\Description.txt
            GuiControl, 1:, DBDesc, %TestXD% 
            Return

        DescNewCancel:
            Gui, NEWDESC:Destroy
            Return
    }
    Return

Restore:
    GuiControlGet, Combo1
    ButtonCounters("RestoreDB")
    If Combo1 = Select a Database
    {
        MsgBox, 16, ERROR, Please select a database backup to restore.
        Return
    }
    Else
    {
        MsgBox, 36, RESTORE?, Are you sure you want to restore "%Combo1%" over your current databases?
        IfMsgBox, Yes
        {
            IniRead, Var1, Settings\Settings.ini, SQLCreds, Server
            IniRead, Var2, Settings\Settings.ini, SQLCreds, User
            IniRead, Var3, Settings\Settings.ini, SQLCreds, Password
            IniRead, Var4, Settings\Settings.ini, BackupFolder, path
            IniRead, Var5, Settings\Settings.ini, Databases, Dynamics
            IniRead, Var6, Settings\Settings.ini, Databases, Company1
            IniRead, Var7, Settings\Settings.ini, Databases, Company2
            Run, "Scripts\Script.DBRestore.bat" %Var1% %Var2% %Var3% %Var4% "%Combo1%" %Var5% %Var6% %Var7%,, UseErrorLevel
            WinWait, C:\windows\system32\cmd.exe
            WinWaitClose
            FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Restored "%Combo1%" backup.`n, Settings\Log.txt
            MsgBox, 0, COMPLETED, Database %Combo1% was restored successfully.
            ButtonCounters("RestoreDB")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }

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
        Gui, OVERWRITE:Destroy
        Gui, OVERWRITE:Add, Progress, x0 y0 w400 h80 BackgroundFFFFFF Disabled, ; TOP WHITE
        Gui, OVERWRITE:Add, Progress, x0 y81 w400 h40 BackgroundF0F0F0 Disabled, ; BOTTOM GRAY
        Gui, OVERWRITE:Add, Text, +BackgroundTrans x15 y25 w370 h110, Are you sure you want to overwrite "%Combo1%" with your current setup?
        Gui, OVERWRITE:Add, Button, x223 y87 w75 h23 gOverwriteYes, Yes
        Gui, OVERWRITE:Add, Button, x310 y87 w75 H23 gOverwriteNo, No
        Gui, OVERWRITE:Add, Checkbox, x15 y93 vOverCheck, Update Backup Description 
        Gui, OVERWRITE:Show, w400 h120, OVERWRITE?
        Return

        OverwriteNo:
            Gui, OVERWRITE:Destroy
            Return

        OverwriteYes:
            GuiControlGet, OverCheck
            IniRead, Var1, Settings\Settings.ini, SQLCreds, Server
            IniRead, Var2, Settings\Settings.ini, SQLCreds, User
            IniRead, Var3, Settings\Settings.ini, SQLCreds, Password
            IniRead, Var4, Settings\Settings.ini, BackupFolder, path
            IniRead, Var5, Settings\Settings.ini, Databases, Dynamics
            IniRead, Var6, Settings\Settings.ini, Databases, Company1
            IniRead, Var7, Settings\Settings.ini, Databases, Company2
            If OverCheck = 0
            {
                Gui, OVERWRITE:Destroy
                Run, "Scripts\Script.DBOverwrite.bat" %Var1% %Var2% %Var3% %Var4% "%Combo1%" %Var5% %Var6% %Var7%,, UseErrorLevel
                WinWait, C:\windows\system32\cmd.exe
                WinWaitClose
                IniRead, DBPath, Settings\Settings.ini, BackupFolder, path
                FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Overwrote "%Combo1%" backup.`n, Settings\Log.txt
                FileAppend, `n`n=================================================================`nBACKUP - %Combo1%`nUPDATED - {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}, %DBPath%\%Combo1%\Description.txt
                FileRead, TestXD, %DBPath%\%Combo1%\Description.txt
                GuiControl, 1:, DBDesc, %TestXD% 
                ButtonCounters("OverwriteDB")
                Return
            }
            if OverCheck = 1
            {
                Gui, OVERWRITE:Destroy
                Gui, OVERWRITEDESC:Add, Text, x15 y15, Enter Description/Notes:
                Gui, OVERWRITEDESC:Add, Edit, x15 y30 w300 r10 vDBDescription,
                Gui, OVERWRITEDESC:Add, Button, x100 y175 w100 h25 +Default gOverOK, OK
                Gui, OVERWRITEDESC:Add, Button, x215 y175 w100 h25 gOverCancel, Cancel
                Gui, OVERWRITEDESC:Show, w330 h205, Overwrite Description
                Return

                OverOK:
                    GuiControlGet, DBDescription
                    Gui, OVERWRITEDESC:Destroy
                    Run, "Scripts\Script.DBOverwrite.bat" %Var1% %Var2% %Var3% %Var4% "%Combo1%" %Var5% %Var6% %Var7%,, UseErrorLevel
                    WinWait, C:\windows\system32\cmd.exe
                    WinWaitClose
                    IniRead, DBPath, Settings\Settings.ini, BackupFolder, path
                    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Overwrote "%Combo1%" backup.`n, Settings\Log.txt
                    FileAppend, `n`n=================================================================`nBACKUP - %Combo1%`nUPDATED - {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}`n%DBDescription%, %DBPath%\%Combo1%\Description.txt
                    FileRead, TestXD, %DBPath%\%Combo1%\Description.txt
                    GuiControl, 1:, DBDesc, %TestXD% 
                    ButtonCounters("OverwriteDB")
                    Return
                    
                OverCancel:
                    Gui, OVERWRITEDESC:Destroy
                    Return
            }
    }
    IfMsgBox, No
    {
        Return
    }

NewDB:
    MsgBox, 20, NEW BACKUP, Are you sure you want to create a new database backup?
    IfMsgBox, Yes
    {
        Gui, NewDB:Destroy
        Gui, NewDB:Add, Text, x15 y15, Database name:
        Gui, NewDB:Add, Edit, x15 y30 w300 vDatabase, 
        Gui, NewDB:Add, Text, x15 y60, Description/Notes:
        Gui, NewDB:Add, Edit, x15 y75 w300 r10 vDBDescription,
        Gui, NewDB:Add, Button, x100 y220 w100 h25 +Default gOKNewDB, OK
        Gui, NewDB:Add, Button, x215 y220 w100 h25 gCancelNewDB, Cancel
        Gui, NewDB:Show, w330 h250, New Database
        Return

        OKNewDB:
            IniRead, DBListNew, Settings\Settings.ini, BackupFolder, path
            GuiControlGet, Database
            if Database = 
            {
                MsgBox, 16, ERROR, No Database Name was entered.
                return
            }
            Else
            {
                ifExist %DBListNew%\%Database%
                {
                    MsgBox, 16, ALREADY EXISTS, A backup named "%Database%" already exists.
                    GuiControl,, Database, 
                    return
                }
                Else
                {
                    MsgBox, 36, CREATE BACKUP?, Are you sure you want to create backup %Database%?
                    ifMsgBox, No
                    {
                        MsgBox, 16, CANCEL, No backup was created.
                        GuiControl,, Database, 
                        return
                    }
                    ifMsgBox, Yes
                    {
                        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Created "%Database%" backup.`n, Settings\Log.txt
                        IniRead, Var1, Settings\Settings.ini, SQLCreds, Server
                        IniRead, Var2, Settings\Settings.ini, SQLCreds, User
                        IniRead, Var3, Settings\Settings.ini, SQLCreds, Password
                        IniRead, Var4, Settings\Settings.ini, BackupFolder, path
                        IniRead, Var5, Settings\Settings.ini, Databases, Dynamics
                        IniRead, Var6, Settings\Settings.ini, Databases, Company1
                        IniRead, Var7, Settings\Settings.ini, Databases, Company2
                        Run, "Scripts\Script.DBBackup.bat" %Var1% %Var2% %Var3% %Var4% "%Database%" %Var5% %Var6% %Var7%,, UseErrorLevel
                        WinWait, C:\windows\system32\cmd.exe
                        WinWaitClose
                        IniRead, DBPath, Settings\Settings.ini, BackupFolder, path
                        GuiControlGet, Database
                        GuiControlGet, DBDescription
                        FileAppend, =================================================================`nBACKUP - %Database%`nCREATED - {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}`n%DBDescription%, %DBPath%\%Database%\Description.txt
                        GuiControl, 1:, DBDesc, =================================================================`nSelect a Database Backup to load it's description.
                        IniRead, DBListDisplay, Settings\Settings.ini, BackupFolder, path
                        GuiControl, 1:, Combo1, |
                        GuiControl, 1:, Combo1, Select a Database ||
                        Loop, %DBListDisplay%\*, 2
                        {
                            GuiControl, 1:, Combo1, %A_LoopFileName%
                        }
                        Gui, NewDB:Destroy
                        ButtonCounters("NewBackup")
                        Return
                    }
                }
            }
        CancelNewDB:
            Gui, NewDB:Destroy
            MsgBox, 16, CANCEL, No new Backup was created.
            Return
    }
    IfMsgBox, No
    {
        Return
    }

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
        IniRead, DBListDelete, Settings\Settings.ini, BackupFolder, path
        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Deleted "%Combo1%" backup.`n, Settings\Log.txt
        FileRemoveDir, %DBListDelete%\%Combo1%, 1
        MsgBox, 48, DELETED, Database "%Combo1%" was deleted.
        ButtonCounters("DeleteBackup")
        GuiControl, 1:, Combo1, |
        GuiControl, 1:, Combo1, Select a Database ||
        Loop, %DBListDisplay%\*, 2
        {
            GuiControl, 1:, Combo1, %A_LoopFileName%
        }
        GuiControl, 1:, DBDesc, =================================================================`nSelect a Database Backup to load it's description.
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 16, CANCEL, Backup "%Combo1%" was not deleted.
        Return
    }

;=================================================================================================================================
;   BUILD MANAGEMENT
;=================================================================================================================================
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
        If Combo2 = SalesPad Desktop
        {
            ButtonCounters("SalesPadDesktop")
            FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\SalesPad.GP\, Select a SalesPad Build, *.exe
            if ErrorLevel
                Return
            SplitPath, SelectedFile,, Instl
            Gui, SPGP:Destroy
            Gui, SPGP:Add, Text, x15 y15, Please enter the location you would like to install the following build to:
            Gui, SPGP:Add, Edit, cgray x15 y35 w600 ReadOnly, %Instl%
            Gui, SPGP:Add, Edit, x15 y65 w600 vBuildLoc, C:\Program Files (x86)\SalesPad.Desktop\
            Gui, SPGP:Add, Text, x136 y95, Extended 
            Gui, SPGP:Add, Text, x455 y95, Custom
            Gui, SPGP:Add, ListBox, 8 x15 y115 w285 r15 vExtList
            Gui, SPGP:Add, ListBox, 8 x330 y115 w285 r15 vCustList
            Gui, SPGP:Add, GroupBox, x15 y325 w155 h70, Large Custom Projects
            Gui, SPGP:Add, CheckBox, x30 y345 gGrizzCheck vGrizzValue, Install with Grizzly DLLs
            Gui, SPGP:Add, CheckBox, x30 y365 gTPGCheck vTPGValue, Install with TPG DLLs
            GUi, SPGP:Add, GroupBox, x185 y325 w155 h70, Build Options
            Gui, SPGP:Add, Checkbox, x200 y345 gDBUpdateCheck vDBUpdateValue, Run Database Update
            Gui, SPGP:Add, Checkbox, x200 y365 gRunBuild vRunBuild, Run Build after Install
            Gui, SPGP:Add, Button, x516 y370 w100 h25 gSPGPCan, Cancel
            Gui, SPGP:Add, Button, Default x405 y370 w100 h25 gSPGPOK, OK
            WinGetPos, xVarEnv, yVarEnv, varEnvWidth, varEnvHeight, Environment Manager
            xVarEnv -= 79
            yVarEnv += 46
            Gui, SPGP:Show, x%xVarEnv% y%yVarEnv% w630 h410, Install SalesPad GP
            GuiControl, SPGP:Disable, TPGValue
            GuiControl, SPGP:Disable, DBUpdateValue
            GuiControl, SPGP:Disable, GrizzValue
            GuiControl, SPGP:Disable, RunBuild
            Loop, %Instl%\ExtModules\WithOutCardControl\*.*
            {
                GuiControl, SPGP:, ExtList, %A_LoopFileName%
            }
            Loop, %Instl%\CustomModules\WithOutCardControl\*.*
            {
                GuiControl, SPGP:, CustList, %A_LoopFileName%
            }
            Return

            GrizzCheck:
                Return

            TPGCheck:
                Return

            DBUpdateCheck:
                Return

            RunBuild:
                Return

            SPGPCan:
            SPGPGuiClose:
                MsgBox, 36, CANCEL, Are you sure you want to cancel?
                IfMsgBox, No
                {
                    Return
                }
                IfMsgBox, Yes
                {
                    Gui, SPGP:Destroy
                    Return
                }
            
            SPGPOK:
                GuiControlGet, BuildLoc
                Gui, Prog:Destroy
                Gui, Prog:Add, Text, x15 y15 vProgressText, Copying installer from network...
                Gui, Prog:Add, Progress, w400 h20 x15 y35 cBlue vProgressBar, 1
                if BuildLoc = C:\Program Files (x86)\SalesPad.Desktop\
                {
                    MsgBox, 16, ERROR, Please update the install path to not be the root SalesPad Install path.`n`nFor reference, you can add the branch\buildnumber to the end of the path, easier to sort through your installed builds this way.
                    Return
                }
                If FileExist(BuildLoc)
                {
                    MsgBox, 20, EXISTS, SalesPad is already installed in the specified location, do you want to override this install?
                    IfMsgBox, Yes
                    {
                        Gui, Prog:Show,, Progress...
                        FileRemoveDir, %BuildLoc%, 1
                        if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
                            FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
                        FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS
                        FileCopy, %SelectedFile%, C:\#EnvMgr\TEMPFILES\INSTALLERS
                        GuiControlGet, BuildLoc
                        IniWrite, %Instl%, Settings\Paths.ini, LastInstalledBuild, SPGP
                        GuiControlGet, BuildLoc
                        GuiControlGet, ExtList
                        GuiControlGet, CustList
                        SPGPInstall()
                        if ExtList = 
                        {
                            if CustList = 
                            {
                                While ! FileExist(BuildLoc "\SalesPad.exe")
                                {
                                    Sleep 250
                                }
                                GuiControl, Prog:, ProgressBar, 100
                                GuiControl, Prog:, ProgressText, Complete!
                                Sleep 1000
                                Gui, Prog: Destroy
                                Run, %BuildLoc%\SalesPad.exe
                                InstallLog(Instl,BuildLoc)
                                ;FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, Settings\SPGPInstallLog.txt
                                Gui, SPGP:Destroy
                                Return
                            }
                            if CustList != 
                            {
                                Loop, Parse, CustList, |
                                {
                                    FileCopy, %Instl%\CustomModules\WithOutCardControl\%A_LoopField%, C:\#EnvMgr\TEMPFILES\DLLs
                                }
                                run, "Scripts\FileUnzipAndMove.bat"
                                WinWait, C:\windows\system32\cmd.exe
                                WinWaitClose
                                While ! FileExist(BuildLoc "\SalesPad.exe")
                                {
                                    Sleep 250
                                }
                                GuiControl, Prog:, ProgressBar, 85
                                FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                                FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                                GuiControl, Prog:, ProgressBar, 100
                                GuiControl, Prog:, ProgressText, Complete!
                                Sleep 1000
                                Gui, Prog: Destroy
                                Run, %BuildLoc%\SalesPad.exe
                                InstallLog(Instl,BuildLoc)
                                ;FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, Settings\SPGPInstallLog.txt
                                Loop, Parse, CustList, `|
                                {
                                    CDLL := Rtrim(A_LoopField, ".Zip")
                                    FileAppend, %A_Tab%Custom - %CDLL%`n, Settings\SPGPInstallLog.txt
                                }
                                Gui, SPGP:Destroy
                                Return
                            }
                        }
                        if ExtList != 
                        {
                            if CustList = 
                            {
                                Loop, Parse, ExtList, |
                                {
                                    FileCopy, %Instl%\ExtModules\WithOutCardControl\%A_LoopField%, C:\#EnvMgr\TEMPFILES\DLLs
                                }
                                run, "Scripts\FileUnzipAndMove.bat"
                                WinWait, C:\windows\system32\cmd.exe
                                WinWaitClose
                                While ! FileExist(BuildLoc "\SalesPad.exe")
                                {
                                    Sleep 250
                                }
                                GuiControl, Prog:, ProgressBar, 85
                                FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                                FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                                GuiControl, Prog:, ProgressBar, 100
                                GuiControl, Prog:, ProgressText, Complete!
                                Sleep 1000
                                Gui, Prog: Destroy
                                Run, %BuildLoc%\SalesPad.exe
                                InstallLog(Instl,BuildLoc)
                                ;FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, Settings\SPGPInstallLog.txt
                                Loop, Parse, ExtList, `|
                                {
                                    EDLL := Rtrim(A_LoopField, ".Zip")
                                    FileAppend, %A_Tab%Extended - %EDLL%`n, Settings\SPGPInstallLog.txt
                                }
                                Gui, SPGP:Destroy
                                Return
                            }
                            if CustList != 
                            {
                                Loop, Parse, CustList, |
                                {
                                    FileCopy, %Instl%\CustomModules\WithOutCardControl\%A_LoopField%, C:\#EnvMgr\TEMPFILES\DLLs
                                }
                                Loop, Parse, ExtList, |
                                {
                                    FileCopy, %Instl%\ExtModules\WithOutCardControl\%A_LoopField%, C:\#EnvMgr\TEMPFILES\DLLs
                                }
                                Sleep 2000
                                run, "Scripts\FileUnzipAndMove.bat"
                                WinWait, C:\windows\system32\cmd.exe
                                WinWaitClose
                                While ! FileExist(BuildLoc "\SalesPad.exe")
                                {
                                    Sleep 250
                                }
                                GuiControl, Prog:, ProgressBar, 85
                                FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                                FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                                GuiControl, Prog:, ProgressBar, 100
                                GuiControl, Prog:, ProgressText, Complete!
                                Sleep 1000
                                Gui, Prog: Destroy
                                Run, %BuildLoc%\SalesPad.exe
                                InstallLog(Instl,BuildLoc)
                                ;FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, Settings\SPGPInstallLog.txt
                                Loop, Parse, CustList, `|
                                {
                                    CDLL := Rtrim(A_LoopField, ".Zip")
                                    FileAppend, %A_Tab%Custom - %CDLL%`n, Settings\SPGPInstallLog.txt
                                }
                                Loop, Parse, ExtList, `|
                                {
                                    EDLL := Rtrim(A_LoopField, ".Zip")
                                    FileAppend, %A_Tab%Extended - %EDLL%`n, Settings\SPGPInstallLog.txt
                                }
                                Gui, SPGP:Destroy
                                Return
                            }
                        }
                    }
                    IfMsgBox, No
                    {
                        MsgBox, 16, CANCEL, Install was canceled, existing install was not removed.
                        Return
                    }
                }
                Else
                {
                    Gui, Prog:Show,, Progress...
                    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
                        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
                    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS
                    FileCopy, %SelectedFile%, C:\#EnvMgr\TEMPFILES\INSTALLERS
                    GuiControl, Prog:, ProgressBar, 40
                    GuiControl, Prog:, ProgressText, Grabbing DLLs...
                    GuiControlGet, BuildLoc
                    GuiControlGet, CheckB
                    IniWrite, %Instl%, Settings\Paths.ini, LastInstalledBuild, SPGP
                    GuiControl, Prog:, ProgressBar, 70
                    GuiControl, Prog:, ProgressText, Installing SalesPad...
                    GuiControlGet, BuildLoc
                    GuiControlGet, ExtList
                    GuiControlGet, CustList
                    SPGPInstall()
                    if ExtList = 
                    {
                        if CustList = 
                        {
                            While ! FileExist(BuildLoc "\SalesPad.exe")
                            {
                                Sleep 250
                            }
                            GuiControl, Prog:, ProgressBar, 100
                            GuiControl, Prog:, ProgressText, Complete!
                            Sleep 1000
                            Gui, Prog: Destroy
                            Run, %BuildLoc%\SalesPad.exe
                            InstallLog(Instl,BuildLoc)
                            ;FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, Settings\SPGPInstallLog.txt
                            Gui, SPGP:Destroy
                            Return
                        }
                        if CustList != 
                        {
                            Loop, Parse, CustList, |
                            {
                                FileCopy, %Instl%\CustomModules\WithOutCardControl\%A_LoopField%, C:\#EnvMgr\TEMPFILES\DLLs
                            }
                            run, "Scripts\FileUnzipAndMove.bat"
                            WinWait, C:\windows\system32\cmd.exe
                            WinWaitClose
                            While ! FileExist(BuildLoc "\SalesPad.exe")
                            {
                                Sleep 250
                            }
                            GuiControl, Prog:, ProgressBar, 85
                            FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                            FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                            GuiControl, Prog:, ProgressBar, 100
                            GuiControl, Prog:, ProgressText, Complete!
                            Sleep 1000
                            Gui, Prog: Destroy
                            Run, %BuildLoc%\SalesPad.exe
                            InstallLog(Instl,BuildLoc)
                            ;FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, Settings\SPGPInstallLog.txt
                            Loop, Parse, CustList, `|
                            {
                                CDLL := Rtrim(A_LoopField, ".Zip")
                                FileAppend, %A_Tab%Custom - %CDLL%`n, Settings\SPGPInstallLog.txt
                            }
                            Gui, SPGP:Destroy
                            Return
                        }
                    }
                    if ExtList != 
                    {
                        if CustList = 
                        {
                            Loop, Parse, ExtList, |
                            {
                                FileCopy, %Instl%\ExtModules\WithOutCardControl\%A_LoopField%, C:\#EnvMgr\TEMPFILES\DLLs
                            }
                            run, "Scripts\FileUnzipAndMove.bat"
                            WinWait, C:\windows\system32\cmd.exe
                            WinWaitClose
                            While ! FileExist(BuildLoc "\SalesPad.exe")
                            {
                                Sleep 250
                            }
                            GuiControl, Prog:, ProgressBar, 85
                            FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                            FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                            GuiControl, Prog:, ProgressBar, 100
                            GuiControl, Prog:, ProgressText, Complete!
                            Sleep 1000
                            Gui, Prog: Destroy
                            Run, %BuildLoc%\SalesPad.exe
                            InstallLog(Instl,BuildLoc)
                            ;FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, Settings\SPGPInstallLog.txt
                            Loop, Parse, ExtList, `|
                            {
                                EDLL := Rtrim(A_LoopField, ".Zip")
                                FileAppend, %A_Tab%Extended - %EDLL%`n, Settings\SPGPInstallLog.txt
                            }
                            Gui, SPGP:Destroy
                            Return
                        }
                        if CustList != 
                        {
                            Loop, Parse, CustList, |
                            {
                                FileCopy, %Instl%\CustomModules\WithOutCardControl\%A_LoopField%, C:\#EnvMgr\TEMPFILES\DLLs
                            }
                            Loop, Parse, ExtList, |
                            {
                                FileCopy, %Instl%\ExtModules\WithOutCardControl\%A_LoopField%, C:\#EnvMgr\TEMPFILES\DLLs
                            }
                            Sleep 2000
                            run, "Scripts\FileUnzipAndMove.bat"
                            WinWait, C:\windows\system32\cmd.exe
                            WinWaitClose
                            While ! FileExist(BuildLoc "\SalesPad.exe")
                            {
                                Sleep 250
                            }
                            GuiControl, Prog:, ProgressBar, 85
                            FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                            FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                            GuiControl, Prog:, ProgressBar, 100
                            GuiControl, Prog:, ProgressText, Complete!
                            Sleep 1000
                            Gui, Prog: Destroy
                            Run, %BuildLoc%\SalesPad.exe
                            InstallLog(Instl,BuildLoc)
                            ;FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, Settings\SPGPInstallLog.txt
                            Loop, Parse, CustList, `|
                            {
                                CDLL := Rtrim(A_LoopField, ".Zip")
                                FileAppend, %A_Tab%Custom - %CDLL%`n, Settings\SPGPInstallLog.txt
                            }
                            Loop, Parse, ExtList, `|
                            {
                                EDLL := Rtrim(A_LoopField, ".Zip")
                                FileAppend, %A_Tab%Extended - %EDLL%`n, Settings\SPGPInstallLog.txt
                            }
                            Gui, SPGP:Destroy
                            Return
                        }
                    }
                }
        }
        If Combo2 = SalesPad Mobile
        {
            InstallBuilds("SalesPadMobile","\\sp-fileserv-01\Shares\Builds\Ares\Mobile-Server\","Select a SalesPad Mobile Server Build:","C:\Program Files (x86)\SalesPad.GP.Mobile.Server\","Install SalesPad GP Mobile Server","SalesPad.GP.Mobile.Server.exe")
            Return
        }
        If Combo2 = DataCollection
        {
            InstallBuilds("DataCollection","\\sp-fileserv-01\Shares\Builds\Ares\DataCollection\","Select a DataCollection Build:","C:\Program Files (x86)\DataCollection\","Install DataCollection","DataCollection Extended Warehouse.exe")
            Return
        }
        If Combo2 = Ship Center
        {
            InstallBuilds("ShipCenter","\\sp-fileserv-01\Shares\Builds\ShipCenter\","Select a ShipCenter Build:","C:\Program Files (x86)\ShipCenter\","Install Ship Center","SalesPad.ShipCenter.exe")
            Return
        }
        If Combo2 = Card Control
        {
            InstallBuilds("CardControl","\\sp-fileserv-01\Shares\Builds\Ares\","Select a Card Control Build:","C:\Program Files (x86)\CardControl\","Install Card Control","CardControl.exe")
            Return
        }
        If Combo2 = Windows Mobile
        {
            IniRead, CabDestination, Settings\Settings.ini, BuildManagement, SharedLocation
            If FileExist(CabDestination "\DCSetup.Motorola.*.CAB")
            {
                MsgBox, 20, EXISTING CAB, Motorola CAB file already exists. Would you like to remove the existing Motorola CAB file?
                IfMsgBox, Yes
                {
                    FileDelete, %CabDestination%\DCSetup.Motorola.*.CAB
                }
                IfMsgBox, No
                {
                    MsgBox, 0, CANCEL, CAB file was NOT deleted.
                }
            }
            ButtonCounters("Cab")
            FileSelectFile, CabFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection\, Select a Windows Mobile file to move, *.cab
            if CabFile = 
            {
                MsgBox, 16, ERROR, Nothing was selected.
                Return
            }
            if CabFile !=
            {
                FileCopy, %CabFile%, %CabDestination%
                IniWrite, %CabFile%, Settings\Paths.ini, LastInstalledBuild, Cab
                Return
            }
            Return
        }
        ;If ((Combo2 = "SalesPad Mobile") || (Combo2 = "DataCollection") || (Combo2 = "Windows Mobile") || (Combo2 = "Ship Center") || (Combo2 = "Card Control"))
        ;{
        ;    MsgBox, 0, test, SalesPad Desktop wasn't selected
        ;    Return
        ;}
    }
    IfMsgBox, No
    {
        MsgBox, 0, test, NO Was selected`n`n%Combo2% will NOT be installed.
        Return
    }

LaunchBuild:
    GuiControlGet, Combo2
    ButtonCounters("LaunchBuild")
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a product to launch.
        Return
    }
    If Combo2 = Windows Mobile
    {
        MsgBox, 16, ERROR, Windows Mobile is not yet supported as an option here.
        Return
    }
    If GetKeyState("Shift", "P")
    {
        IniRead, Launch, Settings\Settings.ini, LastLaunchedBuild, %Combo2%
        Run, %Launch%
        Return
    }
    LaunchBuild(Combo2)
    Return

AddDLL:
    GuiControlGet, Combo2
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a Product to add DLLs to.
        Return
    }
    If Combo2 = SalesPad Desktop
    {
        Loop, \\sp-fileserv-01\Team QA\Tools\Add DLLs\*.exe
        {
            Run *RunAs %A_LoopFilePath%
        }
        Return
    }
    If Combo2 != SalesPad Desktop & Combo2 != Select a Product to Install
    {
        MsgBox, 0, test, No dll's for this product.
        Return
    }

BuildFolder:
    GuiControlGet, Combo2
    IniRead, LocSPGP, Settings\Settings.ini, InstallPaths, LSPGP
    IniRead, LocSPM, Settings\Settings.ini, InstallPaths, LSPM
    IniRead, LocDC, Settings\Settings.ini, InstallPaths, LDC
    IniRead, LocSC, Settings\Settings.ini, InstallPaths, LSC
    IniRead, LocCC, Settings\Settings.ini, InstallPaths, LCC
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a SalesPad Product whose install folder you would like to launch.
        Return
    }
    If Combo2 = Windows Mobile
    {
        MsgBox, 16, ERROR, There is no %Combo2% folder to run.
        Return
    }
    LaunchBuildFolder(Combo2)
    Return

;=================================================================================================================================
;   GP MANAGEMENT
;=================================================================================================================================
GPFolder:
    MsgBox, 36, GP FOLDER, Are you sure you want to launch the Dynamics GP folder?
    IfMsgBox, Yes
    {
        Run, "C:\Program Files (x86)\Microsoft Dynamics"
        Return
    }
    IfMsgBox, No
    {
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
        Run, "%GPLaunchPath1%"
        ButtonCounters("GP1")
        Return
    }
    If Combo3 = %GPLabel2%
    {
        Run, "%GPLaunchPath2%"
        ButtonCounters("GP2")
        Return
    }
    If Combo3 = %GPLabel3%
    {
        Run, "%GPLaunchPath3%"
        ButtonCounters("GP3")
        Return
    }
    If Combo3 = %GPLabel4%
    {
        Run, "%GPLaunchPath4%"
        ButtonCounters("GP4")
        Return
    }
    If Combo3 = %GPLabel5%
    {
        Run, "%GPLaunchPath5%"
        ButtonCounters("GP5")
        Return
    }
    Return

;=================================================================================================================================
;   CLOUD MANAGEMENT
;=================================================================================================================================
Octopush:
    MsgBox, 36, OCTOPUSH, Are you sure you want to launch Octopush?
    IfMsgBox, Yes
    {
        Run, chrome.exe https://deploy.salespad.com
        Return
    }
    IfMsgBox, No
    {
        Return
    }

DeleteCloud:
    GuiControlGet, Combo4
    If Combo4 = Select Cloud Tenant to Delete
    {
        MsgBox, 16, ERROR, Please select a Cloud Tenant to clear tables.
        Return
    }
    IniRead, CloudLab1, Settings\Settings.ini, CloudButtonNames, 01
    IniRead, CloudLab2, Settings\Settings.ini, CloudButtonNames, 02
    IniRead, CloudLab3, Settings\Settings.ini, CloudButtonNames, 03
    IniRead, CloudLab4, Settings\Settings.ini, CloudButtonNames, 04
    IniRead, CloudLab5, Settings\Settings.ini, CloudButtonNames, 05
    If Combo4 = %CloudLab1%
    {
        MsgBox, 36, DELETE TENANT 01, Are you sure you want to delete the tables for Cloud Tenant %CloudLab1%?
        IfMsgBox, Yes
        {
            Run, "Scripts\Script.DropSR01.bat" %CloudLab1%
            ButtonCounters("SPC1")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }
    If Combo4 = %CloudLab2%
    {
        MsgBox, 36, DELETE TENANT 02, Are you sure you want to delete the tables for Cloud Tenant %CloudLab2%?
        IfMsgBox, Yes
        {
            Run, "Scripts\Script.DropSR01.bat" %CloudLab2%
            ButtonCounters("SPC2")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }
    If Combo4 = %CloudLab3%
    {
        MsgBox, 36, DELETE TENANT 03, Are you sure you want to delete the tables for Cloud Tenant %CloudLab3%?
        IfMsgBox, Yes
        {
            Run, "Scripts\Script.DropSR01.bat" %CloudLab3%
            ButtonCounters("SPC3")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }
    If Combo4 = %CloudLab4%
    {
        MsgBox, 36, DELETE TENANT 04, Are you sure you want to delete the tables for Cloud Tenant %CloudLab4%?
        IfMsgBox, Yes
        {
            Run, "Scripts\Script.DropSR01.bat" %CloudLab4%
            ButtonCounters("SPC4")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }
    If Combo4 = %CloudLab5%
    {
        MsgBox, 36, DELETE TENANT 05, Are you sure you want to delete the tables for Cloud Tenant %CloudLab5%?
        IfMsgBox, Yes
        {
            Run, "Scripts\Script.DropSR01.bat" %CloudLab5%
            ButtonCounters("SPC5")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }

;=================================================================================================================================
;   FOOTER STUFF
;=================================================================================================================================
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
        GuiControl, +cRed +Redraw, Always
        Gui, -AlwaysOnTop
        Return
    }
    If Always = 1
    {
        GuiControl, +cBlack +Redraw, Always
        Gui, +AlwaysOnTop
        Return
    }

F8Utils:
    Gui, F8Script:Destroy
    Gui, F8Script:Add, ComboBox, x15 y15 w200 vF8Combo, Select a script to run||
    Gui, F8Script:Add, Button, x14 y36 w202 h23 gF8Run, Run
    Gui, F8Script:Show,, Run Script 

    Loop, C:\Users\steve.rodriguez\Desktop\Scripts\F8Scripts\*.ahk
    {
        Result := RTrim(A_LoopFileName, ".ahk")
        GuiControl, F8Script:, F8Combo, %Result%
    }
    Return

    F8Run:
        GuiControlGet, F8Combo
        If F8Combo = Select a script to run
        {
            MsgBox, 16, ERROR, Please select a script to run.
            Return
        }
        IniRead, F8ScriptPID, Settings\Settings.ini, F8Scripts, PID
        Process, Close, %F8ScriptPID%
        If ErrorLevel = 0
        {
            MsgBox, 16, ERROR, A process with a PID value of %F8ScriptPID% is not currently running, or could not be closed. Please check manually if a F8 Script is running.
        }
        Run, C:\Users\steve.rodriguez\Desktop\Scripts\F8Scripts\%F8Combo%.ahk,,, F8PID
        IniWrite, %F8PID%, Settings\Settings.ini, F8Scripts, PID
        Gui, F8Script:Destroy
        Return

    F8ScriptGuiClose:
        Gui, F8Script:Destroy
        Return

;=================================================================================================================================
;   END
;=================================================================================================================================
GuiClose:
    ExitApp
    ;EnvMgrClose()
    ;Return