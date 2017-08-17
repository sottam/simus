ORG 128
PT_I:     	DW 0
PT_J:     	DW 0
I:        		DB 0
J:        		DS 1
TMP:      	DS 1
	
ORG 160
X:
	DB 6
	DB 2
	DB 20
	DB 3
	DB 10
	DB 5
	DB 60
	DB 4
	DB 8
	DB 120
	
ORG 0
	; MIN = A[0]

        	JMP 	INICIO_I
FOR_I: 	
        	LDA 	I
        	ADD 	#1 
        	STA 	I 
        	LDA 	#8
        	SUB 	I
        	JN  	END  
INICIO_I:
        	LDA 	#X
	ADD 	I 
        	STA 	PT_I
        	LDA 	I
        	ADD 	#1
        	STA 	J
        	JMP 	INICIO_J
FOR_J:   
	LDA 	J
        	ADD 	#1 
        	STA 	J
        	LDA 	#9
        	SUB 	J
        	JN 	END_I
INICIO_J:
        	LDA 	#X
	ADD 	J 
        	STA 	PT_J
COMP:
	LDA 	@PT_I
        	SUB 	@PT_J
        	JN 	END_J	
TROCA:	
	LDA 	@PT_I
	STA 	TMP
        	LDA 	@PT_J
        	STA 	@PT_I
	LDA 	TMP
        	STA 	@PT_J
END_J:  
        	JMP 	FOR_J
END_I:  
        	JMP 	FOR_I
END:
        	HLT
END 0
