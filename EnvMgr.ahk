; AutoHotkey Version:   1.1.30.03
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Script Function: A tool used for managing/creating SQL Database Backups, as well as installing builds
; of the different SalesPad Applications. 

#SingleInstance, force
#NoEnv
#Include, Functions\LoadFromSettings.ahk
#Include, Functions\LoadSettingsScreen.ahk
#Include, Functions\SaveSettingsCheckbox.ahk
#Include, Functions\SaveSettingsEdit.ahk
#Include, Functions\SaveSettingsEditAndButton.ahk
#Include, Functions\EditEntryVariableGUI.ahk
#Include, Functions\FileSelectFile.ahk
#Include, Functions\FileSelectFolder.ahk
SendMode Input
;--------------------------------------------------------------------------------------------------------------------------
; Creating the first GUI
;--------------------------------------------------------------------------------------------------------------------------

If A_IsAdmin = 0
{
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

Menu, FileMenu, Add, E&xit, MenuHandler
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

If A_UserName != steve.rodriguez
{
    Menu, HelpMenu, Disable, &Utilities
    Menu, HelpMenu, Disable, &Move Current Files
}

;Gui, +Resize
;Gui, Add, Button, x592 y387 w100 h30 gExit1 vExit1, Exit

Gui, Add, GroupBox, x15 y5 w640 h256, Database Management
Gui, Add, Text, x134 y31, Select a Database:
Gui, Add, ListBox, vGPBackupsList gGPBackupsList x135 y52 w220 r15
Gui, Add, Text, x369 y31, Backup Description:
Gui, Add, Edit, ReadOnly cGray vDBDescEdit x370 y52 w275 h199
Gui, Add, Button, x25 y51 w100 h25 vRefresh, Refresh 
Gui, Add, Button, x25 y81 w100 h25 vBRest, Restore DB
Gui, Add, Button, x25 y111 w100 h25 vBOver, Overwrite DB
Gui, Add, Button, x25 y141 w100 h25 vBak, New Backup
Gui, Add, Button, x25 y171 w100 h25 vDelete, Delete Backup
Gui, Add, Button, x25 y227 w100 h25 vBakFolder, Backups Folder

Gui, Add, GroupBox, x15 y263 w340 h256, Build Management
Gui, Add, Text, x25 y289, Select a SalesPad Product to Install:
Gui, Add, Button, x25 y309 w155 h25 vBDesktop, SalesPad Desktop
Gui, Add, Button, x25 y339 w155 h25 vBDataCollection, Data Collection
Gui, Add, Button, x25 y369 w155 h25 vCab, Windows Mobile
Gui, Add, Button, x25 y399 w155 h25 vBShipCenter, Ship Center
Gui, Add, Button, x190 y309 w155 h25 vBMobile, SalesPad Mobile
Gui, Add, Button, x190 y339 w155 h25 vGPAPI, Web API
Gui, Add, Button, x190 y369 w155 h25 vGPWEB, Web Portal 
Gui, Add, Button, x190 y399 w155 h25 vBCardControl, Card Control

Gui, Add, Text, x26 y432 w321 0x10 ;Horizontal Line
Gui, Add, Text, x25 y439, Existing Builds:
Gui, Add, Button, x25 y455 w320 h25 vBLaunch, Launch Build
Gui, Add, Button, x25 y485 w155 h25 vAddDLLs, Add DLLs
Gui, Add, Button, x190 y485 w155 h25 vBBuild, Build Folder

IniRead, GP01, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton1
IniRead, GP02, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton2
IniRead, GP03, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton3
IniRead, GP04, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton4
IniRead, GP05, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPButtonLabels, GPButton5
Gui, Add, GroupBox, x370 y263 w285 h200, Dynamics/Cloud
Gui, Add, Text, x380 y289, Launch GP:
Gui, Add, Button, x380 y309 w126 h25 gD10 vD10, %GP01%
Gui, Add, Button, x380 y339 w126 h25 gD13 vD13, %GP02%
Gui, Add, Button, x380 y369 w126 h25 gD15 vD15, %GP03%
Gui, Add, Button, x380 y399 w126 h25 gD16 vD16, %GP04%
Gui, Add, Button, x380 y429 w126 h25 gD18 vD18, %GP05%

IniRead, SPC01, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 01
IniRead, SPC02, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 02
IniRead, SPC03, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 03
IniRead, SPC04, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 04
IniRead, SPC05, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 05
Gui, Add, Text, x517 y289, Delete Cloud DB:
Gui, Add, Button, x517 y309 w126 h25 vCloud01, %SPC01%
Gui, Add, Button, x517 y339 w126 h25 vCloud02, %SPC02%
Gui, Add, Button, x517 y369 w126 h25 vCloud03, %SPC03%
Gui, Add, Button, x517 y399 w126 h25 vCloud04, %SPC04%
Gui, Add, Button, x517 y429 w126 h25 vCloud05, %SPC05%

Gui, Add, Text, x430 y484 gIPText, IP Address: 
Gui, Add, Edit, cgray x490 y481 w100 ReadOnly vIP, %A_IPAddress1%

;GuiControl, Disable, AddDLLs ;Disabling controls
;Gui, Color, FF0000, 3366FF ; Attempting to change the GUI color

;--------------------------------------------------------------------------------------------------------------------------
; This loads the settings from the Settings.ini file
;--------------------------------------------------------------------------------------------------------------------------
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

Gui, Color, f9f9f9 ;FFFFFF is pure white
Gui, Show,, Environment Mananger  ; Finally showing the GUI


;--------------------------------------------------------------------------------------------------------------------------
; Loading the list of database folders into the listbox - location pulled from Settings
;--------------------------------------------------------------------------------------------------------------------------
ListBoxDisplay:
IniRead, DBListDisplay, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
    Loop, %DBListDisplay%\*, 2
    {
        GuiControl,, GPBackupsList, %A_LoopFileName%
    }
    return
;--------------------------------------------------------------------------------------------------------------------------
; Clicking the Settings menu option ot CTRL s > Creating the Settings GUI
;--------------------------------------------------------------------------------------------------------------------------
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
    
;--------------------------------------------------------------------------------------------------------------------------
; Loading the Settings values from the Settings.ini file
;--------------------------------------------------------------------------------------------------------------------------
    ; > Calling Functions
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
    IniRead, DBListDisplay, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
        Loop, %DBListDisplay%\*, 2
        {
            GuiControl, 1:, GPBackupsList, %A_LoopFileName%
        }
        return
    return

;--------------------------------------------------------------------------------------------------------------------------
; The actual Settings Screen Controls
;--------------------------------------------------------------------------------------------------------------------------
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
    FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File",GP1Loc)
    Return
    
SelectGP2:
    FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File",GP2Loc)
    Return

SelectGP3:
    FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File",GP3Loc)
    Return

SelectGP4:
    FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File",GP4Loc)
    Return

SelectGP5:
    FileSelect("C:\Program Files (x86)\Microsoft Dynamics","Select a GP Launcher File",GP5Loc)
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

;--------------------------------------------------------------------------------------------------------------------------
; GUI for the about screen
;--------------------------------------------------------------------------------------------------------------------------
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

ButtonCountersScreen:
    IniRead, Restore, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, RestoreDB
    IniRead, Overwrite, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, OverwriteDB
    IniRead, New, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, NewBackup
    IniRead, Delete, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, DeleteBackup
    IniRead, Desktop, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SalesPadDesktop
    IniRead, Mobile, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SalesPadMobile
    IniRead, DC, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, DataCollection
    IniRead, SC, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, ShipCenter
    IniRead, API, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, WebAPI
    IniRead, Web, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, WebPortal
    IniRead, CC, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, CardControl
    IniRead, Launch, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, LaunchBuild
    IniRead, CabWM, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, Cab
    IniRead, GP1CounterScreen, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, GP1
    IniRead, GP2CounterScreen, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, GP2
    IniRead, GP3CounterScreen, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, GP3
    IniRead, GP4CounterScreen, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, GP4
    IniRead, GP5CounterScreen, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, GP5
    IniRead, SPCCounterScreen1, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC1
    IniRead, SPCCounterScreen2, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC2
    IniRead, SPCCounterScreen3, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC3
    IniRead, SPCCounterScreen4, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC4
    IniRead, SPCCounterScreen5, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC5
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

OpenLog:
    Gui, 29:Destroy
    Gui, 29:Add, Edit, x30 y30 w500 h500 ReadOnly cGray vEdit1,
    Gui, 29:Show, w560 h560, Test Log Reader
    FileRead, Log, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Log.txt
    GuiControl, 29:, Edit1, %Log%
    Return

GPBackupsList:
    GuiControlGet, ListBox1
    FileRead, SelectedX, C:\#DBBackups\%ListBox1%\Description.txt
    GuiControl,, DBDescEdit, %SelectedX%
    Return

ButtonRestoreDB:    ; Button to restore the selected DB from the listbox
    IniRead, RestoreCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, RestoreDB
    RestoreCounter += 1
    IniWrite, %RestoreCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, RestoreDB
    GuiControlGet, GPBackupsList
    If GPBackupsList = 
    {
        MsgBox, 16, ERROR, Please select a Backtup to Restore.
        return
    }
    Else
    {
        MsgBox, 4, RESTORE?, Are you sure you want to restore "%GPBackupsList%" over your current databases?
        IfMsgBox, No
            return
        IniRead, Var1, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Server
        IniRead, Var2, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, User
        IniRead, Var3, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Password
        IniRead, Var4, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
        IniRead, Var5, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Dynamics
        IniRead, Var6, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company1
        IniRead, Var7, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company2
        Run, "Scripts\Script.DBRestore.bat" %Var1% %Var2% %Var3% %Var4% "%GPBackupsList%" %Var5% %Var6% %Var7%,, UseErrorLevel
        WinWait, C:\windows\system32\cmd.exe
        WinWaitClose
        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Restored "%GPBackupsList%" backup.`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Log.txt
        MsgBox,, COMPLETED, Database %GPBackupsList% was restored successfully.
        return
    }

ButtonOverwriteDB:  ; Button to override the selected DB from the list
    IniRead, OverwriteCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, OverwriteDB
    OverwriteCounter += 1
    IniWrite, %OverwriteCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, OverwriteDB
    GuiControlGet, GPBackupsList
    If GPBackupsList = 
    {
        MsgBox, 16, ERROR, Please select a Backtup to Overwrite.
        return
    }
    Else
    {
        Gui, OVERWRITE:Destroy
        Gui, OVERWRITE:Add, Progress, x0 y0 w400 h60 BackgroundFFFFFF Disabled, ; TOP WHITE
        Gui, OVERWRITE:Add, Progress, x0 y61 w400 h40 BackgroundF0F0F0 Disabled, ; BOTTOM GRAY
        Gui, OVERWRITE:Add, Text, +BackgroundTrans x15 y25, Are you sure you want to overwrite "DATABASE" with your current setup?
        Gui, OVERWRITE:Add, Button, x223 y67 w75 h23 gOverwriteYes, Yes
        Gui, OVERWRITE:Add, Button, x310 y67 w75 H23 gOverwriteNo, No
        Gui, OVERWRITE:Add, Checkbox, x15 y73 vOverCheck, Update Backup Description 
        Gui, OVERWRITE:Show, w400 h100, OVERWRITE?
        Return

        OverwriteNo:
            Gui, OVERWRITE:Destroy
            Return

        OverwriteYes:
            GuiControlGet, OverCheck
            If OverCheck = 0
            {
                Gui, OVERWRITE:Destroy
                IniRead, Var1, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Server
                IniRead, Var2, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, User
                IniRead, Var3, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Password
                IniRead, Var4, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
                IniRead, Var5, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Dynamics
                IniRead, Var6, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company1
                IniRead, Var7, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company2
                Run, "Scripts\Script.DBOverwrite.bat" %Var1% %Var2% %Var3% %Var4% "%GPBackupsList%" %Var5% %Var6% %Var7%,, UseErrorLevel
                WinWait, C:\windows\system32\cmd.exe
                WinWaitClose
                IniRead, DBPath, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
                FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Overwrote "%GPBackupsList%" backup.`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Log.txt
                FileAppend, `n`n====================================`nBACKUP - %GPBackupsList%`nUPDATED - {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}, %DBPath%\%GPBackupsList%\Description.txt
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
                    IniRead, Var1, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Server
                    IniRead, Var2, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, User
                    IniRead, Var3, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Password
                    IniRead, Var4, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
                    IniRead, Var5, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Dynamics
                    IniRead, Var6, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company1
                    IniRead, Var7, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company2
                    Run, "Scripts\Script.DBOverwrite.bat" %Var1% %Var2% %Var3% %Var4% "%GPBackupsList%" %Var5% %Var6% %Var7%,, UseErrorLevel
                    WinWait, C:\windows\system32\cmd.exe
                    WinWaitClose
                    IniRead, DBPath, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
                    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Overwrote "%GPBackupsList%" backup.`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Log.txt
                    FileAppend, `n`n====================================`nBACKUP - %GPBackupsList%`nUPDATED - {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}`n%DBDescription%, %DBPath%\%GPBackupsList%\Description.txt
                    Return

                OverCancel:
                    Gui, OVERWRITEDESC:Destroy
                    Return
            }
/*
        MsgBox, 4, OVERWRITE?, Are you sure you want to overwrite "%GPBackupsList%" with your current setup?
        IfMsgBox, No
            return
        IniRead, Var1, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Server
        IniRead, Var2, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, User
        IniRead, Var3, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Password
        IniRead, Var4, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
        IniRead, Var5, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Dynamics
        IniRead, Var6, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company1
        IniRead, Var7, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company2
        Run, "Scripts\Script.DBOverwrite.bat" %Var1% %Var2% %Var3% %Var4% "%GPBackupsList%" %Var5% %Var6% %Var7%,, UseErrorLevel
        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Overwrote "%GPBackupsList%" backup.`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Log.txt
        return
        */
    }

ButtonNewBackup:    ; Button to create a new DB and add it to the list
    IniRead, NewCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, NewBackup
    NewCounter += 1
    IniWrite, %NewCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, NewBackup
    Gui, 5:Destroy
    Gui, 5:Add, Text, x15 y15, Database name:
    Gui, 5:Add, Edit, x15 y30 w300 vDatabase, 
    Gui, 5:Add, Text, x15 y60, Description/Notes:
    Gui, 5:Add, Edit, x15 y75 w300 r10 vDBDescription,
    Gui, 5:Add, Button, x100 y220 w100 h25 +Default gOK5, OK
    Gui, 5:Add, Button, x215 y220 w100 h25 gCancel5, Cancel
    Gui, 5:Show, w330 h250, New Database

    return
    
    Cancel5:
        MsgBox, No new Backup was created.
        Gui, 5:Destroy
        Return
    
    OK5:
        IniRead, DBListNew, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
        GuiControlGet, Database
        if Database = 
        {
            MsgBox, 16, ERROR, No Database Name was entered.
            return
        }
        Else
        {
            ;ifExist C:\#DBBackups\%Database%
            ifExist %DBListNew%\%Database%
            {
                MsgBox,, ALREADY EXISTS, A backup named "%Database%" already exists.
                GuiControl,, Database, 
                return
            }
            Else
            {
                MsgBox, 4, CREATE BACKUP?, Are you sure you want to create backup %Database%?
                ifMsgBox, No
                {
                    MsgBox,, CANCEL, No backup was created.
                    GuiControl,, Database, 
                    return
                }
                ifMsgBox, Yes
                {
                    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Created "%Database%" backup.`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Log.txt
                    IniRead, Var1, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Server
                    IniRead, Var2, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, User
                    IniRead, Var3, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, SQLCreds, Password
                    IniRead, Var4, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
                    IniRead, Var5, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Dynamics
                    IniRead, Var6, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company1
                    IniRead, Var7, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, Databases, Company2
                    Run, "Scripts\Script.DBBackup.bat" %Var1% %Var2% %Var3% %Var4% "%Database%" %Var5% %Var6% %Var7%,, UseErrorLevel
                    WinWait, C:\windows\system32\cmd.exe
                    WinWaitClose
                    IniRead, DBPath, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
                    GuiControlGet, Database
                    GuiControlGet, DBDescription
                    FileAppend, ====================================`nBACKUP - %Database%`nCREATED - {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}`n%DBDescription%, %DBPath%\%Database%\Description.txt
                    GuiControl, 1:, GPBackupsList, |
                    IniRead, DBListDisplay, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
                        Loop, %DBListDisplay%\*, 2
                        {
                            GuiControl, 1:, GPBackupsList, %A_LoopFileName%
                        }
                    Gui, 5:Destroy
                    return
                }
            }
        }

ButtonDeleteBackup: ; Button to delete the selected DB from the listbox
    IniRead, DeleteCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, DeleteBackup
    DeleteCounter += 1
    IniWrite, %DeleteCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, DeleteBackup
    IniRead, DBListDelete, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
    GuiControlGet, GPBackupsList
    If GPBackupsList = 
    {
        MsgBox, 16, ERROR, Please select a Backtup to Delete.
        return
    }
    Else
    {
        MsgBox, 4, DELETE?, Are you sure you want to delete backup %GPBackupsList%?
        ifMsgBox, Yes
        {
            FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Deleted "%GPBackupsList%" backup.`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Log.txt
            FileRemoveDir, %DBListDelete%\%GPBackupsList%, 1
            MsgBox,, DELETED, Database %GPBackupsList% was deleted.
            goto, ButtonRefresh
            return
        }
        IfMsgBox, No
        {
            MsgBox,, CANCEL, Backup %GPBackupsList% was not deleted.
            return
        }
    }

ButtonSalesPadDesktop:  ; Button to launch the SPGP build lookup/auto install the build
    IniRead, SPGP, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SalesPadDesktop
    SPGP += 1
    IniWrite, %SPGP%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SalesPadDesktop
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\SalesPad.GP\, Select a SalesPad Build, *.exe
    if ErrorLevel
        Return
    SplitPath, SelectedFile,, Instl
    Gui, 2:Destroy
    Gui, 2:Add, Text, x15 y15, Please enter the location you would like to install the following build to:
    Gui, 2:Add, Edit, cgray x15 y35 w600 ReadOnly, %Instl%
    Gui, 2:Add, Edit, x15 y65 w600 vBuildLoc, C:\Program Files (x86)\SalesPad.Desktop\
    Gui, 2:Add, Text, x136 y95, Extended 
    Gui, 2:Add, Text, x455 y95, Custom
    Gui, 2:Add, ListBox, 8 x15 y115 w285 r15 vExtList
    Gui, 2:Add, ListBox, 8 x330 y115 w285 r15 vCustList
    Gui, 2:Add, GroupBox, x15 y325 w155 h70, Large Custom Projects
    Gui, 2:Add, CheckBox, x30 y345 gGrizzCheck vGrizzValue, Install with Grizzly DLLs
    Gui, 2:Add, CheckBox, x30 y365 gTPGCheck vTPGValue, Install with TPG DLLs
    GUi, 2:Add, GroupBox, x185 y325 w155 h70, Build Options
    Gui, 2:Add, Checkbox, x200 y345 gDBUpdateCheck vDBUpdateValue, Run Database Update
    Gui, 2:Add, Button, x516 y370 w100 h25 gSPGPCan, Cancel
    Gui, 2:Add, Button, Default x405 y370 w100 h25 gSPGPOK, OK
    Gui, 2:Show, w630 h410, Install SalesPad GP
    GuiControl, 2:Disable, TPGValue
    ;GuiControl, 2:Disable, DBUpdateValue
    Loop, %Instl%\ExtModules\WithOutCardControl\*.*
    {
        GuiControl, 2:, ExtList, %A_LoopFileName%
    }
    Loop, %Instl%\CustomModules\WithOutCardControl\*.*
    {
        GuiControl, 2:, CustList, %A_LoopFileName%
    }
    Return

GrizzCheck:
    GuiControlGet, GrizzValue
    If GrizzValue = 1
    {
        MsgBox, 36, GRIZZLY BUILD?, Are you installing a build that requires Grizzly DLLs? `n`nSelecting Yes will only add the DLLs specified in the Grizzly Dlls Script, not any additional DLLs selected in the Extended and Custom Listboxes above.
        IfMsgBox, Yes
        {
            GuiControlGet, TPGValue
            GuiControlGet, DBUpdateValue
            If TPGValue = 1
            {
                GuiControl,,TPGValue,0
            }
            if DBUpdateValue = 1
            {
                GuiControl,,DBUpdateValue,0
            }
            Return
        }
        IfMsgBox, No
        {
            GuiControl,,GrizzValue,0
            Return
        }
    }
    If GrizzValue = 0
    {
        Return
    }

TPGCheck:
    GuiControlGet, TPGValue
    If TPGValue = 1
    {
        MsgBox, 36, TPG BUILD?, Are you installing a build that requires TPG DLLs? `n`nSelecting Yes will only add the DLL's specified in the TPG Dlls Script, not any additional DLLs selected in the Extended and Custom Listboxes above.
        IfMsgBox, Yes
        {
            GuiControlGet, GrizzValue
            GuiControlGet, DBUpdateValue
            If GrizzValue = 1
            {
                GuiControl,,GrizzValue,0
            }
            if DBUpdateValue = 1
            {
                GuiControl,,DBUpdateValue,0
            }
            Return
        }
        IfMsgBox, No
        {
            GuiControl,,TPGValue,0
            Return
        }
    }
    If TPGValue = 0
    {
        Return
    }

DBUpdateCheck:
    GuiControlGet, DBUpdateValue
    If DBUpdateValue = 1
    {
        MsgBox, 36, AUTO RUN DB UPDATE?, Are you sure you want to automatically run the Database Update on the selected build once installed? `n`nSelecting Yes will uncheck the Grizzly and TPG Checkboxes, as it's not wise to automatically run the Database Update for Grizzly or TPG. Be weary of running the Database Update automatically when adding DLLs, as they may cause the udate to fail. `n`n(NOTE: The update will be ran against the TWO Database.)
        IfMsgBox, Yes
        {
            GuiControlGet, TPGValue
            GuiControlGet, GrizzValue
            If TPGValue = 1
            {
                GuiControl,,TPGValue,0
            }
            if GrizzValue = 1
            {
                GuiControl,,GrizzValue,0
            }
            Return
        }
        IfMsgBox, No
        {
            GuiControl,,DBUpdateValue,0
            Return
        }
    }
    If DBUpdateValue = 0
    {
        Return
    }

SPGPOK:
    GuiControlGet, GrizzValue
    GuiControlGet, TPGValue
    GuiControlGet, DBUpdateValue
    GuiControlGet, BuildLoc
    if BuildLoc = C:\Program Files (x86)\SalesPad.Desktop\
    {
        MsgBox, 16, ERROR, Please update the install path to not be the root SalesPad Install path.`n`nFor reference, you can add the branch\buildnumber to the end of the path, easier to sort through your installed builds this way.
        Return
    }
    if FileExist(BuildLoc)
    {
        MsgBox, 20, EXISTS, SalesPad is already installed in the specified location, do you want to override this install?
        IfMsgBox, Yes
        {
            FileRemoveDir, %BuildLoc%, 1
            if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
                FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
            FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS
            FileCopy, %SelectedFile%, C:\#EnvMgr\TEMPFILES\INSTALLERS
            GuiControlGet, BuildLoc
            GuiControlGet, GrizzValue
            GuiControlGet, TPGValue
            GuiControlGet, DBUpdateValue
            IniWrite, %Instl%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Paths.ini, LastInstalledBuild, SPGP
            if GrizzValue = 1
            {
                Gui, 2:Destroy
                Run, "Scripts\SPInstall.bat" "%BuildLoc%"
                WinWait, C:\windows\system32\cmd.exe
                WinWaitClose
                Run, "Scripts\Script.GetGrizzlyDLL.bat" %Instl%
                WinWait, C:\windows\system32\cmd.exe
                WinWaitClose
                FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                While ! FileExist(BuildLoc "\SalesPad.exe")
                {
                    Sleep 250
                }
                Run, %BuildLoc%\SalesPad.exe
                FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                Return
            }
            If TPGValue = 1
            {
                Gui, 2:Destroy
                Run, "Scripts\SPInstall.bat" "%BuildLoc%"
                WinWait, C:\windows\system32\cmd.exe
                WinWaitClose
                Run, "Scripts\Script.GetTPGDLL.bat" %Instl%
                WinWait, C:\windows\system32\cmd.exe
                WinWaitClose
                FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                While ! FileExist(BuildLoc "\SalesPad.exe")
                {
                    Sleep 250
                }
                Run, %BuildLoc%\SalesPad.exe
                FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                Return
            }
            If DBUpdateValue = 1
            {
                GuiControlGet, BuildLoc
                GuiControlGet, ExtList
                GuiControlGet, CustList
                Run, "Scripts\SPInstall.bat" "%BuildLoc%"
                WinWait, C:\windows\system32\cmd.exe
                WinWaitClose
                Run, C:\Users\steve.rodriguez\Desktop\Scripts\sppresetdatabase.bat
                WinWait, C:\windows\system32\cmd.exe
                WinWaitClose
                if ExtList = 
                {
                    if CustList = 
                    {
                        While ! FileExist(BuildLoc "\SalesPad.exe")
                        {
                            Sleep 250
                        }
                        Run, C:\Users\steve.rodriguez\Desktop\Scripts\Test\DBUPDATE Testing\DB Update.bat "%BuildLoc%\SalesPad.exe" "%BuildLoc%"
                        WinWait, C:\windows\system32\cmd.exe
                        WinWaitClose
                        Run, %BuildLoc%\SalesPad.exe
                        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                        Gui, 2:Destroy
                        if FileExist(BuildLoc "\fail_log_TWO_*.txt")
                        {
                            MsgBox, 20, UPDATE FAILED, The Database Update for the following build has failed. Would you like open the crash log?`n`n%BuildLoc%
                            IfMsgBox, Yes
                            {
                                Loop, %BuildLoc%\fail_log_TWO_*.txt
                                {
                                    Run %A_LoopFileName%
                                    Return
                                }
                            }
                        }
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
                        FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                        FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                        While ! FileExist(BuildLoc "\SalesPad.exe")
                        {
                            Sleep 250
                        }
                        Run, C:\Users\steve.rodriguez\Desktop\Scripts\Test\DBUPDATE Testing\DB Update.bat "%BuildLoc%\SalesPad.exe" "%BuildLoc%"
                        WinWait, C:\windows\system32\cmd.exe
                        WinWaitClose
                        Run, %BuildLoc%\SalesPad.exe
                        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                        Gui, 2:Destroy
                        if FileExist(BuildLoc "\fail_log_TWO_*.txt")
                        {
                            MsgBox, 20, UPDATE FAILED, The Database Update for the following build has failed. Would you like open the crash log?`n`n%BuildLoc%
                            IfMsgBox, Yes
                            {
                                Loop, %BuildLoc%\fail_log_TWO_*.txt
                                {
                                    Run %A_LoopFileName%
                                    Return
                                }
                            }
                        }
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
                        FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                        FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                        While ! FileExist(BuildLoc "\SalesPad.exe")
                        {
                            Sleep 250
                        }
                        Run, C:\Users\steve.rodriguez\Desktop\Scripts\Test\DBUPDATE Testing\DB Update.bat "%BuildLoc%\SalesPad.exe" "%BuildLoc%"
                        WinWait, C:\windows\system32\cmd.exe
                        WinWaitClose
                        Run, %BuildLoc%\SalesPad.exe
                        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                        Gui, 2:Destroy
                        if FileExist(BuildLoc "\fail_log_TWO_*.txt")
                        {
                            MsgBox, 20, UPDATE FAILED, The Database Update for the following build has failed. Would you like open the crash log?`n`n%BuildLoc%
                            IfMsgBox, Yes
                            {
                                Loop, %BuildLoc%\fail_log_TWO_*.txt
                                {
                                    Run %A_LoopFileName%
                                    Return
                                }
                            }
                        }
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
                        FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                        FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                        While ! FileExist(BuildLoc "\SalesPad.exe")
                        {
                            Sleep 250
                        }
                        Run, C:\Users\steve.rodriguez\Desktop\Scripts\Test\DBUPDATE Testing\DB Update.bat "%BuildLoc%\SalesPad.exe" "%BuildLoc%"
                        WinWait, C:\windows\system32\cmd.exe
                        WinWaitClose
                        Run, %BuildLoc%\SalesPad.exe
                        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                        Gui, 2:Destroy
                        if FileExist(BuildLoc "\fail_log_TWO_*.txt")
                        {
                            MsgBox, 20, UPDATE FAILED, The Database Update for the following build has failed. Would you like open the crash log?`n`n%BuildLoc%
                            IfMsgBox, Yes
                            {
                                Loop, %BuildLoc%\fail_log_TWO_*.txt
                                {
                                    Run %A_LoopFileName%
                                    Return
                                }
                            }
                        }
                        Return
                    }
                }
            }
            Else
            {
                GuiControlGet, BuildLoc
                GuiControlGet, ExtList
                GuiControlGet, CustList
                Run, "Scripts\SPInstall.bat" "%BuildLoc%"
                WinWait, C:\windows\system32\cmd.exe
                WinWaitClose
                if ExtList = 
                {
                    if CustList = 
                    {
                        While ! FileExist(BuildLoc "\SalesPad.exe")
                        {
                            Sleep 250
                        }
                        Run, %BuildLoc%\SalesPad.exe
                        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                        Gui, 2:Destroy
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
                        FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                        FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                        While ! FileExist(BuildLoc "\SalesPad.exe")
                        {
                            Sleep 250
                        }
                        Run, %BuildLoc%\SalesPad.exe
                        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                        Gui, 2:Destroy
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
                        FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                        FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                        While ! FileExist(BuildLoc "\SalesPad.exe")
                        {
                            Sleep 250
                        }
                        Run, %BuildLoc%\SalesPad.exe
                        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                        Gui, 2:Destroy
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
                        FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                        FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                        While ! FileExist(BuildLoc "\SalesPad.exe")
                        {
                            Sleep 250
                        }
                        Run, %BuildLoc%\SalesPad.exe
                        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                        Gui, 2:Destroy
                        Return
                    }
                }
            }
        }
        IfMsgBox, No
        {
            MsgBox, 0, CANCEL, Install was canceled, existing install was not removed.
            Return
        }
    }
    Else
    {
        if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
            FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
        FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS
        FileCopy, %SelectedFile%, C:\#EnvMgr\TEMPFILES\INSTALLERS
        GuiControlGet, BuildLoc
        GuiControlGet, CheckB
        IniWrite, %Instl%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Paths.ini, LastInstalledBuild, SPGP
        if GrizzValue = 1
        {
            Gui, 2:Destroy
            Run, "Scripts\SPInstall.bat" "%BuildLoc%"
            WinWait, C:\windows\system32\cmd.exe
            WinWaitClose
            Run, "Scripts\Script.GetGrizzlyDLL.bat" %Instl%
            WinWait, C:\windows\system32\cmd.exe
            WinWaitClose
            FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
            FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
            While ! FileExist(BuildLoc "\SalesPad.exe")
            {
                Sleep 250
            }
            Run, %BuildLoc%\SalesPad.exe
            FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
            Return
        }
        If TPGValue = 1
        {
            MsgBox, 16, ERROR, TPG Install isn't currently set up.
            Return
        }
        Else
        {
            GuiControlGet, BuildLoc
            GuiControlGet, ExtList
            GuiControlGet, CustList
            Run, "Scripts\SPInstall.bat" "%BuildLoc%"
            WinWait, C:\windows\system32\cmd.exe
            WinWaitClose
            if ExtList = 
            {
                if CustList = 
                {   
                    While ! FileExist(BuildLoc "\SalesPad.exe")
                    {
                        Sleep 250
                    }
                    Run, %BuildLoc%\SalesPad.exe
                    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                    Gui, 2:Destroy
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
                    FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                    FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                    While ! FileExist(BuildLoc "\SalesPad.exe")
                    {
                        Sleep 250
                    }
                    Run, %BuildLoc%\SalesPad.exe
                    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                    Gui, 2:Destroy
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
                    FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                    FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                    While ! FileExist(BuildLoc "\SalesPad.exe")
                    {
                        Sleep 250
                    }
                    Run, %BuildLoc%\SalesPad.exe
                    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                    Gui, 2:Destroy
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
                    FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
                    FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
                    While ! FileExist(BuildLoc "\SalesPad.exe")
                    {
                        Sleep 250
                    }
                    Run, %BuildLoc%\SalesPad.exe
                    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Instl%`n, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\SPGPInstallLog.txt
                    Gui, 2:Destroy
                    Return
                }
            }
        }
    }

SPGPCan:
    MsgBox, 4, CANCEL, Are you sure you want to cancel?
    IfMsgBox, No
    {
        Return
    }
    IfMsgBox, Yes
    {
        Gui, 2:Destroy
        Return
    }

ButtonSalesPadMobile:   ; Button to launch the SalesPad Mobile selection/installer
    IniRead, MobileCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SalesPadMobile
    MobileCounter += 1
    IniWrite, %MobileCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SalesPadMobile
    FileSelectFile, SelectedFileMobile, 1, \\sp-fileserv-01\Shares\Builds\Ares\Mobile-Server\, Select a SalesPad Server Build, *.exe
    if ErrorLevel
        return
    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
    FileCopy, %SelectedFileMobile%, C:\#EnvMgr\TEMPFILES\INSTALLERS
    SplitPath, SelectedFileMobile,, InstlMobile
    Variable1 := InstlMobile
    Gui, 15:Destroy
    Gui, 15:Add, Text, x30 y40, Please enter the location you would like to install the following build to:
    Gui, 15:Add, Edit, cgray x30 y60 w600 ReadOnly, %InstlMobile%
    Gui, 15:Add, Edit, x30 y90 w600 vBuildLocMobile, C:\Program Files (x86)\SalesPad.GP.Mobile.Server\
    Gui, 15:Add, Button, x420 y120 w100 h25 gCanMobile, Cancel
    Gui, 15:Add, Button, +Default x531 y120 w100 h25 gOKMobile, OK
    Gui, 15:Show, w660 h160, Install SalesPad GP Mobile Server
    return

CanMobile:
    MsgBox, 4, CANCEL, Are you sure you want to cancel?
    IfMsgBox, No
    {
        return
    }
    IfMsgBox, Yes
    {
        Gui, 15:Destroy
        return
    }

OKMobile:
    GuiControlGet, BuildLocMobile
    IniWrite, %InstlMobile%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Paths.ini, LastInstalledBuild, Mobile
    Gui, 15:Destroy
    run, "Scripts\DCSilentInstall.bat" "%BuildLocMobile%"
    WinWait, C:\windows\system32\cmd.exe
    WinWaitClose
    ;MsgBox, 0, Test, %BuildLocMobile%
    Sleep 4000
    Run *RunAs "%BuildLocMobile%\SalesPad.GP.Mobile.Server.exe" ;Looks like Run *RunAs only prompts if the program it's triggered from isn't running as admin
    ;MsgBox, 0, Test, "%BuildLocMobile%\SalesPad.GP.Mobile.Server.exe"
    ;Run, %BuildLocMobile%
    Return

ButtonDataCollection:   ; Button to launch the DC selection/installer
    IniRead, DCCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, DataCollection
    DCCounter += 1
    IniWrite, %DCCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, DataCollection
    FileSelectFile, SelectedFileDC, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection\, Select a DataCollection Build, *.exe
    if ErrorLevel
        return
    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
    FileCopy, %SelectedFileDC%, C:\#EnvMgr\TEMPFILES\INSTALLERS
    SplitPath, SelectedFileDC,, InstlDC
    Variable1 := InstlDC
    Gui, 14:Destroy
    Gui, 14:Add, Text, x15 y15, Please enter the location you would like to install the following build to:
    Gui, 14:Add, Edit, cgray x15 y35 w600 ReadOnly, %InstlDC%
    Gui, 14:Add, Edit, x15 y65 w600 vDCBuildLoc, C:\Program Files (x86)\DataCollection\
    Gui, 14:Add, Button, +Default x400 y95 w100 h25 gDCOK, OK
    Gui, 14:Add, Button, x515 y95 w100 h25 gDCCan, Cancel
    Gui, 14:Show, w630 h125, Install DataCollection
    return

DCCan:
    MsgBox, 4, CANCEL, Are you sure you want to cancel?
    IfMsgBox, No
    {
        return
    }
    IfMsgBox, Yes
    {
        Gui, 14:Destroy
        return
    }

DCOK:
    GuiControlGet, DCBuildLoc
    IniWrite, %InstlDC%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Paths.ini, LastInstalledBuild, DC
    Gui, 14:Destroy
    run, "Scripts\DCSilentInstall.bat" "%DCBuildLoc%"
    WinWait, C:\windows\system32\cmd.exe
    WinWaitClose
    Sleep 4000
    Run *RunAs "%DCBuildLoc%\DataCollection Extended Warehouse.exe"
    ;Run, %DCBuildLoc%
    Return

ButtonWindowsMobile:
    IniRead, CabDestination, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BuildManagement, SharedLocation
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
    IniRead, CabCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, Cab
    CabCounter += 1
    IniWrite, %CabCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, Cab
    FileSelectFile, CabFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection\, Select a Windows Mobile file to move, *.cab
    if CabFile = 
    {
        MsgBox, 16, ERROR, Nothing was selected.
        Return
    }
    if CabFile !=
    {
        FileCopy, %CabFile%, %CabDestination%
        Return
    }
    Return

ButtonShipCenter:   ; Button to launch the ShipCenter selection/installer
    IniRead, ShipCenterCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, ShipCenter
    ShipCenterCounter += 1
    IniWrite, %ShipCenterCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, ShipCenter
    FileSelectFile, SelectedFileSC, 1, \\sp-fileserv-01\Shares\Builds\ShipCenter\, Select a ShipCenter Build, *.exe
    if ErrorLevel
        return
    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
    FileCopy, %SelectedFileSC%, C:\#EnvMgr\TEMPFILES\INSTALLERS
    SplitPath, SelectedFileSC,, InstlSC
    Variable1 := InstlSC
    Gui, 16:Destroy
    Gui, 16:Add, Text, x30 y40, Please enter the location you would like to install the following build to:
    Gui, 16:Add, Edit, cgray x30 y60 w600 ReadOnly, %InstlSC%
    Gui, 16:Add, Edit, x30 y90 w600 vBuildLocSC, C:\Program Files (x86)\ShipCenter\
    Gui, 16:Add, Button, x420 y120 w100 h25 gCanSC, Cancel
    Gui, 16:Add, Button, +Default x531 y120 w100 h25 gOKSC, OK
    Gui, 16:Show, w660 h160, Install Ship Center
    return

CanSC:
    MsgBox, 4, CANCEL, Are you sure you want to cancel?
    IfMsgBox, No
    {
        return
    }
    IfMsgBox, Yes
    {
        Gui, 16:Destroy
        return
    }

OKSC:
    GuiControlGet, BuildLocSC
    IniWrite, %InstlSC%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Paths.ini, LastInstalledBuild, SC
    Gui, 16:Destroy
    run, "Scripts\DCSilentInstall.bat" "%BuildLocSC%"
    WinWait, C:\windows\system32\cmd.exe
    WinWaitClose
    Sleep 4000
    Run *RunAs "%BuildLocSC%\SalesPad.ShipCenter.exe"
    ;Run, %BuildLocSC%
    Return

ButtonCardControl:  ; Button to launch the CardControl selection/installer
    IniRead, CardControlCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, CardControl
    CardControlCounter += 1
    IniWrite, %CardControlCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, CardControl
    FileSelectFile, SelectedFileCC, 1, \\sp-fileserv-01\Shares\Builds\Ares\, Select a Card Control Build, *.exe
    if ErrorLevel
        return
    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
    FileCopy, %SelectedFileCC%, C:\#EnvMgr\TEMPFILES\INSTALLERS
    SplitPath, SelectedFileCC,, InstlCC
    Variable1 := InstlCC
    Gui, 17:Destroy
    Gui, 17:Add, Text, x30 y40, Please enter the location you would like to install the following build to:
    Gui, 17:Add, Edit, cgray x30 y60 w600 ReadOnly, %InstlCC%
    Gui, 17:Add, Edit, x30 y90 w600 vBuildLocCC, C:\Program Files (x86)\CardControl
    Gui, 17:Add, Button, x420 y120 w100 h25 gCanCC, Cancel
    Gui, 17:Add, Button, +Default x531 y120 w100 h25 gOKCC, OK
    Gui, 17:Show, w660 h160, Install Card Control
    return

CanCC:
    MsgBox, 4, CANCEL, Are you sure you want to cancel?
    IfMsgBox, No
    {
        return
    }
    IfMsgBox, Yes
    {
        Gui, 17:Destroy
        return
    }

OKCC:
    GuiControlGet, BuildLocCC
    IniWrite, %InstlCC%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Paths.ini, LastInstalledBuild, CC
    Gui, 17:Destroy
    run, "Scripts\DCSilentInstall.bat" "%BuildLocCC%"
    WinWait, C:\windows\system32\cmd.exe
    WinWaitClose
    Sleep 4000
    Run, "%BuildLocCC%\CardControl.exe"
    Return

ButtonWebAPI:
    IniRead, APICounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, WebAPI
    APICounter += 1
    IniWrite, %APICounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, WebAPI
    FileSelectFile, SelectedAPI , 1, \\sp-fileserv-01\Shares\Builds\SalesPad.WebApi\, Select a WebAPI Build, *.msi
    if ErrorLevel
        return
    SplitPath, SelectedAPI, APIInstaller
    If FileExist("C:\inetpub\wwwroot\SalesPadWebAPI\*.msi")
    {
        Run, Scripts\Uninstall.bat - Shortcut.lnk
        WinWaitActive, SalesPad WebAPI Setup, Welcome to the SalesPad WebAPI Setup Wizard
        ControlClick, &Next, SalesPad WebAPI Setup, Welcome to the SalesPad WebAPI Setup Wizard
        WinWaitActive, SalesPad WebAPI Setup, SalesPad WebAPI cannot be repaired
        ControlClick, &Remove, SalesPad WebAPI Setup, SalesPad WebAPI cannot be repaired
        WinWaitActive, SalesPad WebAPI Setup, Ready to remove SalesPad WebAPI
        ControlClick, &Remove, SalesPad WebAPI Setup, Ready to remove SalesPad WebAPI
        WinWaitActive, SalesPad WebAPI Setup, Completed the SalesPad WebAPI Setup Wizard
        ControlClick, &Finish, SalesPad WebAPI Setup, Completed the SalesPad WebAPI Setup Wizard
        WinWaitClose, SalesPad WebAPI Setup
        FileDelete, C:\inetpub\wwwroot\SalesPadWebAPI\*.msi
        if FileExist("C:\inetpub\wwwroot\SalesPadWebAPI")
        {
            FileRemoveDir, C:\inetpub\wwwroot\SalesPadWebAPI, 1
        }
        FileCreateDir, C:\inetpub\wwwroot\SalesPadWebAPI
        FileCopy, %SelectedAPI%, C:\inetpub\wwwroot\SalesPadWebAPI
        Run, C:\inetpub\wwwroot\SalesPadWebAPI\%APIInstaller%
        WinWaitActive, SalesPad WebAPI Setup, Click Next to continue or Cancel to exit the Setup Wizard
        ControlClick, &Next, SalesPad WebAPI Setup, Click Next to continue or Cancel to exit the Setup Wizard
        WinWaitActive, SalesPad WebAPI Setup, Please read the following license agreement carefully
        ControlClick, Button1, SalesPad WebAPI Setup, Please read the following license agreement carefully
        ControlClick, &Next, SalesPad WebAPI Setup, Please read the following license agreement carefully
        WinWaitActive, SalesPad WebAPI Setup, Click Next to install to the default folder or click Change to choose another
        ControlClick, &Next, SalesPad WebAPI Setup, Click Next to install to the default folder or click Change to choose another
        WinWaitActive, Web.Config Setup, Setup the connection string and service information in the Web.Config file
        ControlSend, RichEdit20W1, 10.50.0.45\SQLSERVER2016, Web.Config Setup, Setup the connection string and service information in the Web.Config file
        ControlClick, Next, Web.Config Setup, Setup the connection string and service information in the Web.Config file
        WinWaitActive, IIS Setup, Setup the IIS Website
        ControlSetText, RichEdit20W2, 49403, IIS Setup, Setup the IIS Website
        ControlSend, RichEdit20W3, steve.rodriguez, IIS Setup, Setup the IIS Website
        ControlSend, Edit1, S@lespad1, IIS Setup, Setup the IIS Website
        ControlSend, RichEdit20W4, SALESPAD, IIS Setup, Setup the IIS Website
        ControlClick, RichEdit20W1, IIS Setup, Setup the IIS Website
        ;Send, {Tab}
        ;Send, {Tab}
        ;Send, {Tab}
        ;Send, {Tab}
        ControlClick, Next, IIS Setup, Setup the IIS Website
        Sleep 500
        WinWaitActive, SalesPad WebAPI Setup, Click Cancel to exit the wizard
        ControlClick, &Install, SalesPad WebAPI Setup, Click Cancel to exit the wizard
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
        WinWaitActive, SalesPad WebAPI Setup, Click Next to continue or Cancel to exit the Setup Wizard
        ControlClick, &Next, SalesPad WebAPI Setup, Click Next to continue or Cancel to exit the Setup Wizard
        WinWaitActive, SalesPad WebAPI Setup, Please read the following license agreement carefully
        ControlClick, Button1, SalesPad WebAPI Setup, Please read the following license agreement carefully
        ControlClick, &Next, SalesPad WebAPI Setup, Please read the following license agreement carefully
        WinWaitActive, SalesPad WebAPI Setup, Click Next to install to the default folder or click Change to choose another
        ControlClick, &Next, SalesPad WebAPI Setup, Click Next to install to the default folder or click Change to choose another
        WinWaitActive, Web.Config Setup, Setup the connection string and service information in the Web.Config file
        ControlSend, RichEdit20W1, 10.50.0.45\SQLSERVER2016, Web.Config Setup, Setup the connection string and service information in the Web.Config file
        ControlClick, Next, Web.Config Setup, Setup the connection string and service information in the Web.Config file
        WinWaitActive, IIS Setup, Setup the IIS Website
        ControlSetText, RichEdit20W2, 49403, IIS Setup, Setup the IIS Website
        ControlSend, RichEdit20W3, steve.rodriguez, IIS Setup, Setup the IIS Website
        ControlSend, Edit1, S@lespad1, IIS Setup, Setup the IIS Website
        ControlSend, RichEdit20W4, SALESPAD, IIS Setup, Setup the IIS Website
        ControlClick, RichEdit20W1, IIS Setup, Setup the IIS Website
        Send, {Tab}
        Send, {Tab}
        Send, {Tab}
        Send, {Tab}
        Send, {Tab}
        ControlClick, Next, IIS Setup, Setup the IIS Website
        ;Sleep 500
        WinWaitActive, SalesPad WebAPI Setup, Click Cancel to exit the wizard
        ControlClick, &Install, SalesPad WebAPI Setup, Click Cancel to exit the wizard
        Return
    }

ButtonWebPortal:
    IniRead, WebCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, WebPortal
    WebCounter += 1
    IniWrite, %WebCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, WebPortal
    FileSelectFile, SelectWeb, 1, \\sp-fileserv-01\Shares\Builds\Web-Portal\GP\, Select a GPWEB Build, *.zip
    SplitPath, SelectWeb,, WebBuild
    Run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Scripts\Script.WEB.bat - Shortcut.lnk" %WebBuild%
    ;WinWaitActive, C:\windows\system32\cmd.exe
    ;WinWaitClose, C:\windows\system32\cmd.exe
    ;MsgBox, 0, COMPLETE, %WebBuild% was successfully installed!
    Return

ButtonAddDLLs: ; Button to ADD Dlls -- needs work, should pull from the Get DLLs plugin
    run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\DLLGrabTool\DLL Grab.exe"
    return

ButtonBuildFolder:  ; Launches the SP install folder
    MsgBox, 4, OPEN FOLDER, Do you want to open the Builds Folder?
    IfMsgBox, No
        return
    Run, C:\Program Files (x86)\SalesPad.Desktop
    return


ButtonLaunchBuild:  ; Opens a fileselectfile window allowing the user to choose an installed build to launch
    IniRead, LaunchBuildCounter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, LaunchBuild
    LaunchBuildCounter += 1
    IniWrite, %LaunchBuildCounter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, LaunchBuild
    FileSelectFile, SelectedFile, 1, C:\Program Files (x86)\SalesPad.Desktop\, Select a Build, *.exe
    if ErrorLevel
        return
    run, %SelectedFile%
    return

ButtonRefresh:  ; Refreshes the Listbox
    GuiControl,, GPBackupsList, |
    goto, ListBoxDisplay
    Return

ButtonBackupsFolder:    ; Launches the folder the DB backups are restored in -- needs update, should pull location from Settings.ini
    IniRead, DBListFolder, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, BackupFolder, path
    MsgBox, 4, OPEN FOLDER, Do you want to open the Database Backups Folder?
    IfMsgBox, No
        return
    Run, %DBListFolder%
    Return

D10:
    return

D13:
    return

D15:
    return

D16:    ; Launches GP 2016
    IniRead, GP4Counter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, GP4
    GP4Counter += 1
    IniWrite, %GP4Counter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, GP4
    IniRead, D16Location, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, GPLaunchFile, GPLaunch4
    if GetKeyState("Shift","P")
        Run, "C:\Program Files (x86)\Microsoft Dynamics\GP2016"
    else
        ;Run, %D16Location%
        run, "C:\Program Files (x86)\Microsoft Dynamics\GP2016\Dynamics - Shortcut.lnk"
    Return

D18:
    return

IPText:
    GuiControl,, IP, %A_IPAddress1%
    ;MsgBox, 0, test, this is a test %A_IPAddress1%
    return

;--------------------------------------------------------------------------------------------------------------------------
; Delete the DB files for local tenants
;--------------------------------------------------------------------------------------------------------------------------
ButtonSteveRodriguez01:
    IniRead, SPC01Counter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC1
    SPC01Counter += 1
    IniWrite, %SPC01Counter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC1
    IniRead, 01Delete, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 01
    MsgBox, 4, RUN, Do you want to Delete %01Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "Scripts\Script.DropSR01.bat" %01Delete%
        ;run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\0TestSPCName.bat" %01Delete%
        return
    }

ButtonSteveRodriguez02:
    IniRead, SPC02Counter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC2
    SPC02Counter += 1
    IniWrite, %SPC02Counter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC2
    IniRead, 02Delete, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 02
    MsgBox, 4, RUN, Do you want to Delete %02Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "Scripts\Script.DropSR01.bat" %02Delete%
        return
    }

ButtonSteveRodriguez03:
    IniRead, SPC03Counter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC3
    SPC03Counter += 1
    IniWrite, %SPC03Counter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC3
    IniRead, 03Delete, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 03
    MsgBox, 4, RUN, Do you want to Delete %03Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "Scripts\Script.DropSR01.bat" %03Delete%
        return
    }

ButtonSteveRodriguez04:
    IniRead, SPC04Counter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC4
    SPC04Counter += 1
    IniWrite, %SPC04Counter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC4
    IniRead, 04Delete, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 04
    MsgBox, 4, RUN, Do you want to Delete %04Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "Scripts\Script.DropSR01.bat" %04Delete%
        return
    }

ButtonSteveRodriguez05:
    IniRead, SPC05Counter, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC5
    SPC05Counter += 1
    IniWrite, %SPC05Counter%, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\ButtonCounters.ini, ButtonCounters, SPC5
    IniRead, 05Delete, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, CloudButtonNames, 05
    MsgBox, 4, RUN, Do you want to Delete %05Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "Scripts\Script.DropSR01.bat" %05Delete%
        return
    }

Utilities:
    If A_UserName = steve.rodriguez
    {
        run, "C:\Users\steve.rodriguez\Desktop\Scripts\SteveUtilities.ahk"
        return
    }
    Else
    {
        MsgBox, 16, ERROR, You don't have access to this feature.
        Return
    }


BuildOriginPath:
    Run, "C:\Users\steve.rodriguez\Desktop\Scripts\Projects\Build Origin Paths\BuildOriginPaths.ahk"
    Return

MoveChanges:
    If A_UserName = steve.rodriguez
    {
        MsgBox, 4, MOVE CHANGES?, Are you sure you want to pull the current branch files to Environment Manager?
        IfMsgBox, Yes
        {
            if FileExist("C:\Environment Manager")
            {
                FileRemoveDir, C:\Environment Manager, 1
            }
            FileCreateDir, C:\Environment Manager
            FileCopyDir, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-, C:\Environment Manager, 1
            MsgBox, 0, MOVED, Files were moved.
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }
    Else
    {
        MsgBox, 16, ERROR, You don't have access to this feature.
        Return
    }


GuiClose:
Exit1:
    IniRead, PromptToClose, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, PromptClose, Close
    if PromptToClose = 1
    {
        MsgBox, 4, CLOSE?, Are you sure you want to close Environment Manager?
        IfMsgBox, No
        {
            Return
        }
        IfMsgBox, Yes
        {
            ExitApp
        }
    }
    if PromptToClose = 0
    {
        ExitApp
    }