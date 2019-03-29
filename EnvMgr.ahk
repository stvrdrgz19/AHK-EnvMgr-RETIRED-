#SingleInstance, force

Menu, FileMenu, Add, &Open`tCtrl+O, MenuFileOpen 
Menu, FileMenu, Add, E&xit, MenuHandler
Menu, FileMenu, Add, Settings`tCtrl+S, SettingsScreen

Menu, EditMenu, Add, Copy`tCtrl+C, MenuHandler
Menu, EditMenu, Add, Paste`tCtrl+V, MenuHandler
Menu, EditMenu, Add ; with no more options, this is a seperator
Menu, EditMenu, Add, Delete`tDel, MenuHandler

Menu, HelpMenu, Add, &About, MenuHandler

; Attach the sub-menus that were created above.
Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Edit, :EditMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Menu, MyMenuBar ; Attach MyMenuBar to the GUI

Gui, Add, Button, x592 y440 w100 h30, Exit
Gui, Add, Text, x15 y449, IP Address: 
Gui, Add, Edit, cgray x75 y447 w100 ReadOnly vIP, %A_IPAddress1%
Gui, Add, GroupBox, x15 y5 w345 h308, Database Management
Gui, Add, GroupBox, x369 y5 w322 h308, Build Management
Gui, Add, GroupBox, x15 y315 w676 h60, Dynamics GP
Gui, Add, GroupBox, x15 y377 w676 h60, SPC SQL Database Management
;-----------------------------GroupBox 1 Fields-----------------------------;
Gui, Add, Text, x24 y31, Select a Database:
Gui, Add, Button, x145 y21 w100 h25, Refresh 
Gui, Add, ListBox, vGPBackupsList gGPBackupsList x25 y52 w220 r15
Gui, Add, Button, x253 y51 w100 h25, Restore DB
Gui, Add, Button, x253 y81 w100 h25, Backup DB
Gui, Add, Button, x253 y111 w100 h25 vDelete, Delete Backup
Gui, Add, Button, x253 y227 w100 h25, Backups Folder
Gui, Add, Text, x24 y265, Enter a Database Backup Name:
Gui, Add, Edit, x24 y283 w220 vDatabase,
Gui, Add, Button, x253 y281 w100 h25 vBak, New Backup
;-----------------------------GroupBox 2 Fields-----------------------------;
Gui, Add, Text, x376 y31, Select a SalesPad Product to Install:
Gui, Add, Text, x376 y235, Launch an exisiting Build:
Gui, Add, Button, x376 y51 w150 h25, SalesPad Desktop
Gui, Add, Button, x534 y51 w150 h25, SalesPad Mobile
Gui, Add, Button, x376 y81 w150 h25, DataCollection
Gui, Add, Button, x376 y111 w150 h25, Ship Center
Gui, Add, Button, x534 y141 w150 h25, Card Control
Gui, Add, CheckBox, x377 y143 gUpdateB vCheckB, Install With Grizzly DLLs
Gui, Add, Button, x534 y81 w150 h25 vGPAPI, Web API
Gui, Add, Button, x534 y111 w150 h25 vGPWEB, Web Portal 
Gui, Add, Button, x376 y251 w308 h25, Launch Build
Gui, Add, Button, x376 y281 w150 h25 vAddDLLs, Add DLLs
Gui, Add, Button, x534 y281 w150 h25, Build Folder

Gui, Add, Button, x41 y335 w150 h25 gD13 vD13, Dynamics GP 2013
Gui, Add, Button, x199 y335 w150 h25 gD15 vD15, Dynamics GP 2015
Gui, Add, Button, x357 y335 w150 h25 gD16 vD16, Dynamics GP 2016
Gui, Add, Button, x515 y335 w150 h25 gD18 vD18, Dynamics GP 2017

Gui, Add, Button, x22 y397 w125 h25, SteveRodriguez01
Gui, Add, Button, x155 y397 w125 h25, SteveRodriguez02
Gui, Add, Button, x288 y397 w125 h25, SteveRodriguez03
Gui, Add, Button, x421 y397 w125 h25, SteveRodriguez04
Gui, Add, Button, x554 y397 w125 h25, SteveRodriguez05

;GuiControl, Disable, AddDLLs
GuiControl, Disable, D13
GuiControl, Disable, D15
GuiControl, Disable, D18
;Gui, Color, FF0000, 3366FF
Gui, Color, f9f9f9
Gui, Show, w706 h475, Environment Mananger
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

ListBoxDisplay:
IniRead, DBListDisplay, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, BackupFolder, path
    Loop, %DBListDisplay%\*, 2
    {
        GuiControl,, GPBackupsList, %A_LoopFileName%
    }
    return

SettingsScreen:
    Gui, 4:Add, Text, x30 y30, Select a Database Backup Folder:
    Gui, 4:Add, Edit, cgray x30 y50 w600 Readonly vBackupPath,
    Gui, 4:Add, Button, x630 y49 w23 h23 vBackPath gBackPath, ...
    Gui, 4:Add, Text, x30 y90, SQL Server Name:
    Gui, 4:Add, Text, x30 y120, SQL Username:
    Gui, 4:Add, Text, x30 y150, SQL Password:
    Gui, 4:Add, Edit, cgray x125 y85 w200 Readonly vServName,
    Gui, 4:Add, Edit, cgray x125 y115 w200 Readonly vServUN,
    Gui, 4:Add, Edit, cgray x125 y145 w200 Password Readonly vServPW,
    Gui, 4:Add, Button, x325 y84 w23 h23 vSQLServ gSQLServ, ...
    Gui, 4:Add, Button, x325 y114 w23 h23 vSQLUN gSQLUN, ...
    Gui, 4:Add, Button, x325 y144 w23 h23 vSQLPW gSQLPW, ...
    Gui, 4:Add, Text, x370 y90, Dynamics Database:
    Gui, 4:Add, Text, x370 y120, Non-MB Company:
    Gui, 4:Add, Text, x370 y150, MB Company:
    Gui, 4:Add, Edit, cgray x475 y85 w155 Readonly vDynamicsDB,
    Gui, 4:Add, Edit, cgray x475 y115 w155 Readonly vRegDB,
    Gui, 4:Add, Edit, cgray x475 y145 w155 Readonly vMBDB,
    Gui, 4:Add, Button, x630 y84 w23 h23 vDYN gDYN, ...
    Gui, 4:Add, Button, x630 y114 w23 h23 vREG gREG, ...
    Gui, 4:Add, Button, x630 y144 w23 h23 vMB gMB, ...
    Gui, 4:Add, Button, x443 y190 w100 h25 gSave, Save
    Gui, 4:Add, Button, x553 y190 w100 h25 gCan2, Cancel
    Gui, 4:Color, FFFFFF
    Gui, 4:Show, w680 h225, Settings
    IniRead, BackPathLoad, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, BackupFolder, path
    GuiControl, 4:, BackupPath, %BackPathLoad%
    IniRead, ServLoad, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Server
    GuiControl, 4:, ServName, %ServLoad%
    IniRead, UserLoad, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, User
    GuiControl, 4:, ServUN, %UserLoad%
    IniRead, PasswordLoad, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Password
    GuiControl, 4:, ServPW, %PasswordLoad%
    IniRead, DynamicLoad, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Dynamics
    GuiControl, 4:, DynamicsDB, %DynamicLoad%
    IniRead, Company1Load, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company1
    GuiControl, 4:, RegDB, %Company1Load%
    IniRead, Company2Load, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company2
    GuiControl, 4:, MBDB, %Company2Load%
    return

4GuiClose:
    Gui, 4:Destroy
    return

Save:
    GuiControlGet, BackupPath, 4:
    IniWrite, %BackupPath%, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, BackupFolder, path
    GuiControlGet, ServName, 4:
    IniWrite, %ServName%, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Server
    GuiControlGet, ServUN, 4:
    IniWrite, %ServUN%, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, User
    GuiControlGet, ServPW, 4:
    IniWrite, %ServPW%, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Password
    GuiControlGet, DynamicsDB, 4:
    IniWrite, %DynamicsDB%, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Dynamics
    GuiControlGet, RegDB, 4:
    IniWrite, %RegDB%, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company1
    GuiControlGet, MBDB, 4:
    IniWrite, %MBDB%, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company2
    ;MsgBox, Saved!
    ;Gui, 4:Destroy
    Return

Can2:
    Gui, 4:Destroy
    sleep 1000
    goto, ButtonRefresh
    return

BackPath:
    FileSelectFolder, BackFolder, C:\, 3, Select your Database Backups Folder
    if BackFolder = 
    {
        MsgBox, Nothing was selected.
        return
    }
    Else
    {
        GuiControl,, BackupPath, %BackFolder%
        return
    }

SQLServ:
    InputBox, ServerName, SQL Server, Enter your SQL Server Name
    if ErrorLevel
    {
        MsgBox, Nothing was entered.
        return
    }
    Else
    {
        GuiControl,, ServName, %ServerName%
        return
    }

SQLUN:
    InputBox, UserNameBox, SQL Username, Enter your SQL User Name
    if ErrorLevel
    {
        MsgBox, Nothing was entered.
        return
    }
    Else
    {
        GuiControl,, ServUN, %UserNameBox%
        return
    }

SQLPW:
    InputBox, UserPWBox, SQL Password, Enter your SQL Password
    if ErrorLevel
    {
        MsgBox, Nothing was entered.
        return
    }
    Else
    {
        GuiControl,, ServPW, %UserPWBox%
        return
    }

DYN:
    InputBox, DynamicsBox, Dynamics Database, Enter your Dynamics GP Database
    if ErrorLevel
    {
        MsgBox, Nothing was entered.
        return
    }
    Else
    {
        GuiControl,, DynamicsDB, %DynamicsBox%
        return
    }

REG:
    InputBox, RegularBox, Non-Multibin Datbaase, Enter your Non-Multibin Database Name
    if ErrorLevel
    {
        MsgBox, Nothing was entered.
        return
    }
    Else
    {
        GuiControl,, RegDB, %RegularBox%
        return
    }

MB:
    InputBox, MultiBox, Multbin Database, Enter your Multibin Database Name
    if ErrorLevel
    {
        MsgBox, Nothing was entered.
        return
    }
    Else
    {
        GuiControl,, MBDB, %MultiBox%
        return
    }



MenuHandler:
MsgBox, %A_ThisMenuItem%
return
MenuFileOpen:
MsgBox, Open Menu was clicked
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
    IniRead, Var1, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Server
    IniRead, Var2, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, User
    IniRead, Var3, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Password
    IniRead, Var4, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, BackupFolder, path
    IniRead, Var5, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Dynamics
    IniRead, Var6, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company1
    ;IniRead, Var7, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company2
    Run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DBRestore.bat" %Var1% %Var2% %Var3% %Var4% %GPBackupsList% %Var5% %Var6%,, UseErrorLevel
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
    IniRead, Var1, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Server
    IniRead, Var2, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, User
    IniRead, Var3, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Password
    IniRead, Var4, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, BackupFolder, path
    IniRead, Var5, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Dynamics
    IniRead, Var6, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company1
    ;IniRead, Var7, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company2
    Run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DBOverwrite.bat" %Var1% %Var2% %Var3% %Var4% %GPBackupsList% %Var5% %Var6% ,, UseErrorLevel
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
                IniRead, Var1, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Server
                IniRead, Var2, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, User
                IniRead, Var3, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, SQLCreds, Password
                IniRead, Var4, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, BackupFolder, path
                IniRead, Var5, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Dynamics
                IniRead, Var6, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company1
                IniRead, Var7, C:\Users\steve.rodriguez\Desktop\EnvMgr\Settings\Settings.ini, Databases, Company2
                Run, "C:\Users\steve.rodriguez\Desktop\EnvMgr\Script.DBBackup.bat" %Var1% %Var2% %Var3% %Var4% %GPBackupsList% %Var5% %Var6% %Var7%,, UseErrorLevel
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
                Process,Close,SalesPad.exe
                sleep 2000
                goto, ButtonAddDLLs
                return
            }
            IfMsgBox, No
            {
                MsgBox, You must close SalesPad to add DLLs.
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
;    GuiControl,, ScriptList, |
    goto, ListBoxDisplay
    Return

ButtonBackupsFolder:
    MsgBox, 4, OPEN FOLDER, Do you want to open the Database Backups Folder?
    IfMsgBox, No
        return
    Run, C:\#EnvMgr\BACKUPS
    Return

D13:
    return

D15:
    return

D16:
    run, "C:\#SCRIPTS\Tests\DynamicsTest.bat"
    Return

D18:
    return

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
