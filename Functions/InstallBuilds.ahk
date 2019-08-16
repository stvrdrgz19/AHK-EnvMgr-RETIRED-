InstallBuilds(Product,Path,Prompt,SaveTo,Title,Launcher)
{
    global
    IniRead, Counter, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, %Product%
    Counter += 1
    IniWrite, %Counter%, C:\Users\steve.rodriguez\Desktop\Files\ButtonCounters.ini, ButtonCounters, %Product%
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
    Gui, Installer:Add, Text, x30 y40, Please enter the location you would like to install the following build to:
    Gui, Installer:Add, Edit, cgray x30 y60 w600 ReadOnly, %PathWithoutFile%
    Gui, Installer:Add, Edit, x30 y90 w600 vEdit4, %SaveTo%
    Gui, Installer:Add, Button, x420 y120 w100 h25 gCancel, Cancel
    Gui, Installer:Add, Button, +Default x531 y120 w100 h25 gOK, OK
    Gui, Installer:Show, w660 h160, %Title%
    Return

    Cancel:
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

    OK:
        GuiControlGet, Edit4
        IniWrite, %PathWithoutFile%, C:\Users\steve.rodriguez\Desktop\Files\Paths.ini, LastInstalledBuild, %Product%
        Gui, Installer:Destroy
        run, "Scripts\DCSilentInstall.bat" "%Edit4%"
        WinWait, C:\windows\system32\cmd.exe
        WinWaitClose
        Sleep 4000
        Run *RunAs "%Edit4%\%Launcher%"
        Return
}