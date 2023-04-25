; Doesn't work
/*
TODO
Fix GuiControlGet - No
Fix Buttons - WIP
Fix Order (functions > gui) - Np
Make it actually work -.- - Cheat clicker 90% done
Consistant naming - WIP
Fix hotkeys
*/

/*
Cheat Clicker

Naming stuff:
AC = AutoClicker CC = Cheat Clicker G = Global
AC/CC/G_(name) = Func (and labels if I add any)
(name)_AC/CC/G = Vars (no global vars atm)
*/
#SingleInstance Force


Clicks_CC := 1
hotKeyCC := ""
previousHotkeyCC := ""
Active_CC := "false"

stopKeyAC := ""
previousHotkeyAC := ""
activeAC := "false"

LButton::
{
    Loop Clicks_CC
    {
        Click
    }
}
;Hotkey("LButton", "On")
Hotkey("LButton", "Off")

CC_OpenAutoClicker(*) {
    previousHotkeyCC := ""
    hotKeyCC := ""
    CheatClickerGui.Destroy()
    ;MsgBox("If you want to click forever press 0 in Click Amount", "Important", 64) ; TODO Find better way
    AutoClickerGui.Show()
}

CheatClickerGui := Gui(, "Cheat Clicker")
CheatClickerGui.AddText("x10 y10 w90 h20", "Clicks per click")
CheatClickerGui.AddText("x110 y10 w90 h20", "Stop Hotkey")
CheatClickerGui.AddEdit("x10 y40 w90 h20 number vClicksCtrl", "2")
CheatClickerGui.AddHotkey("x110 y40 w90 h20 vhotKeyCC") ; ghotKeyCC
CheatClickerGui.AddButton("x10 y70 w190 h20", "Start Cheat Clicking").OnEvent("Click", CC_StartCheatClicking)
CheatClickerGui.AddButton("x10 y100 w190 h20", "Open AutoClicker").OnEvent("Click", CC_OpenAutoClicker)
CheatClickerGui.AddText("x58 y130", "Made by Banaanae")
CheatClickerGui.Show()



CC_StartCheatClicking(*) {
global
if (hotKeyCC = "") {
    noHotkey := MsgBox("You have not set a stop hotkey!`nWithout a stop hotkey it may be hard to stop cheat clicking`nSet one now?", "Alert", 52)
    if (noHotkey = "Yes") {
        Return
    }
}
Hotkey("LButton", "On")
Clicks_CC := ClicksCtrl.Text
if (Clicks_CC = 1)
{
    Hotkey("LButton", "Off")
}
Active_CC := "true"
}


/*
hotKeyCC() {
if previousHotkeyCC {
    Hotkey(%previousHotkeyCC%,, Off)
}
if !hotKeyCC {
    Return
}
Hotkey(%hotKeyCC%, ResetCheatClicker, On)
previousHotkeyCC := hotKeyCC
}
*/

ResetCheatClicker() {
if (Active_CC = "true")
{
    Hotkey("LButton", "Off")
    Active_CC := "false"
}
Else
{
    Hotkey("LButton", "On")
    Active_CC := "true"
}
}

; AutoClicker code start

AutoClickerGui := Gui(, "AutoClicker")
AutoClickerGui.AddText("x10 y10 w70 h20", "Delay (ms)")
AutoClickerGui.AddText("x90 y10 w70 h20", "Click Amount")
AutoClickerGui.AddText("x170 y10 w70 h20 Disabled", "Hotkey")
AutoClickerGui.AddText("x250 y10 w70 h20", "Click Type")
AutoClickerGui.AddEdit("x10 y30 w70 h20 number vDelay", "1")
AutoClickerGui.AddEdit("x90 y30 w70 h20 number vAmount", "0")
AutoClickerGui.AddHotkey("x170 y30 w70 h20 vstopKeyAC Disabled") ; gstopKeyAC
AutoClickerGui.AddDDL("x250 y30 w70 h20 vclickType R3 Choose1", ["Left","Middle","Right"])
AutoClickerGui.AddButton("x10 y60 w150 h20", "Start").OnEvent("Click", AC_Start)
AutoClickerGui.AddButton("x170 y60 w150 h20", "Stop").OnEvent("Click", AC_Stop)
AutoClickerGui.AddButton("x10 y90 w310 h20", "Return to Cheat Clicker").OnEvent("Click", AC_ReturntoCheatClicker)
AutoClickerGui.AddText("x120 y120", "Made by Banaanae")

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

AC_Start(*) {
/*
GuiControlGet, Delay
GuiControlGet, Amount
GuiControlGet, stopKeyAC
GuiControlGet, clickType
*/
activeAC := "true"
;autoClickerStart(Amount, clickType, delay, activeAC)
}

/*
stopKeyAC() {
if previousHotkeyAC {
    Hotkey(%previousHotkeyAC%,, Off)
}
if !stopKeyAC {
    Return
}
if (activeAC = "true") {
    activeAC := "false"
} Else {
    activeAC := "true"
    ;autoClickerStart(Amount, clickType, delay, activeAC)
}
previousHotkeyAC := stopKeyAC
}
*/

AC_Stop(*) {
activeAC := "false"
}

AC_ReturntoCheatClicker(*) {
AutoClickerGui.Destroy()
CheatClickerGui.Show()
}


CheatClickerGui.OnEvent("Close", G_GuiClose)
AutoClickerGui.OnEvent("Close", G_GuiClose)

G_GuiClose(*) {
if (Active_CC = "true") {
    Hotkey("LButton", "Off")
    ;Active_CC := "false"
}
closeGui := MsgBox("Do you want to close Cheat Clicker?", "Exit App?", 36)

if (closeGui = "Yes") {
    ExitApp
}
}
