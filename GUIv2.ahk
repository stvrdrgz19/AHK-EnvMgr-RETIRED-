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

Gui, Add, Button, x689 y450 w100 h30, Exit
Gui, Add, CheckBox, x15 y457 gUpdate vCheck, Always On Top
Gui, Add, Tab3, x10 y6 w780 h440, Databases\Builds|Dynamics\SQL Installations|Scripts
Gui, Tab, 1
Gui, Add, GroupBox, w755 h225, Restore or Backup Database
Gui, Add, GroupBox, W755 h70, Create or Delete Backup
Gui, Add, GroupBox, w755 h70, Builds
;-----------------------------GroupBox 1 Fields-----------------------------;
Gui, Add, Text, x31 y60, Select a Database:
Gui, Add, Button, x667 y50 w100 h25, Refresh ;| https://autohotkey.com/board/topic/66602-refresh-gui-listbox-control/
Gui, Add, ListBox, vMyListBox gMyListBox x31 y80 w735 r10
Gui, Add, Button, x38 y220 w100 h30, Restore DB
Gui, Add, Button, x142 y220 w100 h30, Backup DB
Gui, Add, Button, x350 y220 w100 h30, Placeholder
Gui, Add, Button, x662 y220 w100 h30, Backups Folder
;Gui, Add, Picture, x402 y219 gFolder, C:\Users\steve.rodriguez\Documents\ShareX\Screenshots\2019-02\A-636.png
;Gui, Add, Text, x437 y230, DB Backups Location: 
;Gui, Add, Edit, cgray x546 y225 w220 ReadOnly, C:\#EnvMgr\BACKUPS
;-----------------------------GroupBox 2 Fields-----------------------------;
Gui, Add, Button ,x38 y364 w100 h30, SalesPad Desktop ;old y228
Gui, Add, Button ,x142 y364 w100 h30, SalesPad Mobile
Gui, Add, Button ,x246 y364 w100 h30, DataCollection
Gui, Add, Button ,x350 y364 w100 h30 vIIS, DataCollection IIS
Gui, Add, Button ,x454 y364 w100 h30, Ship Center
Gui, Add, Button ,x558 y364 w100 h30, Card Control
Gui, Add, Button ,x662 y364 w100 h30 vAuto, Automation Agent
;-----------------------------GroupBox 3 Fields-----------------------------;
Gui, Add, Text, x38 y300, Enter a Database Backup Name:
Gui, Add, Edit, x198 y296 w200 vDatabase,
Gui, Add, Button, x403 y290 w100 h30 vBak, New Backup
;--------------------IP Address section in the lower left--------------------;
Gui, Add, Text, x25 y420, IP Address: 
Gui, Add, Edit, cgray x80 y416 w100 ReadOnly vIP, %A_IPAddress1%
;------------------------------End of Tab 1------------------------------;
Gui, Tab, 2
Gui, Add, Button, Default w80, OK
;------------------------------End of Tab 2------------------------------;
;GuiControl, Disable, Auto
;GuiControl, Disable, IIS
;GuiControl, Disable, Bak
Gui, Show, x1918 y287 w800 h486, Environment Mananger
;Gui, Show, w800 h486, Environment Mananger

ListBoxDisplay:
Loop, C:\#EnvMgr\BACKUPS\*, 2
{
    GuiControl,, MyListBox, %A_LoopFileName%
}
return

MyListBox:
if (A_GuiEvent <> "DoubleClick")
    return
ButtonRestoreDB:
GuiControlGet, MyListBox
MsgBox, 4,, Would you like to restore the Database listed below?`n`n%MyListBox%
IfMsgBox, No
    return
if FileExist("C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt")
    FileDelete, C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt
FileAppend,%MyListBox%,C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt
Run, C:\#EnvMgr\SCRIPTS\DBRestore.bat,, UseErrorLevel
return

ButtonBackupDB:
GuiControlGet, MyListBox
MsgBox, 4,, Would you like overwrite %MyListBox% with your current environment?
IfMsgBox, No
    return
if FileExist("C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt")
    FileDelete, C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt
FileAppend,%MyListBox%,C:\#EnvMgr\TEMPFILES\TEMP\BackRestore.txt
Run, C:\#EnvMgr\SCRIPTS\DBOverwrite.bat,, UseErrorLevel
return

ButtonNewBackup:
GuiControlGet, Database
ifExist C:\#EnvMgr\BACKUPS\%Database%
    MsgBox, A backup named %Database% already exists.
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

; BUTTON THAT WOULD ALLOW THE USER TO GENERATE BEW DB BACKUPS
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

ButtonSalesPadDesktop:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\SalesPad.GP, Select a SalesPad Build, *.exe ;https://autohotkey.com/docs/commands/FileSelectFile.htm
run, %SelectedFile%
return

ButtonSalesPadMobile:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\Mobile-Server, Select a SalesPad Server Build, *.exe
run, %SelectedFile%
return

ButtonDataCollection:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection, *.exe
run, %SelectedFile%
return

ButtonDataCollectionIIS:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares\DataCollection, *.msi
run, %SelectedFile%
return

ButtonShipCenter:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\ShipCenter, *.exe
run, %SelectedFile%
return

ButtonCardControl:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Ares, *.exe
run, %SelectedFile%
return

ButtonAutomationAgent:
FileSelectFile, SelectedFile, 1, \\sp-fileserv-01\Shares\Builds\Cloud, *.exe
run, %SelectedFile%
return


ButtonRefresh:
GuiControl,, MyListBox, |
goto, ListBoxDisplay
return

;Folder:
ButtonBackupsFolder:
MsgBox, 4,, Do you want to open the Database Backups Folder?
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

GuiClose:
ButtonExit:
ExitApp
