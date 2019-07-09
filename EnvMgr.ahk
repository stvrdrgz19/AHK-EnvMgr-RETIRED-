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

Gui, Add, Button, x25 y281 w125 h25 gD10 vD10, Dynamics GP 2010
Gui, Add, Button, x158 y281 w125 h25 gD13 vD13, Dynamics GP 2013
Gui, Add, Button, x291 y281 w125 h25 gD15 vD15, Dynamics GP 2015
Gui, Add, Button, x424 y281 w125 h25 gD16 vD16, Dynamics GP 2016
Gui, Add, Button, x557 y281 w125 h25 gD18 vD18, Dynamics GP 2018

Gui, Add, Button, x25 y343 w125 h25 vSR1, SteveRodriguez01
Gui, Add, Button, x158 y343 w125 h25 vSR2, SteveRodriguez02
Gui, Add, Button, x291 y343 w125 h25 vSR3, SteveRodriguez03
Gui, Add, Button, x424 y343 w125 h25 vSR4, SteveRodriguez04
Gui, Add, Button, x557 y343 w126 h25 vSR5, SteveRodriguez05

;GuiControl, Disable, AddDLLs ;Disabling controls
;Gui, Color, FF0000, 3366FF ; Attempting to change the GUI color

;--------------------------------------------------------------------------------------------------------------------------
; This loads the settings from the Settings.ini file
;--------------------------------------------------------------------------------------------------------------------------
IniRead, RestoreLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, Rest
GuiControl, 4:, CheckRestore, %RestoreLoad%
if RestoreLoad = 1
{
    GuiControl, 1:Disable, BRest
}
IniRead, OverwriteLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, Over
GuiControl, 4:, CheckOverwrite, %OverwriteLoad%
if OverwriteLoad = 1
{
    GuiControl, 1:Disable, BOver
}
IniRead, DeleteLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, Delete
GuiControl, 4:, CheckDelete, %DeleteLoad%
if DeleteLoad = 1
{
    GuiControl, 1:Disable, Delete
}
IniRead, NewLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, New
GuiControl, 4:, CheckNew, %NewLoad%
if NewLoad = 1
{
    GuiControl, 1:Disable, Bak
}



IniRead, DesktopLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, SalesPad
GuiControl, 4:, DisableSP, %DesktopLoad%
if DesktopLoad = 1
{
    GuiControl, 1:Disable, BDesktop
}
IniRead, MobileLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Mobile
GuiControl, 4:, DisableDC, %MobileLoad%
if MobileLoad = 1
{
    GuiControl, 1:Disable, BMobile
}
IniRead, DataCollectionLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, DataCollection
GuiControl, 4:, DisableSC, %DataCollectionLoad%
if DataCollectionLoad = 1
{
    GuiControl, 1:Disable, BDataCollection
}
IniRead, ShipCenterLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, ShipCenter
GuiControl, 4:, DisableMOB, %ShipCenterLoad%
if ShipCenterLoad = 1
{
    GuiControl, 1:Disable, BShipCenter
}
IniRead, CardControlLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, CardControl
GuiControl, 4:, DisableCC, %CardControlLoad%
if CardControlLoad = 1
{
    GuiControl, 1:Disable, BCardControl
}
IniRead, GPAPILoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, API
GuiControl, 4:, DisableAPI, %GPAPILoad%
if GPAPILoad = 1
{
    GuiControl, 1:Disable, GPAPI
}
IniRead, GPWEBLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Web
GuiControl, 4:, DisableWeb, %GPWEBLoad%
if GPWEBLoad = 1
{
    GuiControl, 1:Disable, GPWEB
}
IniRead, LaunchLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Launch
GuiControl, 4:, DisableLaunch, %LaunchLoad%
if LaunchLoad = 1
{
    GuiControl, 1:Disable, BLaunch
}
IniRead, AddLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Add
GuiControl, 4:, DisableAdd, %AddLoad%
if AddLoad = 1
{
    GuiControl, 1:Disable, AddDLLs
}
IniRead, BuildLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Build
GuiControl, 4:, DisableBuild, %BuildLoad%
if BuildLoad = 1
{
    GuiControl, 1:Disable, BBuild
}



IniRead, Dyn10Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics10
GuiControl, 4:, CheckDyn10, %Dyn10Load%
if Dyn10Load = 1
{
    GuiControl, 1:Disable, D10
}
IniRead, Dyn13Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics13
GuiControl, 4:, CheckDyn13, %Dyn13Load%
if Dyn13Load = 1
{
    GuiControl, 1:Disable, D13
}
IniRead, Dyn15Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics15
GuiControl, 4:, CheckDyn15, %Dyn15Load%
if Dyn15Load = 1
{
    GuiControl, 1:Disable, D15
}
IniRead, Dyn16Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics16
GuiControl, 4:, CheckDyn16, %Dyn16Load%
if Dyn16Load = 1
{
    GuiControl, 1:Disable, D16
}
IniRead, Dyn18Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics18
GuiControl, 4:, CheckDyn18, %Dyn18Load%
if Dyn18Load = 1
{
    GuiControl, 1:Disable, D18
}




IniRead, SR1Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud1
GuiControl, 4:, CheckSPC1, %SR1Load%
if SR1Load = 1
{
    GuiControl, 1:Disable, SR1
}
IniRead, SR2Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud2
GuiControl, 4:, CheckSPC2, %SR2Load%
if SR2Load = 1
{
    GuiControl, 1:Disable, SR2
}
IniRead, SR3Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud3
GuiControl, 4:, CheckSPC3, %SR3Load%
if SR3Load = 1
{
    GuiControl, 1:Disable, SR3
}
IniRead, SR4Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud4
GuiControl, 4:, CheckSPC4, %SR4Load%
if SR4Load = 1
{
    GuiControl, 1:Disable, SR4
}
IniRead, SR5Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud5
GuiControl, 4:, CheckSPC5, %SR5Load%
if SR5Load = 1
{
    GuiControl, 1:Disable, SR5
}



Gui, Color, f9f9f9
;Gui, Show, x2100 y-800 w706 h421, Environment Mananger
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
    Gui, 4:Add, Checkbox, x30 y55 vCheckDyn10, Disable Microsoft Dynamics GP 2010
    Gui, 4:Add, Checkbox, x30 y85 vCheckDyn13, Disable Microsoft Dynamics GP 2013
    Gui, 4:Add, Checkbox, x30 y115 vCheckDyn15, Disable Microsoft Dynamics GP 2015
    Gui, 4:Add, Checkbox, x30 y145 vCheckDyn16, Disable Microsoft Dynamics GP 2016
    Gui, 4:Add, Checkbox, x30 y175 vCheckDyn18, Disable Microsoft Dynamics GP 2018
    Gui, 4:Tab, 5
    Gui, 4:Add, Checkbox, x30 y55 vCheckSPC1, Disable SPC Sql Server 1 
    Gui, 4:Add, Checkbox, x30 y85 vCheckSPC2, Disable SPC Sql Server 2
    Gui, 4:Add, Checkbox, x30 y115 vCheckSPC3, Disable SPC Sql Server 3
    Gui, 4:Add, Checkbox, x30 y145 vCheckSPC4, Disable SPC Sql Server 4
    Gui, 4:Add, Checkbox, x30 y175 vCheckSPC5, Disable SPC Sql Server 5
    Gui, 4:Tab, 6
    Gui, 4:Add, Checkbox, x30 y55 vPromptCloseBox, Prompt user when closing Environment Manager 
    Gui, 4:Show, w680 h250, Settings
    
;--------------------------------------------------------------------------------------------------------------------------
; Loading the Settings values from the Settings.ini file
;--------------------------------------------------------------------------------------------------------------------------
    IniRead, BackPathLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
    GuiControl, 4:, BackupPath, %BackPathLoad%
    IniRead, ServLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Server
    GuiControl, 4:, ServName, %ServLoad%
    IniRead, UserLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, User
    GuiControl, 4:, ServUN, %UserLoad%
    IniRead, PasswordLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SQLCreds, Password
    GuiControl, 4:, ServPW, %PasswordLoad%
    IniRead, DynamicLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Dynamics
    GuiControl, 4:, DynamicsDB, %DynamicLoad%
    IniRead, Company1Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company1
    GuiControl, 4:, RegDB, %Company1Load%
    IniRead, Company2Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, Databases, Company2
    GuiControl, 4:, MBDB, %Company2Load%

    IniRead, RestoreLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, Rest
    GuiControl, 4:, CheckRestore, %RestoreLoad%
    IniRead, OverwriteLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, Over
    GuiControl, 4:, CheckOverwrite, %OverwriteLoad%
    IniRead, DeleteLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, Delete
    GuiControl, 4:, CheckDelete, %DeleteLoad%
    IniRead, NewLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, DBManagement, New
    GuiControl, 4:, CheckNew, %NewLoad%
    
    IniRead, DesktopLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, SalesPad
    GuiControl, 4:, DisableSP, %DesktopLoad%
    IniRead, MobileLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Mobile
    GuiControl, 4:, DisableMOB, %MobileLoad%
    IniRead, DataCollectionLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, DataCollection
    GuiControl, 4:, DisableDC, %DataCollectionLoad%
    IniRead, ShipCenterLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, ShipCenter
    GuiControl, 4:, DisableSC, %ShipCenterLoad%
    IniRead, CardControlLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, CardControl
    GuiControl, 4:, DisableCC, %CardControlLoad%
    IniRead, GPAPILoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, API
    GuiControl, 4:, DisableAPI, %GPAPILoad%
    IniRead, GPWEBLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Web
    GuiControl, 4:, DisableWeb, %GPWEBLoad%
    IniRead, LaunchLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Launch
    GuiControl, 4:, DisableLaunch, %LaunchLoad%
    IniRead, AddLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Add
    GuiControl, 4:, DisableAdd, %AddLoad%
    IniRead, BuildLoad, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Build
    GuiControl, 4:, DisableBuild, %BuildLoad%

    IniRead, Dyn10Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics10
    GuiControl, 4:, CheckDyn10, %Dyn10Load%
    IniRead, Dyn13Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics13
    GuiControl, 4:, CheckDyn13, %Dyn13Load%
    IniRead, Dyn15Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics15
    GuiControl, 4:, CheckDyn15, %Dyn15Load%
    IniRead, Dyn16Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics16
    GuiControl, 4:, CheckDyn16, %Dyn16Load%
    IniRead, Dyn18Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, GPButtons, Dynamics18
    GuiControl, 4:, CheckDyn18, %Dyn18Load%

    IniRead, SR1Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud1
    GuiControl, 4:, CheckSPC1, %SR1Load%
    IniRead, SR2Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud2
    GuiControl, 4:, CheckSPC2, %SR2Load%
    IniRead, SR3Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud3
    GuiControl, 4:, CheckSPC3, %SR3Load%
    IniRead, SR4Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud4
    GuiControl, 4:, CheckSPC4, %SR4Load%
    IniRead, SR5Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud5
    GuiControl, 4:, CheckSPC5, %SR5Load%

    IniRead, Other1Load, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, PromptClose, Close
    GuiControl, 4:, PromptCloseBox, %Other1Load%
    return

4GuiClose: ; Close the GUI screen
    Gui, 4:Destroy
    return

Save: ; Saves the Settings fields to the Settings.ini file
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
    GuiControlGet, DisableLaunch, 4:
    IniWrite, %DisableLaunch%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BuildManagement, Build
    if DisableLaunch = 1
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
        GuiControl, 1:Disable, SR1
    }
    Else
    {
        GuiControl, 1:Enable, SR1
    }
    GuiControlGet, CheckSPC2, 4:
    IniWrite, %CheckSPC2%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud2
    if CheckSPC2 = 1
    {
        GuiControl, 1:Disable, SR2
    }
    Else
    {
        GuiControl, 1:Enable, SR2
    }
    GuiControlGet, CheckSPC3, 4:
    IniWrite, %CheckSPC3%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud3
    if CheckSPC3 = 1
    {
        GuiControl, 1:Disable, SR3
    }
    Else
    {
        GuiControl, 1:Enable, SR3
    }
    GuiControlGet, CheckSPC4, 4:
    IniWrite, %CheckSPC4%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud4
    if CheckSPC4 = 1
    {
        GuiControl, 1:Disable, SR4
    }
    Else
    {
        GuiControl, 1:Enable, SR4
    }
    GuiControlGet, CheckSPC5, 4:
    IniWrite, %CheckSPC5%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, SPCButtons, Cloud5
    if CheckSPC5 = 1
    {
        GuiControl, 1:Disable, SR5
    }
    Else
    {
        GuiControl, 1:Enable, SR5
    }

    GuiControlGet, PromptCloseBox, 4:
    IniWrite, %PromptCloseBox%, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, PromptClose, Close
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
    Gui, 10:Add, Edit, x10 y30 w218 vUserPWBox, %ServPW%
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

GPBackupsList:  ; Double clicking an option from the list box will launch it
    if (A_GuiEvent <> "DoubleClick")
        return

ButtonRestoreDB:    ; Button to restore the selected DB from the listbox
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
    GuiControlGet, GPBackupsList
    If GPBackupsList = 
    {
        MsgBox, Please Select a Backtup to Restore.
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
    IniRead, DBListDelete, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, BackupFolder, path
    GuiControlGet, GPBackupsList
    If GPBackupsList = 
    {
        MsgBox, Please Select a Backtup to Restore.
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
    run, "C:\Program Files (x86)\Microsoft Dynamics\GP2010\Dynamics.exe - Shortcut.lnk"
    return

D13:
    return

D15:
    return

D16:    ; Launches GP 2016
    run, "C:\Program Files (x86)\Microsoft Dynamics\GP2016\Dynamics - Shortcut.lnk"
    ;run, "C:\#SCRIPTS\Tests\DynamicsTest.bat"
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
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez01 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR01.bat"
        return
    }

ButtonSteveRodriguez02:
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez02 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR02.bat"
        return
    }

ButtonSteveRodriguez03:
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez03 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR03.bat"
        return
    }

ButtonSteveRodriguez04:
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez04 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR04.bat"
        return
    }

ButtonSteveRodriguez05:
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez05 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Script.DropSR05.bat"
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