; Doesn't work
/*
TODO
Fix Buttons - Everything but ac stop done
Fix Order (Setup > Gui > Func > Close) - No
Fix HotKeys
Consistant naming - WIP
*/

/*
Cheat Clicker

Naming stuff:
AC = AutoClicker CC = Cheat Clicker G = Global
AC/CC/G_(name) = Func Gui (and labels if I add any)
(name)_AC/CC/G = Vars (no global vars atm)
*/

#SingleInstance Force


Clicks_CC := 1
Hotkey_CC := ""
previousHotkeyCC := "" ; Prob won't need, same with ac
Active_CC := "False"

HotKey_AC := ""
previousHotkeyAC := ""
Active_AC := "False"

LButton::
{
    Loop Clicks_CC
    {
        Click
    } Until (Active_CC = "False")
}
;Hotkey("LButton", "On")
Hotkey("LButton", "Off")

CC_OpenAutoClicker(*) {
    previousHotkeyCC := ""
    Hotkey_CC := ""
    CC_Gui.Hide()
    ;MsgBox("If you want to click forever press 0 in Click Amount", "Important", 64) ; TODO Find better way
    AC_Gui.Show()
}

CC_Gui := Gui(, "Cheat Clicker")
CC_Gui.AddText("x10 y10 w90 h20", "Clicks per click")
CC_Gui.AddText("x110 y10 w90 h20", "Stop Hotkey")
ClicksCtrl_CC := CC_Gui.AddEdit("x10 y40 w90 h20 number", "2")
HotkeyCtrl_CC := CC_Gui.AddHotkey("x110 y40 w90 h20 vHotkey_CC Disabled") ; TODO Fix hotkey
CC_Gui.AddButton("x10 y70 w190 h20", "Start Cheat Clicking").OnEvent("Click", CC_StartCheatClicking)
CC_Gui.AddButton("x10 y100 w190 h20", "Open AutoClicker").OnEvent("Click", CC_OpenAutoClicker)
CC_Gui.AddText("x58 y130", "Made by Banaanae")
CC_Gui.Show()



CC_StartCheatClicking(*) {
global
Hotkey_CC := HotkeyCtrl_CC.value
if (Hotkey_CC = "") {
    noHotkey := MsgBox("You have not set a stop hotkey!`nWithout a stop hotkey it may be hard to stop cheat clicking`nSet one now?", "Alert", 52)
    if (noHotkey = "Yes") {
        Return
    }
}
Hotkey("LButton", "On")
Clicks_CC := ClicksCtrl_CC.Text ; .Text and .Value achieve same result .Text is better avoids `n if somehow added
if (Clicks_CC = 1)
{
    Hotkey("LButton", "Off")
}
;Hotkey(Hotkey_CC, CC_Toggle(), "On")
Active_CC := "True"
}


CC_Toggle() {
global
if (Active_CC = "True")
{
    Hotkey("LButton", "Off")
    Active_CC := "False"
}
Else
{
    Hotkey("LButton", "On")
    Active_CC := "True"
}
}

; AutoClicker code start

AC_Gui := Gui(, "AutoClicker")
AC_Gui.AddText("x10 y10 w70 h20", "Delay (ms)")
AC_Gui.AddText("x90 y10 w70 h20", "Click Amount")
AC_Gui.AddText("x170 y10 w70 h20 Disabled", "Hotkey")
AC_Gui.AddText("x250 y10 w70 h20", "Click Type")
DelayCtrl_AC := AC_Gui.AddEdit("x10 y30 w70 h20 number", "1")
AmountCtrl_AC := AC_Gui.AddEdit("x90 y30 w70 h20 number", "0")
HotKey_AC := AC_Gui.AddHotkey("x170 y30 w70 h20 Disabled")
ClickTypeCtrl_AC := AC_Gui.AddDDL("x250 y30 w70 h20 R3 Choose1", ["Left","Middle","Right"])
AC_Gui.AddButton("x10 y60 w150 h20", "Start").OnEvent("Click", AC_StartBtn)
AC_Gui.AddButton("x170 y60 w150 h20", "Stop").OnEvent("Click", AC_StopBtn)
AC_Gui.AddButton("x10 y90 w310 h20", "Return to Cheat Clicker").OnEvent("Click", AC_ReturntoCheatClicker)
AC_Gui.AddText("x120 y120", "Made by Banaanae")


AC_Start(Delay_AC, Amount_AC, ClickType_AC, Active_AC)
{
    Loop Amount_AC
    {
        if (ClickType_AC = "Left")
        {
            Click("Left")
        }
        Else if (ClickType_AC = "Right")
        {
            Click("Right")
        }
        Else
        {
            Click("Middle")
        }
        Sleep(Delay_AC)
    } until Active_AC = "False"
    Active_AC := "False"
}


AC_StartBtn(*) {
Delay_AC := DelayCtrl_AC.Text
Amount_AC := AmountCtrl_AC.Text
if (Amount_AC = 0) {
    Amount_AC := ""
}
;HotKey_AC := HotKeyCtrl_AC.Text
ClickType_AC := ClickTypeCtrl_AC.Text
Active_AC := "True"
AC_Start(Delay_AC, Amount_AC, ClickType_AC, Active_AC)
}

/*
HotKey_AC() {
if previousHotkeyAC {
    Hotkey(%previousHotkeyAC%,, Off)
}
if !HotKey_AC {
    Return
}
if (Active_AC = "True") {
    Active_AC := "False"
} Else {
    Active_AC := "True"
    ;autoClickerStart(Amount, clickType, delay, Active_AC)
}
previousHotkeyAC := HotKey_AC
}
*/

AC_StopBtn(*) {
Active_AC := "False"
}

AC_ReturntoCheatClicker(*) {
AC_Gui.Hide()
CC_Gui.Show()
}


CC_Gui.OnEvent("Close", G_GuiClose)
AC_Gui.OnEvent("Close", G_GuiClose)

G_GuiClose(*) {
if (Active_CC = "True") {
    Hotkey("LButton", "Off")
    ;Active_CC := "False"
}
closeGui := MsgBox("Do you want to close Cheat Clicker?", "Exit App?", 36)

if (closeGui = "Yes") {
    ExitApp
}
}
