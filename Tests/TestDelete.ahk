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

Test=Dynamics

;Dynamics = C:\Program Files (x86)\Microsoft Dynamics\GP2016$NOT UPDATED

/*
Clipboard:= Dynamics"\ONESOURCE.cnk"
*/
MsgBox, 0, Test, %Dynamics%\ONESOURCE.cnk


;if FileExist("%Dynamics%\ONESOURCE.cnk")
;    FileDelete, %Dynamics%\ONESOURCE.cnk

;if FileExist("C:\Program Files (x86)\Microsoft Dynamics\GP2016$NOT UPDATED\ONESOURCENetSDKConfig.xml")
;    FileDelete, C:\Program Files (x86)\Microsoft Dynamics\GP2016$NOT UPDATED\ONESOURCENetSDKConfig.xml

ExitApp