MAIN
    CALL ui.Interface.loadStyles("splash")
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "splash" ATTRIBUTES(STYLE="splash")
    MENU ""
        ON ACTION continue
            EXIT MENU
    END MENU
END MAIN
          