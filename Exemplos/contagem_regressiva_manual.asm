;---------------------------------------------------
; Programa: Contagem regressiva manual
; Autor: Gabriel P. Silva
; Data: 15.09.2003
; Lê o valor das teclas e depois espera a tecla 
; "Entra" ser acionada para decrementar o 
; valor do visor.
;---------------------------------------------------
ORG 0 
STATUS1:
        IN   01               ; Verifica se o valor está pronto
        ADD  #0               ; Soma com o valor 0 
        JZ   STATUS1          ; Enquanto não estiver pronto fica em loop
        IN   00               ; Lê o primeiro valor
        STA  X                ; Armazena o conteúdo na memória
        OUT  00               ; Mostra o valor lido no visor 
STATUS2:
        IN 01
        ADD  #0               ; Soma com o valor 0
        JZ   STATUS2          ; Enquanto não estiver pronto fica em loop 
        LDA  X                ; Lê o ultimo valor armazenado
        SUB  #1               ; Subtrai de um 
        STA  X                ; Armazena
        OUT  00               ; Coloca o resultado no visor
        IN   00               ; Descarta o valor do teclado
        JMP STATUS2           ; Em LOOP para sempre
        END STATUS1           ; Termina o código

        ORG 100
X:      DS  1
