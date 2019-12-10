InstallLog(Network)
{
    FileAppend, {%A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%}: %Network%`n, Settings\SPGPInstallLog.txt
}