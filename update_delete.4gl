MAIN
DEFINE arr DYNAMIC ARRAY OF RECORD
    code INTEGER,
    desc CHAR(40),
    insert STRING,
    update STRING,
    delete STRING
END RECORD
DEFINE i INTEGER

DEFINE w ui.Window
DEFINE f ui.Form

    OPEN WINDOW w WITH FORM "update_delete"
    LET w = ui.Window.getCurrent()
    LET f = w.getForm()

    FOR i = 1 TO 3
        LET arr[i].code = i
        LET arr[i].insert = "fa-plus"
        LET arr[i].update = "fa-pencil"
        LET arr[i].delete = "delete"
    END FOR
    LET arr[1].desc = "One"
    LET arr[2].desc = "Two"
    LET arr[3].desc = "Three"

    DISPLAY ARRAY arr TO scr.* ATTRIBUTES(UNBUFFERED)            
        ON APPEND
            INPUT arr[arr_curr()].* FROM scr[scr_line()].*;
            IF NOT int_flag THEN
                LET arr[arr_curr()].insert = "fa-plus"
                LET arr[arr_curr()].update = "fa-pencil"
                LET arr[arr_curr()].delete = "delete"
            END IF
        
        ON INSERT
            INPUT arr[arr_curr()].* FROM scr[scr_line()].*;
            IF NOT int_flag THEN
                LET arr[arr_curr()].insert = "fa-plus"
                LET arr[arr_curr()].update = "fa-pencil"
                LET arr[arr_curr()].delete = "delete"
            END IF
        
        ON UPDATE
            INPUT arr[arr_curr()].* FROM scr[scr_line()].* ATTRIBUTES(WITHOUT DEFAULTS=TRUE);
           
        ON DELETE
            # delete
            IF FGL_WINQUESTION("Confirmation","Are you sure you want to delete?","no","no|yes","fa-quest",0) = "no" THEN
                LET int_flag = 1
            END IF
    END DISPLAY
END MAIN

