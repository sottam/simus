;--------------------------------------
;  Ecoa um beep 
;
;--------------------------------------
ORG 0
    LDA #6
    TRAP freq
    NOP
    HLT

freq:   440
dur:    1000
END 0
