SPGPInstall()
{
    global
    GuiControlGet, BuildLoc
    Loop, C:\#EnvMgr\TEMPFILES\INSTALLERS\SalesPad.Desktop.Setup.*.exe
    {
        Run, %A_LoopFileLongPath% /S /D=%BuildLoc%
    }
}