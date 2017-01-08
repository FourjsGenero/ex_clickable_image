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
        BEFORE DISPLAY
            -- If using HTML5 web client hide clickable images as not implemented in HTML5,
            IF ui.Interface.getFrontEndName() = "GWC" THEN 
                CALL show_clickable_images(FALSE)
            END IF
            
        ON APPEND
            CALL show_clickable_images(FALSE)
            INPUT arr[arr_curr()].* FROM scr[scr_line()].*;
            IF NOT int_flag THEN
                LET arr[arr_curr()].insert = "fa-plus"
                LET arr[arr_curr()].update = "fa-pencil"
                LET arr[arr_curr()].delete = "delete"
            END IF
            CALL show_clickable_images(TRUE)
        
        ON INSERT
            CALL show_clickable_images(FALSE)
            INPUT arr[arr_curr()].* FROM scr[scr_line()].*;
            IF NOT int_flag THEN
                LET arr[arr_curr()].insert = "fa-plus"
                LET arr[arr_curr()].update = "fa-pencil"
                LET arr[arr_curr()].delete = "delete"
            END IF
            CALL show_clickable_images(TRUE)
        
        ON UPDATE
            CALL show_clickable_images(FALSE)
            INPUT arr[arr_curr()].* FROM scr[scr_line()].* ATTRIBUTES(WITHOUT DEFAULTS=TRUE);
            CALL show_clickable_images(TRUE)
           
                

        ON DELETE
            # delete
            IF FGL_WINQUESTION("Confirmation","Are you sure you want to delete?","no","no|yes","fa-quest",0) = "no" THEN
                LET int_flag = 1
            END IF
    END DISPLAY
END MAIN

FUNCTION show_clickable_images(l_show)
DEFINE l_show BOOLEAN

DEFINE w ui.Window
DEFINE f ui.Form

    IF ui.Interface.getFrontEndName() = "GDC" THEN 
        -- no reason to hide with GDC as it gives different background color
        RETURN
    END IF

    LET w = ui.Window.getCurrent()
    LET f = w.getForm()

    IF ui.Interface.getFrontEndName() = "GWC" THEN 
        -- clickable images don't work with HTML5 so hide and rely on DEFAULTVIEW to put actions in actionapanel
        LET l_show = FALSE
    END IF
    CALL f.setElementHidden("formonly.insert",NOT l_show)
    CALL f.setElementHidden("formonly.update",NOT l_show)
    CALL f.setElementHidden("formonly.delete",NOT l_show)
END FUNCTION


