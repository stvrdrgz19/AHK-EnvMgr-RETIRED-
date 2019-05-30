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
Gui, Add, Edit, x30 y80 w400 vDynamics,
Gui, Add, Button, x430 y79 w23 h23 vDynamicsFind gDynamicsFind, ...
Gui, Add, Text, x150 y120, Clicking the Backup SET button will create a backup of your `nDYNAMICS.SET file and place it in C:\#FILEBAKS, creating `nthe directory if it doesn't exist. 
Gui, Add, Button, x30 y125 w100 h25 gBackSet, Backup SET
Gui, Add, Text, x150 y170, Clicking the Move CSV button will move the CSV file to the `nC:\TEMP directory (Called in the sql script required), creating `nthe directory if it doesn't exist.
Gui, Add, Button, x30 y175 w100 h25 gMoveCSV, Move CSV
Gui, Add, Text, x30 y225, Next you will need to run Dynamics GP as Admin. Select OK/accept the table updates, `nthese are required for Onesource.
Gui, Add, Text, x150 y275, Clicking the Shared button will pop open the shared location `nof the Onesource files. Run the SQL file against your TWO `ndatabase. Leave the folder open and return to Dynamics GP.
Gui, Add, Button, x30 y280 w100 h25 gShared, Shared
Gui, Add, Text, x30 y335, Navigate to Dynamics GP > Tools > Setup > Onesource > Company Setup. Fill out the `nsettings referencing the screenshots in the Shared Folder.
Gui, Add, Text, x30 y375, Navigate to Dynamics GP > Tools > Setup > Onesource > Inventory Setup. Fill out `nthe Settings referencing the screenshots in the Shared Folder.
Gui, Add, Text, x30 y415, In SalesPad GP > Settings > Filter to Onesource, fill out the settings referencing `nthe screenshots in the Shared Folder. Also set the Tax Query Handler to Onesource.
Gui, Add, Text, x30 y455, In SalesPad GP, navigate to the Customer you want to use and set their Contact's `nTax Codes to IDT > Save. To verify taxes are being calculated correctly create a `nSales Document for this Customer > Add an Item > Save > Check the Audit.
Gui, Add, Text, x30 y505 w425 0x10 ;Horizontal Line
Gui, Add, Text, x150 y520, Click the Remove button to remove all of the Onesource stuff `nfrom your Dynamics GP installation. This also restores your `nbacked up DYNAMICS SET file.
Gui, Add, Button, x30 y525 w100 h25 gRemove, Remove
Gui, Show, w480 h580, Onesource Tool
Return

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
            Return
        }
        IfMsgBox No
        {
            MsgBox, 0, Backup DYNAMICS SET?, DYNAMNICS SET was not backed up.
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
    }


MoveCSV:
    if FileExist("C:\TEMP")
    {
        MsgBox, 3, MOVE CSV?, Are you sure you want to move to C:\TEMP?
        IfMsgBox Yes
        {
            return
        }
        IfMsgBox No
        {
            MsgBox, 0, MOVE CSV?, was not moved.
            return
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
    }

Shared:
    MsgBox, 3, OPEN SHARED FOLDER?, Are you sure you want to open?
    IfMsgBox Yes
    {
        Run, "\\sp-fileserv-01\Shares\SharedFolders\SteveR\Onesource"
        return
    }
    IfMsgBox No
    {
        Return
    }

Remove:
    Return

;Create a Troubleshooting file in the shared folder with some quick tips
;Create a recording of the Onesource setup process for additional help
;Get screenshots of the required Settings
;Look into creating a Sql script that would insert the values for the Onesource Settings


GuiClose:
ExitApp