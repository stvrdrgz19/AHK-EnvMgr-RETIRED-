FileSelect(Path,Prompt,EditControl)
{
    global
    FileSelectFile, SelectedFile, 33, %Path%, %Prompt%
    If ErrorLevel
    {
        Return
    }
    Else
    {
        ;MsgBox, 0, test, %EditControl%`n%SelectedFile%
        GuiControl, 4:, %EditControl%, %SelectedFile%
        Return
    }
}