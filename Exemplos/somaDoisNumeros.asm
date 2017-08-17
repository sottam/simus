    org 0
    lda a
    add b
    sta c
    lda #a
    lda @a
    ldi b
    lds #b
    sts C
    sts @C
    hlt

    org 20h
a:  db 200
b:  db 50
c:  ds 2
    end 0