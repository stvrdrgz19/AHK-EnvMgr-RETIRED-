InstallLoadFromSettings(SettingsOutput,Section,Key,ButtonName) ; This function is designed to load values from settings.ini
{
    global
    IniRead, %SettingsOutput%, Settings\Settings.ini, %Section%, %Key%
    if %SettingsOutput% = 1
    {
        GuiControl, SPGP:Disable, %ButtonName%
    }
}