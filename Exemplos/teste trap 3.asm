     ldi 3
     trap buf
     hlt      





      org 50h
buf:  db 70   ; tamanho do buffer 
      ds 70