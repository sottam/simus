;---------------------------------------------------
; Programa: Testa PWM
; Autor: Alonso Matos
; Data: 30/08/2017
;---------------------------------------------------
    
    LDA #1
    STA PIN_TRAP
    LDA #2
    STA PIN_TRAP + 1
    LDA #101
    TRAP PIN_TRAP
    
    LDA #1
    STA PIN_TRAP
    LDA #128
    STA PIN_TRAP + 1
    LDA #105
    TRAP PIN_TRAP



PIN_TRAP DS 3








