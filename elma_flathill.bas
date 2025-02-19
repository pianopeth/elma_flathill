
max_x = 800: max_y = 600
res_x = max_x + 200: res_y = max_y + 200
shift_x = (res_x - max_x) / 2
shift_y = (res_y - max_y) / 2
raise = 25: detail = 50: varvar = 10: startplace = 50 'level parameters
x = startplace: y = max_y
background_color = 104: sky_color = 54: line_color = 7 'paint colors
filename$ = "out"
count = 1
levtype = 2 '1=hill, 2=flat track


DO
    50

    klipbord$ = ""
    res_x = max_x + 200: res_y = max_y + 200
    IF levtype = 1 THEN SCREEN _NEWIMAGE(res_x, (res_y / levtype), 256)
    IF levtype = 2 THEN SCREEN _NEWIMAGE(res_x, (res_y / levtype) + shift_y, 256)

    PAINT (0, 0), background_color 'paint background
    COLOR 10, background_color
    PRINT ""
    PRINT "Flat track & hill polygon generator v1.4 (2023-09-01) by iCS [.lev] 2019-2022"

    COLOR 15, background_color: PRINT "[arrows]",: COLOR 7, background_color: PRINT "level size =", max_x; "x"; (max_y / levtype)
    IF levtype = 1 THEN: COLOR 15, background_color: PRINT "(Shift+)[Q/A]",: COLOR 7, background_color: PRINT "raise      =", raise
    IF levtype = 2 THEN: COLOR 15, background_color: PRINT "(Shift+)[Q/A]",: COLOR 7, background_color: PRINT "roughness  =", raise
    COLOR 15, background_color: PRINT "(Shift+)[W/S]",: COLOR 7, background_color: PRINT "detail     =", detail

    IF levtype = 1 THEN: COLOR 15, background_color: PRINT "(Shift+)[E/D]",: COLOR 7, background_color: PRINT "variation  =", varvar
    IF levtype = 2 THEN: COLOR 15, background_color: PRINT "(Shift+)[E/D]",: COLOR 7, background_color: PRINT "smoothing  =", varvar

    ' left menu
    LOCATE 8, 1
    COLOR 15, background_color: PRINT "[TAB]       "
    IF levtype = 1 THEN: COLOR 7, background_color: PRINT "FLAT | ";: COLOR 10, background_color: PRINT "HILL "
    IF levtype = 2 THEN: COLOR 10, background_color: PRINT "FLAT ";: COLOR 7, background_color: PRINT "| HILL "

    PRINT ""
    COLOR 15, background_color
    PRINT "[SPACE]"
    COLOR 7, background_color
    PRINT "NEW PLEASE! "

    PRINT ""
    COLOR 15, background_color
    PRINT "[F]"
    COLOR 7, background_color
    PRINT "FULL RANDOM!"

    PRINT ""
    COLOR 15, background_color
    PRINT "[R]"
    COLOR 7, background_color
    PRINT "SEMI-RANDOM!"

    PRINT ""
    COLOR 15, background_color
    PRINT "[1]"
    COLOR 7, background_color
    PRINT "MAKE 100 LEV"



    ' PRINT ""
    ' COLOR 15, background_color
    ' PRINT "[X]"
    ' COLOR 7, background_color
    ' PRINT "SLOW DRAW   "


    PRINT ""
    COLOR 15, background_color
    PRINT "[ENTER]"
    COLOR 7, background_color
    PRINT "SAVE TO SVG!"


    currentraise = raise * RND
    LINE (shift_x, shift_y)-(shift_x, (max_y / levtype) - currentraise + shift_y), line_color 'draw left wall
    klipbord$ = klipbord$ + "0,0" + (CHR$(13) + CHR$(10))
    klipbord$ = klipbord$ + "0," + LTRIM$(STR$((max_y / levtype) - currentraise)) + (CHR$(13) + CHR$(10)) 'no + shift_y in SVG!

    LINE -(shift_x + startplace, (max_y / levtype) - currentraise + shift_y), line_color 'safe space for the bike
    klipbord$ = klipbord$ + LTRIM$(STR$(startplace)) + "," + LTRIM$(STR$((max_y / levtype) - currentraise)) + (CHR$(13) + CHR$(10)) 'startplace

    '    klipbord$ = klipbord$ + LTRIM$(STR$(x)) + "," + LTRIM$(STR$(y / levtype)) + (CHR$(13) + CHR$(10))

    DO
        RANDOMIZE TIMER
        variation = (-1 * varvar) + (2 * varvar * RND)

        RANDOMIZE TIMER
        IF levtype = 1 THEN x = x + 0.1 + (RND * (max_x / (detail))) 'go to next point

        IF levtype = 2 THEN x = x + (RND * (max_x / detail)) + (RND * (varvar))
        IF x >= max_x THEN x = max_x: EXIT DO

        '        if slowdraw=1 then _LIMIT 30 else
        RANDOMIZE TIMER
        REM        variation = INT((RND * varvar - 1)) - INT(varvar / 2)
        variation = (-1 * varvar) + (2 * varvar * RND)
        REM        IF levtype = 1 THEN y = y - ((raise * RND) / (2 + (10 * RND))) + (variation * RND)
        IF levtype = 1 THEN y = y - 0.1 - (raise / 20) - (variation / 10)


        IF levtype = 2 THEN y = (max_y / levtype) - (RND * raise)


        IF y <= 20 THEN y = 20: EXIT DO
        LINE -(x + shift_x, y + shift_y), line_color 'continue line
        klipbord$ = klipbord$ + LTRIM$(STR$(x)) + "," + LTRIM$(STR$(y)) + (CHR$(13) + CHR$(10))

        REM DEBUG
        REM LOCATE 1, 1: PRINT "x: ", x, "y: ", y, "varvar: ", varvar, "variation: ", variation
        REM DEBUG
        ' if slowdraw=1 then _LIMIT 30 else


    LOOP



    'closing lines  - hill
    IF levtype = 1 THEN
        LINE -(x + shift_x, y + shift_y), line_color
        klipbord$ = klipbord$ + LTRIM$(STR$(x)) + "," + LTRIM$(STR$(y)) + (CHR$(13) + CHR$(10))
        LINE -(x + shift_x, shift_y), line_color
        klipbord$ = klipbord$ + LTRIM$(STR$(x)) + ",0" + (CHR$(13) + CHR$(10))

    END IF

    'closing lines  - flat
    IF levtype = 2 THEN
        LINE -(max_x + shift_x, y + shift_y), line_color
        klipbord$ = klipbord$ + LTRIM$(STR$(max_x)) + "," + LTRIM$(STR$(y)) + (CHR$(13) + CHR$(10))
        LINE -(max_x + shift_x, shift_y), line_color
        klipbord$ = klipbord$ + LTRIM$(STR$(max_x)) + ",0" + (CHR$(13) + CHR$(10))
    END IF

    LINE -(shift_x, shift_y), line_color
    klipbord$ = klipbord$ + "0,0" + (CHR$(13) + CHR$(10))
    PAINT (shift_x + 1, shift_y + 1), sky_color, line_color

    'draw elmabike
    CIRCLE (shift_x + 12, (max_y / levtype) - currentraise + shift_y - 19), 2, 15
    CIRCLE (shift_x + 4, (max_y / levtype) - currentraise + shift_y - 4), 4, 15
    CIRCLE (shift_x + 21, (max_y / levtype) - currentraise + shift_y - 4), 4, 15
    PAINT (shift_x + 12, (max_y / levtype) - currentraise + shift_y - 19), 10, 15
    PAINT (shift_x + 4, (max_y / levtype) - currentraise + shift_y - 4), 10, 15
    PAINT (shift_x + 21, (max_y / levtype) - currentraise + shift_y - 4), 10, 15

    'bottom menu
    _FONT 8
    COLOR 10, 1
    _PRINTSTRING (20, (max_y / levtype) + 140), "KLASSIK FLAT TRACK PRESETS"

    LINE (10, (max_y / levtype) + 195)-(140, (max_y / levtype) + 155), line_color, B
    PAINT (11, max_y / levtype + 194), 1, line_color
    COLOR 7, 1
    _PRINTSTRING (20, (max_y / levtype) + 160), "juka level    "
    COLOR 15, 0
    _PRINTSTRING (20, (max_y / levtype) + 170), "F1  F2  F3  F4"
    COLOR line_color, 1
    _PRINTSTRING (20, (max_y / levtype) + 180), "short --> long"

    nextblock = 150
    LINE (10 + nextblock, (max_y / levtype) + 195)-(140 + nextblock, (max_y / levtype) + 155), line_color, B
    PAINT (11 + nextblock, max_y / levtype + 194), 1, line_color
    COLOR 7, 1
    _PRINTSTRING (20 + nextblock, (max_y / levtype) + 160), "chris level   "
    COLOR 15, 0
    _PRINTSTRING (20 + nextblock, (max_y / levtype) + 170), "F5  F6  F7  F8"
    COLOR line_color, 1
    _PRINTSTRING (20 + nextblock, (max_y / levtype) + 180), "short --> long"

    nextblock = 300
    LINE (10 + nextblock, (max_y / levtype) + 195)-(140 + nextblock, (max_y / levtype) + 155), line_color, B
    PAINT (11 + nextblock, max_y / levtype + 194), 1, line_color
    COLOR 7, 1
    _PRINTSTRING (20 + nextblock, (max_y / levtype) + 160), "nekit level   "
    COLOR 15, 0
    _PRINTSTRING (20 + nextblock, (max_y / levtype) + 170), "F9 F10 F11 F12"
    COLOR line_color, 1
    _PRINTSTRING (20 + nextblock, (max_y / levtype) + 180), "short --> long"


    IF autoszaz = 1 GOTO 150


    100 'lol
    DO: K$ = INKEY$
    LOOP UNTIL K$ <> ""

    SELECT CASE K$


        CASE "1" 'save 100 levels
            autoszaz = 1
            szazszor = 1
            150


            RANDOMIZE TIMER
            'levtype = INT(RND * 2): IF levtype = 0 THEN levtype = 2
            max_x = 350 + INT(RND * 649)
            max_y = (600 / levtype) + INT(RND * (150 * levtype)) * 2
            RANDOMIZE TIMER
            detail = (INT(RND * 99)) + 1
            RANDOMIZE TIMER
            raise = INT(RND * 29) + 1
            RANDOMIZE TIMER
            varvar = INT(RND * 29) + 1
            x = startplace: y = max_y

            'save lev
            outlev$ = filename$ + RIGHT$("00000" + LTRIM$(STR$(count)), 5) + ".svg"

            WHILE _FILEEXISTS(outlev$)
                count = count + 1
                outlev$ = filename$ + RIGHT$("00000" + LTRIM$(STR$(count)), 5) + ".svg"
            WEND


            IF klipbord$ <> "" THEN
                OPEN outlev$ FOR OUTPUT AS #1

                ' base svg data
                PRINT #1, "<?xml version=" + CHR$(34) + "1.0" + CHR$(34) + " encoding=" + CHR$(34) + "UTF-8" + CHR$(34) + " standalone=" + CHR$(34) + "no" + CHR$(34) + "?>"
                PRINT #1, "<svg xmlns:svg=" + CHR$(34) + "http://www.w3.org/2000/svg" + CHR$(34) + ">"
                PRINT #1, "<path style=" + CHR$(34) + "fill:#000000;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" + CHR$(34) + " d=" + CHR$(34) + "M"
                'generated data
                PRINT #1, klipbord$
                'end svg data
                PRINT #1, "Z" + CHR$(34) + " id=" + CHR$(34) + "1" + CHR$(34) + " />"
                REM                PRINT #1, "<text xml:space=" + CHR$(34) + "preserve" + CHR$(34) + " style=" + CHR$(34) + "font-style:normal;font-weight:normal;font-size:8px;font-family:Arial;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none" + CHR$(34) + " x=" + CHR$(34) + "0" + CHR$(34) + " y=" + CHR$(34) + "-5" + CHR$(34) + " id=" + CHR$(34) + "text1" + CHR$(34) + ">"
                REM                IF levtype = 1 THEN PRINT #1, "GENERATED ON " + DATE$ + ", " + TIME$ + " LEVEL SIZE:" + STR$(max_x) + "x" + LTRIM$(STR$(max_y)) + " RAISE:" + STR$(raise) + " DETAIL:" + STR$(detail) + " VARIATION:" + STR$(varvar)
                REM                IF levtype = 2 THEN PRINT #1, "GENERATED ON " + DATE$ + ", " + TIME$ + " LEVEL SIZE:" + STR$(max_x) + "x" + LTRIM$(STR$(max_y)) + " ROUGHNESS:" + STR$(raise) + " DETAIL:" + STR$(detail) + " SMOOTHING:" + STR$(varvar)
                PRINT #1, "</svg>"

                CLOSE #1

                klipbord$ = ""
                '                   COLOR 10, background_color
                '                    PRINT outlev$ + " saved! To make .LEV file, import the SVG output into SLE (Smibu's Level Editor)!"
                count = count + 1
            END IF

            'IF autoszaz = 1 THEN _DELAY 0.15
            szazszor = szazszor + 1
            IF szazszor = 100 GOTO 100 ELSE GOTO 50


            'WASD - coarse adjust
        CASE "q"
            x = startplace: y = max_y
            raise = raise + 5
            IF raise > 100 THEN raise = 100
        CASE "a"
            x = startplace: y = max_y
            raise = raise - 5
            IF raise < 1 THEN raise = 1
        CASE "w"
            x = startplace: y = max_y
            detail = detail + 5
            IF detail > 300 THEN detail = 300
        CASE "s"
            x = startplace: y = max_y
            detail = ABS(detail - 5)
            IF detail < 5 THEN detail = 5
        CASE "e"
            x = startplace: y = max_y
            varvar = varvar + 5
            IF varvar > 100 THEN varvar = 100
        CASE "d"
            x = startplace: y = max_y
            varvar = varvar - 5
            IF varvar < 1 THEN varvar = 1

            'shift - fine adjust
        CASE "Q"
            x = startplace: y = max_y
            raise = raise + 1
            IF raise > 100 THEN raise = 100
        CASE "A"
            x = startplace: y = max_y
            raise = raise - 1
            IF raise < 1 THEN raise = 1
        CASE "W"
            x = startplace: y = max_y
            detail = detail + 1
            IF detail > 300 THEN detail = 300
        CASE "S"
            x = startplace: y = max_y
            detail = ABS(detail - 1)
            IF detail < 5 THEN detail = 5
        CASE "E"
            x = startplace: y = max_y
            varvar = varvar + 1
            IF varvar > 100 THEN varvar = 100
        CASE "D"
            x = startplace: y = max_y
            varvar = varvar - 1
            IF varvar < 1 THEN varvar = 1


        CASE CHR$(0) + CHR$(72) 'up
            max_y = max_y + 50
            IF max_y >= 1000 THEN max_y = 1000
            x = startplace: y = max_y
        CASE CHR$(0) + CHR$(80) 'down
            max_y = max_y - 50
            IF max_y <= 300 THEN max_y = 300
            x = startplace: y = max_y
        CASE CHR$(0) + CHR$(75) 'left
            max_x = max_x - 50
            IF max_x <= 350 THEN max_x = 350
            x = startplace: y = max_y
        CASE CHR$(0) + CHR$(77) 'right
            max_x = max_x + 50
            IF max_x >= 1800 THEN max_x = 1800
            x = startplace: y = max_y

            'juka
        CASE CHR$(0) + CHR$(59) 'F1
            levtype = 2
            x = startplace: y = max_y
            max_x = 350
            max_y = 600
            detail = INT(max_x / 65)
            raise = INT(max_y / 35)
            varvar = INT(max_x / 50)

        CASE CHR$(0) + CHR$(60) 'F2
            levtype = 2
            x = startplace: y = max_y
            max_x = 660
            max_y = 600
            detail = INT(max_x / 65)
            raise = INT(max_y / 35)
            varvar = INT(max_x / 50)

        CASE CHR$(0) + CHR$(61) 'F3
            levtype = 2
            x = startplace: y = max_y
            max_x = 1000
            max_y = 600
            detail = INT(max_x / 60)
            raise = INT(max_y / 35)
            varvar = INT(max_x / 50)

        CASE CHR$(0) + CHR$(62) 'F4
            levtype = 2
            x = startplace: y = max_y
            max_x = 1800
            max_y = 600
            detail = INT(max_x / 60)
            raise = INT(max_y / 35)
            varvar = INT(max_x / 50)

            'chris
        CASE CHR$(0) + CHR$(63) 'F5
            levtype = 2
            x = startplace: y = max_y
            max_x = 350
            max_y = 600
            detail = INT(max_x / 25)
            raise = INT(max_y / 33)
            varvar = INT(max_x / 100)

        CASE CHR$(0) + CHR$(64) 'F6
            levtype = 2
            x = startplace: y = max_y
            max_x = 660
            max_y = 600
            detail = INT(max_x / 25)
            raise = INT(max_y / 33)
            varvar = INT(max_x / 100)

        CASE CHR$(0) + CHR$(65) 'F7
            levtype = 2
            x = startplace: y = max_y
            max_x = 1000
            max_y = 600
            detail = INT(max_x / 25)
            raise = INT(max_y / 33)
            varvar = INT(max_x / 100)

        CASE CHR$(0) + CHR$(66) 'F8
            levtype = 2
            x = startplace: y = max_y
            max_x = 1800
            max_y = 600
            detail = INT(max_x / 25)
            raise = INT(max_y / 33)
            varvar = INT(max_x / 100)

            'nekit
        CASE CHR$(0) + CHR$(67) 'F9
            levtype = 2
            x = startplace: y = max_y
            max_x = 350
            max_y = 600
            detail = INT(max_x / 15)
            raise = INT(max_y / 20)
            varvar = INT(max_x / 200)

        CASE CHR$(0) + CHR$(68) 'F10
            levtype = 2
            x = startplace: y = max_y
            max_x = 660
            max_y = 600
            detail = INT(max_x / 15)
            raise = INT(max_y / 20)
            varvar = INT(max_x / 200)

        CASE CHR$(0) + CHR$(133) 'F11
            levtype = 2
            x = startplace: y = max_y
            max_x = 1000
            max_y = 600
            detail = INT(max_x / 15)
            raise = INT(max_y / 20)
            varvar = INT(max_x / 200)

        CASE CHR$(0) + CHR$(134) 'F12
            levtype = 2
            x = startplace: y = max_y
            max_x = 1800
            max_y = 600
            detail = INT(max_x / 15)
            raise = INT(max_y / 20)
            varvar = INT(max_x / 200)

        CASE "r", "R" 'safe random
            RANDOMIZE TIMER
            'levtype = INT(RND * 2): IF levtype = 0 THEN levtype = 2
            max_x = 350 + INT(RND * 649)
            max_y = (600 / levtype) + INT(RND * (150 * levtype)) * 2
            RANDOMIZE TIMER
            detail = (INT(RND * 99)) + 1
            RANDOMIZE TIMER
            raise = INT(RND * 29) + 1
            RANDOMIZE TIMER
            varvar = INT(RND * 29) + 1
            x = startplace: y = max_y


        CASE "f", "F" 'full random
            RANDOMIZE TIMER
            levtype = INT(RND * 2): IF levtype = 0 THEN levtype = 2
            max_x = 350 + INT(RND * 1449)
            max_y = (600 / levtype) + INT(RND * (150 * levtype)) * 2
            RANDOMIZE TIMER
            detail = (INT(RND * 299)) + 1
            RANDOMIZE TIMER
            raise = INT(RND * 99) + 1
            RANDOMIZE TIMER
            varvar = INT(RND * 99) + 1
            x = startplace: y = max_y


            '        CASE "x", "X" 'toggle slow draw
            '            IF slowdraw = 0 THEN slowdraw = 1 ELSE slowdraw = 0
            '           x = startplace: y = max_y

        CASE CHR$(9) 'TAB=change level type
            IF levtype = 1 THEN levtype = 2 ELSE levtype = 1
            x = startplace: y = max_y

        CASE CHR$(13) 'save level

            outlev$ = filename$ + RIGHT$("00000" + LTRIM$(STR$(count)), 5) + ".svg"

            WHILE _FILEEXISTS(outlev$)
                count = count + 1
                outlev$ = filename$ + RIGHT$("00000" + LTRIM$(STR$(count)), 5) + ".svg"
            WEND


            IF klipbord$ <> "" THEN
                OPEN outlev$ FOR OUTPUT AS #1

                ' base svg data
                PRINT #1, "<?xml version=" + CHR$(34) + "1.0" + CHR$(34) + " encoding=" + CHR$(34) + "UTF-8" + CHR$(34) + " standalone=" + CHR$(34) + "no" + CHR$(34) + "?>"
                PRINT #1, "<svg xmlns:svg=" + CHR$(34) + "http://www.w3.org/2000/svg" + CHR$(34) + ">"
                PRINT #1, "<path style=" + CHR$(34) + "fill:#000000;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" + CHR$(34) + " d=" + CHR$(34) + "M"
                ' PRINT #1, "0,0"
                ' PRINT #1, "0," + LTRIM$(STR$(max_y / levtype))
                'generated data
                PRINT #1, klipbord$
                'end svg data
                PRINT #1, "Z" + CHR$(34) + " id=" + CHR$(34) + "1" + CHR$(34) + " />"
                REM                PRINT #1, "<text xml:space=" + CHR$(34) + "preserve" + CHR$(34) + " style=" + CHR$(34) + "font-style:normal;font-weight:normal;font-size:8px;font-family:Arial;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none" + CHR$(34) + " x=" + CHR$(34) + "0" + CHR$(34) + " y=" + CHR$(34) + "-5" + CHR$(34) + " id=" + CHR$(34) + "text1" + CHR$(34) + ">"
                REM                IF levtype = 1 THEN PRINT #1, "GENERATED ON " + DATE$ + ", " + TIME$ + " LEVEL SIZE:" + STR$(max_x) + "x" + LTRIM$(STR$(max_y)) + " RAISE:" + STR$(raise) + " DETAIL:" + STR$(detail) + " VARIATION:" + STR$(varvar)
                REM                IF levtype = 2 THEN PRINT #1, "GENERATED ON " + DATE$ + ", " + TIME$ + " LEVEL SIZE:" + STR$(max_x) + "x" + LTRIM$(STR$(max_y)) + " ROUGHNESS:" + STR$(raise) + " DETAIL:" + STR$(detail) + " SMOOTHING:" + STR$(varvar)
                PRINT #1, "</svg>"

                CLOSE #1

                klipbord$ = ""
                COLOR 10, background_color
                PRINT outlev$ + " saved! To make .LEV file, import the SVG output into SLE (Smibu's Level Editor)!"
                count = count + 1
            END IF
            GOTO 100

        CASE CHR$(27) 'esc
            400
            COLOR 15, background_color
            CLS
            _FONT 16
            PRINT "gn all!"
            END

        CASE CHR$(32) 'space=regenerate
            x = startplace: y = max_y
        CASE ELSE
            GOTO 100
    END SELECT



LOOP UNTIL K$ = CHR$(27)
