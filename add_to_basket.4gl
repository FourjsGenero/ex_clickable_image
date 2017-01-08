IMPORT util

CONSTANT BASKET="fa-shopping-cart"
CONSTANT REMOVE_FROM_BASKET="fa-shopping-cart-grey"

MAIN
DEFINE arr DYNAMIC ARRAY OF RECORD
    code INTEGER,
    desc CHAR(40),
    qty INTEGER,
    basket STRING
END RECORD
DEFINE i INTEGER
#/Volumes/Daily/github/fourjs-reuben/asia_seminar_2016/trunk/my_image2font.txt:/Applications/fourjs/fgl/3.00.06/lib/image2font.txt:/Applications/fourjs/fgl/3.00.06/lib
#/Volumes/Daily/github/fourjs-reuben/asia_seminar_2016/trunk/my_image2font.txt;/Applications/fourjs/fgl/3.00.06/lib/image2font.txt;/Applications/fourjs/fgl/3.00.06/lib
    DISPLAY FGL_GETENV("FGLIMAGEPATH")
    FOR i = 1 TO 100
        LET arr[i].code = i
        LET arr[i].desc = "Description"
        IF util.Math.rand(4) = 0 THEN
            LET arr[i].qty = util.Math.rand(100) +1
            LET arr[i].basket = BASKET
        ELSE
            LET arr[i].qty = 0 
            LET arr[i].basket = REMOVE_FROM_BASKET
        END IF
    END FOR
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "add_to_basket"
    DISPLAY ARRAY arr TO scr.* ATTRIBUTES(UNBUFFERED)
        ON ACTION basket
            IF arr[arr_curr()].basket = BASKET THEN
                LET arr[arr_curr()].qty = 0
                LET arr[arr_curr()].basket = REMOVE_FROM_BASKET
            ELSE
                PROMPT "Enter qty" FOR arr[arr_curr()].qty
                IF int_flag THEN
                    LET arr[arr_curr()].qty = 0
                    LET int_flag = 0
                ELSE
                    LET arr[arr_curr()].basket = BASKET
                END IF
            END IF
    END DISPLAY
END MAIN