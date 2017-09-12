
espera: ldi 1
        trap 0
        or #0
        jz espera
        sta letra
loop0:
        ldi 26
        sta conta

loop:   ldi 2
        trap letra
        lda letra
        add #1
        sta letra

        lda conta
        sub #1
        sta conta
        jnz loop
        
        ldi 2
        trap cr
        ldi 2
        trap lf

        hlt

letra:  ds 1
conta:  ds 1
cr:     db 0dh
lf:     db 0ah

        end 0