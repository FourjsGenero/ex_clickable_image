MAIN
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "fullscreen_menu" ATTRIBUTES(TEXT="Select Transport")
    MENU ""
        ON ACTION fly   CALL FGL_WINMESSAGE("Info","Fly","")
        ON ACTION ship  CALL FGL_WINMESSAGE("Info","Ship","")
        ON ACTION car   CALL FGL_WINMESSAGE("Info","Car","")
        ON ACTION train CALL FGL_WINMESSAGE("Info","Train","")
        ON ACTION cancel
            EXIT MENU
    END MENU
END MAIN