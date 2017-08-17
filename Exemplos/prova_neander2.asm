ORG 080H 
P:  		DB 090H
AUX: 		DB 0 

ORG  090H
X:  		DB  1
     		DB  2
     		DB  9
     		DB  4
     		DB  5

ORG 0H
 INICIO:    	LDA 	@I 
     		STA 	AUX
     		LDI 	1
     		ADD	P
     		STA 	P
     		LDA 	@P
LOOP:   	SUB 	AUX
     		JN 	PULO 
     		LDA 	@P
     		STA 	AUX
PULO:   	LDI 	1
     		ADD 	P 
     		STA 	P 
     		LDA 	@P 
     		JNZ 	LOOP 
     		HLT

