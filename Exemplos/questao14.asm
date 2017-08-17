;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
ORG 100

MAX: DS 1
I:  DS 1
PTA: DS 1
A: DB 0
   DB 1
   DB 2
   DB 3
   DB 40
   DB 5 
   DB 6
   DB 7
   DB 8
   DB 9

ORG 0
INICIO: 

      LDA 1
      STA I
      LDA A
      STA MAX
      LDI  A       
      STA  PTA
    
FOR:  LDI 1
      STA I
      JMP LACO
TESTE:
      LDI 1
      ADD I 
      STA I
      LDI 10 
      SUB I 
      JZ  FIM
LACO: LDA PTA
      ADD  1
      STA PTA
      LDA MAX
      SUB @PTA
      JN  MENOR
      JM TESTE
MENOR:LDA @PTA
      STA MAX
L2:   JMP TESTE
FIM:      HLT

     

      
FIM:  HLT
      



