Settings()
{
;============================================================================================================================================
;   Settings GUI
;============================================================================================================================================
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

;============================================================================================================================================
;   Loading Settings values from Settings.ini via Functions
;============================================================================================================================================
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

;============================================================================================================================================
;   Settings Screen Controls
;============================================================================================================================================
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
}