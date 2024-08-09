/*
Cheat Clicker

Naming stuff:
AC = AutoClicker | CC = Cheat Clicker | G = Global
AC/CC/G_(name) = Functions and Gui
(name)_AC/CC/G = Vars (no global vars)

TODO List:
Allow hotkey activation after setting (instead of clicking start first)
Allow setting delay between clicks
Different click modes (CC)
*/

#SingleInstance Force

Active_CC := false
Active_AC := false

; #HotIf !WinActive("Cheat Clicker")
LButton:: {
    Loop ClicksCtrl_CC.Text {
        Click
    } Until (Active_CC = false)
}

Hotkey("LButton", "Off")

CC_Gui := Gui(, "Cheat Clicker")
CC_Gui.AddText("x10 y10 w90 h20", "Clicks per click")
CC_Gui.AddText("x110 y10 w90 h20", "Stop Hotkey")
ClicksCtrl_CC := CC_Gui.AddEdit("x10 y40 w90 h20 number", "2")
HotkeyCtrl_CC := CC_Gui.AddHotkey("x110 y40 w90 h20")
ToggleCCCtrl_CC := CC_Gui.AddButton("x10 y70 w190 h20", "Start Cheat Clicking")
ToggleCCCtrl_CC.OnEvent("Click", CC_StartCheatClicking)
CC_Gui.AddButton("x10 y100 w190 h20", "Open AutoClicker").OnEvent("Click", CC_OpenAutoClicker)
CC_Gui.AddText("x58 y130", "Made by Banaanae")
CC_Gui.Show()

CC_StartCheatClicking(*) {
    global
    if (Active_CC) { ; Turning off
        CC_Toggle()
        return
    }
    Active_CC := !Active_CC
    if (HotkeyCtrl_CC.Value = "") {
        noHotkey := MsgBox("You have not set a hotkey!`nWithout a hotkey it may be hard to stop cheat clicking`nSet one now?", "Alert", 52)
        if (noHotkey = "Yes") {
            Return
        }
    }
    Hotkey("LButton", "On")
    if (ClicksCtrl_CC.Text = 1)
        Hotkey("LButton", "Off")
    if (HotkeyCtrl_CC.Value)
        Hotkey(HotkeyCtrl_CC.Value, CC_Toggle)
    CC_ToggleText()
}

CC_Toggle(*) {
    global
    Active_CC := !Active_CC
    if (Active_CC) {
        Hotkey("LButton", "On")
    } Else {
        Hotkey("LButton", "Off")
    }
    CC_ToggleText()
}

CC_ToggleText() {
    global Active_CC
    if Active_CC
        ToggleCCCtrl_CC.Text := "Stop Cheat Clicking"
    else
        ToggleCCCtrl_CC.Text := "Start Cheat Clicking"
}

CC_OpenAutoClicker(*) {
    global
    CC_Gui.Hide()
    ;MsgBox("If you want to click forever press 0 in Click Amount", "Important", 64) ; TODO Find better way
    AC_Gui.Show()
    Active_CC := false
    if (HotkeyCtrl_CC.Value != "") { ; Activate hotkey for AC
        Hotkey(HotkeyCtrl_CC.Value, CC_Toggle, "Off")
        Hotkey(HotkeyCtrl_CC.Value, AC_HotKey, "On")
    }
    HotKeyCtrl_AC.Value := HotkeyCtrl_CC.Value
    StopCtrl_AC.Enabled := false
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
StartCtrl_AC := AC_Gui.AddButton("x10 y60 w150 h20", "Start")
StartCtrl_AC.OnEvent("Click", AC_StartBtn)
StopCtrl_AC := AC_Gui.AddButton("x170 y60 w150 h20", "Stop")
StopCtrl_AC.OnEvent("Click", AC_StopBtn)
AC_Gui.AddButton("x10 y90 w310 h20", "Return to Cheat Clicker").OnEvent("Click", AC_ReturntoCheatClicker)
AC_Gui.AddText("x120 y120", "Made by Banaanae")

AC_Start(Delay_AC, Amount_AC, ClickType_AC) {
    global
    Amount_AC := Amount_AC = 0 ? -1 : Amount_AC
    While (Amount_AC != 0 && Active_AC) {
        Click(ClickType_AC)
        Sleep(Delay_AC)
        Amount_AC--
    }
    Active_AC := false
}

AC_StartBtn(*) {
    global
    if (HotKeyCtrl_AC.Value != "")
        Hotkey(HotKeyCtrl_AC.Value, AC_HotKey, "On")
    Active_AC := true
    StartCtrl_AC.Enabled := false
    StopCtrl_AC.Enabled := true
    AC_Start(DelayCtrl_AC.Text, AmountCtrl_AC.Text, ClickTypeCtrl_AC.Text)
}

AC_HotKey(*) {
    global
    Active_AC := !Active_AC
    if (Active_AC) {
        AC_Start(DelayCtrl_AC.Text, AmountCtrl_AC.Text, ClickTypeCtrl_AC.Text)
    }
    StartCtrl_AC.Enabled := !StartCtrl_AC.Enabled
    StopCtrl_AC.Enabled := !StopCtrl_AC.Enabled
}

AC_StopBtn(*) {
    global
    StartCtrl_AC.Enabled := true
    StopCtrl_AC.Enabled := false
    Active_AC := false
}

AC_ReturntoCheatClicker(*) {
    global
    Active_AC := false
    AC_Gui.Hide()
    CC_Gui.Show()
}

CC_Gui.OnEvent("Close", G_GuiClose)
AC_Gui.OnEvent("Close", G_GuiClose)

G_GuiClose(*) {
    ExitApp
}
