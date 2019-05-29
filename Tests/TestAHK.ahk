#SingleInstance, force

run, "C:\Program Files\Dell SonicWALL\Global VPN Client\SWGVC.exe"

SLEEP 5000

FileRead, Clipboard, C:\#SCRIPTS\TestingComments\SonicWallUN.txt
Send, ^v
;return
;
;^Numpad9::
Send {Tab} ;, #32770
FileRead, Clipboard, C:\#SCRIPTS\TestingComments\SonicWallPW.txt
Send, ^v
Send {Enter}
return