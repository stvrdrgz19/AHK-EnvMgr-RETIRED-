LoadSettingsScreen(SettingsInput,Section,Key,Field)
{
    IniRead, SettingsInput, Settings\Settings.ini, %Section%, %Key%
    GuiControl, 4:, %Field%, %SettingsInput%
}