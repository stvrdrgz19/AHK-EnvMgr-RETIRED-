


#SingleInstance, force

Gui, Add, Button, x30 y30 w100 h25 gClick1, 10 Percent
Gui, Add, Button, x30 y60 w100 h25 gClick2, 40 Percent
Gui, Add, Button, x30 y90 w100 h25 gClick3, 70 Percent
Gui, Add, Button, x30 y120 w100 h25 gComplete, Complete
Gui, Add, GroupBox, x15 y150 w270 h35,
Gui, Add, Progress, x20 y160 w260 h20 vMyProgress, 0
Gui, Show, w300 h200, Test GUI
Return

Click1:
    ;GuiControl,, MyProgress, +10 ;Adds 10% to the progress bar
    GuiControl,, MyProgress, 10 ;Sets the progress bar to 10%
    Return

Click2:
    ;GuiControl,, MyProgress, +30 ;Adds 30% to the progress bar
    GuiControl,, MyProgress, 40 ;Sets the progress bar to 40%
    Return

Click3:
    ;GuiControl,, MyProgress, +30 ;Adds 30% to the progress bar
    GuiControl,, MyProgress, 70 ;Sets the progress bar to 70%
    Return

Complete:
    GuiControl,, MyProgress, 100 ;Sets the progress bar to 100%
    Return

GuiClose:
ExitApp