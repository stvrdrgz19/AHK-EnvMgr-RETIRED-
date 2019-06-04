


#SingleInstance, force

;Loop, read, C:\Users\stvrd\Desktop\Tests\Test1.txt, C:\Users\stvrd\Desktop\Tests\Test2.txt
;{
;    if InStr(A_LoopReadLine, "family")
;        FileAppend, %A_LoopReadLine%`n
;}

Loop, read, C:\Users\stvrd\Desktop\Tests\Test1.txt, C:\Users\stvrd\Desktop\Tests\Test2.txt
{
    if InStr(A_LoopReadLine, "Test-task="*" ")
        FileAppend, %A_LoopReadLine%`n
}



 