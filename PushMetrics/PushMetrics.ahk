; AutoHotkey Version:   1.1.30.03
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: 

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

If A_IsAdmin = 0
{
    if A_IsCompiled
        Run *RunAs "%A_ScriptFullPath%"
    else
        Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

FromSettings := "C:\EnvMgr\Settings"
MetricsDump = \\sp-fileserv-01\Shares\Shared Folders\SteveR\Environment Manager\Metrics\%A_UserName%\%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%

FileCreateDir, %MetricsDump%
FileCopy, %FromSettings%\*, %MetricsDump% ;\%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%, 1

;MsgBox, 0, test, %MetricsDump%\%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%
Return