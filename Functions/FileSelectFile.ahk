FileSelect(Variable,Path,Prompt,EditControl)
{
    FileSelectFile, %Variable%, 33, %Path%, %Prompt%
    If ErrorLevel
    {
        Return
    }
    Else
    {
        GuiControl, 4:, %EditControl%, %Variable%
        Return
    }
}