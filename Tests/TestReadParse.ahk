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

theData =
(
Dog license number registered to Jane Doe 
Burmington California 
2 warnings given, has following dog tags recorded. 

Jane Doe, Dog Name Scruffy, License#1 abcd1234 
123 roadname st. 
Burmington, CA. 33124 

Record # 92211LG
Jane Doe, Dog Name Dog2, License#1 TEST1234 
Jane Doe, Dog Name Scruffy3, License#1 Test12345
Jane Doe, Dog Name Scruffyddd, License#1 abcd12346
)

; read the data.
Loop, parse, theData, `n, `r  ; Specifying `n prior to `r allows both Windows and Unix files to be parsed.
	{
	; skip blank lines
	If A_LoopField =
		Continue
	; look for the line that has License#1 in it
	IfInString, A_LoopField, License#1
		{
		; get the licence number by RegExReplace & stored in variable 'licences'
		licences .= RegExReplace(A_LoopField, "^.*License#1 (.*)", "$1") . "`n"
		}
	}
msgbox outta loop`n`n%licences%