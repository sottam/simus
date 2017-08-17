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
PT_I:     DS 1
PT_J:     DS 1
I:        DB 0
J:        DS 1
TMP:      DS 1
	
ORG 160
X:
	DB 6
	DB 2
	DB 20
	DB 3
	DB 10
	DB 5
	DB 60
	DB 4
	DB 8
	DB 0ffh


	
ORG 0
	; MIN = A[0]

        JMP INICIO_I
FOR_I: 	
        LDI 1
        ADD I 
        STA I 
        LDI 8
        SUB I
        JN  END  
INICIO_I:
        LDI X
	ADD I 
        STA PT_I
        LDI 1
        ADD I
        STA J
        JMP INICIO_J
FOR_J:   
	LDI 1
        ADD J 
        STA J
        LDI 9
        SUB J
        JN END_I
INICIO_J:
        LDI X
	ADD J 
        STA PT_J
COMP:
	LDA @PT_I
        SUB @PT_J
        JN END_J	
TROCA:	
	LDA @PT_I
	STA TMP
        LDA @PT_J
        STA @PT_I
	LDA TMP
        STA @PT_J
END_J:  
        JMP FOR_J
END_I:  
        JMP FOR_I
END:
        HLT
END 0
