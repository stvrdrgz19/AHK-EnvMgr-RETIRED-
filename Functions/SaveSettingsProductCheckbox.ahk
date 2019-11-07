SaveSettingsProductCheckbox()
{
    global
    GuiControlGet, DisableSP, 4:
    GuiControlGet, DisableMOB, 4:
    GuiControlGet, DisableDC, 4:
    GuiControlGet, DisableDCMOB, 4:
    GuiControlGet, DisableSC, 4:
    GuiControlGet, DisableCC, 4:
    GuiControlGet, DisableAPI, 4:
    GuiControlGet, DisableWeb, 4:
    IniWrite, %DisableSP%, Settings\Settings.ini, BuildManagement, SalesPad
    IniWrite, %DisableMOB%, Settings\Settings.ini, BuildManagement, Mobile
    IniWrite, %DisableDC%, Settings\Settings.ini, BuildManagement, DataCollection
    IniWrite, %DisableDCMOB%, Settings\Settings.ini, BuildManagement, WindowsMobile
    IniWrite, %DisableSC%, Settings\Settings.ini, BuildManagement, ShipCenter
    IniWrite, %DisableCC%, Settings\Settings.ini, BuildManagement, CardControl
    IniWrite, %DisableAPI%, Settings\Settings.ini, BuildManagement, API
    IniWrite, %DisableWeb%, Settings\Settings.ini, BuildManagement, Web
    GuiControl,, Combo2, |
    GuiControl,, Combo2, Select a Product to Install||
    SaveProduct := []
    If DisableSP = 0
    {
        SaveProduct.Push("SalesPad Desktop")
    }
    If DisableMOB = 0
    {
        SaveProduct.Push("SalesPad Mobile")
    }
    If DisableDC = 0
    {
        SaveProduct.Push("DataCollection")
    }
    If DisableDCMOB = 0
    {
        SaveProduct.Push("Windows Mobile")
    }
    If DisableSC = 0
    {
        SaveProduct.Push("Ship Center")
    }
    If DisableCC = 0
    {
        SaveProduct.Push("Card Control")
    }
    If DisableAPI = 0
    {
        SaveProduct.Push("API")
    }
    If DisableWeb = 0
    {
        SaveProduct.Push("WEB")
    }
    For Index, Element in SaveProduct
    {
        GuiControl,, Combo2, %Element%
    }
    Return
}


