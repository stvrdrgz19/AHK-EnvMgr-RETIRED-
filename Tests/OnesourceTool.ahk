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
Gui, Add, Text, x30 y30, Step 1. Create Backup Directories
Gui, Font, S9,
Gui, Add, Text, x30 y60, Clicking the button below will create the C:\#FILEBAKS directory if it doesn't already Exist.
Gui, Add, Button, x30 y80 w100 h25 vBackup gBackup, Backup

Gui, Font, s16,
Gui, Add, Text, x30 y130, Step 2. Copy and Move DYNAMICS.SET
Gui, Font, S9,
Gui, Add, Text, x30 y160, Clicking the button below will move the DYNAMICS.SET file to FILEBAKS.
Gui, Add, Button, x30 y180 w100 h25 vSet gSet, Dynamics Set

Gui, Font, s16,
Gui, Add, Text, x30 y230, Step 3. Set DB Install Folder
Gui, Font, S9,
Gui, Add, Text, x30 y260, Select the location of your GP Install you want to add Onesource to.
Gui, Add, Edit, x30 y280 w400 vDynamics, 
Gui, Add, Button, x430 y278 w25 h25 vDynamicsFind gDynamicsFind, ...
Gui, Add, Text, x30 y320, Clicking the button below will move the Onesource files into your GP install directory.
Gui, Add, Button, x30 y340 w100 h25 gMoveFiles, Move Files

Gui, Font, s16,
Gui, Add, Text, x30 y390, Step 4. Move Product Codes
Gui, Font, S9,
Gui, Add, Text, x30 y420, Clicking the button below will move the csv file to the C:\TEMP directory, creating it if needed.
Gui, Add, Button, x30 y440 w100 h25 gMoveCSV, Move CSV

Gui, Font, s16,
Gui, Add, Text, x30 y490, Step 5. Update Dynamics GP Tables
Gui, Font, S9,
Gui, Add, Text, x30 y520, Run Dynamics GP as Admin, select OK/Yes to the prompts to update tables

Gui, Font, s16,
Gui, Add, Text, x30 y570, Step 6. Update TWO Database
Gui, Font, S9,
Gui, Add, Text, x30 y600, Run the SQL Query found here against your TWO Database.

;Step 7 - insert the values listed below

;Step 8 - Insert the item values listed below

Gui, Show, w500 h900, Onesource Tool
Return

Backup:
    Return

Set:
    Return

DynamicsFind:
    Return

MoveFiles:
    Return

MoveCSV:
    Return

GuiClose:
ExitApp