FolderSelect(Path,Prompt,EditControl)
{
    global
    FileSelectFolder, SelectedFolder, %Path%, 3, %Prompt%
    If SelectedFolder = 
    {
        MsgBox, 0, ERROR, Nothing was selected.
        Return
    }
    Else
    {
        GuiControl, 4:, %EditControl%, %SelectedFolder%
        Return
    }
}