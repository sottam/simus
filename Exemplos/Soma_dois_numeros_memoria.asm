;---------------------------------------------------
; Programa: Soma A = B + C 
; Autor: Gabriel P. Silva
; Data: 2016
;---------------------------------------------------
ORG  100

B:       DB   10    ; B = 10
C:       DB   5     ; C = 5
A:       DS   1     ; A

ORG  0
MAIN:    LDA  B     ; ACC = B
         ADD  C     ; ACC = ACC + C
         STA  A     ; A = ACC
         OUT  0     ;
         HLT        ;  PARA



        
 









