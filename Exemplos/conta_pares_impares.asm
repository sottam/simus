;---------------------------------------------------
; Programa: Conta total de pares ou impares em um vetor
; Autor: Gabriel P. Silva
; Data: 07.08.2017
;---------------------------------------------------
ORG 0

; Declaração das variáveis do programa principal
TAM_VETOR:       DB    14  
END_VETOR:       DW    VETOR
PARES:           DB    0
IMPARES:         DB    0
VETOR:           DB    1,2,3,4,5,6,7,8,9,10,12,14,16,18
CONT:            DB    0
MODO:            DB    0
STR_PARES:       STR   "Pares:"
                 DB    0
STR_IMPARES:     STR   "Impares:"
                 DB    0
STR_INICIAL:     STR   "Entre par ou impar:"
                 DB    0
END_BASE         EQU   0
 
ORG 100
        LDA     #END_BASE  
        PUSH
        LDA     #STR_INICIAL
        PUSH
        JSR     ROTINA
; Le as chaves. Se for impar conta impares e vice-versa.
INPUT:  IN      1 
        AND     #1
        JZ      INPUT
        IN      0
        STA     MODO
; Faz a leitura de um elemento do vetor e incrementa o contador
INICIO:  
        LDA      CONT
        ADD      #1
        STA      CONT
        LDA     @END_VETOR
            
; Testa se é par (bit 0=0)
        AND     #1
        JNZ     EHIMPAR
 
; Se for par, faz pares++

EHPAR:
        LDA     #1
        ADD     PARES
        STA     PARES
        JMP     TESTE
 
; Se for impar, faz impares++
EHIMPAR:
        LDA     #1
        ADD     IMPARES
        STA     IMPARES

; Incrementa o apontador e verifica se o loop acabou
TESTE:   
        LDA     END_VETOR
        ADD     #1
        STA     END_VETOR
        LDA     TAM_VETOR
        SUB     CONT           
        JP      INICIO

; Coloca o endereço da string na pilha e chama a rotina de impressão
IMPRIME: 
        LDA     MODO 
        AND     #1
        JNZ     SO_IMPAR
SO_PAR:
        LDA     #END_BASE
        PUSH
        LDA     #STR_PARES
        PUSH
        JSR     ROTINA

; Macete para imprimir o número em decimal (0-9)
        LDA     PARES 
        ADD     #30H
        OUT     BANNER
        JMP     FIM
; Coloca o endereço da string na pilha e chama a rotina de impressão
SO_IMPAR:
        LDA     #END_BASE  
        PUSH
        LDA     #STR_IMPARES
        PUSH
        JSR     ROTINA

; Macete para imprimir o número em decimal (0-9)
        LDA     IMPARES 
        ADD     #30H
        OUT     BANNER
FIM:    HLT
END     100        
;------------------------------------------------------
; Rotina para impressão de uma string no banner
; Declaração das variáveis da rotina
 
ORG  1000
SP:     DW      0    ; Guarda o valor do stack pointer
PTR:    DW      0    ; Ponteiro com o endereço da string a ser impressa
 
 
; Constantes de hardware
CLEARB  EQU 3
BANNER  EQU 2
;------------------------------------------------------
 
ROTINA:
        STS     SP      ; Salva o valor atual do sp
        POP
        POP             ; Descarta as primeiras duas posiçoes da pilha
        POP             ; Tira a parte baixa do endereco da string
        STA     PTR     ; Salva na parte baixa do ponteiro
        POP
        STA     PTR+1   ; Salva na parte alta do ponteiro
        OUT     CLEARB  ; Limpa o Banner
LOOP:
        LDA     @PTR    ; Lẽ o caractere
        OR      #0      ; É NULL?
        JZ      RETORNA ; Se for retorna
        OUT     BANNER  ; Imprime o caractere no banner
        LDA     PTR     ; Incrementa o ponteiro
        ADD     #1
        STA     PTR
        JMP     LOOP    ; Volta para o inicio
 
RETORNA:
        LDS      SP     ; Restaura o Stack Pointer
        RET             ; Retorna