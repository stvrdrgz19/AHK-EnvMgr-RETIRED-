SaveSettingsCheckboxNoButton(FieldToSave,Section,Key)
{   
    global 
    GuiControlGet, DisableGrizz, 4:
    GuiControlGet, DisableTPG, 4:
    GuiControlGet, DisableDBUpdate, 4:
    IniWrite, %FieldToSave%, Settings\Settings.ini, %Section%, %Key%
}