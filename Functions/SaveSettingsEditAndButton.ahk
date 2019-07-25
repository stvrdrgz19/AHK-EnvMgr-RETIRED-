SaveSettingsEditAndButton(FieldToSave,Section,Key,ButtonName)
{
    GuiControlGet, %FieldToSave%, 4:
    IniWrite, %FieldToSave%, Path, %Section%, %Key%
    GuiControl, 1:, %ButtonName%, %FieldToSave%
}