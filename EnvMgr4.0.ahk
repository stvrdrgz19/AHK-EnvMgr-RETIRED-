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

#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\GuiButtonIcon.ahk
#Include, C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Functions\ButtonCounters.ahk

If A_IsAdmin = 0
{
    if A_IsCompiled
        Run *RunAs "%A_ScriptFullPath%"
    else
        Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
}

Menu, FileMenu, Add, E&xit, MenuHandler
Menu, FileMenu, Add, Settings`tCtrl+S, SettingsScreen

Menu, ToolsMenu, Add, &Utilities, Utilities
Menu, ToolsMenu, Add, &Reset Database Version, sppResetDB
Menu, ToolsMenu, Add, &Button Counters, ButtonCounters
Menu, ToolsMenu, Add, &Install Log, Log

Menu, HelpMenu, Add, &About, AboutScreen

Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Tools, :ToolsMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu

Gui, Menu, MyMenuBar

Gui, Font, s10
Gui, Add, GroupBox, w443 h235 cBlue, Database Management
Gui, Font, s9
Gui, Add, ComboBox, x25 y30 w359 vCombo1 gCombo1, Select a Database||
Gui, Add, Button, x24 y202 w100 h25 gRestore, Restore DB
Gui, Add, Button, x129 y202 w100 h25 gOverwrite, Overwrite DB
Gui, Add, Button, x234 y202 w100 h25 gNewDB, New Backup
Gui, Add, Button, x339 y202 w100 h25 gDelete, Delete Backup
Gui, Add, Edit, ReadOnly cGray x25 y55 w413 r10 vDBDesc, =================================================================`nSelect a Database Backup to load it's description.
Gui, Add, Button, x386 y28 w25 h25 gDBFolder hwndIconDBFolder,
GuiButtonIcon(IconDBFolder, "imageres.dll", 4, "s21")
Gui, Add, Button, x413 y28 w25 h25 gAddDesc hwndIconAdd,
GuiButtonIcon(IconAdd, "imageres.dll", 278, "s21")

Gui, Font, s10
Gui, Add, GroupBox, x12 y249 w443 h85 cBlue, Build Management
Gui, Font, s9
Gui, Add, ComboBox, x25 y270 w413 vCombo2, Select a Product to Install||SalesPad Desktop|SalesPad Mobile|DataCollection|Windows Mobile|Ship Center|Card Control ;|Web API|Web Portal
Gui, Add, Button, x24 y300 w100 h25 gLaunchBuild, Launch Build
Gui, Add, Button, x129 y300 w100 h25 gAddDLL, Add DLLs 
Gui, Add, Button, x234 y300 w100 h25 gBuildFolder, Build Folder
Gui, Font, s9 bold
Gui, Add, Button, x339 y300 w100 h25 gInstall, Install
Gui, Font, s9 norm

IniRead, GP1, Settings\Settings.ini, GPButtonLabels, GPButton1
IniRead, GP2, Settings\Settings.ini, GPButtonLabels, GPButton2
IniRead, GP3, Settings\Settings.ini, GPButtonLabels, GPButton3
IniRead, GP4, Settings\Settings.ini, GPButtonLabels, GPButton4
IniRead, GP5, Settings\Settings.ini, GPButtonLabels, GPButton5
Gui, Font, s10
Gui, Add, GroupBox, x12 y339 w214 h85 cBlue, Launch GP
Gui, Font, s9
Gui, Add, ComboBox, x25 y360 w184 vCombo3, Select GP to Launch||%GP1%|%GP2%|%GP3%|%GP4%|%GP5%
Gui, Add, Button, x110 y390 w100 h25 gLaunchGP, Launch
Gui, Add, Button, x80 y390 w25 h25 gGPFolder hwndIconGP
GuiButtonIcon(IconGP, "C:\Program Files (x86)\Microsoft Dynamics\GP2016\GPIcons.dll", 159,"s21")

IniRead, SPC1, Settings\Settings.ini, CloudButtonNames, 01
IniRead, SPC2, Settings\Settings.ini, CloudButtonNames, 02
IniRead, SPC3, Settings\Settings.ini, CloudButtonNames, 03
IniRead, SPC4, Settings\Settings.ini, CloudButtonNames, 04
IniRead, SPC5, Settings\Settings.ini, CloudButtonNames, 05
Gui, Font, s10
Gui, Add, GroupBox, x241 y339 w214 h85 cBlue, Delete Cloud DB
Gui, Font, s9
Gui, Add, ComboBox, x254 y360 w184 vCombo4, Select Cloud to Delete||%SPC1%|%SPC2%|%SPC3%|%SPC4%|%SPC5%
Gui, Add, Button, x339 y390 w100 h25 gDeleteCloud, Delete
Gui, Add, Button, x309 y390 w25 h25 gOctopush hwndIconSPC
GuiButtonIcon(IconSPC, "imageres.dll", 232,"s21")

Gui, Add, Checkbox, x12 y430 vAlways gAlways, Always On Top
Gui, Add, Text, x294 y430 gIPText vIPText, IP Address:
Gui, Add, Edit, x354 y427 w100 vIP cgray ReadOnly, %A_IPAddress1%
Gui, Color, f9f9f9 ;FFFFFF is pure white
Gui, Show,, Environment Manager

LoadDBList:
    IniRead, DBBakPath, Settings\Settings.ini, BackupFolder, path
    Loop, %DBBakPath%\*, 2
    {
        GuiControl,, Combo1, %A_LoopFileName%
    }
Return

;=================================================================================================================================
;   FILEMENU STUFF
;=================================================================================================================================
MenuHandler:
    Return

SettingsScreen:
    Return

Utilities:
    Return

sppResetDB:
    Return

ButtonCounters:
    Return

Log:
    Return

AboutScreen:
    Return

;=================================================================================================================================
;   GUIButtons
;=================================================================================================================================
Combo1:
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        GuiControl,, DBDesc, =================================================================`nSelect a Database Backup to load it's description.
        Return
    }
    If FileExist("C:\#DBBackups\" Combo1 "\Description.txt")
    {
        FileRead, SelectedX, C:\#DBBackups\%Combo1%\Description.txt
        GuiControl,, DBDesc, %SelectedX%
        Return
    }
    Else
    {
        GuiControl,, DBDesc, This Database Backup has no description.`n`nTo add a description, select a Database Backup from the list and then click the "Add Description" button above.
        Return
    }

DBFolder:
    MsgBox, 36, OPEN FOLDER, Are you sure you want to open the DB Backup folder?
    IfMsgBox, Yes
    {
        IniRead, DBBakPath, Settings\Settings.ini, BackupFolder, path
        Run, %DBBakPath%
        Return
    }
    IfMsgBox, No
    {
        Return
    }

AddDesc:
    MsgBox, 0, test, Add desc.
    Return

Restore:
    GuiControlGet, Combo1
    ButtonCounters("RestoreDB")
    If Combo1 = Select a Database
    {
        MsgBox, 16, ERROR, Please select a database backup to restore.
        Return
    }
    Else
    {
        MsgBox, 36, RESTORE?, Are you sure you want to restore "%Combo1%" over your current databases?
        IfMsgBox, Yes
        {
            IniRead, Var1, Settings\Settings.ini, SQLCreds, Server
            IniRead, Var2, Settings\Settings.ini, SQLCreds, User
            IniRead, Var3, Settings\Settings.ini, SQLCreds, Password
            IniRead, Var4, Settings\Settings.ini, BackupFolder, path
            IniRead, Var5, Settings\Settings.ini, Databases, Dynamics
            IniRead, Var6, Settings\Settings.ini, Databases, Company1
            IniRead, Var7, Settings\Settings.ini, Databases, Company2
            Run, "Scripts\Script.DBRestore.bat" %Var1% %Var2% %Var3% %Var4% "%Combo1%" %Var5% %Var6% %Var7%,, UseErrorLevel
            WinWait, C:\windows\system32\cmd.exe
            WinWaitClose
            FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Restored "%Combo1%" backup.`n, Settings\Log.txt
            MsgBox, 0, COMPLETED, Database %Combo1% was restored successfully.
            ButtonCounters("RestoreDB")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }

Overwrite:
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        MsgBox, 16, ERROR, Please select a database backup to restore.
        Return
    }
    MsgBox, 20, OVERWRITE, Are you sure you want to overwrite "%Combo1%" with your current dataset?
    IfMsgBox, Yes
    {
        MsgBox, 0, test, Yes
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 0, test, No
        Return
    }
    Return

NewDB:
    MsgBox, 20, NEW BACKUP, Are you sure you want to create a new database backup?
    IfMsgBox, Yes
    {
        MsgBox, 0, test, Yes
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 0, test, No
        Return
    }
    Return

Delete:
    GuiControlGet, Combo1
    If Combo1 = Select a Database
    {
        MsgBox, 16, ERROR, Please select a database backup to restore.
        Return
    }
    MsgBox, 20, DELETE, Are you sure you want to delete "%Combo1%"?
    IfMsgBox, Yes
    {
        IniRead, DBListDelete, Settings\Settings.ini, BackupFolder, path
        FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Deleted "%Combo1%" backup.`n, Settings\Log.txt
        FileRemoveDir, %DBListDelete%\%Combo1%, 1
        MsgBox, 48, DELETED, Database "%Combo1%" was deleted.
        ButtonCounters("DeleteBackup")
        Gosub, LoadDBList
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 16, CANCEL, Backup "%Combo1%" was not deleted.
        Return
    }

Install:
    GuiControlGet, Combo2
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a SalesPad Product to install.
        Return
    }
    MsgBox, 36, INSTALL, Are you sure you want to install a %Combo2% build?
    IfMsgBox, Yes
    {
        MsgBox, 0, test, Yes was selected`n`nInstalling %Combo2%
        Return
    }
    IfMsgBox, No
    {
        MsgBox, 0, test, NO Was selected`n`n%Combo2% will NOT be installed.
        Return
    }

LaunchBuild:
    GuiControlGet, Combo2
    ButtonCounters("LaunchBuild")
    IniRead, LocSPGP, Settings\Settings.ini, InstallPaths, LSPGP
    IniRead, LocSPM, Settings\Settings.ini, InstallPaths, LSPM
    IniRead, LocDC, Settings\Settings.ini, InstallPaths, LDC
    IniRead, LocSC, Settings\Settings.ini, InstallPaths, LSC
    IniRead, LocCC, Settings\Settings.ini, InstallPaths, LCC
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a Product to launch.
        Return
    }
    If Combo2 = SalesPad Desktop
    {
        FileSelectFile, SelectedFile, 1, %LocSPGP%\, Select a Build, *.exe
        If ErrorLevel
            Return
        Run, %SelectedFile%
        Return
    }
    If Combo2 = SalesPad Mobile
    {
        FileSelectFile, SelectedFile, 1, %LocSPM%\, Select a Build, *.exe
        If ErrorLevel
            Return
        Run, %SelectedFile%
        Return
    }
    If Combo2 = DataCollection
    {
        FileSelectFile, SelectedFile, 1, %LocDC%\, Select a Build, *.exe
        If ErrorLevel
            Return
        Run, %SelectedFile%
        Return
    }
    If Combo2 = Ship Center
    {
        FileSelectFile, SelectedFile, 1, %LocSC%\, Select a Build, *.exe
        If ErrorLevel
            Return
        Run, %SelectedFile%
        Return
    }
    If Combo2 = Card Control
    {
        FileSelectFile, SelectedFile, 1, %LocCC%\, Select a Build, *.exe
        If ErrorLevel
            Return
        Run, %SelectedFile%
        Return
    }

AddDLL:
    GuiControlGet, Combo2
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a Product to add DLLs to.
        Return
    }
    If Combo2 = SalesPad Desktop
    {
        Run, "C:\Users\steve.rodriguez\Desktop\EnvironmentManager\AHK-EnvMgr-RETIRED-\Tests\DLLGrabTool\DLL Grab.exe"
        ;MsgBox, 0, test, Run the ADD DLLs app.
        Return
    }
    If Combo2 != SalesPad Desktop & Combo2 != Select a Product to Install
    {
        MsgBox, 0, test, No dll's for this product.
        Return
    }

BuildFolder:
    GuiControlGet, Combo2
    IniRead, LocSPGP, Settings\Settings.ini, InstallPaths, LSPGP
    IniRead, LocSPM, Settings\Settings.ini, InstallPaths, LSPM
    IniRead, LocDC, Settings\Settings.ini, InstallPaths, LDC
    IniRead, LocSC, Settings\Settings.ini, InstallPaths, LSC
    IniRead, LocCC, Settings\Settings.ini, InstallPaths, LCC
    If Combo2 = Select a Product to Install
    {
        MsgBox, 16, ERROR, Please select a SalesPad Product whose install folder you would like to launch.
        Return
    }
    If Combo2 = SalesPad Desktop
    {
        Run, %LocSPGP%
        Return
    }
    If Combo2 = SalesPad Mobile
    {
        Run, %LocSPM%
        Return
    }
    If Combo2 = DataCollection
    {
        Run, %LocDC%
        Return
    }
    If Combo2 = Windows Mobile
    {
        MsgBox, 16, ERROR, There is no %Combo2% folder to run.
        Return
    }
    If Combo2 = Ship Center
    {
        Run, %LocSC%
        Return
    }
    If Combo2 = Card Control
    {
        Run, %LocCC%
        Return
    }

GPFolder:
    MsgBox, 36, GP FOLDER, Are you sure you want to launch the Dynamics GP folder?
    IfMsgBox, Yes
    {
        Run, "C:\Program Files (x86)\Microsoft Dynamics"
        Return
    }
    IfMsgBox, No
    {
        Return
    }

LaunchGP:
    GuiControlGet, Combo3
    If Combo3 = Select GP to Launch
    {
        MsgBox, 16, ERROR, Please select a version of GP to launch.
        Return
    }
    IniRead, GPLabel1, Settings\Settings.ini, GPButtonLabels, GPButton1
    IniRead, GPLabel2, Settings\Settings.ini, GPButtonLabels, GPButton2
    IniRead, GPLabel3, Settings\Settings.ini, GPButtonLabels, GPButton3
    IniRead, GPLabel4, Settings\Settings.ini, GPButtonLabels, GPButton4
    IniRead, GPLabel5, Settings\Settings.ini, GPButtonLabels, GPButton5
    IniRead, GPLaunchPath1, Settings\Settings.ini, GPLaunchFile, GPLaunch1
    IniRead, GPLaunchPath2, Settings\Settings.ini, GPLaunchFile, GPLaunch2
    IniRead, GPLaunchPath3, Settings\Settings.ini, GPLaunchFile, GPLaunch3
    IniRead, GPLaunchPath4, Settings\Settings.ini, GPLaunchFile, GPLaunch4
    IniRead, GPLaunchPath5, Settings\Settings.ini, GPLaunchFile, GPLaunch5
    If Combo3 = %GPLabel1%
    {
        Run, "%GPLaunchPath1%"
        ButtonCounters("GP1")
        Return
    }
    If Combo3 = %GPLabel2%
    {
        Run, "%GPLaunchPath2%"
        ButtonCounters("GP2")
        Return
    }
    If Combo3 = %GPLabel3%
    {
        Run, "%GPLaunchPath3%"
        ButtonCounters("GP3")
        Return
    }
    If Combo3 = %GPLabel4%
    {
        ;MsgBox, 0, test, %GPLabel4%`n%GPLaunchPath4%
        Run, "%GPLaunchPath4%"
        ButtonCounters("GP4")
        Return
    }
    If Combo3 = %GPLabel5%
    {
        Run, "%GPLaunchPath5%"
        ButtonCounters("GP5")
        Return
    }
    Return

Octopush:
    MsgBox, 36, OCTOPUSH, Are you sure you want to launch Octopush?
    IfMsgBox, Yes
    {
        Run, chrome.exe https://deploy.salespad.com
        Return
    }
    IfMsgBox, No
    {
        Return
    }

DeleteCloud:
    GuiControlGet, Combo4
    If Combo4 = Select Cloud to Delete
    {
        MsgBox, 16, ERROR, Please select a Cloud Tenant to clear tables.
        Return
    }
    IniRead, CloudLab1, Settings\Settings.ini, CloudButtonNames, 01
    IniRead, CloudLab2, Settings\Settings.ini, CloudButtonNames, 02
    IniRead, CloudLab3, Settings\Settings.ini, CloudButtonNames, 03
    IniRead, CloudLab4, Settings\Settings.ini, CloudButtonNames, 04
    IniRead, CloudLab5, Settings\Settings.ini, CloudButtonNames, 05
    If Combo4 = %CloudLab1%
    {
        MsgBox, 36, DELETE TENANT 01, Are you sure you want to delete the tables for Cloud Tenant %CloudLab1%?
        IfMsgBox, Yes
        {
            ;MsgBox, 0, test, Delete %CloudLab1%.
            Run, "Scripts\Script.DropSR01.bat" %CloudLab1%
            ButtonCounters("SPC1")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }
    If Combo4 = %CloudLab2%
    {
        MsgBox, 36, DELETE TENANT 02, Are you sure you want to delete the tables for Cloud Tenant %CloudLab2%?
        IfMsgBox, Yes
        {
            ;MsgBox, 0, test, Delete %CloudLab2%.
            Run, "Scripts\Script.DropSR01.bat" %CloudLab2%
            ButtonCounters("SPC2")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }
    If Combo4 = %CloudLab3%
    {
        MsgBox, 36, DELETE TENANT 03, Are you sure you want to delete the tables for Cloud Tenant %CloudLab3%?
        IfMsgBox, Yes
        {
            ;MsgBox, 0, test, Delete %CloudLab3%.
            Run, "Scripts\Script.DropSR01.bat" %CloudLab3%
            ButtonCounters("SPC3")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }
    If Combo4 = %CloudLab4%
    {
        MsgBox, 36, DELETE TENANT 04, Are you sure you want to delete the tables for Cloud Tenant %CloudLab4%?
        IfMsgBox, Yes
        {
            ;MsgBox, 0, test, Delete %CloudLab4%.
            Run, "Scripts\Script.DropSR01.bat" %CloudLab4%
            ButtonCounters("SPC4")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }
    If Combo4 = %CloudLab5%
    {
        MsgBox, 36, DELETE TENANT 05, Are you sure you want to delete the tables for Cloud Tenant %CloudLab5%?
        IfMsgBox, Yes
        {
            ;MsgBox, 0, test, Delete %CloudLab5%.
            Run, "Scripts\Script.DropSR01.bat" %CloudLab5%
            ButtonCounters("SPC5")
            Return
        }
        IfMsgBox, No
        {
            Return
        }
    }

IPText:
    GuiControl,, IP, %A_IPAddress1%
    GuiControl, +cblue +Redraw, IPText
    GuiControl, +cblue +Redraw, IP
    Sleep 50
    GuiControl, +cblack +Redraw, IPText
    GuiControl, +cgray +Redraw, IP
    Return

Always:
    GuiControlGet, Always
    If Always = 0
    {
        Gui, -AlwaysOnTop
        Return
    }
    If Always = 1
    {
        Gui, +AlwaysOnTop
        Return
    }

;=================================================================================================================================
;   END
;=================================================================================================================================
GuiClose:
    ExitApp