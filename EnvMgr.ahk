; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Script Function: A tool used for managing/creating SQL Database Backups, as well as installing builds
; of the different SalesPad Applications. 

#SingleInstance, force
#NoEnv
SendMode Input
;--------------------------------------------------------------------------------------------------------------------------
; Creating the first GUI
;--------------------------------------------------------------------------------------------------------------------------

Menu, FileMenu, Add, E&xit, MenuHandler
Menu, FileMenu, Add, Settings`tCtrl+S, SettingsScreen

Menu, HelpMenu, Add, &About, AboutScreen
Menu, HelpMenu, Add, &Counters, ButtonCountersScreen

Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Menu, MyMenuBar 

Gui, Add, Button, x592 y387 w100 h30 gExit1 vExit1, Exit
Gui, Add, Text, x15 y395 gIPText, IP Address: 
Gui, Add, Edit, cgray x75 y392 w100 ReadOnly vIP, %A_IPAddress1%
Gui, Add, GroupBox, x15 y5 w345 h254, Database Management
Gui, Add, GroupBox, x369 y5 w322 h254, Build Management
Gui, Add, GroupBox, x15 y261 w676 h60, Dynamics GP
Gui, Add, GroupBox, x15 y323 w676 h60, SPC SQL Database Management

Gui, Add, Text, x24 y31 gUtilities, Select a Database:
Gui, Add, Button, x145 y21 w100 h25 vRefresh, Refresh 
Gui, Add, ListBox, vGPBackupsList gGPBackupsList x25 y52 w220 r15
Gui, Add, Button, x253 y51 w100 h25 vBRest, Restore DB
Gui, Add, Button, x253 y81 w100 h25 vBOver, Overwrite DB
Gui, Add, Button, x253 y141 w100 h25 vDelete, Delete Backup
Gui, Add, Button, x253 y227 w100 h25 vBakFolder, Backups Folder
Gui, Add, Button, x253 y111 w100 h25 vBak, New Backup

Gui, Add, Text, x376 y31, Select a SalesPad Product to Install:
Gui, Add, Text, x376 y174 w308 0x10 ;Horizontal Line
Gui, Add, Text, x376 y181, Existing Builds:
Gui, Add, Button, x376 y51 w150 h25 vBDesktop, SalesPad Desktop
Gui, Add, Button, x534 y51 w150 h25 vBMobile, SalesPad Mobile
Gui, Add, Button, x376 y81 w150 h25 vBDataCollection, Data Collection
Gui, Add, Button, x376 y111 w150 h25 vBShipCenter, Ship Center
Gui, Add, Button, x534 y141 w150 h25 vBCardControl, Card Control
Gui, Add, Button, x534 y81 w150 h25 vGPAPI, Web API
Gui, Add, Button, x534 y111 w150 h25 vGPWEB, Web Portal 
Gui, Add, Button, x376 y197 w308 h25 vBLaunch, Launch Build
Gui, Add, Button, x376 y227 w150 h25 vAddDLLs, Add DLLs
Gui, Add, Button, x534 y227 w150 h25 vBBuild, Build Folder

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

;GuiControl, Disable, AddDLLs ;Disabling controls
;Gui, Color, FF0000, 3366FF ; Attempting to change the GUI color

;--------------------------------------------------------------------------------------------------------------------------
; This loads the settings from the Settings.ini file
;--------------------------------------------------------------------------------------------------------------------------
; > Functions
LoadFromSettings(SettingsOutput,Section,Key,CheckboxName,ButtonName) ; This function is designed to load values from settings.ini
{
    IniRead, %SettingsOutput%, Settings\Settings.ini, %Section%, %Key%
    GuiControl, 4:, %CheckboxName%, %SettingsOutput%
    if %SettingsOutput% = 1
    {
        GuiControl, 1:Disable, %ButtonName%
    }
}

LoadSettingsScreen(SettingsInput,Section,Key,Field)
{
    IniRead, SettingsInput, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, %Section%, %Key%
    GuiControl, 4:, %Field%, %SettingsInput%
}

SaveSettingsEdit(FieldToSave,Section,Key)
{
    IniWrite, %FieldToSave%, Settings\Settings.ini, %Section%, %Key%
}

SaveSettingsCheckbox(FieldToSave,Section,Key,ButtonName)
{
    GuiControlGet, %FieldToSave%, 4:
    IniWrite, %FieldToSave%, Path, %Section%, %Key%
    If %FieldToSave% = 1
    {
        GuiControl, 1:Disable, %ButtonName%
    }
}

SaveSettingsEditAndButton(FieldToSave,Section,Key,ButtonName)
{
    GuiControlGet, %FieldToSave%, 4:
    IniWrite, %FieldToSave%, Path, %Section%, %Key%
    GuiControl, 1:, %ButtonName%, %FieldToSave%
}

; > Loading Settings
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

Gui, Color, f9f9f9
Gui, Show, w706 h421, Environment Mananger  ; Finally showing the GUI

;--------------------------------------------------------------------------------------------------------------------------
; Loading the list of database folders into the listbox - location pulled from Settings
;--------------------------------------------------------------------------------------------------------------------------
ListBoxDisplay:
IniRead, DBListDisplay, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
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
    ;Gui, 4:Add, Text, x0 y10 w683 0x10 ;Horizontal Line
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
    Gui, 4:Add, Checkbox, x30 y175 vDisableCC, Disable Card Control Button
    Gui, 4:Add, Checkbox, x300 y55 vDisableAPI, Disable Web API Button
    Gui, 4:Add, Checkbox, x300 y85 vDisableWeb, Disable Web Portal Button
    Gui, 4:Add, Checkbox, x300 y115 vDisableLaunch, Disable Launch Build Button
    Gui, 4:Add, Checkbox, x300 y145 vDisableAdd, Disable Add DLLs Button
    Gui, 4:Add, Checkbox, x300 y175 vDisableBuild, Disable Build Folder Button
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
    ; => Maybe have to add a crap ton of GuiControlGets (BackupPath, Servname etc
    ;SaveSettingsEdit(BackupPath,"BackupFolder","path")
    GuiControlGet, ServName, 4:
    SaveSettingsEdit(ServName,"SQLCreds","Server")
    ;SaveSettingsEdit(ServUN,"SQLCreds","User")
    ;SaveSettingsEdit(ServPW,"SQLCreds","Password")
    ;SaveSettingsEdit(DynamicsDB,"Databases","Dynamics")
    ;SaveSettingsEdit(RegDB,"Databases","Company1")
    ;SaveSettingsEdit(MBDB,"Databases","Company2")
    ;SaveSettingsEdit(GP1Loc,"GPLaunchFile","GPLaunch1")
    ;SaveSettingsEdit(GP2Loc,"GPLaunchFile","GPLaunch2")
    ;SaveSettingsEdit(GP3Loc,"GPLaunchFile","GPLaunch3")
    ;SaveSettingsEdit(GP4Loc,"GPLaunchFile","GPLaunch4")
    ;SaveSettingsEdit(GP5Loc,"GPLaunchFile","GPLaunch5")
    ;SaveSettingsEdit(PromptCloseBox,"PromptClose","Close")
    ;SaveSettingsCheckbox(CheckRestore,"DBManagement","Rest","BRest")
    ;SaveSettingsCheckbox(CheckOverwrite,"DBManagement","Over","BOver")
    ;SaveSettingsCheckbox(CheckDelete,"DBManagement","Delete","Delete")
    ;SaveSettingsCheckbox(CheckNew,"DBManagement","New","Bak")
    ;SaveSettingsCheckbox(DisableSP,"BuildManagement","SalesPad","BDesktop")
    ;SaveSettingsCheckbox(DisableDC,"BuildManagement","DataCollection","BDataCollection")
    ;SaveSettingsCheckbox(DisableSC,"BuildManagement","ShipCenter","BShipCenter")
    ;SaveSettingsCheckbox(DisableMOB,"BuildManagement","Mobile","BMobile")
    ;SaveSettingsCheckbox(DisableCC,"BuildManagement","CardControl","BCardControl")
    ;SaveSettingsCheckbox(DisableAPI,"BuildManagement","API","GPAPI")
    ;SaveSettingsCheckbox(DisableWeb,"BuildManagement","Web","GPWEB")
    ;SaveSettingsCheckbox(DisableLaunch,"BuildManagement","Launch","BLaunch")
    ;SaveSettingsCheckbox(DisableAdd,"BuildManagement","Add","AddDLLs")
    ;SaveSettingsCheckbox(DisableBuild,"BuildManagement","Build","BBuild")
    ;SaveSettingsCheckbox(CheckDyn10,"GPButtons","Dynamics10","D10")
    ;SaveSettingsCheckbox(CheckDyn13,"GPButtons","Dynamics13","D13")
    ;SaveSettingsCheckbox(CheckDyn15,"GPButtons","Dynamics15","D15")
    ;SaveSettingsCheckbox(CheckDyn16,"GPButtons","Dynamics16","D16")
    ;SaveSettingsCheckbox(CheckDyn18,"GPButtons","Dynamics18","D18")
    ;SaveSettingsCheckbox(CheckSPC1,"SPCButtons","Cloud1","Cloud01")
    ;SaveSettingsCheckbox(CheckSPC2,"SPCButtons","Cloud2","Cloud02")
    ;SaveSettingsCheckbox(CheckSPC3,"SPCButtons","Cloud3","Cloud03")
    ;SaveSettingsCheckbox(CheckSPC4,"SPCButtons","Cloud4","Cloud04")
    ;SaveSettingsCheckbox(CheckSPC5,"SPCButtons","Cloud5","Cloud05")
    ;SaveSettingsEditAndButton(CloudLabel01,"CloudButtonNames","01","Cloud01")
    ;SaveSettingsEditAndButton(CloudLabel02,"CloudButtonNames","02","Cloud02")
    ;SaveSettingsEditAndButton(CloudLabel03,"CloudButtonNames","03","Cloud03")
    ;SaveSettingsEditAndButton(CloudLabel04,"CloudButtonNames","04","Cloud04")
    ;SaveSettingsEditAndButton(CloudLabel05,"CloudButtonNames","05","Cloud05")
    ;SaveSettingsEditAndButton(GPLabel1,"GPButtonLabels","GPButton1","D10")
    ;SaveSettingsEditAndButton(GPLabel2,"GPButtonLabels","GPButton2","D13")
    ;SaveSettingsEditAndButton(GPLabel3,"GPButtonLabels","GPButton3","D15")
    ;SaveSettingsEditAndButton(GPLabel4,"GPButtonLabels","GPButton4","D16")
    ;SaveSettingsEditAndButton(GPLabel5,"GPButtonLabels","GPButton5","D18")
    Return

/*
    GuiControlGet, BackupPath, 4:
    IniWrite, %BackupPath%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
    GuiControlGet, ServName, 4:
    IniWrite, %ServName%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Server
    GuiControlGet, ServUN, 4:
    IniWrite, %ServUN%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, User
    GuiControlGet, ServPW, 4:
    IniWrite, %ServPW%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Password
    GuiControlGet, DynamicsDB, 4:
    IniWrite, %DynamicsDB%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Dynamics
    GuiControlGet, RegDB, 4:
    IniWrite, %RegDB%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company1
    GuiControlGet, MBDB, 4:
    IniWrite, %MBDB%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company2


    GuiControlGet, CheckRestore, 4:
    IniWrite, %CheckRestore%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, Rest
    if CheckRestore = 1
    {
        GuiControl, 1:Disable, BRest
    }
    Else
    {
        GuiControl, 1:Enable, BRest
    }
    GuiControlGet, CheckOverwrite, 4:
    IniWrite, %CheckOverwrite%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, Over
    if CheckOverwrite = 1
    {
        GuiControl, 1:Disable, BOver
    }
    Else
    {
        GuiControl, 1:Enable, BOver
    }
    GuiControlGet, CheckDelete, 4:
    IniWrite, %CheckDelete%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, Delete
    if CheckDelete = 1
    {
        GuiControl, 1:Disable, Delete
    }
    Else
    {
        GuiControl, 1:Enable, Delete
    }
    GuiControlGet, CheckNew, 4:
    IniWrite, %CheckNew%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, New
    if CheckNew = 1
    {
        GuiControl, 1:Disable, Bak
    }
    Else
    {
        GuiControl, 1:Enable, Bak
    }



    GuiControlGet, DisableSP, 4:
    IniWrite, %DisableSP%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, SalesPad
    if DisableSP = 1
    {
        GuiControl, 1:Disable, BDesktop
    }
    Else
    {
        GuiControl, 1:Enable, BDesktop
    }
    GuiControlGet, DisableDC, 4:
    IniWrite, %DisableDC%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, DataCollection
    if DisableDC = 1
    {
        GuiControl, 1:Disable, BDataCollection
    }
    Else
    {
        GuiControl, 1:Enable, BDataCollection
    }
    GuiControlGet, DisableSC, 4:
    IniWrite, %DisableSC%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, ShipCenter
    if DisableSC = 1
    {
        GuiControl, 1:Disable, BShipCenter
    }
    Else
    {
        GuiControl, 1:Enable, BShipCenter
    }
    GuiControlGet, DisableMOB, 4:
    IniWrite, %DisableMOB%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Mobile
    if DisableMOB = 1
    {
        GuiControl, 1:Disable, BMobile
    }
    Else
    {
        GuiControl, 1:Enable, BMobile
    }
    GuiControlGet, DisableCC, 4:
    IniWrite, %DisableCC%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, CardControl
    if DisableCC = 1
    {
        GuiControl, 1:Disable, BCardControl
    }
    Else
    {
        GuiControl, 1:Enable, BCardControl
    }
    GuiControlGet, DisableAPI, 4:
    IniWrite, %DisableAPI%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, API
    if DisableAPI = 1
    {
        GuiControl, 1:Disable, GPAPI
    }
    Else
    {
        GuiControl, 1:Enable, GPAPI
    }
    GuiControlGet, DisableWeb, 4:
    IniWrite, %DisableWeb%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Web
    if DisableWeb = 1
    {
        GuiControl, 1:Disable, GPWEB
    }
    Else
    {
        GuiControl, 1:Enable, GPWEB
    }
    GuiControlGet, DisableLaunch, 4:
    IniWrite, %DisableLaunch%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Launch
    if DisableLaunch = 1
    {
        GuiControl, 1:Disable, BLaunch
    }
    Else
    {
        GuiControl, 1:Enable, BLaunch
    }
    GuiControlGet, DisableAdd, 4:
    IniWrite, %DisableAdd%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Add
    if DisableAdd = 1
    {
        GuiControl, 1:Disable, AddDLLs
    }
    Else
    {
        GuiControl, 1:Enable, AddDLLs
    }
    GuiControlGet, DisableBuild, 4:
    IniWrite, %DisableBuild%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Build
    if DisableBuild = 1
    {
        GuiControl, 1:Disable, BBuild
    }
    Else
    {
        GuiControl, 1:Enable, BBuild
    }



    GuiControlGet, CheckDyn10, 4:
    IniWrite, %CheckDyn10%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics10
    if CheckDyn10 = 1
    {
        GuiControl, 1:Disable, D10
    }
    Else
    {
        GuiControl, 1:Enable, D10
    }
    GuiControlGet, CheckDyn13, 4:
    IniWrite, %CheckDyn13%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics13
    if CheckDyn13 = 1
    {
        GuiControl, 1:Disable, D13
    }
    Else
    {
        GuiControl, 1:Enable, D13
    }
    GuiControlGet, CheckDyn15, 4:
    IniWrite, %CheckDyn15%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics15
    if CheckDyn15 = 1
    {
        GuiControl, 1:Disable, D15
    }
    Else
    {
        GuiControl, 1:Enable, D15
    }
    GuiControlGet, CheckDyn16, 4:
    IniWrite, %CheckDyn16%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics16
    if CheckDyn16 = 1
    {
        GuiControl, 1:Disable, D16
    }
    Else
    {
        GuiControl, 1:Enable, D16
    }
    GuiControlGet, CheckDyn18, 4:
    IniWrite, %CheckDyn18%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics18
    if CheckDyn18 = 1
    {
        GuiControl, 1:Disable, D18
    }
    Else
    {
        GuiControl, 1:Enable, D18
    }


    
    GuiControlGet, CheckSPC1, 4:
    IniWrite, %CheckSPC1%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud1
    if CheckSPC1 = 1
    {
        GuiControl, 1:Disable, Cloud01
    }
    Else
    {
        GuiControl, 1:Enable, Cloud01
    }
    GuiControlGet, CheckSPC2, 4:
    IniWrite, %CheckSPC2%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud2
    if CheckSPC2 = 1
    {
        GuiControl, 1:Disable, Cloud02
    }
    Else
    {
        GuiControl, 1:Enable, Cloud02
    }
    GuiControlGet, CheckSPC3, 4:
    IniWrite, %CheckSPC3%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud3
    if CheckSPC3 = 1
    {
        GuiControl, 1:Disable, Cloud03
    }
    Else
    {
        GuiControl, 1:Enable, Cloud03
    }
    GuiControlGet, CheckSPC4, 4:
    IniWrite, %CheckSPC4%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud4
    if CheckSPC4 = 1
    {
        GuiControl, 1:Disable, Cloud04
    }
    Else
    {
        GuiControl, 1:Enable, Cloud04
    }
    GuiControlGet, CheckSPC5, 4:
    IniWrite, %CheckSPC5%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud5
    if CheckSPC5 = 1
    {
        GuiControl, 1:Disable, Cloud05
    }
    Else
    {
        GuiControl, 1:Enable, Cloud05
    }

    GuiControlGet, PromptCloseBox, 4:
    IniWrite, %PromptCloseBox%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, PromptClose, Close



    GuiControlGet, CloudLabel01, 4:
    IniWrite, %CloudLabel01%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 01
    GuiControl, 1:, Cloud01, %CloudLabel01%
    GuiControlGet, CloudLabel02, 4:
    IniWrite, %CloudLabel02%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 02
    GuiControl, 1:, Cloud02, %CloudLabel02%
    GuiControlGet, CloudLabel03, 4:
    IniWrite, %CloudLabel03%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 03
    GuiControl, 1:, Cloud03, %CloudLabel03%
    GuiControlGet, CloudLabel04, 4:
    IniWrite, %CloudLabel04%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 04
    GuiControl, 1:, Cloud04, %CloudLabel04%
    GuiControlGet, CloudLabel05, 4:
    IniWrite, %CloudLabel05%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 05
    GuiControl, 1:, Cloud05, %CloudLabel05%

    GuiControlGet, GPLabel1, 4:
    IniWrite, %GPLabel1%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton1
    GuiControl, 1:, D10, %GPLabel1%
    GuiControlGet, GPLabel2, 4:
    IniWrite, %GPLabel2%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton2
    GuiControl, 1:, D13, %GPLabel2%
    GuiControlGet, GPLabel3, 4:
    IniWrite, %GPLabel3%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton3
    GuiControl, 1:, D15, %GPLabel3%
    GuiControlGet, GPLabel4, 4:
    IniWrite, %GPLabel4%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton4
    GuiControl, 1:, D16, %GPLabel4%
    GuiControlGet, GPLabel5, 4:
    IniWrite, %GPLabel5%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtonLabels, GPButton5
    GuiControl, 1:, D18, %GPLabel5%

    GuiControlGet, GP1Loc, 4:
    IniWrite, %GP1Loc%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPLaunchFile, GPLaunch1
    GuiControlGet, GP2Loc, 4:
    IniWrite, %GP2Loc%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPLaunchFile, GPLaunch2
    GuiControlGet, GP3Loc, 4:
    IniWrite, %GP3Loc%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPLaunchFile, GPLaunch3
    GuiControlGet, GP4Loc, 4:
    IniWrite, %GP4Loc%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPLaunchFile, GPLaunch4
    GuiControlGet, GP5Loc, 4:
    IniWrite, %GP5Loc%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPLaunchFile, GPLaunch5
    Return
*/

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

;--------------------------------------------------------------------------------------------------------------------------
; The actual Settings Screen Controls
;--------------------------------------------------------------------------------------------------------------------------
BackPath:
    FileSelectFolder, BackFolder, C:\, 3, Select your Database Backups Folder
    if BackFolder = 
    {
        MsgBox, Nothing was selected.
        return
    }
    Else
    {
        GuiControl,, BackupPath, %BackFolder%
        return
    }

SQLServ:
    GuiControlGet, ServName
    Gui, 8:Destroy
    Gui, 8:Add, Text, x10 y15, Enter your SQL Server Name:
    Gui, 8:Add, Edit, x10 y30 w218 vServerName, %ServName%
    Gui, 8:Add, Button, x9 y60 w100 h25 gOK8, OK 
    Gui, 8:Add, Button, x129 y60 w100 h25 gCancel8, Cancel
    Gui, 8:Show, w238 h90, SQL Server
    return

Cancel8:
    Gui, 8:Destroy
    Return

OK8:
    GuiControlGet, ServerName
    GuiControl, 4:, ServName, %ServerName%
    Gui, 8:Destroy
    return

SQLUN:
    GuiControlGet, ServUN
    Gui, 9:Destroy
    Gui, 9:Add, Text, x10 y15, Enter your SQL Server Username:
    Gui, 9:Add, Edit, x10 y30 w218 vUserNameBox, %ServUN%
    Gui, 9:Add, Button, x9 y60 w100 h25 gOK9, OK 
    Gui, 9:Add, Button, x129 y60 w100 h25 gCancel9, Cancel
    Gui, 9:Show, w238 h90, SQL Server Username
    return

Cancel9:
    Gui, 9:Destroy
    Return

OK9:
    GuiControlGet, UserNameBox
    GuiControl, 4:, ServUN, %UserNameBox%
    Gui, 9:Destroy
    return

SQLPW:
    GuiControlGet, ServPW
    Gui, 10:Destroy
    Gui, 10:Add, Text, x10 y15, Enter your SQL Server Password:
    Gui, 10:Add, Edit, x10 y30 w218 vUserPWBox Password, %ServPW%
    Gui, 10:Add, Button, x9 y60 w100 h25 gOK10, OK 
    Gui, 10:Add, Button, x129 y60 w100 h25 gCancel10, Cancel
    Gui, 10:Show, w238 h90, SQL Server Password
    return

Cancel10:
    Gui, 10:Destroy
    Return

OK10:
    GuiControlGet, UserPWBox
    GuiControl, 4:, ServPW, %UserPWBox%
    Gui, 10:Destroy
    return

DYN:
    GuiControlGet, DynamicsDB
    Gui, 11:Destroy
    Gui, 11:Add, Text, x10 y15, Enter your Dynamics GP Database:
    Gui, 11:Add, Edit, x10 y30 w218 vDynamicsBox, %DynamicsDB%
    Gui, 11:Add, Button, x9 y60 w100 h25 gOK11, OK 
    Gui, 11:Add, Button, x129 y60 w100 h25 gCancel11, Cancel
    Gui, 11:Show, w238 h90, Dynamics GP Database
    return

Cancel11:
    Gui, 11:Destroy
    Return

OK11:
    GuiControlGet, DynamicsBox
    GuiControl, 4:, DynamicsDB, %DynamicsBox%
    Gui, 11:Destroy
    return

REG:
    GuiControlGet, RegDB
    Gui, 12:Destroy
    Gui, 12:Add, Text, x10 y15, Enter your Non-Multibin DB:
    Gui, 12:Add, Edit, x10 y30 w218 vRegularBox, %RegDB%
    Gui, 12:Add, Button, x9 y60 w100 h25 gOK12, OK 
    Gui, 12:Add, Button, x129 y60 w100 h25 gCancel12, Cancel
    Gui, 12:Show, w238 h90, Non-Multibin
    return

Cancel12:
    Gui, 12:Destroy
    Return

OK12:
    GuiControlGet, RegularBox
    GuiControl, 4:, RegDB, %RegularBox%
    Gui, 12:Destroy
    return

MB:
    GuiControlGet, MBDB
    Gui, 13:Destroy
    Gui, 13:Add, Text, x10 y15, Enter your Multibin DB:
    Gui, 13:Add, Edit, x10 y30 w218 vMultiBox, %MBDB%
    Gui, 13:Add, Button, x9 y60 w100 h25 gOK13, OK 
    Gui, 13:Add, Button, x129 y60 w100 h25 gCancel13, Cancel
    Gui, 13:Show, w238 h90, Multibin
    return

Cancel13: ; Cancel action
    Gui, 13:Destroy
    Return

OK13: ; OK action
    GuiControlGet, MultiBox
    GuiControl, 4:, MBDB, %MultiBox%
    Gui, 13:Destroy
    return

SelectCloudLabel01:
    GuiControlGet, CloudLabel01
    Gui, 18:Destroy
    Gui, 18:Add, Text, x10 y15, Enter the name of your 01 Tenant:
    Gui, 18:Add, Edit, x10 y30 w218 vCloudPrompt01, %CloudLabel01%
    Gui, 18:Add, Button, x9 y60 w100 h25 gOKC01, OK 
    Gui, 18:Add, Button, x129 y60 w100 h25 gCancelC01, Cancel
    Gui, 18:Show, w238 h90, Tenant 01
    Return

OKC01:
    GuiControlGet, CloudPrompt01
    GuiControl, 4:, CloudLabel01, %CloudPrompt01%
    Gui, 18:Destroy
    Return

CancelC01:
    Gui, 18:Destroy
    Return

SelectCloudLabel02:
    GuiControlGet, CloudLabel02
    Gui, 19:Destroy
    Gui, 19:Add, Text, x10 y15, Enter the name of your 02 Tenant:
    Gui, 19:Add, Edit, x10 y30 w218 vCloudPrompt02, %CloudLabel02%
    Gui, 19:Add, Button, x9 y60 w100 h25 gOKC02, OK 
    Gui, 19:Add, Button, x129 y60 w100 h25 gCancelC02, Cancel
    Gui, 19:Show, w238 h90, Tenant 02
    Return

OKC02:
    GuiControlGet, CloudPrompt02
    GuiControl, 4:, CloudLabel02, %CloudPrompt02%
    Gui, 19:Destroy
    Return

CancelC02:
    Gui, 19:Destroy
    Return

SelectCloudLabel03:
    GuiControlGet, CloudLabel03
    Gui, 20:Destroy
    Gui, 20:Add, Text, x10 y15, Enter the name of your 03 Tenant:
    Gui, 20:Add, Edit, x10 y30 w218 vCloudPrompt03, %CloudLabel03%
    Gui, 20:Add, Button, x9 y60 w100 h25 gOKC03, OK 
    Gui, 20:Add, Button, x129 y60 w100 h25 gCancelC03, Cancel
    Gui, 20:Show, w238 h90, Tenant 03
    Return

OKC03:
    GuiControlGet, CloudPrompt03
    GuiControl, 4:, CloudLabel03, %CloudPrompt03%
    Gui, 20:Destroy
    Return

CancelC03:
    Gui, 20:Destroy
    Return

SelectCloudLabel04:
    GuiControlGet, CloudLabel04
    Gui, 21:Destroy
    Gui, 21:Add, Text, x10 y15, Enter the name of your 04 Tenant:
    Gui, 21:Add, Edit, x10 y30 w218 vCloudPrompt04, %CloudLabel04%
    Gui, 21:Add, Button, x9 y60 w100 h25 gOKC04, OK 
    Gui, 21:Add, Button, x129 y60 w100 h25 gCancelC04, Cancel
    Gui, 21:Show, w238 h90, Tenant 04
    Return

OKC04:
    GuiControlGet, CloudPrompt04
    GuiControl, 4:, CloudLabel04, %CloudPrompt04%
    Gui, 21:Destroy
    Return

CancelC04:
    Gui, 21:Destroy
    Return

SelectCloudLabel05:
    GuiControlGet, CloudLabel05
    Gui, 22:Destroy
    Gui, 22:Add, Text, x10 y15, Enter the name of your 05 Tenant:
    Gui, 22:Add, Edit, x10 y30 w218 vCloudPrompt05, %CloudLabel05%
    Gui, 22:Add, Button, x9 y60 w100 h25 gOKC05, OK 
    Gui, 22:Add, Button, x129 y60 w100 h25 gCancelC05, Cancel
    Gui, 22:Show, w238 h90, Tenant 05
    Return

OKC05:
    GuiControlGet, CloudPrompt05
    GuiControl, 4:, CloudLabel05, %CloudPrompt05%
    Gui, 22:Destroy
    Return

CancelC05:
    Gui, 22:Destroy
    Return

SelectGP1:
    FileSelectFile, ChooseGP1, 33, C:\Program Files (x86)\Microsoft Dynamics, Select a GP Launcher File, 
    if ErrorLevel
        return
    GuiControl, 4:, GP1Loc, %ChooseGP1%
    Return

SelectGP2:
    FileSelectFile, ChooseGP2, 33, C:\Program Files (x86)\Microsoft Dynamics, Select a GP Launcher File, 
    if ErrorLevel
        return
    GuiControl, 4:, GP2Loc, %ChooseGP2%
    Return

SelectGP3:
    FileSelectFile, ChooseGP3, 33, C:\Program Files (x86)\Microsoft Dynamics, Select a GP Launcher File, 
    if ErrorLevel
        return
    GuiControl, 4:, GP3Loc, %ChooseGP3%
    Return

SelectGP4:
    FileSelectFile, ChooseGP4, 33, C:\Program Files (x86)\Microsoft Dynamics, Select a GP Launcher File, 
    if ErrorLevel
        return
    GuiControl, 4:, GP4Loc, %ChooseGP4%
    Return

SelectGP5:
    FileSelectFile, ChooseGP5, 33, C:\Program Files (x86)\Microsoft Dynamics, Select a GP Launcher File, 
    if ErrorLevel
        return
    GuiControl, 4:, GP5Loc, %ChooseGP5%
    Return

SelectGPLabel1:
    GuiControlGet, GPLabel1
    Gui, 23:Destroy
    Gui, 23:Add, Text, x10 y15, Enter the name of your selected GP Instance:
    Gui, 23:Add, Edit, x10 y30 w218 vGPName1, %GPLabel1%
    Gui, 23:Add, Button, x9 y60 w100 h25 gOKGP1, OK 
    Gui, 23:Add, Button, x129 y60 w100 h25 gCancelGP1, Cancel
    Gui, 23:Show, w238 h90, GP 1 Button Label
    Return

OKGP1:
    GuiControlGet, GPName1
    GuiControl, 4:, GPLabel1, %GPName1%
    Gui, 23:Destroy
    Return

CancelGP1:
    Gui, 23:Destroy
    Return

SelectGPLabel2:
    GuiControlGet, GPLabel2
    Gui, 24:Destroy
    Gui, 24:Add, Text, x10 y15, Enter the name of your selected GP Instance:
    Gui, 24:Add, Edit, x10 y30 w218 vGPName2, %GPLabel2%
    Gui, 24:Add, Button, x9 y60 w100 h25 gOKGP2, OK 
    Gui, 24:Add, Button, x129 y60 w100 h25 gCancelGP2, Cancel
    Gui, 24:Show, w238 h90, GP 2 Button Label
    Return

OKGP2:
    GuiControlGet, GPName2
    GuiControl, 4:, GPLabel2, %GPName2%
    Gui, 24:Destroy
    Return

CancelGP2:
    Gui, 24:Destroy
    Return

SelectGPLabel3:
    GuiControlGet, GPLabel3
    Gui, 25:Destroy
    Gui, 25:Add, Text, x10 y15, Enter the name of your selected GP Instance:
    Gui, 25:Add, Edit, x10 y30 w218 vGPName3, %GPLabel3%
    Gui, 25:Add, Button, x9 y60 w100 h25 gOKGP3, OK 
    Gui, 25:Add, Button, x129 y60 w100 h25 gCancelGP3, Cancel
    Gui, 25:Show, w238 h90, GP 3 Button Label
    Return

OKGP3:
    GuiControlGet, GPName3
    GuiControl, 4:, GPLabel3, %GPName3%
    Gui, 25:Destroy
    Return

CancelGP3:
    Gui, 25:Destroy
    Return

SelectGPLabel4:
    GuiControlGet, GPLabel4
    Gui, 26:Destroy
    Gui, 26:Add, Text, x10 y15, Enter the name of your selected GP Instance:
    Gui, 26:Add, Edit, x10 y30 w218 vGPName4, %GPLabel4%
    Gui, 26:Add, Button, x9 y60 w100 h25 gOKGP4, OK 
    Gui, 26:Add, Button, x129 y60 w100 h25 gCancelGP4, Cancel
    Gui, 26:Show, w238 h90, GP 4 Button Label
    Return

OKGP4:
    GuiControlGet, GPName4
    GuiControl, 4:, GPLabel4, %GPName4%
    Gui, 26:Destroy
    Return

CancelGP4:
    Gui, 26:Destroy
    Return

SelectGPLabel5:
    GuiControlGet, GPLabel5
    Gui, 27:Destroy
    Gui, 27:Add, Text, x10 y15, Enter the name of your selected GP Instance:
    Gui, 27:Add, Edit, x10 y30 w218 vGPName5, %GPLabel5%
    Gui, 27:Add, Button, x9 y60 w100 h25 gOKGP5, OK 
    Gui, 27:Add, Button, x129 y60 w100 h25 gCancelGP5, Cancel
    Gui, 27:Show, w238 h90, GP 5 Button Label
    Return

OKGP5:
    GuiControlGet, GPName5
    GuiControl, 4:, GPLabel5, %GPName5%
    Gui, 27:Destroy
    Return

CancelGP5:
    Gui, 27:Destroy
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
    Gui, 6:Add, Picture, x15 y245 w15 h15 gHubIcon, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\GitHubIcon.png
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
    Gui, 28:Add, Edit, x300 y50 w30 cgray ReadOnly, %Web%
    Gui, 28:Add, Edit, x300 y80 w30 cgray ReadOnly, %CC%
    Gui, 28:Add, Edit, x300 y110 w30 cgray ReadOnly, %Launch%
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


GPBackupsList:  ; Double clicking an option from the list box will launch it
    if (A_GuiEvent <> "DoubleClick")
        return

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
        Run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DBRestore.bat" %Var1% %Var2% %Var3% %Var4% "%GPBackupsList%" %Var5% %Var6% %Var7%,, UseErrorLevel
        WinWait, C:\windows\system32\cmd.exe
        WinWaitClose
        MsgBox,, COMPLETED, Database %GPBackupsList% was restored successfully.
        return
    }

ButtonOverwriteDB:  ; Button to override the selected DB from the list
    IniRead, OverwriteCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, OverwriteDB
    OverwriteCounter += 1
    IniWrite, %OverwriteCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, OverwriteDB
    GuiControlGet, GPBackupsList
    If GPBackupsList = 
    {
        MsgBox, Please Select a Backtup to Overwrite.
        return
    }
    Else
    {
        MsgBox, 4, OVERWRITE?, Would you like overwrite %GPBackupsList% with your current environment?
        IfMsgBox, No
            return
        IniRead, Var1, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Server
        IniRead, Var2, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, User
        IniRead, Var3, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Password
        IniRead, Var4, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
        IniRead, Var5, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Dynamics
        IniRead, Var6, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company1
        IniRead, Var7, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company2
        Run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DBOverwrite.bat" %Var1% %Var2% %Var3% %Var4% "%GPBackupsList%" %Var5% %Var6% %Var7%,, UseErrorLevel
        return
    }

ButtonNewBackup:    ; Button to create a new DB and add it to the list
    IniRead, NewCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, NewBackup
    NewCounter += 1
    IniWrite, %NewCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, NewBackup
    Gui, 5:Destroy
    Gui, 5:Add, Text, x10 y15, Enter a New Database name:
    Gui, 5:Add, Edit, x10 y30 w218 vDatabase, 
    Gui, 5:Add, Button, +Default x9 y60 w100 h25 gOK5, OK 
    Gui, 5:Add, Button, x129 y60 w100 h25 gCancel5, Cancel
    Gui, 5:Show, w238 h90, New Backup
    return
    
    Cancel5:
        MsgBox, No new Backup was created.
        Gui, 5:Destroy
        Return
    
    OK5:
        IniRead, DBListNew, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
        GuiControlGet, Database
        if Database = 
        {
            MsgBox,, ERROR, No Database Name was entered.
            return
        }
        Else
        {
            ;ifExist C:\#DBBackups\%Database%
            ifExist %DBListNew%\%Database%
            {
                MsgBox,, ALREADY EXISTS, A backup named %Database% already exists.
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
                    IniRead, Var1, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Server
                    IniRead, Var2, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, User
                    IniRead, Var3, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Password
                    IniRead, Var4, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
                    IniRead, Var5, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Dynamics
                    IniRead, Var6, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company1
                    IniRead, Var7, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company2
                    Run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DBBackup.bat" %Var1% %Var2% %Var3% %Var4% "%Database%" %Var5% %Var6% %Var7%,, UseErrorLevel
                    sleep 2000
                    GuiControl, 1:, GPBackupsList, |
                    IniRead, DBListDisplay, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
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
    IniRead, DeleteCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, DeleteBackup
    DeleteCounter += 1
    IniWrite, %DeleteCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, DeleteBackup
    IniRead, DBListDelete, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
    GuiControlGet, GPBackupsList
    If GPBackupsList = 
    {
        MsgBox, Please Select a Backtup to Delete.
        return
    }
    Else
    {
        MsgBox, 4, DELETE?, Are you sure you want to delete backup %GPBackupsList%?
        ifMsgBox, Yes
        {
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
    IniRead, SPGP, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SalesPadDesktop
    SPGP += 1
    IniWrite, %SPGP%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SalesPadDesktop
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, Select a SalesPad Build, *.exe
    if ErrorLevel
        return
    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
    FileCopy, %SelectedFile%, C:\#EnvMgr\TEMPFILES\INSTALLERS
    SplitPath, SelectedFile,, Instl
    Variable1 := Instl
    Gui, 2:Destroy
    Gui, 2:Add, Text, x30 y40, Please enter the location you would like to install the following build to:
    Gui, 2:Add, Edit, cgray x30 y60 w600 ReadOnly, %Instl%
    Gui, 2:Add, Edit, x30 y90 w600 vBuildLoc, C:\Program Files (x86)\SalesPad.Desktop\
    Gui, 2:Add, CheckBox, x260 y128 gUpdateB vCheckB, Install With Grizzly DLLs
    Gui, 2:Add, Button, x420 y120 w100 h25 gCan, Cancel
    Gui, 2:Add, Button, x531 y120 w100 h25 gOK, OK
    Gui, 2:Show, w660 h160, Install SalesPad GP
    return

Can:
    MsgBox, 4, CANCEL, Are you sure you want to cancel?
    IfMsgBox, No
    {
        return
    }
    IfMsgBox, Yes
    {
        Gui, 2:Destroy
        return
    }

OK:
    GuiControlGet, BuildLoc
    GuiControlGet, CheckB
    Clipboard := Variable1
    If VarCheck = 1
    {
        MsgBox, 4, Grizzly Build?, Are you installing a Grizzly Build?
        ifMsgBox, No
        {
            GuiControl, , CheckB, 0
            VarCheck = 0
            return
        }
        ifMsgBox, Yes
        {
            Gui, 2:Destroy
            run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\SPInstall.bat" "%BuildLoc%"
            WinWait, C:\windows\system32\cmd.exe
            WinWaitClose
            run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.GetGrizzlyDLL.bat" %Instl%
            WinWait, C:\windows\system32\cmd.exe
            WinWaitClose
            FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
            FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
            sleep 3000
            run, %BuildLoc%\SalesPad.exe
            GuiControl, , CheckB, 0
            VarCheck = 0
            return
        }
    }
    Else
    {
        Gui, 2:Destroy
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\SPInstall.bat" "%BuildLoc%"
        WinWait, C:\windows\system32\cmd.exe
        WinWaitClose
        SplitPath, SelectedFile,, dir
        MsgBox, 4, EXTENDED DLL?, Do you need any Extended DLLs?
        ifMsgBox, No
            Goto, CustDLL
        Else
            FileSelectFile, FilesExt, M3, %dir%\ExtModules\WithOutCardControl, Select any DLLs needed, *.zip
            Array := StrSplit(FilesExt, "`n")

            for index, file in Array
            {
            	if index = 1
            		Dir := file
            	else
            		FileCopy, % Dir "\" file, C:\#EnvMgr\TEMPFILES\DLLs
            }
        FilesExt = 
        dir = 
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\FileUnzipAndMove.bat"
        WinWait, C:\windows\system32\cmd.exe
        WinWaitClose
        FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
        FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*

    CustDLL:
        SplitPath, SelectedFile,, dir
        sleep, 2000
        MsgBox, 4, CUSTOM DLL?, Do you need any Custom DLLs?
        ifMsgBox, No
            Goto, NoDLL
        Else
            FileSelectFile, FilesCust, M3, %dir%\CustomModules\WithOutCardControl, Select any DLLs needed, *.zip
            Array := StrSplit(FilesCust, "`n")

            for index, file in Array
            {
            	if index = 1
            		Dir := file
            	else
            		FileCopy, % Dir "\" file, C:\#EnvMgr\TEMPFILES\DLLs
            }
        FilesCust = 
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\FileUnzipAndMove.bat"
        WinWait, C:\windows\system32\cmd.exe
        ;WinWait, CUSTOM DLL?
        WinWaitClose
        FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %BuildLoc%
        FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*

    NoDLL:
        Sleep, 1000
        run, %BuildLoc%\SalesPad.exe
        return
    }

ButtonSalesPadMobile:   ; Button to launch the SalesPad Mobile selection/installer
    IniRead, MobileCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SalesPadMobile
    MobileCounter += 1
    IniWrite, %MobileCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SalesPadMobile
    FileSelectFile, SelectedFileMobile, 1, \\sp-fileserv-01\Shares\Builds\Ares\Mobile-Server, Select a SalesPad Server Build, *.exe
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
    Gui, 15:Add, Button, x531 y120 w100 h25 gOKMobile, OK
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
    Clipboard := Variable1
    Gui, 15:Destroy
    run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\DCSilentInstall.bat" "%BuildLocMobile%"
    WinWait, C:\windows\system32\cmd.exe
    WinWaitClose
    ;MsgBox, 0, Test, %BuildLocMobile%
    Sleep 4000
    Run *RunAs "%BuildLocMobile%\SalesPad.GP.Mobile.Server.exe" ;Looks like Run *RunAs only prompts if the program it's triggered from isn't running as admin
    ;MsgBox, 0, Test, "%BuildLocMobile%\SalesPad.GP.Mobile.Server.exe"
    ;Run, %BuildLocMobile%
    Return

ButtonDataCollection:   ; Button to launch the DC selection/installer
    IniRead, DCCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, DataCollection
    DCCounter += 1
    IniWrite, %DCCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, DataCollection
    FileSelectFile, SelectedFileDC, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection, Select a DataCollection Build, *.exe
    if ErrorLevel
        return
    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
    FileCopy, %SelectedFileDC%, C:\#EnvMgr\TEMPFILES\INSTALLERS
    SplitPath, SelectedFileDC,, InstlDC
    Variable1 := InstlDC
    Gui, 14:Destroy
    Gui, 14:Add, Text, x30 y40, Please enter the location you would like to install the following build to:
    Gui, 14:Add, Edit, cgray x30 y60 w600 ReadOnly, %InstlDC%
    Gui, 14:Add, Edit, x30 y90 w600 vDCBuildLoc, C:\Program Files (x86)\DataCollection\
    Gui, 14:Add, Button, x420 y120 w100 h25 gDCCan, Cancel
    Gui, 14:Add, Button, x531 y120 w100 h25 gDCOK, OK
    Gui, 14:Show, w660 h160, Install DataCollection
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
    Clipboard := Variable1
    Gui, 14:Destroy
    run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\DCSilentInstall.bat" "%DCBuildLoc%"
    WinWait, C:\windows\system32\cmd.exe
    WinWaitClose
    Sleep 4000
    Run *RunAs "%DCBuildLoc%\DataCollection Extended Warehouse.exe"
    ;Run, %DCBuildLoc%
    Return

ButtonShipCenter:   ; Button to launch the ShipCenter selection/installer
    IniRead, ShipCenterCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, ShipCenter
    ShipCenterCounter += 1
    IniWrite, %ShipCenterCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, ShipCenter
    FileSelectFile, SelectedFileSC, 1, \\sp-fileserv-01\Shares\Builds\ShipCenter, Select a ShipCenter Build, *.exe
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
    Gui, 16:Add, Button, x531 y120 w100 h25 gOKSC, OK
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
    Clipboard := Variable1
    Gui, 16:Destroy
    run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\DCSilentInstall.bat" "%BuildLocSC%"
    WinWait, C:\windows\system32\cmd.exe
    WinWaitClose
    Sleep 4000
    Run *RunAs "%BuildLocSC%\SalesPad.ShipCenter.exe"
    ;Run, %BuildLocSC%
    Return

ButtonCardControl:  ; Button to launch the CardControl selection/installer
    IniRead, CardControlCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, CardControl
    CardControlCounter += 1
    IniWrite, %CardControlCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, CardControl
    FileSelectFile, SelectedFileCC, 1, \\sp-fileserv-01\Shares\Builds\Ares, Select a Card Control Build, *.exe
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
    Gui, 17:Add, Button, x531 y120 w100 h25 gOKCC, OK
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
    Clipboard := Variable1
    Gui, 17:Destroy
    run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\DCSilentInstall.bat" "%BuildLocCC%"
    WinWait, C:\windows\system32\cmd.exe
    WinWaitClose
    Sleep 4000
    Run, "%BuildLocCC%\CardControl.exe"
    Return

ButtonWebAPI:
    IniRead, APICounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, WebAPI
    APICounter += 1
    IniWrite, %APICounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, WebAPI
    if GetKeyState("Shift", "P")
        Run, \\sp-fileserv-01\Shares\Builds\SalesPad.WebApi
    Else if GetKeyState("Ctrl", "P")
        Run, http://localhost:49403/
    Else
        MsgBox, 4, API?, Are you sure you want to install a new Web API?
        IfMsgBox Yes
        {
            Run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Shortcuts\Script.API - Shortcut.lnk"
            Return
        }
        If MsgBox No
        {
            Return
        }
    Return

ButtonWebPortal:
    IniRead, WebCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, WebPortal
    WebCounter += 1
    IniWrite, %WebCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, WebPortal
    if GetKeyState("Shift", "P")
        Run, \\sp-fileserv-01\Shares\Builds\Web-Portal\GP
    Else if GetKeyState("Ctrl", "P")
        Run, http://localhost:80/
    Else
        MsgBox, 4, WEB?, Are you sure you want to install a new Web Portal Web build?
        IfMsgBox Yes
        {
            Run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Shortcuts\Script.WEB - Shortcut.lnk"
            Return
        }
        If MsgBox No
        {
            Return
        }
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
    IniRead, LaunchBuildCounter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, LaunchBuild
    LaunchBuildCounter += 1
    IniWrite, %LaunchBuildCounter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, LaunchBuild
    if GetKeyState("Shift", "P")
        MsgBox, 4, DB UPDATE?, Do you want to select an installed build to run a database update on?
            ifMsgBox, Yes
                Return
            IfMsgBox, No
                Return
    Else
        FileSelectFile, SelectedFile, 1, C:\Program Files (x86)\SalesPad.Desktop, Select a Build, *.exe
        if ErrorLevel
            return
        run, %SelectedFile%
        return

ButtonRefresh:  ; Refreshes the Listbox
    GuiControl,, GPBackupsList, |
    goto, ListBoxDisplay
    Return

ButtonBackupsFolder:    ; Launches the folder the DB backups are restored in -- needs update, should pull location from Settings.ini
    IniRead, DBListFolder, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
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
    IniRead, GP4Counter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, GP4
    GP4Counter += 1
    IniWrite, %GP4Counter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, GP4
    IniRead, D16Location, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPLaunchFile, GPLaunch4
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
    IniRead, SPC01Counter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC1
    SPC01Counter += 1
    IniWrite, %SPC01Counter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC1
    IniRead, 01Delete, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 01
    MsgBox, 4, RUN, Do you want to Delete %01Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR01.bat" %01Delete%
        ;run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\0TestSPCName.bat" %01Delete%
        return
    }

ButtonSteveRodriguez02:
    IniRead, SPC02Counter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC2
    SPC02Counter += 1
    IniWrite, %SPC02Counter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC2
    IniRead, 02Delete, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 02
    MsgBox, 4, RUN, Do you want to Delete %02Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR01.bat" %02Delete%
        return
    }

ButtonSteveRodriguez03:
    IniRead, SPC03Counter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC3
    SPC03Counter += 1
    IniWrite, %SPC03Counter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC3
    IniRead, 03Delete, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 03
    MsgBox, 4, RUN, Do you want to Delete %03Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR01.bat" %03Delete%
        return
    }

ButtonSteveRodriguez04:
    IniRead, SPC04Counter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC4
    SPC04Counter += 1
    IniWrite, %SPC04Counter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC4
    IniRead, 04Delete, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 04
    MsgBox, 4, RUN, Do you want to Delete %04Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR01.bat" %04Delete%
        return
    }

ButtonSteveRodriguez05:
    IniRead, SPC05Counter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC5
    SPC05Counter += 1
    IniWrite, %SPC05Counter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, SPC5
    IniRead, 05Delete, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, CloudButtonNames, 05
    MsgBox, 4, RUN, Do you want to Delete %05Delete% tables?
    ifMsgBox, No
    {
        MsgBox, 0, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR01.bat" %05Delete%
        return
    }

Utilities:
    run, "C:\Users\steve.rodriguez\Desktop\Scripts\SteveUtilities.ahk"
    return

GuiClose:
Exit1:
    IniRead, PromptToClose, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, PromptClose, Close
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