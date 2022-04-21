clicks := 1
previousHotkey := ""

Gui, Add, Text, x25 y20 w90 h20, Clicks per click
Gui, Add, Edit, x25 y50 w90 h20 number vclicks, 2
Gui, Add, Text, x141 y20 w90 h20, Stop Hotkey
Gui, Add, Hotkey, x141 y50 w90 h20 gStopKey vStopKey
Gui, Add, Button, x25 y80 w207 h20, Start
Gui, Add, Text, x80 y110, Made by Banaanae
Gui, -MaximizeBox
Gui, Show, h140 w256, Cheat Clicker
Return

ButtonStart:
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
if previousHotkey
    Hotkey, %previousHotkey%, Off
if !StopKey
    Return
Hotkey, %StopKey%, Reset, On
previousHotkey := StopKey
Return

Reset:
Hotkey, LButton, Off
WinActivate, Cheat Clicker
Return
