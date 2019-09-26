GuiButtonIcon(Handle, File, Index := 1, Options := "")
{
	RegExMatch(Options, "i)w\K\d+", W), (W="") ? W := 16 :
	RegExMatch(Options, "i)h\K\d+", H), (H="") ? H := 16 :
	RegExMatch(Options, "i)s\K\d+", S), S ? W := H := S :
	RegExMatch(Options, "i)l\K\d+", L), (L="") ? L := 0 :
	RegExMatch(Options, "i)t\K\d+", T), (T="") ? T := 0 :
	RegExMatch(Options, "i)r\K\d+", R), (R="") ? R := 0 :
	RegExMatch(Options, "i)b\K\d+", B), (B="") ? B := 0 :
	RegExMatch(Options, "i)a\K\d+", A), (A="") ? A := 4 :
	Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
	VarSetCapacity( button_il, 20 + Psz, 0 )
	NumPut( normal_il := DllCall( "ImageList_Create", DW, W, DW, H, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr )	; Width & Height
	NumPut( L, button_il, 0 + Psz, DW )		; Left Margin
	NumPut( T, button_il, 4 + Psz, DW )		; Top Margin
	NumPut( R, button_il, 8 + Psz, DW )		; Right Margin
	NumPut( B, button_il, 12 + Psz, DW )	; Bottom Margin	
	NumPut( A, button_il, 16 + Psz, DW )	; Alignment
	SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
	return IL_Add( normal_il, File, Index )
}

/*
Gui, Add, Button, w22 h22 hwndIcon
if !GuiButtonIcon(Icon, "some.exe") ; Example of Icon not found
    GuiButtonIcon(Icon, "shell32.dll") ; Not Found then do this

Gui, Add, Button, w22 h22 hwndIcon
GuiButtonIcon(Icon, A_AhkPath)
Gui, Add, Button, w22 h22 hwndIcon
GuiButtonIcon(Icon, "shell32.dll", 23)

Gui, Add, Button, w38 h38 hwndIcon1
Gui, Add, Button, w38 h38 hwndIcon2
Gui, Add, Button, w70 h38 hwndIcon3, Open
Gui, Add, Button, w70 h38 hwndIcon4, % " Save"
Gui, Add, Button, w70 h60 hwndIcon5, % "            Cut`n`n DANGER"
Gui, Add, Button, w26 h26 hwndIcon6
GuiButtonIcon(Icon1, "shell32.dll", 1, "s32")
GuiButtonIcon(Icon2, "imageres.dll", 46, "s32 a1")
GuiButtonIcon(Icon3, "shell32.dll", 46, "s32 a0 l2")
GuiButtonIcon(Icon4, "shell32.dll", 259, "s32 a1 r2")
GuiButtonIcon(Icon5, "shell32.dll", 260, "w40 h22 r20 b20")
GuiButtonIcon(Icon6, "C:\Program Files (x86)\Microsoft Dynamics\GP2016\GPIcons.dll", 117, "s16")

Gui, Show

Return

GuiEscape:
GuiClose:
Exitapp
*/