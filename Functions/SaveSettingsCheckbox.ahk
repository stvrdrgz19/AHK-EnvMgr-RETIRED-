SaveSettingsCheckbox(FieldToSave,Section,Key,ButtonName)
{   
    global 
    GuiControlGet, CheckRestore, 4:
    GuiControlGet, CheckOverwrite, 4:
    GuiControlGet, CheckDelete, 4:
    GuiControlGet, CheckNew, 4:
    GuiControlGet, CheckBackupsFolder, 4:
    GuiControlGet, CheckAddDesc, 4:
    GuiControlGet, DisableInstall, 4:
    GuiControlGet, DisableLaunch, 4:
    GuiControlGet, DisableAdd, 4:
    GuiControlGet, DisableBuild, 4:
    GuiControlGet, CheckSPC1, 4:
    GuiControlGet, CheckSPC2, 4:
    GuiControlGet, CheckSPC3, 4:
    GuiControlGet, CheckSPC4, 4:
    GuiControlGet, CheckSPC5, 4:
    GuiControlGet, GPInstallFolder, 4:
    GuiControlGet, SPCDeleteButton, 4:
    GuiControlGet, LaunchOctopush, 4:
    GuiControlGet, AOT, 4:
    GuiControlGet, GPLaunchButton, 4:
    IniWrite, %FieldToSave%, Settings\Settings.ini, %Section%, %Key%
    If FieldToSave = 1
    {
        GuiControl, 1:Disable, %ButtonName%
    }
    If FieldToSave = 0
    {
        GuiControl, 1:Enable, %ButtonName%
    }
}





    ; ,CheckRestore ,CheckOverwrite ,CheckDelete ,CheckNew ,DisableSP ,DisableDC ,DisableSC ,DisableMOB ,DisableCC ,DisableAPI ,DisableWeb ,DisableLaunch ,DisableAdd ,DisableBuild ,CheckDyn10 ,CheckDyn13 ,CheckDyn15 ,CheckDyn16 ,CheckDyn18 ,CheckSPC1 ,CheckSPC2 ,CheckSPC3 ,CheckSPC4 ,CheckSPC5