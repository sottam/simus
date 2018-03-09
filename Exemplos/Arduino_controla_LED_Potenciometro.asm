;---------------------------------------------------
; Programa: Controla LED potenciometro
; Autor: Alonso Matos
; Data: 18.10.2017
;---------------------------------------------------
ORG	 0
         LDA    #219
         TRAP   0

	LDA	#13	; pino desejado = 13
	STA	PIN_LED

        LDA     #56      ; PINO potenciometro = A2
        STA     PIN_POT
;
	LDA	#3	; modo de saída PWM
	STA	PIN_LED +1
	LDA	#201
	TRAP	PIN_LED

        LDA     #2      ; modo de entrada analogica
        STA     PIN_POT +1
        LDA     #201
        TRAP    PIN_POT

        LDA     #221
        TRAP    PIN_POT


LOOP:
        LDA     #204    ;analog read
        TRAP    PIN_POT

	STA	PIN_LED+1
	LDA	#205
	TRAP	PIN_LED

        JMP     LOOP

T500:	DW	50
PIN_LED:	DS	3
PIN_POT:        DS      3
END	 0
