; --------------------------------------------------------
; Programa: Converte números hexadecimais para decimal (entre 00 e 99) 
; Autor: Gabriel P. Silva
; Data: 2016
;----------------------------------------------------------
ORG  100
VALOR:   DS   1    ;
MOSTRA:  DS   1    ;

ORG  0
MAIN:    IN   0      ; ACC = Chaves
         STA  VALOR  ;
         STA  MOSTRA ; 
LACO:    SUB  #10    ; 
         JN   SAIDA  ;
         STA  VALOR  ;
         LDA  #6     ;
         ADD  MOSTRA ;
         STA  MOSTRA ;
         LDA  VALOR  ;
         JMP  LACO   ;
SAIDA:   LDA  MOSTRA ;
         OUT   0     ;
         HLT         ;
