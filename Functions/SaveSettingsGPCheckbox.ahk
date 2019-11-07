SaveSettingsGPCheckbox()
{
    Global
    GuiControlGet, CheckDyn10, 4:
    GuiControlGet, CheckDyn13, 4:
    GuiControlGet, CheckDyn15, 4:
    GuiControlGet, CheckDyn16, 4:
    GuiControlGet, CheckDyn18, 4:
    IniWrite, %CheckDyn10%, Settings\Settings.ini, GPButtons, Dynamics10
    IniWrite, %CheckDyn13%, Settings\Settings.ini, GPButtons, Dynamics13
    IniWrite, %CheckDyn15%, Settings\Settings.ini, GPButtons, Dynamics15
    IniWrite, %CheckDyn16%, Settings\Settings.ini, GPButtons, Dynamics16
    IniWrite, %CheckDyn18%, Settings\Settings.ini, GPButtons, Dynamics18
    IniRead, GPLabVar1, Settings\Settings.ini, GPButtonLabels, GPButton1
    IniRead, GPLabVar2, Settings\Settings.ini, GPButtonLabels, GPButton2
    IniRead, GPLabVar3, Settings\Settings.ini, GPButtonLabels, GPButton3
    IniRead, GPLabVar4, Settings\Settings.ini, GPButtonLabels, GPButton4
    IniRead, GPLabVar5, Settings\Settings.ini, GPButtonLabels, GPButton5
    GuiControl,, Combo3, |
    GuiControl,, Combo3, Select GP to Launch||
    SaveDyn := []
    If CheckDyn10 = 0
    {
        SaveDyn.Push(GPLabVar1)
    }
    If CheckDyn13 = 0
    {
        SaveDyn.Push(GPLabVar2)
    }
    If CheckDyn15 = 0
    {
        SaveDyn.Push(GPLabVar3)
    }
    If CheckDyn16 = 0
    {
        SaveDyn.Push(GPLabVar4)
    }
    If CheckDyn18 = 0
    {
        SaveDyn.Push(GPLabVar5)
    }
    For Index, Element in SaveDyn
    {
        GuiControl,, Combo3, %Element%
    }
    Return
}
