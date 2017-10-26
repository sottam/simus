;---------------------------------------------------
; Programa: Blink Array de Leds Arduino
; Autor: Alonso Matos
; Data: 18.09.2017
;---------------------------------------------------

T500:	        DW      500
PIN_lED1:	DS	3
PIN_lED2:	DS	3
PIN_lED3:	DS	3
PIN_lED4:	DS	3
PIN_lED5:	DS	3

PIN_POT:        DS      3

ORG	 30
        LDA     #219
        TRAP    0

	LDA	#12
	STA	PIN_LED1

        LDA	#8
	STA	PIN_LED2

        LDA	#7
	STA	PIN_LED3

        LDA	#6
	STA	PIN_LED4

        LDA	#5
	STA	PIN_LED5

        LDA     #0
        STA     PIN_POT
;
	LDA	#1	; modo de saída
	STA	PIN_LED1 +1
        STA	PIN_LED2 +1
        STA	PIN_LED3 +1
        STA	PIN_LED4 +1
        STA	PIN_LED5 +1
        LDA     #2
        STA     PIN_POT
	LDA	#201
	TRAP	PIN_LED1
        TRAP	PIN_LED2
        TRAP	PIN_LED3
        TRAP	PIN_LED4
        TRAP	PIN_LED5
        TRAP    PIN_POT

        ;LDA     #221
        ;TRAP    PIN_POT



LOOP:
        ;LDA     #204
        ;TRAP    PIN_POT
        ;STA     T500
        ;LDA     #255
        ;STA     T500

	LDA	#1
	STA	PIN_LED1+1
	LDA	#202
	TRAP	PIN_LED1
;
	LDA	#5	; espera (500 ms)
	TRAP	T500
;
	LDA	#0
	STA	PIN_LED1+1
	LDA	#202
	TRAP	PIN_LED1

        LDA	#1
	STA	PIN_LED2+1
	LDA	#202
	TRAP	PIN_LED2
;
	LDA	#5	; espera (500 ms)
	TRAP	T500

        LDA	#0
	STA	PIN_LED2+1
	LDA	#202
	TRAP	PIN_LED2

        LDA	#1
	STA	PIN_LED3+1
	LDA	#202
	TRAP	PIN_LED3

        LDA	#5	; espera (500 ms)
	TRAP	T500

        LDA	#0
	STA	PIN_LED3+1
	LDA	#202
	TRAP	PIN_LED3

        LDA	#1
	STA	PIN_LED4+1
	LDA	#202
	TRAP	PIN_LED4

        LDA	#5	; espera (500 ms)
	TRAP	T500

        LDA	#0
	STA	PIN_LED4+1
	LDA	#202
	TRAP	PIN_LED4

        LDA	#1
	STA	PIN_LED5+1
	LDA	#202
	TRAP	PIN_LED5

        LDA	#5	; espera (500 ms)
	TRAP	T500

        LDA	#0
	STA	PIN_LED5+1
	LDA	#202
	TRAP	PIN_LED5

	JMP	LOOP


END	 30
