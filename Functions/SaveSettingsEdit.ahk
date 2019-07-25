SaveSettingsEdit(FieldToSave,Section,Key)
{
    global BackupPath
    global ServName ;,ServUN ,ServPW ,DynamicsDB ,RegDB ,MBDB ,GP1Loc ,GP2Loc ,GP3Loc ,GP4Loc ,GP5Loc ,PromptCloseBox ,CloudLabel01 ,CloudLabel02 ,CloudLabel03 ,CloudLabel04 ,CloudLabel05 ,GPLabel1 ,GPLabel2 ,GPLabel3 ,GPLabel4 ,GPLabel
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
    GuiControlGet, CloudLabel01, 4:
    GuiControlGet, CloudLabel02, 4:
    GuiControlGet, CloudLabel03, 4:
    GuiControlGet, CloudLabel04, 4:
    GuiControlGet, CloudLabel05, 4:
    GuiControlGet, GPLabel1, 4:
    GuiControlGet, GPLabel2, 4:
    GuiControlGet, GPLabel3, 4:
    GuiControlGet, GPLabel4, 4:
    GuiControlGet, GPLabel, 4:
    IniWrite, %FieldToSave%, Settings\Settings.ini, %Section%, %Key%
}




