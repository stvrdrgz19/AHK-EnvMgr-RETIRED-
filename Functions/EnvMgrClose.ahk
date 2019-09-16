; AutoHotkey Version:   1.1.30.03
; Platform:             Win10
; Author:               Steve Rodriguez
; Created:              9/16/2019
;
; Description: Function to check the "Prompt to close EnvMgr" Setting and react accordingly

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, Force
#KeyHistory, 0
SetBatchLines, -1
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed.
SetTitleMatchMode, 3 ; A window's title must exactly match WinTitle to be a match.
SetWorkingDir, %A_ScriptDir%
SplitPath, A_ScriptName, , , , thisscriptname
#MaxThreadsPerHotkey, 1 ; no re-entrant hotkey handling
; DetectHiddenWindows, On
; SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
; SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
; SetMouseDelay, -1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag

EnvMgrClose()
{
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