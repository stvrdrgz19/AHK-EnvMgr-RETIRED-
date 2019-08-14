FolderSelect(Variable,Path,Prompt,EditControl)
{
    global
    FileSelectFolder, %Variable%, %Path%, 3, %Prompt%
    If %Variable% = 
    {
        MsgBox, 0, ERROR, Nothing was selected.
        Return
    }
    Else
    {
        GuiControl, 4:, %EditControl%, %Variable%
        Return
    }
}