;---------------------------------------------------
; Programa: Crossfade RGB LED Arduino
; Autor: Alonso Matos
; Data: 14/10/17
;---------------------------------------------------
;O LED deve estar conectado em 3 pinos PWM-capable do
;Arduino. Neste programa iremos utilizar os pinos 9,
;10 e 11.
;PINOS
P_RED:     DS 3
P_GREEN:   DS 3
P_BLUE:    DS 3
;VALORES (255 = APAGADO 0 = ACESO MAX)
V_RED:     DB 255
V_GREEN:   DB 255
V_BLUE:    DB 255

PINMDE:    DB 201
PWMMDE:    DB 3
ANGWRT:    DB 205
SLEEP:     DB 5
TEMPO:     DW 1

CONTROLE:  DB 0

ORG 50
     LDA #9
     STA P_RED

     LDA #10
     STA P_GREEN

     LDA #11
     STA P_BLUE

     LDA PWMMDE
     STA P_RED +1
     LDA PINMDE
     TRAP P_RED

     LDA PWMMDE
     STA P_GREEN +1
     LDA PINMDE
     TRAP P_GREEN

     LDA PWMMDE
     STA P_BLUE +1
     LDA PINMDE
     TRAP P_BLUE

MAINLOOP:
     LDA #0
     STA V_GREEN
     STA V_BLUE
     LDA #255
     STA V_RED

     LDA #255  ;COMECA COM 255 E VAI SUBTRAINDO
     STA CONTROLE

     LOOP1:
     LDA #1
     ADD V_GREEN
     STA V_GREEN

     LDA V_RED
     SUB #1
     STA V_RED

     LDA #255
     SUB V_GREEN
     STA P_GREEN + 1
     LDA ANGWRT
     TRAP P_GREEN

     LDA #255
     SUB V_RED
     STA P_RED + 1
     LDA ANGWRT
     TRAP P_RED

     LDA SLEEP
     TRAP TEMPO

     LDA CONTROLE
     SUB #1
     STA CONTROLE

     JNZ LOOP1 ;FIM DO PRIMEIRO LOOP

     LDA #0
     STA V_RED
     STA V_BLUE
     LDA #255
     STA V_GREEN

     LDA #255  ;COMECA COM 255 E VAI SUBTRAINDO
     STA CONTROLE

     LOOP2:
     LDA #1
     ADD V_BLUE
     STA V_BLUE

     LDA V_GREEN
     SUB #1
     STA V_GREEN

     LDA #255
     SUB V_BLUE
     STA P_BLUE + 1
     LDA ANGWRT
     TRAP P_BLUE

     LDA #255
     SUB V_GREEN
     STA P_GREEN + 1
     LDA ANGWRT
     TRAP P_GREEN

     LDA SLEEP
     TRAP TEMPO

     LDA CONTROLE
     SUB #1
     STA CONTROLE

     JNZ LOOP2 ;FIM DO SEGUNDO LOOP

     LDA #0
     STA V_RED
     STA V_GREEN
     LDA #255
     STA V_BLUE

     LDA #255  ;COMECA COM 255 E VAI SUBTRAINDO
     STA CONTROLE

     LOOP3:
     LDA #1
     ADD V_RED
     STA V_RED

     LDA V_BLUE
     SUB #1
     STA V_BLUE

     LDA #255
     SUB V_RED
     STA P_RED + 1
     LDA ANGWRT
     TRAP P_RED

     LDA #255
     SUB V_BLUE
     STA P_BLUE + 1
     LDA ANGWRT
     TRAP P_BLUE

     LDA SLEEP
     TRAP TEMPO

     LDA CONTROLE
     SUB #1
     STA CONTROLE

     JNZ LOOP3

     JMP MAINLOOP

     HLT
END 50







