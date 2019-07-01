; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Script Function: Trying to get DC to silently install

#SingleInstance, force
#NoEnv
SendMode Input


Gui, 1:Add, Button, x30 y30 w100 h25 gFromPath, Get DC
Gui, 1:Add, Button, x30 y60 w100 h25 gLaunchGUI2, GO
Gui, 1:Show, w300 h300, DC Silent Install Test
Return

FromPath:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection, Select a DataCollection Build, *.exe
    if ErrorLevel
        return
    ;run, %SelectedFile%
    return
    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
    FileCopy, %SelectedFile%, C:\#EnvMgr\TEMPFILES\INSTALLERS

LaunchGUI2:
    SplitPath, SelectedFile,, Instl
    ;Gui, 2:Add, Button, x30 y30 w100 h25 gFromPath, Get DC
    Gui, 2:Add, Text, x30 y50, Please enter the location you would like to install the following build to
    Gui, 2:Add, Edit, cgray x30 y70 w600 ReadOnly, %Instl%
    Gui, 2:Add, Edit, x30 y100 w600 vDCBuildLoc, C:\Program Files (x86)\DataCollection\
    Gui, 2:Add, Button, x420 y130 w100 h25 gDCCan, Cancel
    Gui, 2:Add, Button, x531 y130 w100 h25 gDCOK, OK
    Gui, 2:Show, w660 h170, Install DataCollection
    Return
    
    DCCan:
        MsgBox, 4, CANCEL, Are you sure you want to cancel?
        IfMsgBox, No
        {
            Return
        }
        IfMsgBox, Yes
        {
            Gui, 2:Destroy
            Return
        }

    DCOK:
        Gui, 2:Destroy
        Run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\SPInstall.bat" "%DCBuildLoc%"
        WinWait, C:\windows\system32\cmd.exe
        WinWaitClose
        Run, %DCBuildLoc%\DataCollection Extended Warehouse.exe



GuiClose:
    ExitApp