;---------------------------------------------------
; Programa:
; Autor:
; Data:
;---------------------------------------------------
org 100
teste: dw 55AAh, 5501h
ender: dw 0
pc:    dw 0
temp:  ds 1
total: db 0 
contador: db 0

org 0
rotina:  pop
         sta pc
         pop
         sta pc +1
         pop 
         sta ender
         pop
         sta ender+1
inicio:  lda @ender
         sta temp
loop:    lda temp
         or  #0
         jz  cont
         shl 
         sta temp
         jnc  fim
         lda  #1
         add  total 
         sta  total
fim:     jmp loop
cont:    lda ender
         add #1   
         sta ender
         lda contador
         add #1
         sta contador
         sub #4
         jnz inicio   
         lda pc+1
         push 
         lda pc
         push
         lda total
         ret
         nop
main:  lda #0
       push
       lda #teste
       push 
       jsr rotina
       out 0
       hlt
end      main