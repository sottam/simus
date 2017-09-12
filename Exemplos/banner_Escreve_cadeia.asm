;-------------------------------------
; Programa para escrever uma cadeia no banner
; Autor: José Antonio Borges
; Data:  2017
;---------------------------------------
ORG 0
INICIO:
        OUT     CLEARBANNER
LOOP:
        LDA     @PTR             ; Le um caractere
        OR      #0               ; Se for NULL
        JZ      FIM              ; Termina
        OUT     BANNER           ; Senão escreve no banner
        LDA     #CONSOLEWRITE    ;
        TRAP    @PTR             ; Escreve também na console
; Incrementa o ponteiro
        LDA     PTR        
        ADD     #1
        STA     PTR
; Vai para o laço
        JMP     LOOP
FIM:    HLT
        END     INICIO

GABRIEL: STR    "Gabriel P. Silva"
         DB     0                    ; Termina com NULL
PTR:     DW     GABRIEL

;------------------------------------------------------
; constantes de hardware
CLEARBANNER   EQU 3
BANNER        EQU 2
; constantes de trap
CONSOLEWRITE  EQU 2
;------------------------------------------------------
