SaveSettingsEditAndButton(FieldToSave,Section,Key,ButtonName)
{
    global ;CloudLabel01 ,CloudLabel02 ,CloudLabel03 ,CloudLabel04 ,CloudLabel05 ,GPLabel1 ,GPLabel2 ,GPLabel3 ,GPLabel4 ,GPLabel
    GuiControlGet, CloudLabel01, 4:
    GuiControlGet, CloudLabel02, 4:
    GuiControlGet, CloudLabel03, 4:
    GuiControlGet, CloudLabel04, 4:
    GuiControlGet, CloudLabel05, 4:
    GuiControlGet, GPLabel1, 4:
    GuiControlGet, GPLabel2, 4:
    GuiControlGet, GPLabel3, 4:
    GuiControlGet, GPLabel4, 4:
    GuiControlGet, GPLabel5, 4:
    IniWrite, %FieldToSave%, Settings\Settings.ini, %Section%, %Key%
    GuiControl, 1:, %ButtonName%, %FieldToSave%
}
