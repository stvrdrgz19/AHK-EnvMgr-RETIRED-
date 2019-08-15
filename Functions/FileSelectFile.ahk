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
        GuiControl, 4:, %EditControl%, %SelectedFile%
        Return
    }
}