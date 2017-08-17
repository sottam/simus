; Converte números entre 00 e 99 em decimal
; Programa:
ORG  100
VALOR:   DS   1    ;
MOSTRA:  DS   1    ;
DEZ:     DB   10   ;

ORG  0
MAIN:    IN   0      ; ACC = Chaves
         STA  VALOR  ;
         STA  MOSTRA ; 
LACO:    SUB  DEZ    ; 
         JN   SAIDA  ;
         STA  VALOR  ;
         LDI  6      ;
         ADD  MOSTRA ;
         STA  MOSTRA ;
         LDA  VALOR  ;
         JMP  LACO   ;
SAIDA:   LDA  MOSTRA ;
         OUT   0     ;
         HLT         ;