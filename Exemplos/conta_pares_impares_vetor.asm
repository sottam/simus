ORG 100

; Declaração das variáveis do programa principal
TAM_VETOR:   	DB	10  
END_VETOR:   	DW	VETOR
PARES:       	DB	0
IMPARES:     	DB	0
VETOR:       	DB 	1,2,3,4,5,6,7,8,9,10
CONT:        	DB  	0
STR_PARES:   	STR 	"Pares:"
             	DB 	0
STR_IMPARES: 	STR 	" Impares:"
             	DB 	0

ORG 0

; Faz a leitura de um elemento do vetor e incrementa o contador
INICIO:  
	LDA  	CONT
        ADD  	#1
        STA  	CONT
        LDA 	@END_VETOR
            
; Testa se é par (bit 0=0)
        AND     #1
        JNZ     EHIMPAR

; Se for par, faz pares++
EHPAR:
        LDA     #1
        ADD     PARES
        STA     PARES
        JMP     TESTE

; Se for impar, faz impares++
EHIMPAR:
        LDA     #1
        ADD     IMPARES
        STA     IMPARES

; Incrementa o apontador e verifica se o loop acabou
TESTE:   
        LDA     END_VETOR
        ADD     #1
        STA     END_VETOR
        LDA     TAM_VETOR
        SUB     CONT           
        JP      INICIO

; Coloca o endereço da string na pilha e chama a rotina de impressão
FIM:    LDA     #00  
        PUSH
        LDA     #STR_PARES
        PUSH
        JSR     ROTINA

; Macete para imprimir o número em decimal (0-9)
        LDA     PARES 
        ADD     #30H
        OUT     BANNER

; Coloca o endereço da string na pilha e chama a rotina de impressão
        LDA     #00  
        PUSH
        LDA     #STR_IMPARES
        PUSH
        JSR     ROTINA

; Macete para imprimir o número em decimal (0-9)
        LDA     IMPARES 
        ADD     #30H
        OUT     BANNER
        HLT
END     0        
;------------------------------------------------------
; Rotina para impressão de uma string no banner
; Declaração das variáveis da rotina

ORG  200
SP:    	DW   	0    	; Guarda o valor do stack pointer
PTR:  	DW     	0	; Ponteiro com o endereço da string a ser impressa


; Constantes de hardware
CLEARB  EQU 3
BANNER  EQU 2
;------------------------------------------------------

ROTINA:
    	STS     SP  	; Salva ovalor atual do sp
    	POP
    	POP          	; Descarta as primeiras duas posiçoes da pilha
    	POP            	; Tira a parte baixa do endereco da string
        STA 	PTR    	; Salva na parte baixa do ponteiro
    	POP
    	STA     PTR+1   ; Salva na parte alta do ponteiro
    	OUT 	CLEARB  ; Limpa o Banner
LOOP:
    	LDA 	@PTR	; Le o caractere
    	OR 	#0      ; É NULL?
    	JZ  	RETORNA	; Se for retorna
    	OUT 	BANNER  ; Imprime o caractere no banner
    	LDA	PTR	; Incrementa o ponteiro
    	ADD 	#1
    	STA 	PTR
    	JMP	LOOP	; Volta para o inicio

RETORNA:
    	LDS SP		; Restaura o Stack Pointer
    	RET		; Retorna