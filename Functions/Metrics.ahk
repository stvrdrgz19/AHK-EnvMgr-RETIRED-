Metrics(keyName)
{
    IniRead, localVar, Settings\Metrics.ini, Metrics, %keyName%
    localVar += 1
    IniWrite, %localVar%, Settings\Metrics.ini, Metrics, %keyName%
}