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

;Gui, Color, 808080
;Gui, Font, cD0D0D0 
Gui, Add, Button, x609 y354 w100 h30, Exit
Gui, Add, CheckBox, x15 y361 gUpdate vCheck, Always On Top
Gui, Add, Tab3, x10 y6 w701 h344, Databases\Builds|Dynamics\SQL Installations|Scripts
Gui, Tab, 1
Gui, Add, GroupBox, w345 h308, Database Management
Gui, Add, GroupBox, x375 y34 w322 h308, Build Management
;-----------------------------GroupBox 1 Fields-----------------------------;
Gui, Add, Text, x31 y60, Select a Database:
Gui, Add, Button, x152 y50 w100 h25, Refresh ;| https://autohotkey.com/board/topic/66602-refresh-gui-listbox-control/
Gui, Add, ListBox, vGPBackupsList gGPBackupsList x31 y81 w220 r15
Gui, Add, Button, x260 y80 w100 h25, Restore DB
Gui, Add, Button, x260 y110 w100 h25, Backup DB
Gui, Add, Button, x260 y140 w100 h25 vDelete, Delete Backup
Gui, Add, Button, x260 y256 w100 h25, Backups Folder
;-----------------------------GroupBox 2 Fields-----------------------------;
Gui, Add, Text, x382 y60, Select a SalesPad Product to Install:
Gui, Add, Text, x382 y236, Launch an exisiting Build:
Gui, Add, Button ,x382 y80 w150 h25, SalesPad Desktop ;old y228
Gui, Add, Button ,x540 y80 w150 h25, SalesPad Mobile
Gui, Add, Button ,x382 y110 w150 h25, DataCollection
;Gui, Add, Button ,x350 y364 w100 h30 vIIS, DataCollection IIS
Gui, Add, Button ,x382 y140 w150 h25, Ship Center
Gui, Add, Button ,x540 y110 w150 h25, Card Control
Gui, Add, Button, x540 y140 w150 h25 vGPWEB, GP Web
Gui, Add, Button, x382 y170 w150 h25, Modules
;Gui, Add, Button ,x662 y364 w100 h30 vAuto, Automation Agent
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
;GuiControl, Disable, Delete
GuiControl, Disable, GPWEB
Gui, Show, w721 h390, Environment Mananger
;=============================================================================================;
;===========================================Tab 1=============================================;
;=============================================================================================;
ListBoxDisplay:
Loop, C:\#EnvMgr\BACKUPS\*, 2
{
    GuiControl,, GPBackupsList, %A_LoopFileName%
}

Loop, C:\#SCRIPTS\*.*
{
    GuiControl,, ScriptList, %A_LoopFileName%
}
return

GPBackupsList:
if (A_GuiEvent <> "DoubleClick")
    return
ButtonRestoreDB:
GuiControlGet, GPBackupsList
MsgBox, 4, RESTORE?, Would you like to restore the Database listed below?`n`n%GPBackupsList%
IfMsgBox, No
    return
if FileExist("C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt")
    FileDelete, C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt
FileAppend,%GPBackupsList%,C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt
Run, C:\#EnvMgr\SCRIPTS\DBRestore.bat,, UseErrorLevel
return

ButtonBackupDB:
GuiControlGet, GPBackupsList
MsgBox, 4, OVERWRITE?, Would you like overwrite %GPBackupsList% with your current environment?
IfMsgBox, No
    return
if FileExist("C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt")
    FileDelete, C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt
FileAppend,%GPBackupsList%,C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt
Run, C:\#EnvMgr\SCRIPTS\DBOverwrite.bat,, UseErrorLevel
return

ButtonNewBackup:
GuiControlGet, Database
ifExist C:\#EnvMgr\BACKUPS\%Database%
    MsgBox,, ALREADY EXISTS, A backup named %Database% already exists.
ifExist C:\#EnvMgr\BACKUPS\%Database%
    goto, CancelBak
if FileExist("C:\#EnvMgr\TEMPFILES\TEMP\NewBack.txt")
        FileDelete, C:\#EnvMgr\TEMPFILES\TEMP\NewBack.txt
    FileAppend,%Database%,C:\#EnvMgr\TEMPFILES\TEMP\NewBack.txt
    Run, C:\#EnvMgr\SCRIPTS\DBBackup.bat,, UseErrorLevel
    sleep, 2000
    goto, ButtonRefresh
return
CancelBak:
return

; BUTTON THAT WOULD ALLOW THE USER TO GENERATE NEW DB BACKUPS
;ButtonNewBackup:
;MsgBox, 4,, Would you like to create a new Database Backup?
;IfMsgBox, No
;    return
;InputBox, NewDB, New Database Name, Please enter a name for your new Database Backup.
;if ErrorLevel
;    MsgBox, CANCEL was pressed.
;else
;    ifExist("C:\#BAKs\%NewDB%")
;        MsgBox, 4,, A backup with this name already exists. Please select "Backup DB" instead of "New Backup" if you wish to use this name.
;    else
;        FileCreateDir, C:\#BAKs\%NewDB%
;return

ButtonDeleteBackup:
GuiControlGet, GPBackupsList
MsgBox, 4, DELETE?, Are you sure you want to delete backup %GPBackupsList%?
ifMsgBox, Yes
;    MsgBox, C:\#EnvMgr\BACKUPS\%GPBackupsList%
    FileRemoveDir, C:\#EnvMgr\BACKUPS\%GPBackupsList%, 1
    sleep, 2000
    goto, ButtonRefresh
;else
;    return
return


ButtonSalesPadDesktop:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, Select a SalesPad Build, *.exe ;https://autohotkey.com/docs/commands/FileSelectFile.htm
;run, %SelectedFile%
if FileExist("C:\#EnvMgr\TEMPFILES\INSTALLERS")
    FileRemoveDir, C:\#EnvMgr\TEMPFILES\INSTALLERS, 1
FileCreateDir, C:\#EnvMgr\TEMPFILES\INSTALLERS\
FileCopy, %SelectedFile%, C:\#EnvMgr\TEMPFILES\INSTALLERS
Loop, C:\#EnvMgr\TEMPFILES\INSTALLERS\*.exe
{
	Run, %A_LoopFileLongPath%
	break
}
;run, C:\#EnvMgr\TEMPFILES\INSTALLERS\*.exe
;InputBox, InstallFolder, Install To, Where would you like to install `n`n%SelectedFile%?, , 640, 200
;if ErrorLevel
;    MsgBox, CANCEL was pressed.
;else
;    if FileExist("C:\#EnvMgr\TEMPFILES\TEMP\BuildLocation.txt")
;        FileDelete, C:\#EnvMgr\TEMPFILES\TEMP\BuildLocation.txt
;    FileAppend,%InstallFolder%,C:\#EnvMgr\TEMPFILES\TEMP\BuildLocation.txt
;run, "C:\#EnvMgr\SCRIPTS\SPInstall.bat"
return

ButtonSalesPadMobile:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\Mobile-Server, Select a SalesPad Server Build, *.exe
run, %SelectedFile%
return

ButtonDataCollection:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection, Select a DataCollection Build, *.exe
run, %SelectedFile%
return

;ButtonDataCollectionIIS:
;FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection, *.msi
;run, %SelectedFile%
;return

ButtonShipCenter:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\ShipCenter, Select a ShipCenter Build, *.exe
run, %SelectedFile%
return

ButtonCardControl:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares, Select a Card Control Build, *.exe
run, %SelectedFile%
return

;ButtonAutomationAgent:
;FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Cloud, *.exe
;run, %SelectedFile%
;return

;ButtonModules:
;FileSelectFile, SelectedModules, M, C:\Users\steve.rodriguez\Desktop\Test\DLLs, Select any DLLs needed, *.zip
;;FileCopy, %SelectedModules%, C:\#SCRIPTS\Tests\test2
;Loop, parse, SelectedModules, `,
;{
;    MsgBox, Color number C:\Users\steve.rodriguez\Desktop\Test\DLLs is %A_LoopField%.
;}
;;MsgBox, %SelectedModules%
;return

ButtonModules:
FileSelectFile Files, M3, C:\Users\steve.rodriguez\Desktop\Test\DLLs, Select any DLLs needed, *.zip  ;https://autohotkey.com/board/topic/119441-how-to-copy-multiples-files/
Array := StrSplit(Files, "`n")

for index, file in Array
{
	if index = 1
		Dir := file
	else
		FileCopy, % Dir "\" file, C:\#SCRIPTS\Tests\test2
}
return

ButtonLaunchBuild:
FileSelectFile, SelectedFile, 1, C:\Program Files (x86)\SalesPad.Desktop, Select a Build, *.exe
run, %SelectedFile%
return

ButtonRefresh:
GuiControl,, GPBackupsList, |
goto, ListBoxDisplay
return

;Folder:
ButtonBackupsFolder:
MsgBox, 4, OPEN FOLDER, Do you want to open the Database Backups Folder?
IfMsgBox, No
    return
Run, C:\#EnvMgr\BACKUPS
return 

Update:
    Gui, Submit, NoHide
    If Check = 1
    {
        Gui, +AlwaysOnTop
    }
    else
    {
        Gui, -AlwaysOnTop
    }
Return

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

GuiClose:
ButtonExit:
ExitApp