LoadGPDisabled()
{
    global
    IniRead, GP1, Settings\Settings.ini, GPButtons, Dynamics10
    IniRead, GP2, Settings\Settings.ini, GPButtons, Dynamics13
    IniRead, GP3, Settings\Settings.ini, GPButtons, Dynamics15
    IniRead, GP4, Settings\Settings.ini, GPButtons, Dynamics16
    IniRead, GP5, Settings\Settings.ini, GPButtons, Dynamics18
    IniRead, GPLab, Settings\Settings.ini, GPButtonLabels, GPButton1
    IniRead, GPLab, Settings\Settings.ini, GPButtonLabels, GPButton2
    IniRead, GPLab, Settings\Settings.ini, GPButtonLabels, GPButton3
    IniRead, GPLab, Settings\Settings.ini, GPButtonLabels, GPButton4
    IniRead, GPLab, Settings\Settings.ini, GPButtonLabels, GPButton5
    GuiControl,, Combo3, |
    If (GP1 = 0 && GP2 = 0 && GP3 = 0 && GP4 = 0 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||
    }
    Else If (GP1 = 1 && GP2 = 0 && GP3 = 0 && GP4 = 0 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%
    }
    Else If (GP1 = 1 && GP2 = 1 && GP3 = 0 && GP4 = 0 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton2%
    }
    Else If (GP1 = 1 && GP2 = 1 && GP3 = 1 && GP4 = 0 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton2%|%GPButton3%
    }
    Else If (GP1 = 1 && GP2 = 1 && GP3 = 1 && GP4 = 1 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton2%|%GPButton3%|%GPButton4%
    }
    Else If (GP1 = 1 && GP2 = 1 && GP3 = 1 && GP4 = 1 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton2%|%GPButton3%|%GPButton4%|%GPButton5%
    }
    Else If (GP1 = 0 && GP2 = 1 && GP3 = 0 && GP4 = 0 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton2%
    }
    Else If (GP1 = 0 && GP2 = 1 && GP3 = 1 && GP4 = 0 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton2%|%GPButton3%
    }
    Else If (GP1 = 0 && GP2 = 1 && GP3 = 1 && GP4 = 1 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton2%|%GPButton3%|%GPButton4%
    }
    Else If (GP1 = 0 && GP2 = 1 && GP3 = 1 && GP4 = 1 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton2%|%GPButton3%|%GPButton4%|%GPButton5%
    }
    Else If (GP1 = 0 && GP2 = 0 && GP3 = 1 && GP4 = 0 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton3%
    }
    Else If (GP1 = 0 && GP2 = 0 && GP3 = 1 && GP4 = 1 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton3%|%GPButton4%
    }
    Else If (GP1 = 0 && GP2 = 0 && GP3 = 1 && GP4 = 1 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton3%|%GPButton4%|%GPButton5%
    }
    Else If (GP1 = 1 && GP2 = 0 && GP3 = 1 && GP4 = 1 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton3%|%GPButton4%|%GPButton5%
    }
    Else If (GP1 = 0 && GP2 = 0 && GP3 = 0 && GP4 = 1 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton4%
    }
    Else If (GP1 = 0 && GP2 = 0 && GP3 = 0 && GP4 = 1 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton4%|%GPButton5%
    }
    Else If (GP1 = 1 && GP2 = 0 && GP3 = 0 && GP4 = 1 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton4%|%GPButton5%
    }
    Else If (GP1 = 1 && GP2 = 1 && GP3 = 0 && GP4 = 1 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton2%|%GPButton4%|%GPButton5%
    }
    Else If (GP1 = 0 && GP2 = 0 && GP3 = 0 && GP4 = 0 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton5%
    }
    Else If (GP1 = 1 && GP2 = 0 && GP3 = 0 && GP4 = 0 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton5%
    }
    Else If (GP1 = 1 && GP2 = 1 && GP3 = 0 && GP4 = 0 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton2%|%GPButton5%
    }
    Else If (GP1 = 1 && GP2 = 1 && GP3 = 1 && GP4 = 0 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton2%|%GPButton3%|%GPButton5%
    }
    Else If (GP1 = 1 && GP2 = 0 && GP3 = 1 && GP4 = 0 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton3%|%GPButton5%
    }
    Else If (GP1 = 0 && GP2 = 1 && GP3 = 0 && GP4 = 1 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton2%|%GPButton4%
    }
    Else If (GP1 = 1 && GP2 = 0 && GP3 = 1 && GP4 = 1 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||Dynamcis 1|%GPButton3%|%GPButton4%
    }
    Else If (GP1 = 1 && GP2 = 1 && GP3 = 0 && GP4 = 1 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton2%|%GPButton4%
    }
    Else If (GP1 = 1 && GP2 = 0 && GP3 = 0 && GP4 = 1 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton4%
    }
    Else If (GP1 = 0 && GP2 = 1 && GP3 = 0 && GP4 = 0 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||Dynamcis 2|%GPButton5%
    }
    Else If (GP1 = 1 && GP2 = 0 && GP3 = 1 && GP4 = 0 && GP5 = 0 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton1%|%GPButton3%
    }
    Else If (GP1 = 0 && GP2 = 0 && GP3 = 1 && GP4 = 0 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton3%|%GPButton5%
    }
    Else If (GP1 = 0 && GP2 = 1 && GP3 = 0 && GP4 = 1 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton2%|%GPButton4%|%GPButton5%
    }
    Else (GP1 = 0 && GP2 = 1 && GP3 = 1 && GP4 = 0 && GP5 = 1 )
    {
        GuiControl,, Combo3, Select GP to Launch||%GPButton2%|%GPButton3%|%GPButton5%
    }
    Return
}