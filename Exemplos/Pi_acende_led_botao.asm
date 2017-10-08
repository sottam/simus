;---------------------------------------------------
; Programa: Acende led com pressionamento de botao Wiring Pi
; Autor: Alonso Matos
; Data: 03.10.2017
;---------------------------------------------------
ORG	 0
;a numeracao dos pinos segue a referencia do wiringPi
	LDA	#23	; pino LED = 23
	STA	PIN_LED

	LDA     #22
	STA     PIN_BUT ;pino botao = 22

	LDA	#1	; modo de saída
	STA	PIN_LED +1
	LDA	#101
	TRAP	PIN_LED

	LDA     #0      ; modo entrada
	STA     PIN_BUT +1
	LDA     #101
	TRAP    PIN_BUT

	LDA     #2      ;modo da resistencia pull up
	STA     PIN_BUT +1
	LDA     #104
	TRAP    PIN_BUT
LOOP:
	LDA     #103
	TRAP    PIN_BUT ;le o estado do botao
	SUB     #1      ;se 1, acende, se 0 apaga
	JN      APAGA             
ACENDE:
	LDA	#1	; coloca ‘1’  no pino do led
	STA	PIN_LED+1
	LDA	#102
	TRAP	PIN_LED
	JMP     LOOP
APAGA:
	LDA	#0	; coloca ‘0’  no pino do led
	STA	PIN_LED +1
	LDA	#102
	TRAP	PIN_LED
	JMP	LOOP

PIN_LED:	DS	3
PIN_BUT:	DS	3
END	 0
