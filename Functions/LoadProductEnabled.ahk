LoadProductEnabled()
{
    global
    IniRead, PROD1, Settings\Settings.ini, BuildManagement, SalesPad
    IniRead, PROD2, Settings\Settings.ini, BuildManagement, Mobile
    IniRead, PROD3, Settings\Settings.ini, BuildManagement, DataCollection
    IniRead, PROD4, Settings\Settings.ini, BuildManagement, WindowsMobile
    IniRead, PROD5, Settings\Settings.ini, BuildManagement, ShipCenter
    IniRead, PROD6, Settings\Settings.ini, BuildManagement, CardControl
    IniRead, PROD7, Settings\Settings.ini, BuildManagement, API
    IniRead, PROD8, Settings\Settings.ini, BuildManagement, Web
    EnabledProd := []
    If PROD1 = 0
    {
        EnabledProd.Push("SalesPad Desktop")
    }
    If PROD2 = 0
    {
        EnabledProd.Push("SalesPad Mobile")
    }
    If PROD3 = 0
    {
        EnabledProd.Push("DataCollection")
    }
    If PROD4 = 0
    {
        EnabledProd.Push("Windows Mobile")
    }
    If PROD5 = 0
    {
        EnabledProd.Push("Ship Center")
    }
    If PROD6 = 0
    {
        EnabledProd.Push("Card Control")
    }
    If PROD7 = 0
    {
        EnabledProd.Push("API")
    }
    If PROD8 = 0
    {
        EnabledProd.Push("WEB")
    }
    For Index, Element in EnabledProd
    {
        GuiControl,, Combo2, %Element%
    }
    Return
}