;-------------------------------
; Programa:
; Autor:
; Data:
;------------------------------
ORG 100
X:   DB  1
     DB  2
     DB  9
     DB  4
     DB  5
I:   DB  0
MAX:  DB 0 
TAM:  DB 4
UM: DB 1
ORG 0
FOR:  LDA TAM
     SUB I
     JN FIM
     LDA MAX
     SUB @I
     JN TROCA
     LDA I
     ADD UM
     JMP FOR
TROCA: LDA @I
      STA MAX
FIM:  
     HLT 