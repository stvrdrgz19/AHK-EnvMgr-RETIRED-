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
LoadSettings("OverwriteLoad","DBManagement","Over","CheckOverwrite","BOver")
LoadSettings("DeleteLoad","DBManagement","Delete","CheckDelete","Delete")
LoadSettings("NewLoad","DBManagement","New","CheckNew","Bak")

LoadSettings("DesktopLoad","BuildManagement","SalesPad","DisableSP","BDesktop")
LoadSettings("MobileLoad","BuildManagement","Mobile","DisableMOB","BMobile")
LoadSettings("DataCollectionLoad","BuildManagement","DataCollection","DisableDC","BDataCollection")
LoadSettings("ShipCenterLoad","BuildManagement","ShipCenter","DisableSC","BShipCenter")
LoadSettings("CardControlLoad","BuildManagement","CardControl","DisableCC","BCardControl")
LoadSettings("GPAPILoad","BuildManagement","API","DisableAPI","GPAPI")
LoadSettings("GPWEBLoad","BuildManagement","Web","DisableWeb","GPWEB")
LoadSettings("LaunchLoad","BuildManagement","Launch","DisableLaunch","BLaunch")
LoadSettings("AddLoad","BuildManagement","Add","DisableAdd","AddDLLs")
LoadSettings("BuildLoad","BuildManagement","Build","DisableBuild","BBuild")

LoadSettings("Dyn10Load","GPButtons","Dynamics10","CheckDyn10","D10")
LoadSettings("Dyn13Load","GPButtons","Dynamics13","CheckDyn13","D13")
LoadSettings("Dyn15Load","GPButtons","Dynamics15","CheckDyn15","D15")
LoadSettings("Dyn16Load","GPButtons","Dynamics16","CheckDyn16","D16")
LoadSettings("Dyn18Load","GPButtons","Dynamics18","CheckDyn18","D18")

LoadSettings("Cloud01Load","SPCButtons","Cloud1","CheckSPC1","Cloud01")
LoadSettings("Cloud02Load","SPCButtons","Cloud2","CheckSPC2","Cloud02")
LoadSettings("Cloud03Load","SPCButtons","Cloud3","CheckSPC3","Cloud03")
LoadSettings("Cloud04Load","SPCButtons","Cloud4","CheckSPC4","Cloud04")
LoadSettings("Cloud05Load","SPCButtons","Cloud5","CheckSPC5","Cloud05")