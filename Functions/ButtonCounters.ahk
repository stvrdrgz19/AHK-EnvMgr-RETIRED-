ButtonCounters(keyName)
{
    IniRead, localVar, Settings\ButtonCounters.ini, ButtonCounters, %keyName%
    localVar += 1
    IniWrite, %localVar%, Settings\ButtonCounters.ini, ButtonCounters, %keyName%
}