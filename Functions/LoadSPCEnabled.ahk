LoadSPCEnabled()
{
    global
    IniRead, SPC1, Settings\Settings.ini, SPCButtons, Cloud1
    IniRead, SPC2, Settings\Settings.ini, SPCButtons, Cloud2
    IniRead, SPC3, Settings\Settings.ini, SPCButtons, Cloud3
    IniRead, SPC4, Settings\Settings.ini, SPCButtons, Cloud4
    IniRead, SPC5, Settings\Settings.ini, SPCButtons, Cloud5
    IniRead, SPCLab1, Settings\Settings.ini, CloudButtonNames, 01
    IniRead, SPCLab2, Settings\Settings.ini, CloudButtonNames, 02
    IniRead, SPCLab3, Settings\Settings.ini, CloudButtonNames, 03
    IniRead, SPCLab4, Settings\Settings.ini, CloudButtonNames, 04
    IniRead, SPCLab5, Settings\Settings.ini, CloudButtonNames, 05
    EnabledSPC := []
    If SPC1 = 0
    {
        EnabledSPC.Push(SPCLab1)
    }
    If SPC2 = 0
    {
        EnabledSPC.Push(SPCLab2)
    }
    If SPC3 = 0
    {
        EnabledSPC.Push(SPCLab3)
    }
    If SPC4 = 0
    {
        EnabledSPC.Push(SPCLab4)
    }
    If SPC5 = 0
    {
        EnabledSPC.Push(SPCLab5)
    }
    For Index, Element in EnabledSPC
    {
        GuiControl,, Combo4, %Element%
    }
    Return
}