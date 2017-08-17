;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
ORG 100
UM:           DB  1

ORG 0
          
LOOP:         IN   1
              AND UM
              JZ   LOOP
              IN   0
              OUT  0
              jMP LOOP




