;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------


ORG 100 

UM:      DB   1 

VETOR1:  DB   1 ; pos 65 
         DB   2 ; pos 66
         DB   3 ; pos 67 
         DB   4 ; pos 68
         DB   5 ; pos 69
         DB   6 ; pos 6A
         DB   7 ; pos 6B
         DB   8 ; pos 6C
         DB   9 ; pos 6D
         DB   10 ; pos 6E
PTR1:    DS   1 ; pos 6F

ORG 136
VETOR2:  DB   10 ; pos 88 
         DB   20 ; pos 89
         DB   30 ; pos 8A 
         DB   40 ; pos 8B
         DB   50 ; pos 8C
         DB   60 ; pos 8D
         DB   70 ; pos 8E
         DB   80 ; pos 8F
         DB   90 ; pos 90
         DB   100 ; pos 91
PTR2:    DS   1 ; pos 92


COUNT:   DB   10 ; percorrer o vetor[9]
SOMA:    DS   1 ;  pos 94

ORG 160
VETOR3:  DS   1 ; pos A0 
         DS   1 ; pos A1
         DS   1 ; pos A2 
         DS   1 ; pos A3
         DS   1 ; pos A4
         DS   1 ; pos A5
         DS   1 ; pos A6
         DS   1 ; pos A7
         DS   1 ; pos A8
         DS   1 ; pos A9
PTR3:    DS   1 ; pos AA




ORG 0 
MAIN:    LDI  VETOR1  ; passa ender do vetor para o acc
         STA  PTR1  ; passa o valor do acc para a pos de PTR          


         LDI  VETOR2 
         STA  PTR2

         
         LDI  VETOR3
         STA  PTR3
         


PERCORRE1:                
         
         LDA  @PTR1  ; passa pro acc o valor do ender que PTR armazena

         STA  SOMA

         LDA  PTR1  ; 
         ADD  UM    ; guarda proximo indice do vetor
         STA  PTR1  ; 

         JMP PERCORRE2


   
INC:          
         LDA  COUNT
         SUB  UM
         STA  COUNT 

         JNZ  PERCORRE1

HLT

PERCORRE2: 
         LDA  @PTR2    
         ADD  SOMA
         JMP  INSEREV3 
INC2:  
         LDA  PTR2  ; 
         ADD  UM    ; guarda proximo indice do vetor
         STA  PTR2  ; 
         
         JMP  INC
      
INSEREV3:
        STA   @PTR3

        LDA  PTR3  ; 
        ADD  UM    ; guarda proximo indice do vetor
        STA  PTR3  ; 
         
        JMP  INC2
                



