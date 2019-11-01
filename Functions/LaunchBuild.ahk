LaunchBuild(Project)
{
    IniRead, inVar, Settings\Settings.ini, InstallPaths, %Project%
    FileSelectFile, SelectedFile, 1, %inVar%\, Select a Build, *.exe
    If ErrorLevel
        Return
    Run, %SelectedFile%
    Return
}