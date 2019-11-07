SaveSettingsSPCCheckbox()
{
    global
    GuiControlGet, CheckSPC1, 4:
    GuiControlGet, CheckSPC2, 4:
    GuiControlGet, CheckSPC3, 4:
    GuiControlGet, CheckSPC4, 4:
    GuiControlGet, CheckSPC5, 4:
    IniWrite, %CheckSPC1%, Settings\Settings.ini, SPCButtons, Cloud1
    IniWrite, %CheckSPC2%, Settings\Settings.ini, SPCButtons, Cloud2
    IniWrite, %CheckSPC3%, Settings\Settings.ini, SPCButtons, Cloud3
    IniWrite, %CheckSPC4%, Settings\Settings.ini, SPCButtons, Cloud4
    IniWrite, %CheckSPC5%, Settings\Settings.ini, SPCButtons, Cloud5
    IniRead, %SPCLab1%, Settings\Settings.ini, CloudButtonNames, 01
    IniRead, %SPCLab2%, Settings\Settings.ini, CloudButtonNames, 02
    IniRead, %SPCLab3%, Settings\Settings.ini, CloudButtonNames, 03
    IniRead, %SPCLab4%, Settings\Settings.ini, CloudButtonNames, 04
    IniRead, %SPCLab5%, Settings\Settings.ini, CloudButtonNames, 05
    GuiControl,, Combo4, |
    GuiControl,, Combo4, Select Cloud Tenant to Delete||
    SaveSPC := []
    If CheckSPC1 = 0
    {
        SaveSPC.Push(SPCLab1)
    }
    If CheckSPC2 = 0
    {
        SaveSPC.Push(SPCLab2)
    }
    If CheckSPC3 = 0
    {
        SaveSPC.Push(SPCLab3)
    }
    If CheckSPC4 = 0
    {
        SaveSPC.Push(SPCLab4)
    }
    If CheckSPC5 = 0
    {
        SaveSPC.Push(SPCLab5)
    }
    For Index, Element in SaveSPC
    {
        GuiControl,, Combo4, %Element%
    }
    Return
}