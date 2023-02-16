#SingleInstance, Force
Hotkey, LButton, Off

MsgBox, 64, Welcome!, Welcome to Cheat Clicker Legacy`nIt`'s pretty easy to use`nJust set the amount of times you want to click each time you click and press Enter`n`nHere are some useful hotkeys:`nF5 - Allows you to edit the click amount`nCtrl + F5 - Exit Cheat Clicker

clickInput()
{
    global
    InputBox, clickAmount, Welcome!, Welcome to Cheat Clicker Legacy!`nHow many clicks do you want to do per click?`nCan only contain 0-9, SHOW, Default, Default, Center, Center, Locale,, 2
    if ErrorLevel
        clickInput()

    if clickAmount is not digit
    {
        Loop
        {
            Hotkey, LButton, Off
            InputBox, clickAmount, Welcome!, Welcome to Cheat Clicker!`nHow many clicks do you want to do per click?`nYou must ONLY type characters 0 to 9, SHOW, Default, Default, Center, Center, Locale,, 2
            if ErrorLevel
                clickInput()
            if clickAmount is digit 
                Break
        }
    }
    Hotkey, LButton, On
}

clickInput()

LButton::
loop, %clickAmount%
{
    Click
}
Return

F5::
Hotkey, LButton, Off
clickInput()
Return

^F5::
ExitApp
Return
