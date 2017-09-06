;---------------------------------------------------
; Programa: Soma dois vetores e coloca o resultado em um terceiro
; Autor: Gabriel P. Silva
; Data: 7/9/2017
;---------------------------------------------------

ORG 100 
COUNT:   DB   10         
SOMA:    DS   1 
VETOR1:  DB   1, 2, 3, 4, 5, 6, 7, 8, 9, 10  
PTR1:    DW   VETOR1 
VETOR2:  DB   10, 20 , 30, 40, 50 , 60 0, 70 , 80, 90, 100       
PTR2:    DW   VETOR2
VETOR3:  DS   10 
PTR3:    DW   VETOR3

ORG 0 
MAIN:           
         
PERCORRE1:                
         LDA  @PTR1  ; passa pro acc o valor do ender que PTR armazena
         STA  SOMA
         LDA  PTR1  ; 
         ADD  #1    ; guarda proximo indice do vetor
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
                



