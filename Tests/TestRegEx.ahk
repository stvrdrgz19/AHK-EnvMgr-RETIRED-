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
text=<a id="221573" uc="1">

Pos=1

While	Pos :=	RegExMatch(text,"""\K[^""]+""",m,Pos+StrLen(m))

	MsgBox % m	;SubStr(m,1,StrLen(m)-1)
*/



/*
FileRead, Test1, C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\TestText.txt

RegExMatch(Test1,"data-content=""\K[^""]+""" , Result)
MsgBox, % SubStr(Result,1,StrLen(Result)-1) ;Result
*/





/*

FileRead, Test1, C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\TestText.txt

Pos=1
While Pos := RegExMatch(Test1,"data-content=""\K[^""]+""" , Result)
    Result .= (!Result ? "" : "`n")
MsgBox, % SubStr(Result,1,StrLen(Result)-1) ;Result
*/




FileRead, var, C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\TestText.txt
Pos=1
While   Pos :=   RegExMatch(var,"data-content=""\K[^""]+""",m,Pos+StrLen(m))
   res .=   (!res ? "" : "`n") m
;MsgBox % res
FileAppend, %res%, C:\Users\steve.rodriguez\Desktop\EnvMgr\Tests\Results.txt

;MsgBox %   SubStr(res,1,StrLen(res)-1) ;res



ExitApp