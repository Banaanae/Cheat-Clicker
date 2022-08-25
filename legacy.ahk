clickAmount = 1

MsgBox, 64, Welcome!, Welcome to Cheat Clicker`nCheat Clicker is pretty easy to use`nJust set the amount of times you want to click each time you click and press Enter`n`nHere are some useful hotkeys:`nF5 - Allows you to edit the click amount`nCtrl + F5 - Force exit Cheat Clicker`nNote: In some cases you might need to also use the fn key

clickInput()
{
    global clickAmount
    InputBox, clickAmount, Welcome!, Welcome to Cheat Clicker!`nHow many clicks do you want to do per click?`nCan only contain 0-9, SHOW, Default, Default, Center, Center, Locale,, 2

    if clickAmount is not digit
    {
        Loop
        {
            clickAmount := 1
            InputBox, clickAmount, Welcome!, Welcome to Cheat Clicker!`nHow many clicks do you want to do per click?`nCan only contain keys 0-9, SHOW, Default, Default, Center, Center, Locale,, 2
            if clickAmount is digit 
                Break
        }
    }
}

clickInput()

LButton::
loop, %clickAmount%
{
    Click
}
Return

F5::
clickAmount = 1
clickInput()
Return

^F5::
ExitApp
Return