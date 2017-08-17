;-------------------------------
; Programa: Soma os elementos de um vetor
; Autor:
; Data:
;------------------------------

DISPLAY EQU 0

ORG 100
X:   	DB 1, 2, 3, 4, 5, 6, 7, 8, 9

I:   	DB 0
SOMA: 	DB 0 
PTR: 	DW X
TAM:    DB 9


ORG 0

INICIO: 
 	LDA I
     	SUB TAM
     	JN  TOTAL
        JMP FIM

TOTAL:  LDA SOMA
        ADD @PTR
        STA SOMA
        OUT DISPLAY

INC:  	LDA I
     	ADD #1
     	STA I 
     	LDA PTR
     	ADD #1
     	STA PTR
     	JMP INICIO

FIM:    LDA SOMA
        OUT DISPLAY        
        HLT
