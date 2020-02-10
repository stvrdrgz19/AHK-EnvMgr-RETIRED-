LaunchBuildFolder(Project,Version)
{
    If Version = x64
    {
        IniRead, inVar, Settings\Settings.ini, InstallPaths, SalesPad Desktop64
    }
    If Version = x86
    {
        IniRead, inVar, Settings\Settings.ini, InstallPaths, SalesPad Desktop86
    }
    Run, %inVar%
    Return
}