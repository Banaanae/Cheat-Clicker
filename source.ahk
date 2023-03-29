; Doesn't
#SingleInstance Force
#Warn All, Off

;Hotkey, LButton, Cheat, On
;Hotkey, LButton, Off
clicks := 1
hotKeyCC := ""
previousHotkeyCC := ""
activeCC := "false"

stopKeyAC := ""
previousHotkeyAC := ""
activeAC := "false"

CheatClickerGui := Gui(, "Cheat Clicker")
CheatClickerGui.AddText("x10 y10 w90 h20", "Clicks per click")
CheatClickerGui.AddText("x110 y10 w90 h20", "Stop Hotkey")
CheatClickerGui.AddEdit("x10 y40 w90 h20 number vclicks", "2")
CheatClickerGui.AddHotkey("x110 y40 w90 h20 vhotKeyCC") ; ghotKeyCC
CheatClickerGui.AddButton("x10 y70 w190 h20", "Start Cheat Clicking")
CheatClickerGui.AddButton("x10 y100 w190 h20", "Open Autoclicker")
CheatClickerGui.AddText("x58 y130", "Made by Banaanae")
CheatClickerGui.Show()


/*
ButtonStartCheatClicking:
if (hotKeyCC = "") {
    noHotkey := MsgBox, 52, Alert, You have not set a stop hotkey!`nWithout a stop hotkey it may be hard to stop cheat clicking`nSet one now?
    if (noHotkey = Yes) {
        Return
    }
}
;Hotkey, LButton, Cheat, On
GuiControlGet, clicks
if (clicks = 1)
{
    ;Hotkey, LButton, Off
}
activeCC := "true"
Return
*/
Cheat:
Loop ;%clicks%
{
    ;Click
}
Return

hotKeyCC:
if previousHotkeyCC
{
    ;Hotkey, %previousHotkeyCC%, Off
}
if !hotKeyCC
{
    Return
}
;Hotkey, %hotKeyCC%, ResetCheatClicker, On
previousHotkeyCC := hotKeyCC
Return
/*
ResetCheatClicker:
if (activeCC = "true")
{
    ;Hotkey, LButton, Off
    activeCC := "false"
}
Else
{
    ;Hotkey, LButton, On
    activeCC := "true"
}
Return
*/
; Autoclicker code start

AutoclickerGui := Gui(, "Autoclicker")
AutoclickerGui.AddText("x10 y10 w70 h20", "Delay (dms)")
AutoclickerGui.AddText("x90 y10 w70 h20", "Click Amount")
AutoclickerGui.AddText("x170 y10 w70 h20 Disabled", "Hotkey")
AutoclickerGui.AddText("x250 y10 w70 h20", "Click Type")
AutoclickerGui.AddEdit("x10 y30 w70 h20 number vDelay", "1")
AutoclickerGui.AddEdit("x90 y30 w70 h20 number vAmount", "0")
AutoclickerGui.AddHotkey("x170 y30 w70 h20 vstopKeyAC Disabled") ; gstopKeyAC
AutoclickerGui.AddDDL("x250 y30 w70 h20 vclickType R3 Choose1", ["Left","Middle","Right"])
AutoclickerGui.AddButton("x10 y60 w150 h20", "Start")
AutoclickerGui.AddButton("x170 y60 w150 h20", "Stop")
AutoclickerGui.AddButton("x10 y90 w310 h20", "Return to Cheat Clicker")
AutoclickerGui.AddText("x120 y120", "Made by Banaanae")

/*
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
*/

ButtonOpenAutoclicker:
previousHotkeyCC := ""
hotKeyCC := ""
CheatClickerGui.Destroy()
;MsgBox, 64, Important, If you want to click forever press 0 in Click Amount
AutoclickerGui.Show()
Return

ButtonStart:
/*
GuiControlGet, Delay
GuiControlGet, Amount
GuiControlGet, stopKeyAC
GuiControlGet, clickType
*/
activeAC := "true"
;autoClickerStart(Amount, clickType, delay, activeAC)
Return

stopKeyAC:
if previousHotkeyAC
{
    ;Hotkey, %previousHotkeyAC%, Off
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
AutoclickerGui.Destroy()
CheatClickerGui.Show()
Return

GuiClose:
if (activeCC = "true")
{
    ;Hotkey, LButton, Off
    activeCC := "false"
}
/*
MsgBox, 36, Exit App?, Do you want to close Cheat Clicker?
ifMsgBox, Yes
{
    ExitApp
}
*/
ExitApp ; Temp
Return
