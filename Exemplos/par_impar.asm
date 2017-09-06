ORG 100
A:       DS  1
PARES:   DS  1
IMPARES: DS  1

ORG 0
; Faz a leitura do painel de chaves
        IN      0
        STA     A
; Testa se é par (bit 0=0)
        LDI     1
        AND     A
        JNZ     SENAO
; Se for, faz pares++
        LDI     1
        ADD     PARES
        STA     PARES
        JMP     FIM
SENAO:
; Incrementa I
        LDI     1
        ADD     IMPARES
        STA     IMPARES
FIM:    HLT
END 0        
