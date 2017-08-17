;-------------------------------
; Programa:
; Autor:
; Data:
;------------------------------
ORG 100
X:   DB 1 
        DB  2
        DB  9
        DB  4
        DB  5
I:      DB 0
MAX:  DB 0 
UM:   DB 1
PTR:  DS 1
CINCO:  DB 5
AUX:    DB 0
ORG 0H
FIM-IF:  LDI 0
        ADD AUX 
        STA I 
        LDI X 
        ADD AUX 
        STA PTR
        LDA AUX
        ADD UM
        STA AUX
        LDA I 
        SUB CINCO
        JZ FIM-FOR
        LDA PTR
        SUB MAX
        JZ FIM-IF
        JN FIM-IF
        LDA PTR
        STA MAX
FIM-FOR: HLT