        ldi 41h
        sta buf
loop0:
        ldi 26
        sta conta

loop:   ldi 2
        trap buf
        lda buf
        add #1
        sta buf

        lda conta
        sub #1
        sta conta
        jnz loop
        
        ldi 2
        trap cr
        ldi 2
        trap lf

        hlt

buf:    ds 1
conta:  ds 1
cr:     db 0dh
lf:     db 0ah

        end 0