    org 0


inicio:
    ldi gabriel
    sta ptr

    out clearBanner

loop:
    lda @ptr
    or #0
    jz fim

    out banner

    ldi consoleWrite
    trap @ptr

    lda ptr
    add #1
    sta ptr
   
    jmp loop
fim:
    hlt  
    end inicio


gabriel: str "Gabriel P. Silva"
         db 0

ptr:     dw gabriel

;------------------------------------------------------

; constantes de hardware
clearBanner   equ 3
banner        equ 2

; constantes de trap
consoleWrite  equ 2

;------------------------------------------------------

end