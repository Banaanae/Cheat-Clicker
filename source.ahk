; Doesn't work
/*
TODO
Fix Buttons - Done i think
Fix Order (Setup > Gui > Func > Close) - No
Fix HotKeys - WIP (cc done)
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
Gui_G := "CC"

Clicks_CC := 1
Hotkey_CC := ""
HotkeyVar_CC := ""
Active_CC := "False"

HotKey_AC := ""
Active_AC := "False"

LButton::
{
    Loop Clicks_CC
    {
        Click
    } Until (Active_CC = "False")
}

Hotkey("LButton", "Off")

CC_OpenAutoClicker(*) {
    global
    CC_Gui.Hide()
    ;MsgBox("If you want to click forever press 0 in Click Amount", "Important", 64) ; TODO Find better way
    Gui_G := "AC"
    AC_Gui.Show()
    HotKeyCtrl_AC.Value := HotkeyVar_CC
}

CC_Gui := Gui(, "Cheat Clicker")
CC_Gui.AddText("x10 y10 w90 h20", "Clicks per click")
CC_Gui.AddText("x110 y10 w90 h20", "Stop Hotkey")
ClicksCtrl_CC := CC_Gui.AddEdit("x10 y40 w90 h20 number", "2")
HotkeyCtrl_CC := CC_Gui.AddHotkey("x110 y40 w90 h20") ; TODO Fix hotkey ; HotkeyCtrl_CC := 
CC_Gui.AddButton("x10 y70 w190 h20", "Start Cheat Clicking").OnEvent("Click", CC_StartCheatClicking)
CC_Gui.AddButton("x10 y100 w190 h20", "Open AutoClicker").OnEvent("Click", CC_OpenAutoClicker)
CC_Gui.AddText("x58 y130", "Made by Banaanae")
CC_Gui.Show()



CC_StartCheatClicking(*) {
global
HotkeyVar_CC := HotkeyCtrl_CC.value
if (HotkeyVar_CC = "") {
    noHotkey := MsgBox("You have not set a hotkey!`nWithout a hotkey it may be hard to stop cheat clicking`nSet one now?", "Alert", 52)
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
Hotkey(HotkeyVar_CC, CC_Toggle)
Active_CC := "True"
}


CC_Toggle(*) {
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
AC_Gui.AddText("x170 y10 w70 h20", "Hotkey")
AC_Gui.AddText("x250 y10 w70 h20", "Click Type")
DelayCtrl_AC := AC_Gui.AddEdit("x10 y30 w70 h20 number", "1")
AmountCtrl_AC := AC_Gui.AddEdit("x90 y30 w70 h20 number", "0")
HotKeyCtrl_AC := AC_Gui.AddHotkey("x170 y30 w70 h20")
ClickTypeCtrl_AC := AC_Gui.AddDDL("x250 y30 w70 h20 R3 Choose1", ["Left","Middle","Right"])
AC_Gui.AddButton("x10 y60 w150 h20", "Start").OnEvent("Click", AC_StartBtn)
AC_Gui.AddButton("x170 y60 w150 h20", "Stop").OnEvent("Click", AC_StopBtn)
AC_Gui.AddButton("x10 y90 w310 h20", "Return to Cheat Clicker").OnEvent("Click", AC_ReturntoCheatClicker)
AC_Gui.AddText("x120 y120", "Made by Banaanae")


AC_Start(Delay_AC, Amount_AC, ClickType_AC)
{
    global
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
    } Until Active_AC = "False"
    Active_AC := "False"
}


AC_StartBtn(*) {
global
Delay_AC := DelayCtrl_AC.Text
Amount_AC := AmountCtrl_AC.Text
if (Amount_AC = 0) {
    Amount_AC := ""
}
HotKey_AC := HotKeyCtrl_AC.Value
Hotkey(HotKey_AC, AC_HotKey, "On")
ClickType_AC := ClickTypeCtrl_AC.Text
Active_AC := "True"
AC_Start(Delay_AC, Amount_AC, ClickType_AC)
}

AC_HotKey(*) {
global
if (Active_AC = "True") {
    Active_AC := "False"
} Else {
    Active_AC := "True"
    AC_Start(Delay_AC, Amount_AC, ClickType_AC)
}
}

AC_StopBtn(*) {
global
Active_AC := "False"
}

AC_ReturntoCheatClicker(*) {
global
Active_AC := "False"
AC_Gui.Hide()
Gui_G := "CC"
CC_Gui.Show()
}

CC_Gui.OnEvent("Close", G_GuiClose)
AC_Gui.OnEvent("Close", G_GuiClose)

G_GuiClose(*) {
; global
; if (Active_CC = "True") {
;     Hotkey("LButton", "Off")
;     Active_CC := "False"
; }
; closeGui := MsgBox("Do you want to close Cheat Clicker?", "Exit App?", 36)
; if (closeGui = "Yes") {
;     ExitApp 
; } Else {
;     if (Gui_G = "CC") { ; Probably can be fixed with gui in function
;         CC_Gui.Show()
;     } Else {
;         AC_Gui.Show()
;     }
; }
ExitApp
}
