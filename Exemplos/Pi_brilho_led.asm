;------------------------------
; Programa;
; Autor:
; Data:
;------------------------------
; somente pinos 12 e 33 (fisicos) suportam pwm

; pino desejado = PWM_PIN (wiringpi e gpio pins)
      LDA #PWM_PIN
      STA TRAP_PARAM
; modo PWM
      LDA #PWM_MODE
      STA TRAP_PARAM +1
      LDA #MODO_TRAP
      TRAP TRAP_PARAM
;
; loop de fade in / fade out
LOOP:
      JSR FADEIN
      JSR FADEOUT
      JMP LOOP
;-----------------------------------
FADEIN:
; Valor inicial PWM = 0
      LDA #0
      STA PWM_HIGH
      STA PWM_LOW

LOOPFIN:
; Gera sinal PWM (0 – 1023)
      JSR TRAP_PWM
; lê a parte baixa do PWM
      LDA PWM_LOW
; incrementa de 16 (passo)
      ADD VELFADE
; armazena 8 bits da parte baixa
      STA PWM_LOW
      LDA #0
; se deu carry soma 1 na parte alta
      ADC PWM_HIGH
; armazena 8 bits da parte alta
      STA PWM_HIGH
; se chegou ao final (ou seja 1024)
      SUB #04H
      JNZ LOOPFIN
; retorna
      RET
;-----------------------------------
FADEOUT:
; Valor inicial PWM = 1008
      LDA #03
      STA PWM_HIGH
      LDA #0F0H
      STA PWM_LOW
LOOPFOUT:
; Gera sinal PWM (0 - 1023)
      JSR TRAP_PWM
; Lê da parte baixa do PWM
      LDA PWM_LOW
; Diminui de 16
      SUB VELFADE
; armazena 8 bits da parte baixa
      STA PWM_LOW
; Carrega parte alta
      LDA PWM_HIGH
; Se deu carry subtrai 1 da parte alta
      SBC #0
; armazena 8 bits da parte alta
      STA PWM_HIGH
      JP LOOPFOUT
      JZ LOOPFOUT
; Se for negativo retorna
      RET
;-----------------------------------
TRAP_PWM:
; prepara parametros 
      LDA PWM_LOW
      STA TRAP_PARAM+1
      LDA PWM_HIGH
      STA TRAP_PARAM+2
      LDA #PWM_TRAP
; executa o trap
      TRAP TRAP_PARAM
; espera 20 Milissegundos
      LDA #DELAY_TRAP
      TRAP TIME
      RET
;-----------------------------------
      TIME: DW 1
      VELFADE: DW 8
; área para passar parâmetros do trap
      TRAP_PARAM: DS 3
; Valor do PWM
      PWM_LOW: DB 0FFH
      PWM_HIGH: DB 03H
; pino PWM (1 e 23 que funcionam por hardware)
      PWM_PIN EQU 23
; parâmetro do modo do pino PWM
      PWM_MODE EQU 2
      PWM_TRAP EQU 105
      MODO_TRAP EQU 101
      DELAY_TRAP EQU 5
;
END 0
 
