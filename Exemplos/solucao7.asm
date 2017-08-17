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
PTR:  DS 1
UM:   DB 1
ORG 0H
START:     LDI  X 
     STA PTR
FOR: LDA I
     SUB  CINCO
     JN  ENTRAFOR
INC:  LDA I
     ADD UM
     STA I 
     LDA PTR
     ADD UM
     STA PTR
     JMP FOR
ENTRAFOR: LDA MAX
          SUB @PTR
          JN ENTRAIF
          JMP INC
ENTRAIF:  LDA @PTR
     STA MAX
     JMP INC
     HLT