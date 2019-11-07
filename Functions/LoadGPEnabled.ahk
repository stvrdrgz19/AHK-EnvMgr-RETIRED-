LoadGPEnabled()
{
    global
    IniRead, GP1, Settings\Settings.ini, GPButtons, Dynamics10
    IniRead, GP2, Settings\Settings.ini, GPButtons, Dynamics13
    IniRead, GP3, Settings\Settings.ini, GPButtons, Dynamics15
    IniRead, GP4, Settings\Settings.ini, GPButtons, Dynamics16
    IniRead, GP5, Settings\Settings.ini, GPButtons, Dynamics18
    IniRead, GPLab1, Settings\Settings.ini, GPButtonLabels, GPButton1
    IniRead, GPLab2, Settings\Settings.ini, GPButtonLabels, GPButton2
    IniRead, GPLab3, Settings\Settings.ini, GPButtonLabels, GPButton3
    IniRead, GPLab4, Settings\Settings.ini, GPButtonLabels, GPButton4
    IniRead, GPLab5, Settings\Settings.ini, GPButtonLabels, GPButton5
    EnabledGP := []
    If GP1 = 0
    {
        EnabledGP.Push(GPLab1)
    }
    If GP2 = 0
    {
        EnabledGP.Push(GPLab2)
    }
    If GP3 = 0
    {
        EnabledGP.Push(GPLab3)
    }
    If GP4 = 0
    {
        EnabledGP.Push(GPLab4)
    }
    If GP5 = 0
    {
        EnabledGP.Push(GPLab5)
    }
    For Index, Element in EnabledGP
    {
        GuiControl,, Combo3, %Element%
    }
    Return
}