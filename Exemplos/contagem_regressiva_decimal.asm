;---------------------------------------------------
; Programa: Contador descrente em decimal
; Autor: Gabriel P. Silva
; Data: 2016
;---------------------------------------------------

ORG  0
MAIN:    IN   1          ; 
         ADD  #0         ;
         JZ   MAIN       ; Espera um valor nas chaves
         IN   0          ; ACC = Chaves
         STA  COUNT      ;
LOOP:    JSR  DECIMAL    ; VISOR = A
         LDA  COUNT      ; 
         SUB  #1         ;
         STA  COUNT      ; COUNT = ACC
         JNZ  LOOP       ; 
         JSR  DECIMAL    ; 
FIM:     HLT             ;
         END  0 
COUNT:   DS   1          ;  COUNT

ORG 300
VALOR:  DS 1
MOSTRA: DS 1

DECIMAL: STA  MOSTRA     ; Rotina para converter
         STA  VALOR      ; de hexadecimal para decimal
LACO:    SUB  #10        ; 
         JN   SAIDA      ;
         STA  VALOR      ;
         LDA  #6         ;
         ADD  MOSTRA     ;
         STA  MOSTRA     ;
         LDA  VALOR      ;
         JMP  LACO       ;
SAIDA:   LDA  MOSTRA     ;
         OUT   0         ;
         RET     
