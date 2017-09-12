; --------------------------------------------------------------------
; Descrição: Rotina para imprimir uma cadeia de caracteres no banner 
; Parametros: O endereço da cadeia é passado na pilha
; Autor: Gabriel P. Silva
; ---------------------------------------------------------------------
ORG 300
SP:    DW 0
AUX:   DW 0
PTR:   DW 0
;------------------------------------------------------
; constantes de hardware
CLEARB   equ 3
BANNER   equ 2
;------------------------------------------------------
ROTINA:
    STS     SP
    STS     AUX
    LDA     AUX
    ADD     #2
    LDA     @AUX
    STA     PTR
    ADD     #1
    STA     PTR+1
    OUT     CLEARB
loop:
    LDA     @ptr
    OR      #0
    JZ      fim
    OUT     banner
    LDA     ptr
    ADD     #1
    STA     ptr
    JMP     loop
fim:
    LDS SP
    RET            
END ROTINA
