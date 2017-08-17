;-------------------------------
; Programa:
; Autor:
; Data:
;------------------------------
ORG 100
CINCO:  DB 5
X:   DB  1
     DB  2
     DB  9
     DB  4
     DB  5
I:   DB  0
MAX:  DB 0 
UM:  DB 1
ORG 0
     LDA I 
     SUB CINCO
     JN PULO
     JMP FIM
     LDA I
     ADD UM
PULO: LDA @X
      SUB MAX
     JN FIM
     STA MAX
FIM:  
     HLT 