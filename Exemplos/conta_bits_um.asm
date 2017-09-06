;---------------------------------------------------
; Programa: Rotina que conta o número de bits em um 
            de uma palavra de 32 bits
; Autor: Gabriel P. Silva
; Data: 07.09.2017
;---------------------------------------------------
ORG 100
TESTE:    DW 55AAh, 5501h     ; Palavra de 32 bits
ENDER:    DW 0                ; Salva endereço do byte na palavra
PC:       DW 0                ; Salva apontador de instruções
TEMP:     DS 1                
TOTAL:    DB 0                ; Total de bits em '1'
CONTADOR: DB 0                ; Número de bytes já lidos

ORG 0
ROTINA:  pop
         sta PC
         pop
         sta PC+1              ; Tira o PC da pilha e salva na memória
         pop 
         sta ENDER
         pop 
         sta ENDER+1           ; Salva o endereço da palavra
INICIO:  lda @ENDER
         sta TEMP
LOOP:    lda TEMP
         OR  #0                ; Se estiver tudo zerado acabou
         JZ  CONT              ;
         shl                   ; Senão desloca de um bit para esquerda
         sta TEMP              ;
         jnc  FIM              ; Testa se  igual a '1'
         lda  #1               ; se for incrementa total
         add  TOTAL            ;
         sta  TOTAL            ;
FIM:     jmp LOOP
CONT:    lda ENDER
         add #1   
         sta ENDER             ; ENDER = ENDER + 1
         lda CONTADOR
         add #1
         sta CONTADOR          ; CONTADOR = CONTADOR + 1
         sub #4                ; Leu os quatro bytes?
         jnz inicio   
         lda pc+1              ; Restaura o PC para a pilha
         push 
         lda pc
         push
         lda total             ; Coloca o total no acumulador
         ret
         nop
main:    lda #0                ; macete para parte alta do endereço
         push
         lda #teste
         push 
         jsr rotina
         out 0
         hlt
end      main
