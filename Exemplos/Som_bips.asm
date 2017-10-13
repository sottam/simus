loop:
    LDI 6
    TRAP freq
    LDA  freq
    ADD  #10
    STA  freq
    JMP  loop

    NOP
    HLT
freq:   dw 440
dur:    dw 200
