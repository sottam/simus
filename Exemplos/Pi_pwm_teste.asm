;---------------------------------------------------
; Programa: Testa PWM
; Autor: Alonso Matos
; Data: 30/08/2017
;---------------------------------------------------
ORG 0
;inicializa pino como pwm
    LDA #1
    STA PIN_TRAP
    LDA #2
    STA PIN_TRAP + 1
    LDA #101
    TRAP PIN_TRAP
;seta duty cycle em 128
    LDA #1
    STA PIN_TRAP
    LDA #128
    STA PIN_TRAP + 1
    LDA #105
    TRAP PIN_TRAP

    HLT



PIN_TRAP: DS 3








