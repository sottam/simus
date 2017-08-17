;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
ORG 100

I: DB 4
J: DB 8
K:  DS 1
DOIS: DB 2

ORG 0
INICIO: 

      LDA I
      SUB J
      JN  THEN
ELSE: LDA I
      SUB DOIS
      STA K
      LDI 1
      ADD J
      STA J
      JMp FIM
THEn: LDA J
      ADD J
      STA K
FIM:  HLT
      



