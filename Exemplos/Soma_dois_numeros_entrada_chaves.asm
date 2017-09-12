;---------------------------------------------------
; Programa: Soma dois números
; Autor: Gabriel P. Silva
; Data: 15.09.2003
;---------------------------------------------------
STATUS1:
        IN   01               ; Verifica se o valor está pronto
        ADD  ZERO             ; Soma com o valor 0 
        JZ   STATUS1          ; Enquanto não estiver pronto fica em loop
        IN   00               ; Lê o primeiro valor
        STA  X                ; Armazena o conteúdo na memória
        OUT  00               ; Mostra o valor lido no visor 
STATUS2:
        IN 01
        ADD  ZERO             ; Soma com o valor 0
        JZ   STATUS2          ; Enquanto não estiver pronto fica em loop 
        IN   00               ; Lê o segundo valor
        OUT  00               ; Mostra o valor lido no visor 
        ADD  X                ; Soma com o primeiro valor
        STA  X                ; Armazena o resultado na memória
STATUS3:
        IN 01                 ; Espera o pelo teclado
        ADD  ZERO             ; Soma com o valor 0
        JZ   STATUS3          ; Enquanto não estiver pronto fica em loop
        LDA  X                ; Lê o resultado da memória
        OUT  00               ; Exibe no visor
        HLT                   ; Pára
        END STATUS1           ; Termina o código

        ORG 100
A:      DS  1
X:      DS  1
ZERO:   DB  0

        
