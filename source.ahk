#SingleInstance, Force


clicks := 1
hotKeyCC := ""
previousHotkeyCC := ""
activeCC := "false"

stopKeyAC := ""
previousHotkeyAC := ""
activeAC := "false"

MsgBox, 64, Beta, Cheat Clicker hotkey wont work

cheatClicker()
{
    global
    Gui, Add, Text, x10 y10 w90 h20, Clicks per click
    Gui, Add, Text, x110 y10 w90 h20 Disabled, Stop Hotkey
    Gui, Add, Edit, x10 y40 w90 h20 number vclicks, 2
    Gui, Add, Hotkey, x110 y40 w90 h20 ghotKeyCC vhotKeyCC Disabled
    Gui, Add, Button, x10 y70 w190 h20, Start Cheat Clicking
    Gui, Add, Button, x10 y100 w190 h20, Open Autoclicker
    Gui, Add, Text, x58 y130, Made by Banaanae
    Gui, -MaximizeBox
    Gui, Show, center h155 w210, Cheat Clicker
    Return
}

autoClicker()
{
    global
    Gui, Add, Text, x10 y10 w70 h20, Delay (ms)
    Gui, Add, Text, x90 y10 w70 h20, Click Amount
    Gui, Add, Text, x170 y10 w70 h20 Disabled, Hotkey
    Gui, Add, Text, x250 y10 w70 h20, Click Type
    Gui, Add, Edit, x10 y30 w70 h20 number vDelay, 1
    Gui, Add, Edit, x90 y30 w70 h20 number vAmount, 0
    Gui, Add, Hotkey, x170 y30 w70 h20 gstopKeyAC vstopKeyAC Disabled
    Gui, Add, DDL, x250 y30 w70 h20 vclickType R3, Left||Middle|Right
    Gui, Add, Button, x10 y60 w150 h20, Start
    Gui, Add, Button, x170 y60 w150 h20, Stop
    Gui, Add, Button, x10 y90 w310 h20, Return to Cheat Clicker
    Gui, Add, Text, x120 y120, Made by Banaanae
    Gui, -MaximizeBox
    Gui, Show, center h145 w335, Autoclicker
    Return
}

autoClickerStart(Amount, clickType, delay, activeAC)
{
    if (Amount = 0)
    {
        Loop,
        {
            if (clickType = "Left")
            {
                Click
            }
            Else if (clickType = "Right")
            {
                Click, Right
            }
            Else
            {
                Click, Middle
            }
            Sleep, %delay%
        } until activeAC = "false"
    }
    Else
    {
        Loop, %Amount%
        {
            if (clickType = "Left")
            {
                Click
            }
            Else if (clickType = "Right")
            {
                Click, Right
            }
            Else
            {
                Click, Middle
            }
            Sleep, %delay%
        } until activeAC = "false"
        activeAC := "false"
    }
}

cheatClicker()
Return ; Here to prevent code below from running when it shouldn't

ButtonStartCheatClicking:
if (hotKeyCC = "")
{
    MsgBox, 52, Alert, You have not set a stop hotkey!`nWithout a stop hotkey it may be hard to stop cheat clicking`nSet one now?
}
IfMsgBox, Yes
{
    Return
}
Hotkey, LButton, Cheat, On
WinMinimize, Cheat Clicker ; Might Remove
GuiControlGet, clicks
if (clicks = 1)
{
    Hotkey, LButton, Off
}
activeCC := "true"
Return

Cheat:
Loop %clicks%
{
    Click
}
Return

hotKeyCC:
if previousHotkeyCC
{
    Hotkey, %previousHotkeyCC%, Off
}
if !hotKeyCC
{
    Return
}
previousHotkeyCC := hotKeyCC
if activeCC
{
    Hotkey, LButton, Cheat, On
}
Else
{
    Hotkey, LButton,, Off
}
Return

ButtonOpenAutoclicker:
previousHotkeyCC := ""
hotKeyCC := ""
Gui, Destroy
; MsgBox, 64, Important, If you want to click forever, press 0 in Click Amount
autoClicker()
Return

ButtonStart:
GuiControlGet, Delay
GuiControlGet, Amount
GuiControlGet, stopKeyAC
GuiControlGet, clickType
activeAC := "true"
WinMinimize, Autoclicker ; Also might remove
autoClickerStart(Amount, clickType, delay, activeAC)
Return

stopKeyAC:
if previousHotkeyAC
{
    Hotkey, %previousHotkeyAC%, Off
}
if !stopKeyAC
{
    Return
}
if (activeAC = "true")
{
    activeAC := "false"
}
Else
{
    activeAC := "true"
    autoClickerStart(Amount, clickType, delay, activeAC)
}
previousHotkeyAC := stopKeyAC
Return

ButtonStop:
activeAC := "false"
Return

ButtonReturntoCheatClicker:
Gui, Destroy
cheatClicker()
Return

GuiClose:
MsgBox, 36, Exit App?, Do you want to close Cheat Clicker?
ifMsgBox, Yes
{
    ExitApp
}
Return
