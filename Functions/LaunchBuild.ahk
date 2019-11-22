LaunchBuild(Project)
{
    IniRead, inVar, Settings\Settings.ini, InstallPaths, %Project%
    FileSelectFile, SelectedFile, 1, %inVar%\, Select a Build, *.exe
    If ErrorLevel
        Return
    IniWrite, %SelectedFile%, Settings\Settings.ini, LastLaunchedBuild, %Project%
    Run, %SelectedFile%
    Return
}