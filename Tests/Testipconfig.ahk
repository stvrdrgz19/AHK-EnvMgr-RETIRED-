#SingleInstance, force

Gui, Add, Button, x30 y30 w100 h25, Click
Gui, Add, Text, x30 y60 gText, This is some text
Gui, Show, w300 h200, Gui
Return

ButtonClick:
    MsgBox, Computer Name: %A_ComputerName%`nOS Version: %A_OSVersion%`nIP Address: %A_IPAddress2%
    Return

Text:
    MsgBox, Computer Name: %A_ComputerName%`nOS Version: %A_OSVersion%`nIP Address: %A_IPAddress2%
    Return

GuiClose:
ExitApp