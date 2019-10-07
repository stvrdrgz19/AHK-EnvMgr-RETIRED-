RestoreDB()
{
    global
    GuiControlGet, Combo1
    IniRead, Var1, Settings\Settings.ini, SQLCreds, Server
    IniRead, Var2, Settings\Settings.ini, SQLCreds, User
    IniRead, Var3, Settings\Settings.ini, SQLCreds, Password
    IniRead, Var4, Settings\Settings.ini, BackupFolder, path
    IniRead, Var5, Settings\Settings.ini, Databases, Dynamics
    IniRead, Var6, Settings\Settings.ini, Databases, Company1
    IniRead, Var7, Settings\Settings.ini, Databases, Company2
    Run, "Scripts\Script.DBRestore.bat" %Var1% %Var2% %Var3% %Var4% "%Combo1%" %Var5% %Var6% %Var7%,, UseErrorLevel
    WinWait, C:\windows\system32\cmd.exe
    WinWaitClose
    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: Restored "%Combo1%" backup.`n, Settings\Log.txt
}