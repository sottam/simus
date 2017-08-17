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
PT_I:     DB 160
PT_J:     DB 160
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
I_END:	
        DB 0ffh
J_END:


	
ORG 0
	; MIN = A[0]

        JMP INICIO_I
FOR_I: 	
        LDI 1
        ADD PT_I 
        STA PT_I
        LDI I_END
        SUB PT_I
        JZ  END  
INICIO_I:
        LDI 1
        ADD PT_I
        STA PT_J
        JMP INICIO_J
FOR_J:   
	LDI 1
        ADD PT_J 
        STA PT_J
        LDI J_END
        SUB PT_J
        JZ END_I
INICIO_J:      
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
