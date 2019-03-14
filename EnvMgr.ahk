/*
-------------------------------------------------------------------------------
References
-------------------------------------------------------------------------------
REFRESH - https://autohotkey.com/board/topic/66602-refresh-gui-listbox-control/
CLIPBOARD - https://autohotkey.com/docs/misc/Clipboard.htm
FILESELECT - https://autohotkey.com/docs/commands/FileSelectFile.htm
FILEAPPEND - https://www.autohotkey.com/docs/commands/FileAppend.htm
RUNNING BAT MINIMIZED - https://www.winhelponline.com/blog/run-bat-files-invisibly-without-displaying-command-prompt/
-------------------------------------------------------------------------------
*/

#SingleInstance, force

Gui, Add, Button, x609 y354 w100 h30, Exit
Gui, Add, CheckBox, x15 y361 gUpdateA vCheckA, Always On Top
Gui, Add, Tab3, x10 y6 w701 h344, Databases\Builds|Dynamics\SQL Installations|Scripts
Gui, Tab, 1
Gui, Add, GroupBox, w345 h308, Database Management
Gui, Add, GroupBox, x375 y34 w322 h308, Build Management
;-----------------------------GroupBox 1 Fields-----------------------------;
Gui, Add, Text, x31 y60, Select a Database:
Gui, Add, Button, x152 y50 w100 h25, Refresh 
Gui, Add, ListBox, vGPBackupsList gGPBackupsList x31 y81 w220 r15
Gui, Add, Button, x260 y80 w100 h25, Restore DB
Gui, Add, Button, x260 y110 w100 h25, Backup DB
Gui, Add, Button, x260 y140 w100 h25 vDelete, Delete Backup
Gui, Add, Button, x260 y256 w100 h25, Backups Folder
;-----------------------------GroupBox 2 Fields-----------------------------;
Gui, Add, Text, x382 y60, Select a SalesPad Product to Install:
Gui, Add, Text, x382 y236, Launch an exisiting Build:
Gui, Add, Button, x382 y80 w150 h25, SalesPad Desktop
Gui, Add, Button, x540 y80 w150 h25, SalesPad Mobile
Gui, Add, Button, x382 y110 w150 h25, DataCollection
Gui, Add, Button, x382 y140 w150 h25, Ship Center
Gui, Add, Button, x540 y110 w150 h25, Card Control
Gui, Add, CheckBox, x383 y172 gUpdateB vCheckB, Install With Grizzly DLLs
Gui, Add, Button, x540 y140 w150 h25 vGPWEB, Web Portal
Gui, Add, Button, x540 y170 w150 h25 vGPAPI, Web API
Gui, Add, Button, x382 y256 w308 h25, Launch Build
;-----------------------------GroupBox 3 Fields-----------------------------;
Gui, Add, Text, x31 y294, Enter a Database Backup Name:
Gui, Add, Edit, x31 y312 w220 vDatabase,
Gui, Add, Button, x260 y310 w100 h25 vBak, New Backup
;--------------------IP Address section in the lower left--------------------;
Gui, Add, Text, x382 y316, IP Address: 
Gui, Add, Edit, cgray x437 y312 w100 ReadOnly vIP, %A_IPAddress1%
;------------------------------End of Tab 1------------------------------;
Gui, Tab, 2
Gui, Add, GroupBox, w345 h308, Dynamics GP
Gui, Add, Button, x30 y60 w200 h25, Dynamics GP 2013
Gui, Add, Button, x30 y90 w200 h25, Dynamics GP 2015
Gui, Add, Button, x30 y120 w200 h25, Dynamics GP 2016
Gui, Add, Button, x30 y150 w200 h25, Dynamics GP 2018
;------------------------------End of Tab 2------------------------------;
Gui, Tab, 3
Gui, Add, Text,, Select a Script to run:
Gui, Add, ListBox, Multi vScriptList gScriptList w225 r21
Gui, Add, Button, x254 y52 w100 h25, Run
Gui, Add, Button, x254 y82 w100 h25, Refresh
;------------------------------End of Tab 3------------------------------;
GuiControl, Disable, GPWEB
GuiControl, Disable, GPAPI
;GuiControl, Disable, CheckB
Gui, Show, w721 h390, Environment Mananger
;=============================================================================================;
;===========================================Gui 2=============================================;
;=============================================================================================;
;Gui, 2:Add, Text, x30 y40, Please enter the location you would like to install the following build to:
;Gui, 2:Add, Edit, x30 y90 w600 vBuildLoc, 
;Gui, 2:Add, Button, x420 y120 w100 h25 gCan, Cancel
;Gui, 2:Add, Button, x531 y120 w100 h25 gOK, OK


ListBoxDisplay:
    Loop, C:\#EnvMgr\BACKUPS\*, 2
    {
        GuiControl,, GPBackupsList, %A_LoopFileName%
    }

ScriptListDisplay:
    Loop, C:\#SCRIPTS\*.*
    {
        GuiControl,, ScriptList, %A_LoopFileName%
    }
    return

UpdateB:
    Gui, Submit, NoHide
    if CheckB = 1
    {
        VarCheck = 1
        return
    }
    Else
    {
        VarCheck = 0
        return
    }

GPBackupsList:
    if (A_GuiEvent <> "DoubleClick")
        return
ButtonRestoreDB:
    GuiControlGet, GPBackupsList
    MsgBox, 4, RESTORE?, Would you like to restore the Database listed below?`n`n%GPBackupsList%
    IfMsgBox, No
        return
    Run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DBRestore.bat" %GPBackupsList%,, UseErrorLevel
    return

ScriptList:
    if (A_GuiEvent <> "DoubleClick")
        return
ButtonRun:
    GuiControlGet, ScriptList
    MsgBox, 4,, Would you like to launch the Batch or AHK File below?`n`n%ScriptList%
    IfMsgBox, No
        return
    Run, C:\#SCRIPTS\%ScriptList%,, UseErrorLevel
    if (ErrorLevel = "ERROR")
        MsgBox Could not launch the specified file. Perhaps it is not associated with anything.
    return

ButtonBackupDB:
    GuiControlGet, GPBackupsList
    MsgBox, 4, OVERWRITE?, Would you like overwrite %GPBackupsList% with your current environment?
    IfMsgBox, No
        return
    Run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DBOverwrite.bat" %GPBackupsList%,, UseErrorLevel
    return

ButtonNewBackup:
    GuiControlGet, Database
    ifExist C:\#EnvMgr\BACKUPS\%Database%
        MsgBox,, ALREADY EXISTS, A backup named %Database% already exists.
    ifExist C:\#EnvMgr\BACKUPS\%Database%
        goto, CancelBak
    Run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DBBackup.bat" %Database%,, UseErrorLevel
    sleep, 2000
    goto, ButtonRefresh
    return
CancelBak:
return

ButtonDeleteBackup:
    GuiControlGet, GPBackupsList
    MsgBox, 4, DELETE?, Are you sure you want to delete backup %GPBackupsList%?
    ifMsgBox, Yes
        FileRemoveDir, C:\#EnvMgr\BACKUPS\%GPBackupsList%, 1
        sleep, 2000
        goto, ButtonRefresh
    return


ButtonSalesPadDesktop:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, Select a SalesPad Build, *.exe
    if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
        FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
    FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
    FileCopy, %SelectedFile%, C:\#EnvMgr\TEMPFILES\INSTALLERS
    SplitPath, SelectedFile,, Instl
    Gui, 2:Destroy
    Gui, 2:Add, Text, x30 y40, Please enter the location you would like to install the following build to:
    Gui, 2:Add, Edit, x30 y90 w600 vBuildLoc, 
    Gui, 2:Add, Button, x420 y120 w100 h25 gCan, Cancel
    Gui, 2:Add, Button, x531 y120 w100 h25 gOK, OK
    Gui, 2:Add, Edit, cgray x30 y60 w600 ReadOnly, %Instl%
    Gui, 2:Show, w660 h160, Test Second GUI
    return

Can:
    Gui, 2:Destroy
    return

OK:
    GuiControlGet, BuildLoc
    GuiControlGet, CheckB
    Gui, 2:Destroy
    run, "C:\#EnvMgr\SCRIPTS\SPInstall.bat" %BuildLoc%
    sleep, 5000
    if VarCheck = 1
    {
        Run *RunAs "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.GetGrizzlyDLL.bat" %Instl% %BuildLoc%
        sleep, 10000
        run, C:\Program Files (x86)\SalesPad.Desktop\%BuildLoc%\SalesPad.exe
        return
    }
    else
    {
        Goto, NotChecked
        return
    }
    Return

NotChecked:
    SplitPath, SelectedFile,, dir
    MsgBox, 4, EXTENDED DLL?, Do you need any Extended DLLs?
    ifMsgBox, No
        Goto, CustDLL
    Else
        FileSelectFile, FilesExt, M3, %dir%\ExtModules\WithOutCardControl, Select any DLLs needed, *.zip
        Array := StrSplit(FilesExt, "`n")

        for index, file in Array
        {
        	if index = 1
        		Dir := file
        	else
        		FileCopy, % Dir "\" file, C:\#EnvMgr\TEMPFILES\DLLs
        }
    FilesExt = 
    dir = 
    CustDLL:
    SplitPath, SelectedFile,, dir
    sleep, 3000
    MsgBox, 4, CUSTOM DLL?, Do you need any Custom DLLs?
    ifMsgBox, No
        Goto, NoDLL
    Else
        FileSelectFile, FilesCust, M3, %dir%\CustomModules\WithOutCardControl, Select any DLLs needed, *.zip
        Array := StrSplit(FilesCust, "`n")

        for index, file in Array
        {
        	if index = 1
        		Dir := file
        	else
        		FileCopy, % Dir "\" file, C:\#EnvMgr\TEMPFILES\DLLs
        }
    FilesCust = 
    run, "C:\#EnvMgr\SCRIPTS\FileUnzipAndMove.bat - Shortcut.lnk" %BuildLoc%
    NoDLL:
    ;MsgBox, C:\Program Files (x86)\SalesPad.Desktop\%BuildLoc%\SalesPad.exe
    ;run, SalesPad.exe, C:\Program Files (x86)\SalesPad.Desktop\%BuildLoc%\SalesPad.exe
    run, C:\Program Files (x86)\SalesPad.Desktop\%BuildLoc%\SalesPad.exe
    return

ButtonSalesPadMobile:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\Mobile-Server, Select a SalesPad Server Build, *.exe
    run, %SelectedFile%
    return

ButtonDataCollection:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection, Select a DataCollection Build, *.exe
    run, %SelectedFile%
    return

ButtonShipCenter:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\ShipCenter, Select a ShipCenter Build, *.exe
    run, %SelectedFile%
    return

ButtonCardControl:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares, Select a Card Control Build, *.exe
    run, %SelectedFile%
    return

ButtonWebPortal:
    return

ButtonWebAPI:
    return

ButtonLaunchBuild:
    FileSelectFile, SelectedFile, 1, C:\Program Files (x86)\SalesPad.Desktop, Select a Build, *.exe
    run, %SelectedFile%
    return

ButtonRefresh:
    GuiControl,, GPBackupsList, |
    GuiControl,, ScriptList, |
    goto, ListBoxDisplay
    Return

ButtonBackupsFolder:
    MsgBox, 4, OPEN FOLDER, Do you want to open the Database Backups Folder?
    IfMsgBox, No
        return
    Run, C:\#EnvMgr\BACKUPS
    return 

UpdateA:
    Gui, Submit, NoHide
    If CheckA = 1
    {
        Gui, +AlwaysOnTop
    }
    else
    {
        Gui, -AlwaysOnTop
    }
    Return

GuiClose:
ButtonExit:
ExitApp
