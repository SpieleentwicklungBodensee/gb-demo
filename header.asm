section "rom", home

    ; $0000
    ret
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret
    nop
    nop
    nop
    nop
    nop
    nop
    nop

    ; $0040
    jp interrupt
    nop
    nop
    nop
    nop
    nop
    jp interrupt
    nop
    nop
    nop
    nop
    nop
    jp interrupt
    nop
    nop
    nop
    nop
    nop
    jp interrupt
    nop
    nop
    nop
    nop
    nop
    jp interrupt
    nop
    nop
    nop
    nop
    nop
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0,0,0,0,0,0,0,0,0
    db 0,0

    ; $0100
    nop
    jp main
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db "SBO DEMO   " ; <-------------------------------------- title
    db 0,0,0,0
    db $00
    db "NA"
    db $00
    db $00
    db $00
    db $00
    db $01
    db $33
    db $00 ; <------------------------------------------------ version
    db $ff
    dw $ffff
