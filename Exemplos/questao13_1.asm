;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
;--------------------------------
; Programa: For Loop
; Autor: Thales de Freitas
; Data: 02/05
;--------------------------------


	
ORG 128
PT:     DB 160
MIN:    DS 1
SOMA:   DB 0 
I:      DB 0 
DEZ:    DB  10
	
ORG 160
A:
	DB 6
	DB 2
	DB 2
	DB 3
	DB 1
	DB 5
	DB 6
	DB 7
	DB 8
	DB 9
	
ORG 0
	; MIN = A[0]
	LDA @PT
	STA MIN
        STA SOMA   ; CORRIGE O ERRO NO PROGRAMA
        JMP TESTE
FOR: 	
        ; TMP = A[i]
	LDI 1 
        ADD PT
	STA PT
	LDA MIN
        SUB @PT
	JN  PULA
	
	; MIN = A[i]
	LDA @PT
	STA MIN
	
PULA:
	; SOMA = SOMA + A[i]
	LDA SOMA
	ADD @PT
	STA SOMA

TESTE:	
        LDI 1
	ADD I
	STA I
        SUB DEZ
	JN FOR
        LDA MIN
        OUT 0
	HLT
END 0
