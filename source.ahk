clicks = 1

InputBox, clicks, Welcome!, Welcome to cheat clicker!`nHow many clicks do you want to do per click?`nCan only contain 0-9`nPress Enter once finished, SHOW, Default, Default, Center, Center, Locale, 2147483, 2

if clicks is not digit 
    Loop {
        InputBox, clicks, Welcome!, Welcome to cheat clicker!`nHow many clicks do you want to do per click?`nCan only contain 0-9`nPress Enter`n`nOnly 1 2 3 4 5 6 7 8 9 works, SHOW, Default, Default, Center, Center, Locale, 2147483, 2
        if second is digit 
            Break
    }

LButton::
loop %clicks% {
    Click
}
Return
F5::
clicks = 1

InputBox, clicks, Welcome!, Welcome to cheat clicker!`nHow many clicks do you want to do per click?`nCan only contain 0-9`nPress Enter once finished, SHOW, Default, Default, Center, Center, Locale, 2147483, 2

if clicks is not digit 
    Loop {
        InputBox, clicks, Welcome!, Welcome to cheat clicker!`nHow many clicks do you want to do per click?`nCan only contain 0-9`nPress Enter`n`nOnly 1 2 3 4 5 6 7 8 9 works, SHOW, Default, Default, Center, Center, Locale, 2147483, 2
        if second is digit 
            Break
    }
