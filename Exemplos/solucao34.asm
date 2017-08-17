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
UM:  DB 1
CINCO: DB 5
ORG 0
IF:  LDA MAX 
     SUB @I
     JN THEN
     LDA I
     ADD UM
     JMP IF
THEN: LDA @I
      STA MAX
JMP2: LDA I
      SUB CINCO
     JNZ IF
FIM:  
     HLT 