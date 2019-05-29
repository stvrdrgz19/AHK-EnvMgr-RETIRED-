; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: Random number generator, in the form of a Character Ability Score
;   generator for 5e Dungeons and Dragons.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

Gui, Add, Button, x30 y30 w100 h25 vGen, Generate
Gui, Add, Edit, w25 x30 y60 vBox1a, 
Gui, Add, Edit, w25 x60 y60 vBox1b,
Gui, Add, Edit, w25 x90 y60 vBox1c,
Gui, Add, Edit, w25 x120 y60 vBox1d,
Gui, Add, Edit, w25 x160 y60 vMin1,
Gui, Add, Edit, w25 x200 y60 vResult1,

Gui, Add, Edit, w25 x30 y90 vBox2a, 
Gui, Add, Edit, w25 x60 y90 vBox2b,
Gui, Add, Edit, w25 x90 y90 vBox2c,
Gui, Add, Edit, w25 x120 y90 vBox2d,
Gui, Add, Edit, w25 x160 y90 vMin2,
Gui, Add, Edit, w25 x200 y90 vResult2,

Gui, Add, Edit, w25 x30 y120 vBox3a, 
Gui, Add, Edit, w25 x60 y120 vBox3b,
Gui, Add, Edit, w25 x90 y120 vBox3c,
Gui, Add, Edit, w25 x120 y120 vBox3d,
Gui, Add, Edit, w25 x160 y120 vMin3,
Gui, Add, Edit, w25 x200 y120 vResult3,

Gui, Add, Edit, w25 x30 y150 vBox4a, 
Gui, Add, Edit, w25 x60 y150 vBox4b,
Gui, Add, Edit, w25 x90 y150 vBox4c,
Gui, Add, Edit, w25 x120 y150 vBox4d,
Gui, Add, Edit, w25 x160 y150 vMin4,
Gui, Add, Edit, w25 x200 y150 vResult4,

Gui, Add, Edit, w25 x30 y180 vBox5a, 
Gui, Add, Edit, w25 x60 y180 vBox5b,
Gui, Add, Edit, w25 x90 y180 vBox5c,
Gui, Add, Edit, w25 x120 y180 vBox5d,
Gui, Add, Edit, w25 x160 y180 vMin5,
Gui, Add, Edit, w25 x200 y180 vResult5,

Gui, Add, Edit, w25 x30 y210 vBox6a, 
Gui, Add, Edit, w25 x60 y210 vBox6b,
Gui, Add, Edit, w25 x90 y210 vBox6c,
Gui, Add, Edit, w25 x120 y210 vBox6d,
Gui, Add, Edit, w25 x160 y210 vMin6,
Gui, Add, Edit, w25 x200 y210 vResult6,

Gui, Show, w300 h300, Test Gui
Return

ButtonGenerate:
    GuiControlGet, Rand1
    Random, Rand1, 1, 6
    GuiControl, , Box1a, %Rand1%
    GuiControlGet, Rand2
    Random, Rand2, 1, 6
    GuiControl, , Box1b, %Rand2%
    GuiControlGet, Rand3
    Random, Rand3, 1, 6
    GuiControl, , Box1c, %Rand3%
    GuiControlGet, Rand4
    Random, Rand4, 1, 6
    GuiControl, , Box1d, %Rand4%
    GuiControlGet, Min1
    VarMin1 := Min(Rand1,Rand2,Rand3,Rand4)
    GuiControl, , Min1, %VarMin1%
    GuiControlGet, Result1
    VarResult1 := Rand1 + Rand2 + Rand3 + Rand4 - VarMin1
    GuiControl, , Result1, %VarResult1%
    
    GuiControlGet, Rand5
    Random, Rand5, 1, 6
    GuiControl, , Box2a, %Rand5%
    GuiControlGet, Rand6
    Random, Rand6, 1, 6
    GuiControl, , Box2b, %Rand6%
    GuiControlGet, Rand7
    Random, Rand7, 1, 6
    GuiControl, , Box2c, %Rand7%
    GuiControlGet, Rand8
    Random, Rand8, 1, 6
    GuiControl, , Box2d, %Rand8%
    GuiControlGet, Min2
    VarMin2 := Min(Rand5,Rand6,Rand7,Rand8)
    GuiControl, , Min2, %VarMin2%
    GuiControlGet, Result2
    VarResult2 := Rand5 + Rand6 + Rand7 + Rand8 - VarMin2
    GuiControl, , Result2, %VarResult2%

    GuiControlGet, Rand9
    Random, Rand9, 1, 6
    GuiControl, , Box3a, %Rand9%
    GuiControlGet, Rand10
    Random, Rand10, 1, 6
    GuiControl, , Box3b, %Rand10%
    GuiControlGet, Rand11
    Random, Rand11, 1, 6
    GuiControl, , Box3c, %Rand11%
    GuiControlGet, Rand12
    Random, Rand12, 1, 6
    GuiControl, , Box3d, %Rand12%
    GuiControlGet, Min3
    VarMin3 := Min(Rand9,Rand10,Rand11,Rand12)
    GuiControl, , Min3, %VarMin3%
    GuiControlGet, Result3
    VarResult3 := Rand9 + Rand10 + Rand11 + Rand12 - VarMin3
    GuiControl, , Result3, %VarResult3%
    
    GuiControlGet, Rand13
    Random, Rand13, 1, 6
    GuiControl, , Box4a, %Rand13%
    GuiControlGet, Rand14
    Random, Rand14, 1, 6
    GuiControl, , Box4b, %Rand14%
    GuiControlGet, Rand15
    Random, Rand15, 1, 6
    GuiControl, , Box4c, %Rand15%
    GuiControlGet, Rand16
    Random, Rand16, 1, 6
    GuiControl, , Box4d, %Rand16%
    GuiControlGet, Min4
    VarMin4 := Min(Rand13,Rand14,Rand15,Rand16)
    GuiControl, , Min4, %VarMin4%
    GuiControlGet, Result4
    VarResult4 := Rand13 + Rand14 + Rand15 + Rand16 - VarMin4
    GuiControl, , Result4, %VarResult4%
    
    GuiControlGet, Rand17
    Random, Rand17, 1, 6
    GuiControl, , Box5a, %Rand17%
    GuiControlGet, Rand18
    Random, Rand18, 1, 6
    GuiControl, , Box5b, %Rand18%
    GuiControlGet, Rand19
    Random, Rand19, 1, 6
    GuiControl, , Box5c, %Rand19%
    GuiControlGet, Rand20
    Random, Rand20, 1, 6
    GuiControl, , Box5d, %Rand20%
    GuiControlGet, Min5
    VarMin5 := Min(Rand17,Rand18,Rand19,Rand20)
    GuiControl, , Min5, %VarMin5%
    GuiControlGet, Result5
    VarResult5 := Rand17 + Rand18 + Rand19 + Rand20 - VarMin5
    GuiControl, , Result5, %VarResult5%
    
    GuiControlGet, Rand21
    Random, Rand21, 1, 6
    GuiControl, , Box6a, %Rand21%
    GuiControlGet, Rand22
    Random, Rand22, 1, 6
    GuiControl, , Box6b, %Rand22%
    GuiControlGet, Rand23
    Random, Rand23, 1, 6
    GuiControl, , Box6c, %Rand23%
    GuiControlGet, Rand24
    Random, Rand24, 1, 6
    GuiControl, , Box6d, %Rand24%
    GuiControlGet, Min6
    VarMin6 := Min(Rand21,Rand22,Rand23,Rand24)
    GuiControl, , Min6, %VarMin6%
    GuiControlGet, Result6
    VarResult6 := Rand21 + Rand22 + Rand23 + Rand24 - VarMin6
    GuiControl, , Result6, %VarResult6%
    return

GuiClose:
ExitApp