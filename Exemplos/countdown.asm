;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
ORG  100

COUNT:   DS   1    ;  COUNT
UM:      DB   1    ;  UM = 1

ORG  0
MAIN:    IN   0      ; ACC = Chaves
LOOP:    OUT  0      ; VISOR = A
         SUB  UM     ;
         STA  COUNT  ; COUNT = ACC
         LDA  COUNT  ;
         JN   FIM    ;
         JMP  LOOP   ;
FIM:     HLT      ;
