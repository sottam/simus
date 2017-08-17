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
    OUT CLEARB
loop:
    lda @ptr
    or #0
    jz fim
    out banner
    lda ptr
    add #1
    sta ptr
    jmp loop
fim:
    LDS SP
    RET            
  



end