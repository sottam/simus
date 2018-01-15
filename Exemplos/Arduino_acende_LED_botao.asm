;---------------------------------------------------
; Programa: Acende Led botao Arduino
; Autor: Alonso Matos
; Data: 18.09.2017
;---------------------------------------------------
ORG	 0
         LDA    #219
         TRAP   0


	LDA	#3	; pino desejado = 5
	STA	PIN_LED

        LDA     #4      ; PINO BOTAO = 2
        STA     PIN_BUT
;
	LDA	#1	; modo de saída
	STA	PIN_LED +1
	LDA	#201
	TRAP	PIN_LED

        LDA     #0      ; modo de entrada
        STA     PIN_BUT +1
        LDA     #201
        TRAP    PIN_BUT

        LDA     #220
        TRAP    PIN_BUT


LOOP:
        LDA     #203    ;digital read
        TRAP    PIN_BUT
        SUB     #1
        JNZ     APAGA

	LDA	#1	; coloca ‘0’  no pino 13
	STA	PIN_LED+1
	LDA	#202
	TRAP	PIN_LED
        JMP     LOOP
APAGA:
	LDA	#0	; coloca ‘1’  no pino 13
	STA	PIN_LED +1
	LDA	#202
	TRAP	PIN_LED
;
	JMP	LOOP

T500:	DW	50
PIN_LED:	DS	3
PIN_BUT:        DS      3
END	 0
