;-------------------------------
; Programa: Soma os elementos de um vetor
; Autor: Gabriel P. Silva
; Data: Aug. 2017
;------------------------------

DISPLAY EQU 0

ORG 100
X:   	 DB    1, 2, 3, 4, 5, 6, 7, 8, 9
I:   	 DB    0
SOMA: 	DB    0 
PTR: 	 DW    X
TAM:   DB    9

ORG 0
INICIO: 
 	      LDA   I
        SUB   TAM
        JN    TOTAL
        JMP   FIM
;
TOTAL:  LDA   SOMA
        ADD   @PTR
        STA   SOMA
        JSR   DECIMAL
;
INC:  	 LDA   I
     	  ADD   #1
     	  STA   I 
     	  LDA   PTR
     	  ADD   #1
     	  STA   PTR
     	  JMP   INICIO
;
FIM:    LDA   SOMA
        JSR   DECIMAL       
        HLT
        END   0
        
ORG 1000
VALOR:   DS    1
MOSTRA:  DS    1

DECIMAL: STA   VALOR   ; Comentário pra quê?
         STA   MOSTRA  ; 
LACO:    SUB   #10     ; 
         JN    SAIDA   ;
         STA   VALOR   ;
         LDA   #6      ;
         ADD   MOSTRA  ;
         STA   MOSTRA  ;
         LDA   VALOR   ;
         JMP   LACO    ;
SAIDA:   LDA   MOSTRA  ;
         OUT   0       ;
         RET     
