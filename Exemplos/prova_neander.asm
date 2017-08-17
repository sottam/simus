;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------

ZERO EQU 123
INDEX EQU 122
X EQU 100
I EQU 120
MIN EQU 121

ORG 100
DB 5
DB 4
DB 1
DB 2
DB 3

ORG 0
LDI 0
STA I
STA ZERO
LDI 127
STA MIN

forinit:
LDI 5
SUB I
JZ forend

forbody:
LDI X
ADD I
STA INDEX
LDA @INDEX
SUB MIN
ADD ZERO
JN process

forcontinue:
LDI 1
ADD I
STA I
JMP forinit

process:
LDA @INDEX
STA MIN
JMP forcontinue

forend:
HLT
