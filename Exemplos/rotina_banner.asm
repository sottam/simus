; 
; Descrição: Rotina para imprimir uma cadeia de caracteres no banner 
; Parametros: O endereço da cadeia é passado na pilja
; Autor: Gabriel P. Silva
; 
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
    lda     @ptr
    or      #0
    jz      fim
    out     banner
    lda     ptr
    add     #1
    sta     ptr
    jmp     loop
fim:
    LDS SP
    RET            
  



end
