;--------------------------------
; Programa: Encontra o menor elemento de um vetor
;           e calcula a soma de todos os elementos
; Autor: Thales de Freitas
; Data: 02/05/2016
;--------------------------------
	
ORG 100
PT:     DW A
MIN:    DS 1
SOMA:   DB 0 
I:      DB 0 
DEZ:    DB 10
A:      DB 6, 2, 2, 3, 1, 5, 6, 7, 8, 9, 
	
ORG 0 
INICIO:
	LDA @PT
	STA MIN    ; MIN = A[0]
        STA SOMA   ; SOMA = MIN
        JMP TESTE
FOR: 	
	LDA PT 
        ADD #1
	STA PT     ; PT = PT + 1
	LDA MIN    
        SUB @PT    ; A[i] < MIN ?
	JN  PULA
	LDA @PT    ; MIN = A[i]
	STA MIN
PULA:
	LDA SOMA    ; SOMA = SOMA + A[i]
	ADD @PT
	STA SOMA
TESTE:	
        LDA I 
	ADD #1
	STA I       ; I = I + 1
        SUB DEZ     ; I < 10 ?
	JN FOR      ; SE VERDADE FICA NO LAÇO
        LDA MIN     ; SENÂO TERMINA
        OUT 0       ; VISOR = MIN
	LDA SOMA    ; 
	OUT 0       ; VISOR = SOMA
	HLT         ; FIM
END 0
