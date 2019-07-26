LoadFromSettings(SettingsOutput,Section,Key,CheckboxName,ButtonName) ; This function is designed to load values from settings.ini
{
    IniRead, %SettingsOutput%, Settings\Settings.ini, %Section%, %Key%
    GuiControl, 4:, %CheckboxName%, %SettingsOutput%
    if %SettingsOutput% = 1
    {
        GuiControl, 1:Disable, %ButtonName%
    }
}