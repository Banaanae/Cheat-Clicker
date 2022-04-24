clicks := 1
PreviousHotkey := ""

Gui, Add, Text, x25 y20 w90 h20, Clicks per click
Gui, Add, Edit, x25 y50 w90 h20 number vclicks, 2
Gui, Add, Text, x141 y20 w90 h20, Stop Hotkey
Gui, Add, Hotkey, x141 y50 w90 h20 gStopKey vStopKey
Gui, Add, Button, x25 y80 w207 h20, Start Cheat Clicking
Gui, Add, Button, x25 y110 w207 h20, Open Autoclicker
Gui, Add, Text, x80 y140, Made by Banaanae
Gui, -MaximizeBox
Gui, Show, h170 w256 Center, Cheat Clicker
Return

ButtonStartCheatClicking:
if (StopKey = "")
    MsgBox, 52, Alert, You have not set a stop hotkey!`nWithout a stop hotkey it may be hard to stop cheat clicking`nSet one now?
IfMsgBox, Yes
    Return
Hotkey, LButton, Cheat, On
WinMinimize, Cheat Clicker
GuiControlGet, clicks
if clicks = 1
    Hotkey, LButton, Off
Return

GuiClose:
ExitApp
Return

Cheat:
Loop %clicks% {
    Click
}
Return

StopKey:
if PreviousHotkey
    Hotkey, %PreviousHotkey%, Off
if !StopKey
    Return
Hotkey, %StopKey%, Reset, On
PreviousHotkey := StopKey
Return

Reset:
Hotkey, LButton, Off
WinActivate, Cheat Clicker
Return

ButtonOpenAutoclicker:
PreviousHotkey := ""
StopKey := ""
Gui, Destroy
Gui, Add, Text, x12 y10 w310 h20, Autoclicker
Gui, Add, Text, x12 y40 w70 h20, Delay (ms)
Gui, Add, Text, x92 y40 w70 h20, Amt. clicks
Gui, Add, Text, x172 y40 w70 h20, Hotkey
Gui, Add, Text, x252 y40 w70 h20, Click Type
Gui, Add, Edit, x12 y70 w70 h20 number, 
Gui, Add, Edit, x92 y70 w70 h20 number,
Gui, Add, Hotkey, x172 y70 w70 h20 ; gToggle vToggle
Gui, Add, DropDownList, x252 y70 w70 h60, Left|Right
Gui, Add, Button, x12 y100 w150 h20, Start
Gui, Add, Button, x172 y100 w150 h20, Stop
Gui, -MaximizeBox
Gui, Show, center h130 w340, Autoclicker
; Get autoclicker variables and start it
