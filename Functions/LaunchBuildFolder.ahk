LaunchBuildFolder(Project)
{
    IniRead, inVar, Settings\Settings.ini, InstallPaths, %Project%
    Run, %inVar%
    Return
}