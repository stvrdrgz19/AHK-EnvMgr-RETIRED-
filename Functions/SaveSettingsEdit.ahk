SaveSettingsEdit(FieldToSave,Section,Key)
{
    global BackupPath, ServName ,ServUN ,ServPW ,DynamicsDB ,RegDB ,MBDB ,GP1Loc ,GP2Loc ,GP3Loc ,GP4Loc ,GP5Loc ,PromptCloseBox
    GuiControlGet, BackupPath, 4:
    GuiControlGet, ServName, 4:
    GuiControlGet, ServUN, 4:
    GuiControlGet, ServPW, 4:
    GuiControlGet, DynamicsDB, 4:
    GuiControlGet, RegDB, 4:
    GuiControlGet, MBDB, 4:
    GuiControlGet, GP1Loc, 4:
    GuiControlGet, GP2Loc, 4:
    GuiControlGet, GP3Loc, 4:
    GuiControlGet, GP4Loc, 4:
    GuiControlGet, GP5Loc, 4:
    GuiControlGet, PromptCloseBox, 4:
    IniWrite, %FieldToSave%, Settings\Settings.ini, %Section%, %Key%
}




