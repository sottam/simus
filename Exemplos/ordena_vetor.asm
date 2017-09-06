;---------------------------------------------------
; Programa: Ordena um Vetor 
; Autor: Thales de Freitas
; Data: 02/05/16
;---------------------------------------------------
	
ORG 100
PT_I:     DW X
PT_J:     DW X+1
I:        DB 0
J:        DS 1
TMP:      DS 1
X:        DB 6, 2, 20, 2, 10, 5, 60, 4, 8, 0FFH

ORG 0 
        JMP INICIO_I
FOR_I: 	
        LDA I
        ADD #1 
        STA I       ;  i = i + 1
        LDA #8  
        SUB I       ;  i <= 8 ?
        JN  FIM     ;  Se falso termina
INICIO_I:
        LDA #X
	ADD I 
	STA PT_I    ;  PT_I = &X[i]
        LDA I       ;  j = i + 1
        ADD #1
        STA J
        JMP INICIO_J
FOR_J:   
	LDA J
        ADD #1 
        STA J        ; j = j + 1
        LDA #9       ; j < = 9?
        SUB J        ; Se falso sai do laço
        JN END_I
INICIO_J:
        LDA #X
	ADD J 
        STA PT_J     ; PT_J = &X[j]
COMP:
	LDA @PT_I    ; 
        SUB @PT_J    ; X[i] > X[j] ?
        JN END_J     ; Senão pula  	
TROCA:	
	LDA @PT_I    ; Troca X[i] com X[j] 
	STA TMP      
        LDA @PT_J
        STA @PT_I
	LDA TMP
        STA @PT_J
END_J:  
        JMP FOR_J
END_I:  
        JMP FOR_I
FIM:
        HLT
END 0
