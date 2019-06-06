; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: 

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

Gui, Font, s16,
Gui, Add, Text, x150 y30, Onesource Setup
Gui, Font,
Gui, Add, Text, x30 y60, Select the Dynamics GP Install folder you want to add Onesource to:
Gui, Add, Edit, ReadOnly x30 y80 w400 vDynamics,
Gui, Add, Button, x430 y79 w23 h23 vDynamicsFind gDynamicsFind, ...
Gui, Add, Text, x30 y125, Clicking the button below will make a backup of your DYNAMICS.SET file, move the CSV `nneeded into C:\TEMP (Creating the directory if necessary), and finally move the required `nOnesource files to the Dynamics GP Install specified.
Gui, Add, Button, x55 y170 w350 h25 gMoveFiles, Backup SET and Move CSV, CNK and XML
Gui, Add, Text, x30 y230, Next you will need to run Dynamics GP as Admin. Select OK/accept the table updates, `nthese are required for Onesource.
Gui, Add, Text, x30 y270, Navigate to Microsoft Dynamics GP > Tools > Setup > ONESOURCE IDT > Tax `nConfiguration. Fill out the settings referencing the files in the Shared Folder.
Gui, Add, Text, x30 y310, Navigate to Microsoft Dynamics GP > Tools > Setup > ONESOURCE IDT > Item `nTaxability. Fill out the Settings referencing the files in the Shared Folder.
Gui, Add, Text, x30 y350, In SalesPad GP > Settings > Filter to Onesource, fill out the settings referencing `nthe screenshots in the Shared Folder. Also set the Tax Query Handler to Onesource.
Gui, Add, Text, x30 y390, In SalesPad GP, navigate to the Customer you want to use and set their Contact's `nTax Codes to IDT > Save. To verify taxes are being calculated correctly create a `nSales Document for this Customer > Add an Item > Save > Check the Audit.
Gui, Add, Text, x30 y440 w425 0x10 ;Horizontal Line
Gui, Add, Text, x150 y455, Click the Remove button to remove all of the Onesource stuff `nfrom your Dynamics GP installation. This also restores your `nbacked up DYNAMICS SET file.
Gui, Add, Button, x30 y460 w100 h25 gRemove, Remove
;if A_IsAdmin = 0
;{
;    MsgBox, 0, NOT ADMIN, Please run Onesource Setup Tool as Admin.
;    ExitApp
;    return
;}
Gui, Show, w480 h520, Onesource Setup Tool
Return

DynamicsFind:
    FileSelectFolder, DynamicsFolder, C:\, 3, Select your Dynamics GP Folder to modify:
    if DynamicsFolder = 
    {
        MsgBox, 0, NOTHING SELECTED, Nothing was selected.
        GuiControl,, Dynamics, 
        Return
    }
    Else
    {
        GuiControl,, Dynamics, %DynamicsFolder%
        Return
    }

MoveFiles:
    GuiControlGet, Dynamics
    If Dynamics = 
    {
        MsgBox, 0, ERROR, Please select a Dynamics GP Install folder to add Onesource to.
        Return
    }
    Else
    {
        FileCreateDir, C:\#FILEBAKS
        FileCreateDir, C:\TEMP
        MsgBox, 3, MOVE FILES?, Are you sure you want to backup DYNAMICS.SET, Move the required CVS file, as well as the CNK and XML Files?
        IfMsgBox, Yes
        {
            GuiControlGet, Dynamics
            FileCopy, %Dynamics%\DYNAMICS.SET, C:\#FILEBAKS, 1
            FileCopy, \\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource\IDTProductCodes.csv, C:\TEMP, 1
            FileCopy, \\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource\ONESOURCE.cnk, %Dynamics%, 1
            FileCopy, \\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource\ONESOURCENetSDKConfig.xml, %Dynamics%, 1
            FileCopy, \\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource\ONESOURCENetSDKLoggingConfig.xml, %Dynamics%, 1
            Return
        }
        IfMsgBox, No
        {
            MsgBox, 0, MOVE FILES?, Nothing was moved.
            Return
        }
        IfMsgBox Cancel
        {
            Return
        }
    }

Remove:
    MsgBox, 3, REMOVE ONESOURCE?, Are you sure you want to remove the Onesource files from GP?
    IfMsgBox Yes
    {
        GuiControlGet, Dynamics
        FileDelete, %Dynamics%\ONESOURCE.cnk
        FileDelete, %Dynamics%\ONESOURCENetSDKConfig.xml
        FileDelete, %Dynamics%\ONESOURCENetSDKLoggingConfig.xml
        FileDelete, %Dynamics%\ONESOURCE.DIC
        FileCopy, C:\#FILEBAKS\DYNAMICS.SET, %Dynamics%, 1
        Return
    }
    IfMsgBox No
    {
        MsgBox, 0, REMOVE ONESOURCE?, Onesource files were not removed.
        Return
    }
    ifMsgBox Cancel
    {
        Return
    }

;Look into creating a Sql script that would insert the values for the Onesource Settings
;Create a Troubleshooting file in the shared folder with some quick tips
;Create a recording of the Onesource setup process for additional help

GuiClose:
ExitApp