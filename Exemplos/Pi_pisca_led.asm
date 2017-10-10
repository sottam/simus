;---------------------------------------------------
; Programa: Blink Led Wiring Pi
; Autor: Alonso Matos
; Data: 09.08.2017
;---------------------------------------------------
ORG	 0
;a numeracao dos pinos segue a referencia do wiringPi
	LDA  #23             ; pino desejado = 23
	STA  PIN_TRAP
;
	LDA  #1              ; modo de saída
	STA  PIN_TRAP +1
	LDA  #101
	TRAP PIN_TRAP

LOOP:
	LDA  #1              ; coloca ‘1’  no pino 23
	STA  PIN_TRAP+1
	LDA  #102
	TRAP PIN_TRAP
;
	LDA  #5              ; espera (1000 ms)
	TRAP T1000
;
	LDA  #0	             ; coloca ‘0’  no pino 23
	STA  PIN_TRAP +1
	LDA  #102
	TRAP PIN_TRAP
;
	LDA  #5              ; espera (1000 ms)
	TRAP T1000
;
	JMP  LOOP

T1000:	DW   1000
PIN_TRAP:	DS	3
END	 0
