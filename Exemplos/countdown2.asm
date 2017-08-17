;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
ORG  100
TESTE	    EQU  10000;  
COUNT:   DS   1    ;  COUNT

ORG  0
MAIN:    IN   1      ; 
         ADD  #0     ;
         JZ   MAIN   ;
         IN   0      ; ACC = Chaves
LOOP:    OUT  0      ; VISOR = A
         SUB  #1     ;
         STA  COUNT  ; COUNT = ACC
         JNZ  LOOP   ; 
         OUT  0      ; 
FIM:     HLT         ;
         END  0 
