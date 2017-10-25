;---------------------------------------------------
; Programa: Blink Led Arduino
; Autor: Alonso Matos
; Data: 18.09.2017
;---------------------------------------------------
ORG	 0
        LDA    #219
        TRAP   0

	LDA	#13	; pino desejado = 13
	STA	PIN_TRAP
;
	LDA	#1	; modo de saída
	STA	PIN_TRAP +1
	LDA	#201
	TRAP	PIN_TRAP

LOOP:
	LDA	#1	; coloca ‘1’  no pino 13
	STA	PIN_TRAP+1
	LDA	#202
	TRAP	PIN_TRAP
;
	LDA	#5	; espera (500 ms)
	TRAP	T500
;
	LDA	#0	; coloca ‘0’  no pino 13
	STA	PIN_TRAP +1
	LDA	#202
	TRAP	PIN_TRAP
;
	LDA	#5	; espera (500 ms)
	TRAP	T500
;
	JMP	LOOP

T500:	DW	50
PIN_TRAP:	DS	3
END	 0
