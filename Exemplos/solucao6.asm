;-------------------------------
; Programa:
; Autor:
; Data:
;------------------------------
ORG 100
VETX:   DB 1 
        DB  2
        DB  9
        DB  4
        DB  5
I:      DB 0
MAX:  DB 0 
PTR:  DB 0
ORG 0H
     LDI  VETX 
     STA PTR
LOOP: LDA MAX
     SUB  @PTR
     JN  MAIOR
ENDIF:  LDI 1
     ADD I
     STA I 
     LDI 5
     SUB I 
     JZ FIM 
     LDI 1 
     ADD PTR
     STA PTR 
     JMP LOOP
MAIOR:  LDA @PTR
     STA MAX
     JMP ENDIF
FIM:  HLT 