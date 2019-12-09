InstallLog(Network,Local)
{
    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Network%`n, Settings\SPGPInstallLog.txt
    FileRead, varList, Settings\ListOfBuilds.txt
    If ! InStr(varList, Local)
    {
        FileAppend, %Local%`n, Settings\ListOfBuilds.txt
    }
}