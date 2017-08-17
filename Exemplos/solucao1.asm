;-------------------------------
; Programa:
; Autor:
; Data:
;------------------------------
ORG 080H 
I:  DB 090H
MAX: DB 0 
UM: DB 1

ORG  090H
X1:  DB  1
     DB  2
     DB  9
     DB  4
     DB  5
ORG 0

     LDA @I 
     STA MAX
     LDA I 
     ADD UM
     STA I
     LDA @I
LOOP: SUB MAX
     JN HUE 
     LDA @I
     STA MAX
HUE: LDA I
     ADD UM 
     STA I 
     LDA @I 
     JNZ LOOP 
     HLT 