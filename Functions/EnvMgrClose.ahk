EnvMgrClose()
{
    WinGetPos, xVar, yVar, Width, Height, Environment Mananger
    IniWrite, %xVar%, Settings\Settings.ini, Position, xPOS
    IniWrite, %yVar%, Settings\Settings.ini, Position, yPOS
    ;IniRead, PromptToClose, \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Files\%A_UserName%\Settings.ini, PromptClose, Close
    IniRead, PromptToClose, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Settings\Settings.ini, PromptClose, Close
    if PromptToClose = 1
    {
        MsgBox, 36, CLOSE?, Are you sure you want to close Environment Manager?
        IfMsgBox, No
        {
            Return
        }
        IfMsgBox, Yes
        {
            ExitApp
        }
    }
    if PromptToClose = 0
    {
        ExitApp
    }
}