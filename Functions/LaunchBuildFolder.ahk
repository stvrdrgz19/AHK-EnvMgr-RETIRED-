LaunchBuildFolder(Project,Version)
{
    If Version = x64
    {
        IniRead, inVar, Settings\Settings.ini, InstallPaths, SalesPad Desktop64
    }
    If (Version = "x86" || Version = "Pre")
    {
        IniRead, inVar, Settings\Settings.ini, InstallPaths, SalesPad Desktop86
    }
    Run, %inVar%
    Return
}