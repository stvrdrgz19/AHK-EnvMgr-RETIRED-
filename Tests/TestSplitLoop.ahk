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

/*
FileRead, Text, C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\TestText1.txt
oText := StrSplit(Text, "#")
Loop, % oText.MaxIndex()
	MsgBox, % oText[A_Index]
*/



/*
; Create the array, initially empty:
Array := [] ; or Array := Array()

; Write to the array:
Loop, Read, C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\TestText1.txt ; This loop retrieves each line from the file, one at a time.
{
    Array.Push(A_LoopReadLine) ; Append this line to the array.
}

; Read from the array:
; Loop % Array.MaxIndex()   ; More traditional approach.
for index, element in Array ; Enumeration is the recommended approach in most cases.
{
    ; Using "Loop", indices must be consecutive numbers from 1 to the number
    ; of elements in the array (or they must be calculated within the loop).
    ; MsgBox % "Element number " . A_Index . " is " . Array[A_Index]

    ; Using "for", both the index (or "key") and its associated value
    ; are provided, and the index can be *any* value of your choosing.
    MsgBox % "Element number " . index . " is " . element
}
*/



TestArray := []

Loop, Read, C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\TestText1.txt
{
    TestArray.Push(A_LoopReadLine)
}

for index, element in TestArray
{
    Random, RandomNum, 1, 14
    MsgBox % Array[%RandomNum%]
)



;https://www.autohotkey.com/docs/misc/Arrays.htm
;https://www.autohotkey.com/docs/commands/Loop.htm

ExitApp