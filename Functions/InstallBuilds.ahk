InstallBuilds(Product,Path,Prompt,SaveTo,Title,Launcher)
{
    global
    IniRead, Counter, Settings\ButtonCounters.ini, ButtonCounters, %Product%
    Counter += 1
    IniWrite, %Counter%, Settings\ButtonCounters.ini, ButtonCounters, %Product%
    FileSelectFile, SelectInstaller, 1, %Path%, %Prompt%, *.exe
    if ErrorLevel
        Return
    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
    FileCopy, %SelectInstaller%, C:\#EnvMgr\TEMPFILES\INSTALLERS
    SplitPath, SelectInstaller,, PathWithoutFile
    Variable1 := PathWithoutFile
    Gui, Installer:Destroy
    Gui, Installer:Add, Text, x15 y15, Please enter the location you would like to install the following build to:
    Gui, Installer:Add, Edit, cgray x15 y35 w600 ReadOnly, %PathWithoutFile%
    Gui, Installer:Add, Edit, x15 y65 w600 vEdit4, %SaveTo%
    Gui, Installer:Add, Button, +Default x400 y95 w100 h25 gInstallOK, OK
    Gui, Installer:Add, Button, x515 y95 w100 h25 gInstallCancel, Cancel
    Gui, Installer:Show, w630 h125, %Title%
    WinWaitClose, %Title%
    Return

    InstallOK:
        GuiControlGet, Edit4
        Gui, Installer:Destroy
        IniWrite, %PathWithoutFile%, Settings\Paths.ini, LastInstalledBuild, %Product%
        Loop, C:\#EnvMgr\TEMPFILES\INSTALLERS\*
        {
            Run, %A_LoopFileLongPath% /S /D=%Edit4%
        }
        While ! FileExist(Edit4 "\" Launcher)
        {
            Sleep 250
        }
        Run *RunAs "%Edit4%\%Launcher%"
        Return

    InstallCancel:
        MsgBox, 4, CANCEL, Are you sure you want to cancel?
        IfMsgBox, No
        {
            Return
        }
        IfMsgBox, Yes
        {
            Gui, Installer:Destroy
            Return
        }
}