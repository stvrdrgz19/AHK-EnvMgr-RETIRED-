; AutoHotkey Version:   1.1.30.01
; Platform:             Win10
; Author:               Steve Rodriguez
;
; Description: Test automating programs
; Video Reference - https://www.youtube.com/watch?v=A1UiX_gCuDc

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force
;F7::Reload
;F8::
;================================================================================

;~The below adds "Test" aas a Font Style to the NotePad Font Window
;Control,Add,Test,ComboBox2,ahk_class #32770

;~ This Deletes the 5th entry in the Font Style NotePad Window
;Control,Delete,5,ComboBox2,ahk_class #32770

;~The below will dropdown the Script dropddown for 2 seconds, then close it.
;Control,Showdropdown,,ComboBox5,ahk_class #32770
;Sleep, 2000
;Control,Hidedropdown,,ComboBox5,ahk_class #32770

;~This will enter "Wow this is cool" into the Notepad window
;Can use ahk_class instead of ahk_exe, have to change notepad.exe to Notepad though.
;ControlSetText, Edit1, Wow this is cool, ahk_exe notepad.exe

;~This will copy the text in the specified object "Edit1" into the variable var.
;ControlGetText, var, Edit1, ahk_class Notepad
;MsgBox % var

;~This sets the Font to Cooper and the Font Style to Black
;ControlSetText,Edit1,Cooper,ahk_class #32770
;ControlSetText,Edit2,Bold,ahk_class #32770

;~This enters text into the Edit1 field of the Notepad program
;The Raw tag lets things like exclamation points be sent
;The Text tag could be used instead
;ControlSend,Edit1,{Raw}Hello World! ,ahk_class Notepad
;ControlSendRaw,Edit1,This is a cool example,ahk_class Notepad

;~This focuses the Edit2 Control of the Notepad font style window
;~This also gets the coordinates/w/h of the Edit 2 control in a msgbox
;Note sure what ControlGetFocus is used for, will have to look into this
;ControlGetFocus,var,ahk_exe notepad.exe
;ControlFocus,Edit2,ahk_exe notepad.exe
;ControlGetPos,x,y,width,height,Edit2,ahk_exe notepad.exe
;MsgBox % x a_tab y a_tab width a_tab height

;~This gets the checked value (0/1) of Button2 of the find menu in Notepad
;ControlGet,var,Checked,,Button2,ahk_exe notepad.exe
;MsgBox % var

;~This returns the selected text from the Notepad window.
;ControlGet,var,Selected,,Edit1,ahk_exe notepad.exe
;MsgBox % var

;~This returns the text on the 4th line of the notepad document
;ControlGet,var,Line,4,Edit1,ahk_exe notepad.exe
;MsgBox % var

;~This returns the number of the current selected line in the notepad document
;ControlGet,var,CurrentLine,,Edit1,ahk_exe notepad.exe
;MsgBox % var

;~This returns the amount of lines in the control
;ControlGet,var,LineCount,,Edit1,ahk_exe notepad.exe
;MsgBox % var

;~This returns the selected lines in a table (Specifically the Details tab table of WinSpy)
;Remove "Selected" to return all the results in the table
;Replace "Selected" with Focused ooto get the same as selected (not sure how different)
;Replace "Selected" with Col# to retreice specific columns
;Replacing "Selected" with "Selected Col4" will grab the selected value of the 4th Column
;Replacing "Selected" with Count returns the number of rows
;   Count Selected returns the number of rows selected
;   Count Focused returns the row number that is selected
;   Count Col Retrieves the number of Columns
;ControlGet,var,Choice,,ComboBox1,ahk_exe notepad.exe
;Replacing "Selected" with Choice retreives the name of the currently selected entry in a listbox or combobox
;ControlGet,var,List,Count Focused,SysListView321,ahk_exe WinSpy64.exe
;MsgBox % var

;~This left clicks Button4 in the Replace window of Notepad
;ControlClick,Button4,ahk_class #32770

;~This clicks into the Edit1 box of the Find/Replace window and pastes from the clipboard
;https://www.autohotkey.com/docs/commands/ControlClick.htm
;Clipboard:="Cool"
;Sleep, 200
;ControlClick,Edit1, ahk_class #32770,,Right,1,D
;Sleep, 100
;ControlSend,Edit1,%Clipboard%,ahk_class #32770

;~This scrolls down 5 times in the ComboBox1 control of the Font window
;Loop, 5
;{
;    ControlClick,ComboBox1,ahk_class #32770,,WheelDown
;}

;~The below will do stuff in the Notepad++ Preferences window.
Control,ChooseString,Language,ListBox1,ahk_exe notepad++.exe
sleep, 500
Control,ChooseString,C++,ListBox5,ahk_exe notepad++.exe
sleep, 500
ControlClick,Button114,ahk_exe notepad++.exe
sleep, 500
ControlClick,Button1,ahk_exe notepad++.exe