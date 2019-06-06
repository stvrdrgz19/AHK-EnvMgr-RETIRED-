; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: A Tool created to help install/remove Thomson Reuter's One Source

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

Gui, Font, s16,
Gui, Add, Text, x150 y30, Onesource Setup
Gui, Font, s9,
Gui, Add, Text, x30 y60, Select your Dynamics GP Install folder to add Onesource to:
Gui, Add, Edit, ReadOnly x30 y80 w400 vDynamics,
Gui, Add, Button, x430 y79 w23 h23 vDynamicsFind gDynamicsFind, ...
Gui, Add, Text, x150 y120, Clicking the Backup SET button will create a backup of your `nDYNAMICS.SET file and place it in C:\#FILEBAKS, creating `nthe directory if it doesn't exist. 
Gui, Add, Button, x30 y125 w100 h25 gBackSet, Backup SET
Gui, Add, Text, x150 y170, Clicking the Move CSV button will move the CSV file to the `nC:\TEMP directory (Called in the sql script required), creating `nthe directory if it doesn't exist.
Gui, Add, Button, x30 y175 w100 h25 gMoveCSV, Move CSV
Gui, Add, Text, x150 y220, Clicking the CNK and XML button will move the CNK and XML `nfiles to the Dynamics GP Install location specified above. `nThree files will be moved.
Gui, Add, Button, x30 y225 w100 h25 gMoveCNK, CNK and XML
Gui, Add, Text, x30 y275, Next you will need to run Dynamics GP as Admin. Select OK/accept the table updates, `nthese are required for Onesource.
Gui, Add, Text, x150 y325, Clicking the Shared button will pop open the shared location `nof the Onesource files. Run the SQL file against your TWO `ndatabase. Leave the folder open and return to Dynamics GP.
Gui, Add, Button, x30 y330 w100 h25 gShared, Shared
Gui, Add, Text, x30 y385, Navigate to Microsoft Dynamics GP > Tools > Setup > ONESOURCE IDT > Tax `nConfiguration. Fill out the settings referencing the files in the Shared Folder.
Gui, Add, Text, x30 y425, Navigate to Microsoft Dynamics GP > Tools > Setup > ONESOURCE IDT > Item `nTaxability. Fill out the Settings referencing the files in the Shared Folder.
Gui, Add, Text, x30 y465, In SalesPad GP > Settings > Filter to Onesource, fill out the settings referencing `nthe screenshots in the Shared Folder. Also set the Tax Query Handler to Onesource.
Gui, Add, Text, x30 y505, In SalesPad GP, navigate to the Customer you want to use and set their Contact's `nTax Codes to IDT > Save. To verify taxes are being calculated correctly create a `nSales Document for this Customer > Add an Item > Save > Check the Audit.
Gui, Add, Text, x30 y555 w425 0x10 ;Horizontal Line
;Gui, Font,, Consolas
Gui, Add, Text, x150 y570, Click the Remove button to remove all of the Onesource stuff `nfrom your Dynamics GP installation. This also restores your `nbacked up DYNAMICS SET file.
;Gui, Font
Gui, Add, Button, x30 y575 w100 h25 gRemove, Remove
;Gui, Add, Button, x5 y5 w50 h25 gTest, Test
if A_IsAdmin = 0
{
    MsgBox, 0, NOT ADMIN, Please run Onesource Setup.ahk as Admin.
    ExitApp
    return
}
Gui, Show, w480 h635, Onesource Tool
Return

;Test:
;    MsgBox, 0, Is Admin?, %A_IsAdmin%
;    Return

DynamicsFind:
    FileSelectFolder, DynamicsFolder, C:\, 3, Select your Dynamics GP Folder to modify
    if DynamicsFolder = 
    {
        MsgBox, 0, NOTHING SELECTED, Nothing was selected.
        return
    }
    Else
    {
        GuiControl,, Dynamics, %DynamicsFolder%
        return
    }

BackSet:
    if FileExist("C:\#FILEBAKS")
    {
        MsgBox, 3, Backup DYNAMICS SET?, Are you sure you want to move DYNAMICS SET to C:\#FILEBAKS?
        IfMsgBox Yes
        {
            GuiControlGet, Dynamics
            FileCopy, %Dynamics%\DYNAMICS.SET, C:\#FILEBAKS, 1
            Return
        }
        IfMsgBox No
        {
            MsgBox, 0, Backup DYNAMICS SET?, DYNAMNICS SET was not backed up.
            Return
        }
        IfMsgBox Cancel
        {
            Return
        }
    }
    Else
    {
        MsgBox, 3, CREATE C:\#FILEBAKS?, C:\#FILEBAKS doesn't exist. Do you want to create it?
        IfMsgBox Yes
        {
            FileCreateDir, C:\#FILEBAKS
            MsgBox, 3, Backup DYNAMICS SET?, Are you sure you want to move DYNAMICS SET to C:\#FILEBAKS?
            IfMsgBox Yes
            {
                GuiControlGet, Dynamics
                FileCopy, %Dynamics%\DYNAMICS.SET, C:\#FILEBAKS, 1
                Return
            }
            IfMsgBox No
            {
                MsgBox, 0, Backup DYNAMICS SET?, DYNAMNICS SET was not backed up.
                Return
            }
        }
        IfMsgBox No
        {
            Return
        }
        IfMsgBox Cancel
        {
            Return
        }
    }


MoveCSV:
    if FileExist("C:\TEMP")
    {
        MsgBox, 3, MOVE CSV?, Are you sure you want to move to C:\TEMP?
        IfMsgBox Yes
        {
            FileCopy, \\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource\IDTProductCodes.csv, C:\TEMP, 1
            return
        }
        IfMsgBox No
        {
            MsgBox, 0, MOVE CSV?, was not moved.
            return
        }
        IfMsgBox Cancel
        {
            Return
        }
    }
    Else
    {
        MsgBox, 3, CREATE C:\TEMP?, C:\TEMP doesn't exist. Do you want to create it?
        IfMsgBox Yes
        {
            FileCreateDir, C:\TEMP
            MsgBox, 3, MOVE CSV?, Are you sure you want to move to C:\TEMP?
            IfMsgBox Yes
            {
                FileCopy, \\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource\IDTProductCodes.csv, C:\TEMP, 1
                return
            }
            IfMsgBox No
            {
                MsgBox, 0, MOVE CSV?, was not moved.
                return
            }
        }
        IfMsgBox No
        {
            Return
        }
        IfMsgBox Cancel
        {
            Return
        }
    }

MoveCNK:
    MsgBox, 3, MOVE CNK AND XML?, Are you sure you want to move the CNK and XML files to the Dynamics GP install folder?
    IfMsgBox Yes
    {
        FileCopy, \\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource\ONESOURCE.cnk, %Dynamics%, 1
        FileCopy, \\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource\ONESOURCENetSDKConfig.xml, %Dynamics%, 1
        FileCopy, \\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource\ONESOURCENetSDKLoggingConfig.xml, %Dynamics%, 1
        Return
    }
    IfMsgBox No
    {
        MsgBox, 0, MOVE CNK AND XML? CNK and XML files were not moved.
        Return
    }
    IfMsgBox Cancel
    {
        Return
    }

Shared:
    MsgBox, 3, OPEN SHARED FOLDER?, Are you sure you want to open?
    IfMsgBox Yes
    {
        Run, "\\sp-fileserv-01\Team QA\Setup Documentation\Thomsom Reuters Onesource"
        return
    }
    IfMsgBox No
    {
        Return
    }
    IfMsgBox Cancel
    {
        Return
    }

Remove:
    ;MsgBox, 0, Is Admin?, %A_IsAdmin%
    ;Return
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

;Create a Troubleshooting file in the shared folder with some quick tips
;Create a recording of the Onesource setup process for additional help
;Get screenshots of the required Settings
;Look into creating a Sql script that would insert the values for the Onesource Settings

GuiClose:
ExitApp