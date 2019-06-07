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



colors := Object("red", 0xFF0000, "blue", 0x0000FF, "green", 0x00FF00)
for key, value in colors
    s .= key "=" value "`n"
MsgBox % s



/*
dir := "\\sp-fileserv-01\Shares\Builds\SalesPad.GP\Release\4.6.4.6"

FileSelectFile, FilesExt, M3, %dir%\ExtModules\WithOutCardControl, Select any DLLs needed, *.zip
Array := StrSplit(FilesExt, "`n")

for index, file in Array
{
    if index = 1
        Dir := file
    else
        FileCopy, % Dir "\" file, C:\#EnvMgr\TEMPFILES\DLLs
}

FileSelectFile, FilesExt, M3, %dir%\ExtModules\WithOutCardControl, Select any DLLs needed, *.zip
Array := StrSplit(FilesExt, "`n")

for index, file in Array
{
    if index = 1
        Dir := file
    else
        FileCopy, % Dir "\" file, C:\#EnvMgr\TEMPFILES\DLLs
}
*/

;CustomModules\WithOutCardControl