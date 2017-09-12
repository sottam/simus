loop:
    ldi 6
    trap freq
    lda  freq
    add  #10
    sta  freq
    jmp  loop 

    nop
    hlt




freq:   dw 440
dur:    dw 100
