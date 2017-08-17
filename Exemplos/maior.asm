;---------------------------------------------------
; Programa: Encontra o maior valor em um vetor
; Contém diversos erros de compilação
; Autor: Ghost
; Data: 19.9.2003
;---------------------------------------------------
INICIO:   LDA  @PONTEIRO      ; Carrega o endereço
          JZ   FIM            ; Se Zero Acabou
          STA  ATUAL          ; Endereco do indice
:         NOT                 ; Complementea
:         ADD  MAIOR

          LDA  ADD UM         ; Soma um
          NOT  A              ; Complementa
          ADD  UM             ; Soma um
          NOT  A              ; Complementa

PONTEIRO: DB   0F0H           ; 
TROCA:    DS   1              ; Para a comparação
MAIOR:    DB   0              ; Guarda o maior valor
UM:       DB   1              ; Um
          ORG  F0H
A:        DB   23             ; A[0]
          DB   45
          DB   67
          DB   34
          DB   26
          DB   120
          DB   180
          DB   148
          DB   3
          DB   59
          DB   00
