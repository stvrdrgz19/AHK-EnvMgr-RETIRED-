This is a test
* This is test one
* This is test two

This is another test
- This is test three
- This is test four

```Autohotkey
ButtonSalesPadDesktop:
    GuiControlGet, CheckB
    If VarCheck = 1
    {
        MsgBox, 4, Grizzly Build?, Are you installing a Grizzly Build?
        ifMsgBox, No
        {
            GuiControl, , CheckB, 0
            VarCheck = 0
            return
        }
    }
    Else
    {
        Goto, GetBuild
        return
    }
```

_This is a MD File_
*Bold*
