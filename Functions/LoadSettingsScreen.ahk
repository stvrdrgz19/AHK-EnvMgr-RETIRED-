LoadSettingsScreen(SettingsInput,Section,Key,Field)
{
    IniRead, SettingsInput, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, %Section%, %Key%
    GuiControl, 4:, %Field%, %SettingsInput%
}