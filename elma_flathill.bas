PRINT "Flat track level generator 0.8 by iCS"
PRINT ""
PRINT "Level sizes:"
PRINT "1: Warm Up"
PRINT "2: Flat Track"
PRINT "3: long flat"
PRINT "4: very long flat"
PRINT ""
PRINT "SELECT SIZE (1-4): ";
DO
    DO: K$ = UCASE$(INKEY$)
    LOOP UNTIL K$ <> ""
    SELECT CASE K$
        CASE "1"
            PRINT "1"
            max_width = 330
            max_height = 180
        CASE "2"
            PRINT "2"
            max_width = 660
            max_height = 240
        CASE "3"
            PRINT "3"
            max_width = 1000
            max_height = 300
        CASE "4"
            PRINT "4"
            max_width = 1800
            max_height = 500
        CASE CHR$(27)
            PRINT "ESC pressed"
            END
    END SELECT
LOOP UNTIL max_width <> 0

PRINT ""
PRINT "Level smoothness:"
PRINT "1: juka"
PRINT "2: chris"
PRINT "3: Nekit"
PRINT ""
PRINT "SELECT SMOOTHNESS (1-3): ";

detail = 0
DO
    DO: KK$ = UCASE$(INKEY$)
    LOOP UNTIL KK$ <> ""
    SELECT CASE KK$
        CASE "1"
            PRINT "1"
            detail = INT(max_width / 75)
            slope = INT(max_height / 18)
            smoothing = INT(max_width / 50)
        CASE "2"
            PRINT "2"
            detail = INT(max_width / 25)
            slope = INT(max_height / 15)
            smoothing = INT(max_width / 100)
        CASE "3"
            PRINT "3"
            detail = INT(max_width / 15)
            slope = INT(max_height / 10)
            smoothing = INT(max_width / 200)
        CASE CHR$(27)
            PRINT "ESC pressed"
            END
    END SELECT
LOOP UNTIL detail <> 0

PRINT ""
PRINT "NUMBER OF LEVELS to be generated (1-9): ";
count = 0

DO
    DO: KKK$ = UCASE$(INKEY$)
    LOOP UNTIL KKK$ <> ""
    SELECT CASE KKK$
        CASE "1"
            PRINT "1"
            count = 1
        CASE "2"
            PRINT "2"
            count = 2
        CASE "3"
            PRINT "3"
            count = 3
        CASE "4"
            PRINT "4"
            count = 4
        CASE "5"
            PRINT "5"
            count = 5
        CASE "6"
            PRINT "6"
            count = 6
        CASE "7"
            PRINT "7"
            count = 7
        CASE "8"
            PRINT "8"
            count = 8
        CASE "9"
            PRINT "9"
            count = 9
        CASE CHR$(27)
            PRINT "ESC pressed"
            END
    END SELECT
LOOP UNTIL count <> 0


FOR sorszam = 1 TO count
    x = 0
    filename$ = "flattrak.dat"
    OPEN filename$ FOR OUTPUT AS #1

    ' base svg data
    PRINT #1, "<?xml version=" + CHR$(34) + "1.0" + CHR$(34) + " encoding=" + CHR$(34) + "UTF-8" + CHR$(34) + " standalone=" + CHR$(34) + "no" + CHR$(34) + "?>"
    PRINT #1, "<svg xmlns:svg=" + CHR$(34) + "http://www.w3.org/2000/svg" + CHR$(34) + ">"
    PRINT #1, "<path style=" + CHR$(34) + "fill:#000000;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" + CHR$(34) + " d=" + CHR$(34) + "M"

    '     PRINT "0," + LTRIM$(STR$((max_height / 2)))

    PRINT #1, "0,0"
    PRINT #1, "0," + LTRIM$(STR$((max_height / 2)))
    RANDOMIZE TIMER
    DO
        xa = INT(RND * (max_width / detail))
        x = x + xa + INT(RND * (smoothing))
        y = (max_height / 2) + INT(RND * slope)
        IF x >= max_width THEN EXIT DO

        '        PRINT LTRIM$(STR$(x)) + "," + LTRIM$(STR$(y))

        PRINT #1, LTRIM$(STR$(x)) + "," + LTRIM$(STR$(y))
    LOOP

    '   PRINT LTRIM$(STR$(max_width)) + "," + LTRIM$(STR$((max_height / 2)))

    PRINT #1, LTRIM$(STR$(max_width)) + "," + LTRIM$(STR$((max_height / 2)))
    PRINT #1, LTRIM$(STR$(max_width)) + ",0"

    'end svg data
    PRINT #1, "Z" + CHR$(34) + " id=" + CHR$(34) + "1" + CHR$(34) + " /> </svg>"

    CLOSE #1

    SHELL "COPY flattrak.dat output" + LTRIM$(STR$(sorszam)) + ".svg"
    SHELL "DEL flattrak.dat"

    PRINT "output" + LTRIM$(STR$(sorszam)) + ".svg generated"
NEXT sorszam

