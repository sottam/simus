;---------------------------------------------------
; Programa: Contagem regressiva
; Autor: Gabriel P. Silva
; Data: 16.09.2003
;---------------------------------------------------
ORG 0 
STATUS1:
        IN   01               ; Verifica se o valor está pronto
        ADD  ZERO             ; Soma com o valor 0 
        JZ   STATUS1          ; Enquanto não estiver pronto fica em loop
        IN   00               ; Lê o primeiro valor
LOOP:   STA  X                ; Armazena o conteúdo na memória
        OUT  00               ; Mostra o valor lido no visor 
        LDA  X                ; Lê o ultimo valor armazenado
        NOT                   ; Complementa a um
        SUB  #1               ; Subtrai 
        JMP  LOOP             ; Em LOOP para sempre
        END STATUS1           ; Termina o código

        ORG 100
X:      DS  1
ZERO:   DB  0
