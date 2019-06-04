; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: Tiles change color when the button is pressed

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

Gui, Add, GroupBox, x10 y10 w185 h110, Modifier
Gui, Add, Checkbox, x20 y30 vCtrl gCtrl, Ctrl
Gui, Add, Checkbox, x20 y50 vShift gShift, Shift
Gui, Add, Checkbox, x20 y70 vWin gWin, Win
Gui, Add, Checkbox, x20 y90 vAlt gAlt, Alt

Gui, Add, GroupBox, x200 y10 w185 h110, Optional Attributes
Gui, Add, Checkbox, x210 y30 vNative, ~ (Native)
Gui, Add, Checkbox, x210 y50 vWildCard, * (WindCard)
Gui, Add, Checkbox, x210 y70 vLeft, < (Left pair only)
Gui, Add, Checkbox, x210 y90 vRight, > (Right pair only)

Gui, Add, GroupBox, x10 y130 w375 h180, Keys
Gui, Add, Radio, x20 y150 vStandard gStandard Checked, Standard
Gui, Add, Radio, x20 y170 vFunction gFunction, Function Keys
Gui, Add, Radio, x20 y190 vNumpad gNumpad, Numpad
Gui, Add, Radio, x20 y210 vMouse gMouse, Mouse
Gui, Add, Radio, x20 y230 vMultimedia gMultimedia, Multimedia
Gui, Add, Radio, x20 y250 vSpecial gSpecial, Special
Gui, Add, ListBox, x170 y150 w205 r11 vListBox1, a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z

Gui, Add, Text, x20 y320, Hotkey:
Gui, Add, Edit, ReadOnly x70 y318 w305 vHotkey, 
Gui, Add, Text, x20 y345, Desc:
Gui, Add, Text, x70 y345 vTxtEdit, 

Gui, Add, Button, x10 y380 w100 h25 vGenerate gGenerate, Generate
Gui, Add, Button, x120 y380 w100 h25 vReset gReset, Reset

GuiControl, Disable, Native
GuiControl, Disable, WildCard
GuiControl, Disable, Left
GuiControl, Disable, Right

Gui, Show, w400 h415, Autohotkey Hotkeys
Return

Ctrl:
    GuiControlGet, Ctrl
    if Ctrl = 1
    {
        xControl = 1
    }
    Else
    {
        xControl = 0
    }
    Return

Shift:
    Return

Win:
    Return

Alt:
    Return


Native:
    Return

WildCard:
    Return

Left:
    Return

Right:
    Return


Standard:
    GuiControl, , ListBox1, |
    GuiControl, , ListBox1, a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z
    Return

Function:
    GuiControl, , ListBox1, |
    GuiControl, , ListBox1, F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12
    Return

Numpad:
    GuiControl, , ListBox1, |
    GuiControl, , ListBox1, Numpad0|Numpad1|Numpad2|Numpad3|Numpad4|Numpad5|Numpad6|Numpad7|Numpad8|Numpad9|NumpadDot|NumpadEnter|NumpadMult|NumpadDiv|NumpadAdd|NumpadSub|NumpadDel|NumpadIns|NumpadClear|NumpadUp|NumpadDown|NumpadLeft|NumpadRight|NumpadHome|NumpadEnd|NumpadPgUp|NumpadPgDn
    Return

Mouse:
    GuiControl, , ListBox1, |
    GuiControl, , ListBox1, WheelDown|WheelUp|WheelLeft|WheelRight|LButton|RButton|MButton|XButton1|XButton2
    Return

Multimedia:
    GuiControl, , ListBox1, |
    GuiControl, , ListBox1, Volume_Mute|Volume_Down|Volume_Up|Media_Next|Media_Prev|Media_Stop|Media_Play_Pause
    Return

Special:
    GuiControl, , ListBox1, |
    GuiControl, , ListBox1, !|#|+|^|{|}|Enter|Escape|Space|Tab|Backspace|Delete|Insert|Up|Down|Left|Right|Home|End|PgUp|PgDn|CapsLock|ScrollLock|NumLock|Ctrl|LCtrl|RCtrl|Ctrl Down|Ctrl Up|Alt|LAlt|RAlt|Alt Down|Alt Up|Shift|LShift|RShift|Shift Down|Shift Up|LWin|RWin|LWin Down|LWin Up|RWin Down|RWin Up
    Return

Generate:
    GuiControlGet, Ctrl
    GuiControlGet, Shift
    GuiControlGet, Win
    GuiControlGet, Alt
    GuiControlGet, ListBox1
    GuiControlGet, TxtEdit
    GuiControl,, TxtEdit, |
    GuiControl,, TxtEdit, %Ctrl% + %Shift% + %Win% + %Alt% + %ListBox1%
    Return

Reset:
    Return

GuiClose:
ExitApp