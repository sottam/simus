ORG 100
TAM_VETOR: DB 10  
END_VETOR: DW VETOR
PARES:     DB  0
IMPARES:   DB  0
VETOR:     DB 1,2,3,4,5,6,7,8,9,10
IND:       DB  0


ORG 0
; Faz a leitura do elemento do vetor
INICIO:  
        LDA  IND
        ADD  #1
        STA  IND
        LDA @END_VETOR
            
; Testa se é par (bit 0=0)

        AND     #1
        JNZ     EHIMPAR
; Se for par, faz pares++
EHPAR:
        LDA     #1
        ADD     PARES
        STA     PARES
        JMP     TESTE
EHIMPAR:
; Se for impar, faz impares++
        LDA     #1
        ADD     IMPARES
        STA     IMPARES
TESTE:   
        LDA     END_VETOR
        ADD     #1
        STA     END_VETOR
        LDA     TAM_VETOR
        SUB     IND
        JP      INICIO
FIM:    HLT
END 0        
