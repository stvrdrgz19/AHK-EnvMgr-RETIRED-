#SingleInstance, force

Gui, Add, Button, x609 y354 w100 h30, Exit
Gui, Add, Text, x15 y361, IP Address: 
Gui, Add, Edit, cgray x75 y357 w100 ReadOnly vIP, %A_IPAddress1%
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
Gui, Add, Text, x382 y264, Launch an exisiting Build:
Gui, Add, Button, x382 y80 w150 h25, SalesPad Desktop
Gui, Add, Button, x540 y80 w150 h25, SalesPad Mobile
Gui, Add, Button, x382 y110 w150 h25, DataCollection
Gui, Add, Button, x382 y140 w150 h25, Ship Center
Gui, Add, Button, x540 y110 w150 h25, Card Control
Gui, Add, CheckBox, x383 y172 gUpdateB vCheckB, Install With Grizzly DLLs
Gui, Add, Button, x540 y140 w150 h25 vGPAPI, Web API
Gui, Add, Button, x540 y170 w150 h25 vGPWEB, Web Portal 
Gui, Add, Button, x382 y280 w308 h25, Launch Build
Gui, Add, Button, x382 y310 w150 h25 vAddDLLs, Add DLLs
Gui, Add, Button, x540 y310 w150 h25, Build Folder
;-----------------------------GroupBox 3 Fields-----------------------------;
Gui, Add, Text, x31 y294, Enter a Database Backup Name:
Gui, Add, Edit, x31 y312 w220 vDatabase,
Gui, Add, Button, x260 y310 w100 h25 vBak, New Backup
;------------------------------End of Tab 1------------------------------;
Gui, Tab, 2
Gui, Add, GroupBox, w345 h308, Dynamics GP
Gui, Add, Button, x30 y60 w200 h25, Dynamics GP 2013
Gui, Add, Button, x30 y90 w200 h25, Dynamics GP 2015
Gui, Add, Button, x30 y120 w200 h25 gD16, Dynamics GP 2016
Gui, Add, Button, x30 y150 w200 h25, Dynamics GP 2018
;------------------------------End of Tab 2------------------------------;
Gui, Tab, 3
Gui, Add, Text,, Select a Script to run:
Gui, Add, ListBox, Multi vScriptList gScriptList w225 r21
Gui, Add, Button, x254 y52 w100 h25, Run
Gui, Add, Button, x254 y82 w100 h25, Refresh
Gui, Add, Button, x254 y112 w100 h25, Scripts Folder
Gui, Add, Button, x540 y80 w150 h25, SteveRodriguez01
Gui, Add, Button, x540 y110 w150 h25, SteveRodriguez02
Gui, Add, Button, x540 y140 w150 h25, SteveRodriguez03
Gui, Add, Button, x540 y170 w150 h25, SteveRodriguez04
Gui, Add, Button, x540 y200 w150 h25, SteveRodriguez05
;------------------------------End of Tab 3------------------------------;
;GuiControl, Disable, GPWEB
;GuiControl, Disable, AddDLLs
Gui, Show, w721 h390, Environment Mananger


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
    WinWait, C:\WINDOWS\system32\cmd.exe
    WinWaitClose
    MsgBox,, COMPLETED, Database %GPBackupsList% was restored successfully.
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
    if Database = 
    {
        MsgBox,, ERROR, No Database Name was entered.
        return
    }
    Else
    {
        ifExist C:\#EnvMgr\BACKUPS\%Database%
        {
            MsgBox,, ALREADY EXISTS, A backup named %Database% already exists.
            GuiControl,, Database, 
            return
        }
        Else
        {
            MsgBox, 4, CREATE BACKUP?, Are you sure you want to create backup %Database%?
            ifMsgBox, No
            {
                MsgBox,, CANCEL, No backup was created.
                GuiControl,, Database, 
                return
            }
            ifMsgBox, Yes
            {
                Run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DBBackup.bat" %Database%,, UseErrorLevel
                WinWait, C:\WINDOWS\system32\cmd.exe
                WinWaitClose
                GuiControl,, Database, 
                MsgBox,, CREATED, Database %Database% was created.
                goto, ButtonRefresh
                return
            }
        }
    }

ButtonDeleteBackup:
    GuiControlGet, GPBackupsList
    MsgBox, 4, DELETE?, Are you sure you want to delete backup %GPBackupsList%?
    ifMsgBox, Yes
    {
        FileRemoveDir, C:\#EnvMgr\BACKUPS\%GPBackupsList%, 1
        MsgBox,, DELETED, Database %GPBackupsList% was deleted.
        goto, ButtonRefresh
        return
    }
    IfMsgBox, No
    {
        MsgBox,, CANCEL, Backup %GPBackupsList% was not deleted.
        return
    }

ButtonSalesPadDesktop:
    GuiControlGet, CheckB
    If VarCheck = 1
    {
        MsgBox, 4, Grizzly Build?, Are you installing a Grizzly Build?
        ifMsgBox, No
        {
            GuiControl, , CheckB, 0
            VarCheck = 0
            return
        }
    }
    Else
    {
        Goto, GetBuild
        return
    }

GetBuild:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, Select a SalesPad Build, *.exe
    if ErrorLevel
        return
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
    Gui, 2:Show, w660 h160, Install SalesPad GP
    return

Can:
    Gui, 2:Destroy
    return

OK:
    GuiControlGet, BuildLoc
    GuiControlGet, CheckB
    Gui, 2:Destroy
    run, "C:\#EnvMgr\SCRIPTS\SPInstall.bat" %BuildLoc%
    WinWait, C:\WINDOWS\system32\cmd.exe
    WinWaitClose
    if VarCheck = 1
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.GetGrizzlyDLL.bat" %Instl%
        WinWait, C:\WINDOWS\system32\cmd.exe
        WinWaitClose
        FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, C:\Program Files (x86)\SalesPad.Desktop\%BuildLoc%
        FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
        sleep 3000
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
    run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\FileUnzipAndMove.bat"
    WinWait, C:\WINDOWS\system32\cmd.exe
    WinWaitClose
    FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, C:\Program Files (x86)\SalesPad.Desktop\%BuildLoc%
    FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*

CustDLL:
    SplitPath, SelectedFile,, dir
    sleep, 2000
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
    run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\FileUnzipAndMove.bat"
    WinWait, C:\WINDOWS\system32\cmd.exe
    WinWaitClose
    FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, C:\Program Files (x86)\SalesPad.Desktop\%BuildLoc%
    FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*

NoDLL:
    run, C:\Program Files (x86)\SalesPad.Desktop\%BuildLoc%\SalesPad.exe
    return

ButtonSalesPadMobile:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\Mobile-Server, Select a SalesPad Server Build, *.exe
    if ErrorLevel
        return
    run, %SelectedFile%
    return

ButtonDataCollection:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection, Select a DataCollection Build, *.exe
    if ErrorLevel
        return
    run, %SelectedFile%
    return

ButtonShipCenter:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\ShipCenter, Select a ShipCenter Build, *.exe
    if ErrorLevel
        return
    run, %SelectedFile%
    return

ButtonCardControl:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares, Select a Card Control Build, *.exe
    if ErrorLevel
        return
    run, %SelectedFile%
    return

ButtonWebAPI:
    If FileExist("C:\inetpub\wwwroot\SalesPadWebAPI\*.msi")
        Loop, C:\inetpub\wwwroot\SalesPadWebAPI\*.msi
        {
        	Run, %A_LoopFileLongPath%
            WinWait, SalesPad WebAPI Setup
            WinWaitClose
            Goto, Continue
        }
    Else
        Goto, Continue
    Continue:
    FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\SalesPad.WebApi, Select an API Build, *.msi
    if ErrorLevel
        return
    run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.APIDLLCopy.bat - Shortcut.lnk" %SelectedFile%
    Loop, C:\inetpub\wwwroot\SalesPadWebAPI\*.msi
    {
    	Run, %A_LoopFileLongPath%
        Return
    }

ButtonWebPortal:
    FileSelectFile, SelectedFile, 1, , Select a Web Build, *.zip
    if ErrorLevel
        return
    SplitPath, SelectedFile,, WEB
    run, "" %WEB%
    return

ButtonAddDLLs:
    Process, Exist, SalesPad.exe
        if ! errorLevel
        {
            Gui, 3:Destroy
            Gui, 3:Add, Text, x30 y20, Select the SalesPad Install you want to add DLLs to:
            Gui, 3:Add, Edit, x30 y37 w600 vDLLFrom, 
            Gui, 3:Add, Button, x630 y36 w23 h23 ggetfile1 vgetfile1, ...
            Gui, 3:Add, Text, x30 y73, Select the SalesPad Build you need DLLs from:
            Gui, 3:Add, Edit, x30 y90 w600 vDLLPlace, 
            Gui, 3:Add, Button, x630 y89 w23 h23 ggetfile2 vgetfile2, ...
            Gui, 3:Add, Button, x420 y120 w100 h25 gCanx, Cancel
            Gui, 3:Add, Button, x531 y120 w100 h25 gOKx, OK
            Gui, 3:Show, w692 h160, Add DLLs
            return
        }
        else
        {
            MsgBox, 4, CLOSE, SalesPad must be closed for DLLs to be added properly.`n`nDo you wan't Environment Manager to close SalesPad?
            ifMsgBox, Yes
            {
                MsgBox, Close SalesPad
                return
            }
            IfMsgBox, No
            {
                MsgBox, Don't close SalesPad
                return
            }
            return
        }

getfile1:
    FileSelectFolder, ToFolder, C:\Program Files (x86)\SalesPad.Desktop, 3, Select an Install for the DLLs
    if ToFolder = 
    {
        MsgBox, Nothing was selected.
        Return
    }
    Else
    {
        GuiControl,, DLLFrom, %ToFolder%
        return
    }
    return

getfile2:
    FileSelectFolder, FromFolder, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, 3, Select a build to pull DLLs from:
    if FromFolder = 
    {
        MsgBox, Nothing was selected.
        Return
    }
    Else
    {
        GuiControl,, DLLPlace, %FromFolder%
        return
    }
    return

Canx:
    Gui, 3:Destroy
    return

OKx:
    Gui, 3:Destroy
    FileSelectFile, FilesExt, M3, %FromFolder%\ExtModules\WithOutCardControl, Select any DLLs needed, *.zip
        Array := StrSplit(FilesExt, "`n")

        for index, file in Array
        {
        	if index = 1
        		FromFolder := file
        	else
        		FileCopy, % FromFolder "\" file, C:\#EnvMgr\TEMPFILES\DLLs
        }
    FilesExt = 
    FileSelectFile, FilesCust, M3, %FromFolder%\CustomModules\WithOutCardControl, Select any DLLs needed, *.zip
        Array := StrSplit(FilesCust, "`n")

        for index, file in Array
        {
        	if index = 1
        		FromFolder := file
        	else
        		FileCopy, % FromFolder "\" file, C:\#EnvMgr\TEMPFILES\DLLs
        }
    FilesCust = 
    run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\FileUnzipAndMove.bat"
    WinWait, C:\WINDOWS\system32\cmd.exe
    WinWaitClose
    FileCopy, C:\#EnvMgr\TEMPFILES\DLLs\*.*, %ToFolder%
    FileDelete, C:\#EnvMgr\TEMPFILES\DLLs\*.*
    return

ButtonBuildFolder:
    MsgBox, 4, OPEN FOLDER, Do you want to open the Builds Folder?
    IfMsgBox, No
        return
    Run, C:\Program Files (x86)\SalesPad.Desktop
    return

ButtonLaunchBuild:
    FileSelectFile, SelectedFile, 1, C:\Program Files (x86)\SalesPad.Desktop, Select a Build, *.exe
    if ErrorLevel
        return
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

ButtonScriptsFolder:
    MsgBox, 4, OPEN FOLDER, Do you want to open the Scripts Folder?
    IfMsgBox, No
        return
    Run, C:\#SCRIPTS
    return

D16:
    run, "C:\#SCRIPTS\Tests\DynamicsTest.bat"
    Return

ButtonSteveRodriguez01:
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez01 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DropSR01.bat"
        return
    }

ButtonSteveRodriguez02:
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez02 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DropSR02.bat"
        return
    }

ButtonSteveRodriguez03:
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez03 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DropSR03.bat"
        return
    }

ButtonSteveRodriguez04:
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez04 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DropSR04.bat"
        return
    }

ButtonSteveRodriguez05:
    MsgBox, 4, RUN, Do you want to Delete SteveRodriguez05 tables?
    ifMsgBox, No
    {
        MsgBox, CANCEL, Tables were not deleted.
        return
    }
    ifMsgBox, Yes
    {
        run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DropSR05.bat"
        return
    }

GuiClose:
ButtonExit:
ExitApp
