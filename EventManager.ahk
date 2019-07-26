; AutoHotkey Version:   1.1.30.03
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: Re-writing the Event Manager tool using functions

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

; > Functions
LoadSettings(SettingsOutput,Section,Key,CheckboxName,ButtonName) ; This function is designed to load the Settings
{
    IniRead, %SettingsOutput%, Settings\Settings.ini, %Section%, %Key%
    GuiControl, 4:, %CheckboxName%, %SettingsOutput%
    if %SettingsOutput% = 1
    {
        GuiControl, 1:Disable, %ButtonName%
    }
}

; > Loading Settings
LoadSettings("RestoreLoad","DBManagement","Rest","CheckRestore","BRest")


; > Function
LoadSettingsScreen(SettingsInput,Section,Key,Field)
{
    IniRead, SettingsInput, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, %Section%, %Key%
    GuiControl, 4:, %Field%, %SettingsInput%
}

; > Calling Functions
LoadSettingsScreen("BackPathLoad","BackupFolder","path","BackupPath")
Return


; > Function
SaveSettingsEdit(FieldToSave,Section,Key)
{
    GuiControlGet, %FieldToSave%, 4:
    IniWrite, %FieldToSave%, Path, %Section%, %Key%
}

SaveSettingsEdit("BackupPath","BackupFolder","path")
SaveSettingsEdit("ServName","SQLCreds","Server")
SaveSettingsEdit("ServUN","SQLCreds","User")
SaveSettingsEdit("ServPW","SQLCreds","Password")
SaveSettingsEdit("DynamicsDB","Databases","Dynamics")
SaveSettingsEdit("RegDB","Databases","Company1")
SaveSettingsEdit("MBDB","Databases","Company2")
SaveSettingsEdit("GP1Loc","GPLaunchFile","GPLaunch1")
SaveSettingsEdit("GP2Loc","GPLaunchFile","GPLaunch2")
SaveSettingsEdit("GP3Loc","GPLaunchFile","GPLaunch3")
SaveSettingsEdit("GP4Loc","GPLaunchFile","GPLaunch4")
SaveSettingsEdit("GP5Loc","GPLaunchFile","GPLaunch5")
SaveSettingsEdit("PromptCloseBox","PromptClose","Close")

SaveSettingsCheckbox(FieldToSave,Section,Key,ButtonName)
{
    GuiControlGet, %FieldToSave%, 4:
    IniWrite, %FieldToSave%, Path, %Section%, %Key%
    If %FieldToSave% = 1
    {
        GuiControl, 1:Disable, %ButtonName%
    }
}

SaveSettingsCheckbox("CheckRestore","DBManagement","Rest","BRest")
SaveSettingsCheckbox("CheckOverwrite","DBManagement","Over","BOver")
SaveSettingsCheckbox("CheckDelete","DBManagement","Delete","Delete")
SaveSettingsCheckbox("CheckNew","DBManagement","New","Bak")

SaveSettingsCheckbox("DisableSP","BuildManagement","SalesPad","BDesktop")
SaveSettingsCheckbox("DisableDC","BuildManagement","DataCollection","BDataCollection")
SaveSettingsCheckbox("DisableSC","BuildManagement","ShipCenter","BShipCenter")
SaveSettingsCheckbox("DisableMOB","BuildManagement","Mobile","BMobile")
SaveSettingsCheckbox("DisableCC","BuildManagement","CardControl","BCardControl")
SaveSettingsCheckbox("DisableAPI","BuildManagement","API","GPAPI")
SaveSettingsCheckbox("DisableWeb","BuildManagement","Web","GPWEB")
SaveSettingsCheckbox("DisableLaunch","BuildManagement","Launch","BLaunch")
SaveSettingsCheckbox("DisableAdd","BuildManagement","Add","AddDLLs")
SaveSettingsCheckbox("DisableBuild","BuildManagement","Build","BBuild")

SaveSettingsCheckbox("CheckDyn10","GPButtons","Dynamics10","D10")
SaveSettingsCheckbox("CheckDyn13","GPButtons","Dynamics13","D13")
SaveSettingsCheckbox("CheckDyn15","GPButtons","Dynamics15","D15")
SaveSettingsCheckbox("CheckDyn16","GPButtons","Dynamics16","D16")
SaveSettingsCheckbox("CheckDyn18","GPButtons","Dynamics18","D18")

SaveSettingsCheckbox("CheckSPC1","SPCButtons","Cloud1","Cloud01")
SaveSettingsCheckbox("CheckSPC2","SPCButtons","Cloud2","Cloud02")
SaveSettingsCheckbox("CheckSPC3","SPCButtons","Cloud3","Cloud03")
SaveSettingsCheckbox("CheckSPC4","SPCButtons","Cloud4","Cloud04")
SaveSettingsCheckbox("CheckSPC5","SPCButtons","Cloud5","Cloud05")

SaveSettingsEditAndButton(FieldToSave,Section,Key,ButtonName)
{
    GuiControlGet, %FieldToSave%, 4:
    IniWrite, %FieldToSave%, Path, %Section%, %Key%
    GuiControl, 1:, %ButtonName%, %FieldToSave%
}

SaveSettingsEditAndButton("CloudLabel01","CloudButtonNames","01","Cloud01")
SaveSettingsEditAndButton("CloudLabel02","CloudButtonNames","02","Cloud02")
SaveSettingsEditAndButton("CloudLabel03","CloudButtonNames","03","Cloud03")
SaveSettingsEditAndButton("CloudLabel04","CloudButtonNames","04","Cloud04")
SaveSettingsEditAndButton("CloudLabel05","CloudButtonNames","05","Cloud05")

SaveSettingsEditAndButton("GPLabel1","GPButtonLabels","GPButton1","D10")
SaveSettingsEditAndButton("GPLabel2","GPButtonLabels","GPButton2","D13")
SaveSettingsEditAndButton("GPLabel3","GPButtonLabels","GPButton3","D15")
SaveSettingsEditAndButton("GPLabel4","GPButtonLabels","GPButton4","D16")
SaveSettingsEditAndButton("GPLabel5","GPButtonLabels","GPButton5","D18")