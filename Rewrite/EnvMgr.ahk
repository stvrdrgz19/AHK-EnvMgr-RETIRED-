; AutoHotkey Version:   1.1.30.03
; Platform:             Win10
; Author:               Steve Rodriguez
; Rewrite date:         8/14/2019
;
; Description: A tool used for managing/creating SQL Database Backups, as well as installing builds
; of the different SalesPad Applications. 

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

;=====================================================================================================
;   MAIN GUI
;=====================================================================================================
Menu, FileMenu, Add, E&xit, MenuHandler
Menu, FileMenu, Add, Settings `tCtrl+S, SettingsScreen
Menu, HelpMenu, Add, &About, AboutScreen
Menu, HelpMenu, Add, &Counters, ButtonCountersScreen
Menu, HelpMenu, Add, &Log, OpenLog
Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Menu, MyMenuBar
;   Base Setup
Gui, Add, Button, x592 y387 w100 h30 gExit1 vExit1, Exit
Gui, Add, Text, x15 y395 gIPText, IP Address: 
Gui, Add, Edit, cgray x75 y392 w100 ReadOnly vIP, %A_IPAddress1%
Gui, Add, GroupBox, x15 y5 w345 h254, Database Management
Gui, Add, GroupBox, x369 y5 w322 h254, Build Management
Gui, Add, GroupBox, x15 y261 w676 h60, Dynamics GP
Gui, Add, GroupBox, x15 y323 w676 h60, SPC SQL Database Management
;   Database Management
Gui, Add, Text, x24 y31 gUtilities, Select a Database:
Gui, Add, Button, x145 y21 w100 h25 vRefresh, Refresh 
Gui, Add, ListBox, vGPBackupsList gGPBackupsList x25 y52 w220 r15
Gui, Add, Button, x253 y51 w100 h25 vBRest, Restore DB
Gui, Add, Button, x253 y81 w100 h25 vBOver, Overwrite DB
Gui, Add, Button, x253 y141 w100 h25 vDelete, Delete Backup
Gui, Add, Button, x253 y227 w100 h25 vBakFolder, Backups Folder
Gui, Add, Button, x253 y111 w100 h25 vBak, New Backup
;   Build Management
Gui, Add, Text, x376 y31, Select a SalesPad Product to Install:
Gui, Add, Text, x376 y174 w308 0x10 ;Horizontal Line
Gui, Add, Text, x376 y181, Existing Builds:
Gui, Add, Button, x376 y51 w150 h25 vBDesktop, SalesPad Desktop
Gui, Add, Button, x534 y51 w150 h25 vBMobile, SalesPad Mobile
Gui, Add, Button, x376 y81 w150 h25 vBDataCollection, Data Collection
Gui, Add, Button, x376 y111 w150 h25 vCab, Windows Mobile
Gui, Add, Button, x376 y141 w150 h25 vBShipCenter, Ship Center
Gui, Add, Button, x534 y141 w150 h25 vBCardControl, Card Control
Gui, Add, Button, x534 y81 w150 h25 vGPAPI, Web API
Gui, Add, Button, x534 y111 w150 h25 vGPWEB, Web Portal 
Gui, Add, Button, x376 y197 w308 h25 vBLaunch, Launch Build
Gui, Add, Button, x376 y227 w150 h25 vAddDLLs, Add DLLs
Gui, Add, Button, x534 y227 w150 h25 vBBuild, Build Folder
;   Dynamics GP
IniRead, GP01, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton1
IniRead, GP02, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton2
IniRead, GP03, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton3
IniRead, GP04, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton4
IniRead, GP05, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton5
Gui, Add, Button, x25 y281 w125 h25 gD10 vD10, %GP01%
Gui, Add, Button, x158 y281 w125 h25 gD13 vD13, %GP02%
Gui, Add, Button, x291 y281 w125 h25 gD15 vD15, %GP03%
Gui, Add, Button, x424 y281 w125 h25 gD16 vD16, %GP04%
Gui, Add, Button, x557 y281 w125 h25 gD18 vD18, %GP05%
;   SPC SQL Database Management
IniRead, SPC01, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 01
IniRead, SPC02, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 02
IniRead, SPC03, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 03
IniRead, SPC04, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 04
IniRead, SPC05, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 05
Gui, Add, Button, x25 y343 w125 h25 vCloud01, %SPC01%
Gui, Add, Button, x158 y343 w125 h25 vCloud02, %SPC02%
Gui, Add, Button, x291 y343 w125 h25 vCloud03, %SPC03%
Gui, Add, Button, x424 y343 w125 h25 vCloud04, %SPC04%
Gui, Add, Button, x557 y343 w126 h25 vCloud05, %SPC05%

;=====================================================================================================
;   LOADING DEFAULTS FROM SETTINGS
;=====================================================================================================
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
LoadFromSettings("Dyn10Load","GPButtons","Dynamics10","CheckDyn10","D10")
LoadFromSettings("Dyn13Load","GPButtons","Dynamics13","CheckDyn13","D13")
LoadFromSettings("Dyn15Load","GPButtons","Dynamics15","CheckDyn15","D15")
LoadFromSettings("Dyn16Load","GPButtons","Dynamics16","CheckDyn16","D16")
LoadFromSettings("Dyn18Load","GPButtons","Dynamics18","CheckDyn18","D18")
LoadFromSettings("Cloud01Load","SPCButtons","Cloud1","CheckSPC1","Cloud01")
LoadFromSettings("Cloud02Load","SPCButtons","Cloud2","CheckSPC2","Cloud02")
LoadFromSettings("Cloud03Load","SPCButtons","Cloud3","CheckSPC3","Cloud03")
LoadFromSettings("Cloud04Load","SPCButtons","Cloud4","CheckSPC4","Cloud04")
LoadFromSettings("Cloud05Load","SPCButtons","Cloud5","CheckSPC5","Cloud05")

Gui, Color, f9f9f9  ;Setting the Color of the GUI
Gui, Show, w703 h421, Environment Manager

;=====================================================================================================
;   LOAD LISTBOX WITH DATABASES / GRIZZLY CHECKBOX CONTROL / DOUBLE CLICK EVENT
;=====================================================================================================
ListBoxDisplay:
IniRead, DBListDisplay, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
    Loop, %DBListDisplay%\*, 2
    {
        GuiControl,, GPBackupsList, %A_LoopFileName%
    }
    return

UpdateB: ; I believe this is the Grizzly DLL checkbox
    Gui, Submit, NoHide
    if CheckB = 1
    {
        VarCheck = 1
        return
    }
    Else
    {
        VarCheck = 0
        return
    }

GPBackupsList:  ; Double clicking an option from the list box will launch it
    if (A_GuiEvent <> "DoubleClick")
        return
;=====================================================================================================
;   SETTINGS SCREEN GUI
;=====================================================================================================
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
    Gui, 4:Tab, 3
    Gui, 4:Add, Checkbox, x30 y55 vDisableSP, Disable SalesPad Desktop Button
    Gui, 4:Add, Checkbox, x30 y85 vDisableDC, Disable DataCollection Button
    Gui, 4:Add, Checkbox, x30 y115 vDisableSC, Disable Ship Center Button
    Gui, 4:Add, Checkbox, x30 y145 vDisableMOB, Disable SalesPad Mobile Button
    Gui, 4:Add, Checkbox, x260 y55 vDisableCC, Disable Card Control Button
    Gui, 4:Add, Checkbox, x260 y85 vDisableAPI, Disable Web API Button
    Gui, 4:Add, Checkbox, x260 y115 vDisableWeb, Disable Web Portal Button
    Gui, 4:Add, Checkbox, x260 y145 vDisableLaunch, Disable Launch Build Button
    Gui, 4:Add, Checkbox, x490 y55 vDisableAdd, Disable Add DLLs Button
    Gui, 4:Add, Checkbox, x490 y85 vDisableBuild, Disable Build Folder Button
    Gui, 4:Add, Text, x30 y181, Shared Folder:
    Gui, 4:Add, Edit, x105 y178 w512 cGray ReadOnly vSharedF,
    Gui, 4:Add, Button, x617 y177 w23 h23 gShared, ...
    Gui, 4:Tab, 4
    Gui, 4:Add, Text, x38 y45, Disabled
    Gui, 4:Add, Checkbox, x30 y70 vCheckDyn10, GP 2010
    Gui, 4:Add, Checkbox, x30 y100 vCheckDyn13, GP 2013
    Gui, 4:Add, Checkbox, x30 y130 vCheckDyn15, GP 2015
    Gui, 4:Add, Checkbox, x30 y160 vCheckDyn16, GP 2016
    Gui, 4:Add, Checkbox, x30 y190 vCheckDyn18, GP 2018
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
    Gui, 4:Add, Checkbox, x30 y70 vCheckSPC1, Disable SPC Sql Server 01
    Gui, 4:Add, Checkbox, x30 y100 vCheckSPC2, Disable SPC Sql Server 02
    Gui, 4:Add, Checkbox, x30 y130 vCheckSPC3, Disable SPC Sql Server 03
    Gui, 4:Add, Checkbox, x30 y160 vCheckSPC4, Disable SPC Sql Server 04
    Gui, 4:Add, Checkbox, x30 y190 vCheckSPC5, Disable SPC Sql Server 05
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
    Gui, 4:Show, w680 h250, Settings

;=====================================================================================================
;   LOADING SETTINGS SCREEN FIELD VALUES
;=====================================================================================================
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
    LoadSettingsScreen("DesktopLoad","BuildManagement","SalesPad","DisableSP")
    LoadSettingsScreen("MobileLoad","BuildManagement","Mobile","DisableMOB")
    LoadSettingsScreen("DataCollectionLoad","BuildManagement","DataCollection","DisableDC")
    LoadSettingsScreen("ShipCenterLoad","BuildManagement","ShipCenter","DisableSC")
    LoadSettingsScreen("CardControlLoad","BuildManagement","CardControl","DisableCC")
    LoadSettingsScreen("GPAPILoad","BuildManagement","API","DisableAPI")
    LoadSettingsScreen("GPWEBLoad","BuildManagement","Web","DisableWeb")
    LoadSettingsScreen("LaunchLoad","BuildManagement","Launch","DisableLaunch")
    LoadSettingsScreen("AddLoad","BuildManagement","Add","DisableAdd")
    LoadSettingsScreen("SharedLoad","BuildManagement","SharedLocation","SharedF")
    LoadSettingsScreen("BuildLoad","BuildManagement","Build","DisableBuild")
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

;=====================================================================================================
;   SAVING/CANCELLING SETTINGS
;=====================================================================================================
4GuiClose: ; Close the GUI screen
    Gui, 4:Destroy
    return

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
    SaveSettingsCheckbox(CheckRestore,"DBManagement","Rest","BRest")
    SaveSettingsCheckbox(CheckOverwrite,"DBManagement","Over","BOver")
    SaveSettingsCheckbox(CheckDelete,"DBManagement","Delete","Delete")
    SaveSettingsCheckbox(CheckNew,"DBManagement","New","Bak")
    SaveSettingsCheckbox(DisableSP,"BuildManagement","SalesPad","BDesktop")
    SaveSettingsCheckbox(DisableDC,"BuildManagement","DataCollection","BDataCollection")
    SaveSettingsCheckbox(DisableSC,"BuildManagement","ShipCenter","BShipCenter")
    SaveSettingsCheckbox(DisableMOB,"BuildManagement","Mobile","BMobile")
    SaveSettingsCheckbox(DisableCC,"BuildManagement","CardControl","BCardControl")
    SaveSettingsCheckbox(DisableAPI,"BuildManagement","API","GPAPI")
    SaveSettingsCheckbox(DisableWeb,"BuildManagement","Web","GPWEB")
    SaveSettingsCheckbox(DisableLaunch,"BuildManagement","Launch","BLaunch")
    SaveSettingsCheckbox(DisableAdd,"BuildManagement","Add","AddDLLs")
    SaveSettingsCheckbox(DisableBuild,"BuildManagement","Build","BBuild")
    SaveSettingsCheckbox(CheckDyn10,"GPButtons","Dynamics10","D10")
    SaveSettingsCheckbox(CheckDyn13,"GPButtons","Dynamics13","D13")
    SaveSettingsCheckbox(CheckDyn15,"GPButtons","Dynamics15","D15")
    SaveSettingsCheckbox(CheckDyn16,"GPButtons","Dynamics16","D16")
    SaveSettingsCheckbox(CheckDyn18,"GPButtons","Dynamics18","D18")
    SaveSettingsCheckbox(CheckSPC1,"SPCButtons","Cloud1","Cloud01")
    SaveSettingsCheckbox(CheckSPC2,"SPCButtons","Cloud2","Cloud02")
    SaveSettingsCheckbox(CheckSPC3,"SPCButtons","Cloud3","Cloud03")
    SaveSettingsCheckbox(CheckSPC4,"SPCButtons","Cloud4","Cloud04")
    SaveSettingsCheckbox(CheckSPC5,"SPCButtons","Cloud5","Cloud05")
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
    Return

Can2:   ; Cancel the GUI screen
    Gui, 4:Destroy
    sleep 1000
    GuiControl, 1:, GPBackupsList, |
    IniRead, DBListDisplay, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
        Loop, %DBListDisplay%\*, 2
        {
            GuiControl, 1:, GPBackupsList, %A_LoopFileName%
        }
        return
    return

;=====================================================================================================
;   SETTINGS SCREEN CONTROLS
;=====================================================================================================
BackPath:
    ;Insert FileSelectFolder Function
    Return

SQLServ:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SQLUN:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SQLPW:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

DYN:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

REG:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

MB:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectCloudLabel01:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectCloudLabel02:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectCloudLabel03:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectCloudLabel04:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectCloudLabel05:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectGP1:
    ;Insert FileSelectFile Function
    Return

SelectGP2:
    ;Insert FileSelectFile Function
    Return

SelectGP3:
    ;Insert FileSelectFile Function
    Return

SelectGP4:
    ;Insert FileSelectFile Function
    Return

SelectGP5:
    ;Insert FileSelectFile Function
    Return

SelectGPLabel1:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectGPLabel2:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectGPLabel3:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectGPLabel4:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

SelectGPLabel5:
    Gui, Submit, NoHide
    ;Insert VariableGUI Function
    Return

Shared:
    ;Insert FileSelectFolder Function
    Return

;=====================================================================================================
;   ABOUT SCREEN GUI
;=====================================================================================================
AboutScreen:
    Gui, 6:Add, GroupBox, x15 y45 w370 h53, 
    Gui, 6:Font, s15
    Gui, 6:Add, Text, x15 y15, Environment Manager v0.0.1
    Gui, 6:Font, s9
    Gui, 6:Add, Text, x23 y55, Environment Manager is a tool that was created to help with time efficiency. `nIt was designed to quicken the database backup/restore/management `nprocess, as well as provide quick deployment of SalesPad Products.
    Gui, 6:Add, Text, x15 y115, Product Page: 
    Gui, 6:Font, Underline cBlue
    Gui, 6:Add, Text, x85 y115 glink1, https://github.com/stvrdrgz19/AHK-EnvMgr-RETIRED-
    Gui, 6:Font
    Gui, 6:Add, Text, x15 y130, Issues:
    Gui, 6:Font, Underline cBlue
    Gui, 6:Add, Text, x50 y130 glink2, https://github.com/stvrdrgz19/AHK-EnvMgr-RETIRED-/projects/1
    Gui, 6:Font
    ;Gui, 6:Add, Text, x15 y165, Changelog:
    Gui, 6:Add, Text, x15 y225, Environment Manager Team:
    Gui, 6:Add, Text, x35 y245, stvrdrgz19 (Steve Rodriguez)
    Gui, 6:Add, Picture, x15 y245 w15 h15 gHubIcon, Icons\GitHubIcon.png
    Gui, 6:Add, Text, x0 y264 w403 0x10 ;Horizontal Line
    Gui, 6:Add, Button, x295 y270 w100 h25 gClose1, Close 
    Gui, 6:Show, w400 h300, About
    return

Close1: ; Close the about screen
    Gui, 6:Destroy
    return

link1:
    Run, chrome.exe https://github.com/stvrdrgz19/AHK-EnvMgr-RETIRED-
    return

link2:
    Run, chrome.exe https://github.com/stvrdrgz19/AHK-EnvMgr-RETIRED-/projects/1
    return

HubIcon:
    Run, chrome.exe https://github.com/stvrdrgz19
    return

MenuHandler:
    goto, Exit1
    return

;=====================================================================================================
;   BUTTON COUNTERS SCREEN GUI
;=====================================================================================================
ButtonCountersScreen:
    IniRead, Restore, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, RestoreDB
    IniRead, Overwrite, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, OverwriteDB
    IniRead, New, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, NewBackup
    IniRead, Delete, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, DeleteBackup
    IniRead, Desktop, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SalesPadDesktop
    IniRead, Mobile, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SalesPadMobile
    IniRead, DC, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, DataCollection
    IniRead, SC, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, ShipCenter
    IniRead, API, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, WebAPI
    IniRead, Web, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, WebPortal
    IniRead, CC, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, CardControl
    IniRead, Launch, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, LaunchBuild
    IniRead, CabWM, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, Cab
    IniRead, GP1CounterScreen, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, GP1
    IniRead, GP2CounterScreen, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, GP2
    IniRead, GP3CounterScreen, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, GP3
    IniRead, GP4CounterScreen, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, GP4
    IniRead, GP5CounterScreen, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, GP5
    IniRead, SPCCounterScreen1, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC1
    IniRead, SPCCounterScreen2, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC2
    IniRead, SPCCounterScreen3, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC3
    IniRead, SPCCounterScreen4, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC4
    IniRead, SPCCounterScreen5, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC5
    Gui, 28:Add, Text, x65 y55, Restore
    Gui, 28:Add, Text, x65 y85, Overwrite
    Gui, 28:Add, Text, x65 y115, New
    Gui, 28:Add, Text, x65 y145, Delete
    Gui, 28:Add, Edit, x30 y50 w30 cgray ReadOnly, %Restore%
    Gui, 28:Add, Edit, x30 y80 w30 cgray ReadOnly, %Overwrite%
    Gui, 28:Add, Edit, x30 y110 w30 cgray ReadOnly, %New%
    Gui, 28:Add, Edit, x30 y140 w30 cgray ReadOnly, %Delete%
    Gui, 28:Add, Text, x200 y55, Desktop
    Gui, 28:Add, Text, x200 y85, Mobile
    Gui, 28:Add, Text, x200 y115, DC
    Gui, 28:Add, Text, x200 y145, SC
    Gui, 28:Add, Text, x200 y175, API
    Gui, 28:Add, Edit, x165 y50 w30 cgray ReadOnly, %Desktop%
    Gui, 28:Add, Edit, x165 y80 w30 cgray ReadOnly, %Mobile%
    Gui, 28:Add, Edit, x165 y110 w30 cgray ReadOnly, %DC%
    Gui, 28:Add, Edit, x165 y140 w30 cgray ReadOnly, %SC%
    Gui, 28:Add, Edit, x165 y170 w30 cgray ReadOnly, %API%
    Gui, 28:Add, Text, x335 y55, Web
    Gui, 28:Add, Text, x335 y85, CC
    Gui, 28:Add, Text, x335 y115, Launch
    Gui, 28:Add, Text, x335 y145, Windows Mobile
    Gui, 28:Add, Edit, x300 y50 w30 cgray ReadOnly, %Web%
    Gui, 28:Add, Edit, x300 y80 w30 cgray ReadOnly, %CC%
    Gui, 28:Add, Edit, x300 y110 w30 cgray ReadOnly, %Launch%
    Gui, 28:Add, Edit, x300 y140 w30 cgray ReadOnly, %CabWM%
    Gui, 28:Add, Text, x470 y55, GP1
    Gui, 28:Add, Text, x470 y85, GP2
    Gui, 28:Add, Text, x470 y115, GP3
    Gui, 28:Add, Text, x470 y145, GP4
    Gui, 28:Add, Text, x470 y175, GP5
    Gui, 28:Add, Edit, x435 y50 w30 cgray ReadOnly, %GP1CounterScreen%
    Gui, 28:Add, Edit, x435 y80 w30 cgray ReadOnly, %GP2CounterScreen%
    Gui, 28:Add, Edit, x435 y110 w30 cgray ReadOnly, %GP3CounterScreen%
    Gui, 28:Add, Edit, x435 y140 w30 cgray ReadOnly, %GP4CounterScreen%
    Gui, 28:Add, Edit, x435 y170 w30 cgray ReadOnly, %GP5CounterScreen%
    Gui, 28:Add, Text, x605 y55, SCP1
    Gui, 28:Add, Text, x605 y85, SCP2
    Gui, 28:Add, Text, x605 y115, SCP3
    Gui, 28:Add, Text, x605 y145, SCP4
    Gui, 28:Add, Text, x605 y175, SCP5
    Gui, 28:Add, Edit, x570 y50 w30 cgray ReadOnly, %SPCCounterScreen1%
    Gui, 28:Add, Edit, x570 y80 w30 cgray ReadOnly, %SPCCounterScreen2%
    Gui, 28:Add, Edit, x570 y110 w30 cgray ReadOnly, %SPCCounterScreen3%
    Gui, 28:Add, Edit, x570 y140 w30 cgray ReadOnly, %SPCCounterScreen4%
    Gui, 28:Add, Edit, x570 y170 w30 cgray ReadOnly, %SPCCounterScreen5%
    Gui, 28:Show, w680 h250, Button Counters
    Return
    
;=====================================================================================================
;   OPEN DATABASE LOG
;=====================================================================================================
OpenLog:
    Gui, 29:Destroy
    Gui, 29:Add, Edit, x30 y30 w500 h500 ReadOnly cGray vEdit1,
    Gui, 29:Show, w560 h560, Test Log Reader
    FileRead, Log, C:\Users\steve.rodriguez\Desktop\Files\Log.txt
    GuiControl, 29:, Edit1, %Log%
    Return

;=====================================================================================================
;   RESTORE DB
;=====================================================================================================
ButtonRestoreDB:    ; Button to restore the selected DB from the listbox
    IniRead, RestoreCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, RestoreDB
    RestoreCounter += 1
    IniWrite, %RestoreCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, RestoreDB
    GuiControlGet, GPBackupsList
    If GPBackupsList = 
    {
        MsgBox, Please Select a Backtup to Restore.
        return
    }
    Else
    {
        MsgBox, 4, RESTORE?, Would you like to restore the Database listed below?`n`n%GPBackupsList%
        IfMsgBox, No
            return
        IniRead, Var1, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Server
        IniRead, Var2, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, User
        IniRead, Var3, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Password
        IniRead, Var4, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
        IniRead, Var5, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Dynamics
        IniRead, Var6, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company1
        IniRead, Var7, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company2
        Run, "Scripts\Script.DBRestore.bat" %Var1% %Var2% %Var3% %Var4% "%GPBackupsList%" %Var5% %Var6% %Var7%,, UseErrorLevel
        WinWait, C:\windows\system32\cmd.exe
        WinWaitClose
        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Restored "%GPBackupsList%" backup.`n, C:\Users\steve.rodriguez\Desktop\Files\Log.txt
        MsgBox,, COMPLETED, Database %GPBackupsList% was restored successfully.
        return
    }

;=====================================================================================================
;   OVERWRITE DB
;=====================================================================================================

;=====================================================================================================
;   NEW DB
;=====================================================================================================

;=====================================================================================================
;   DELETE DB
;=====================================================================================================

;=====================================================================================================
;   
;=====================================================================================================

;=====================================================================================================
;   
;=====================================================================================================
