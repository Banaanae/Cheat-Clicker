#SingleInstance, Force

clicks := 1
PreviousHotkey := ""
active := false

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
MsgBox, 64, Important, If you want to click forever, press 0 in Amt. clicks (IGNORE! TYPING 0 WILL DEFAULT TO ONE)`nNote! Click Type, Hotkey and Stop button all temp disabled.
Gui, Add, Text, x12 y10 w70 h20, Delay (ms)
Gui, Add, Text, x92 y10 w70 h20, Amt. clicks
Gui, Add, Text, x172 y10 w70 h20, Hotkey
Gui, Add, Text, x252 y10 w70 h20, Click Type
Gui, Add, Edit, x12 y30 w70 h20 number vDelay, 
Gui, Add, Edit, x92 y30 w70 h20 number vAmount,
;Gui, Add, Hotkey, x172 y30 w70 h20 vToggle
Gui, Add, Text, x172 y30, Use Buttons
;Gui, Add, DropDownList, x252 y30 w70 h60 vCType, Left||Middle|Right
Gui, Add, Text, x252 y30, WIP Left Only ; temp
Gui, Add, Button, x12 y60 w150 h20, Start
;Gui, Add, Button, x172 y60 w150 h20, Stop
Gui, Add, Text, x120 y90, Made by Banaanae
Gui, -MaximizeBox
Gui, Show, center h110 w335, Autoclicker
Return

ButtonStart:
GuiControlGet, Delay
GuiControlGet, Amount
;GuiControlGet, Toggle
;GuiControlGet, CType
active := true
if (Amount = 0) ; Temp
    Amount := 1 ; Temp
if (Amount = 0)
    Loop {
;        if (CType = Left)
            Click
;        Else ; Add Middle when working
;            Click, Right
        Sleep, %delay%
    } until active = false
Else
    Loop %Amount% {
;        if (CType = Left)
            Click
;        Else ; See Else above
;            Click, Right
        Sleep, %delay%
    } until active = false
    active := false
Return

;ButtonStop: ; This code doesn't work because the loop doesn't let this run
;active = false
;Return
