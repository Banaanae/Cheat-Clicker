clicks = 1

Gui, Add, Text, x25 y20 w90 h20, Clicks per click
Gui, Add, Edit, x25 y50 w90 h20 number vclicks, 2
Gui, Add, Text, x141 y20 w90 h20, Stop Cheat Hotkey
;Gui, Add, Hotkey, x141 y20 w90 h20, F5
Gui, Add, Text, x141 y50 w90 h20, WIP (F5 for now)
Gui, Add, Button, x25 y80 w200 h20, Start
Gui, -MaximizeBox
Gui, Show, h128 w256, Cheat Clicker
Return

ButtonStart:
GuiControlGet, clicks
WinMinimize, Cheat Clicker
Return

GuiClose:
ExitApp
Return

LButton::
Loop %clicks% {
    Click
}
Return

F5::
clicks = 1
WinActivate, Cheat Clicker
Return
