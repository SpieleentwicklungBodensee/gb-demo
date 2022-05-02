; --------------------------------------------------------------------------------------------------
; function: waitForVBlank
; do not call while lcd is disabled
; --------------------------------------------------------------------------------------------------
waitForVBlank:

    ei
    halt
    nop
    di

    ret

; --------------------------------------------------------------------------------------------------
; function: vramWriteStart
; disables lcd
; do not call while lcd is disabled
; --------------------------------------------------------------------------------------------------
vramWriteStart:

    call waitForVBlank ; prevents lcd screen damage

    ldh a, [$40]
    and %01111111
    ldh [$40], a

    ret

; --------------------------------------------------------------------------------------------------
; function: vramWriteStop
; enables lcd
; --------------------------------------------------------------------------------------------------
vramWriteStop:

    ldh a, [$40]
    or %10000000
    ldh [$40], a

    ret

; --------------------------------------------------------------------------------------------------
; function: vramInitSome
; --------------------------------------------------------------------------------------------------
vramInitSome:

    ; disable sprites
    ld a, 0
    ld [$fe00+ 0*4], a
    ld [$fe00+ 1*4], a
    ld [$fe00+ 2*4], a
    ld [$fe00+ 3*4], a
    ld [$fe00+ 4*4], a
    ld [$fe00+ 5*4], a
    ld [$fe00+ 6*4], a
    ld [$fe00+ 7*4], a
    ld [$fe00+ 8*4], a
    ld [$fe00+ 9*4], a
    ld [$fe00+10*4], a
    ld [$fe00+11*4], a
    ld [$fe00+12*4], a
    ld [$fe00+13*4], a
    ld [$fe00+14*4], a
    ld [$fe00+15*4], a
    ld [$fe00+16*4], a
    ld [$fe00+17*4], a
    ld [$fe00+18*4], a
    ld [$fe00+19*4], a
    ld [$fe00+20*4], a
    ld [$fe00+21*4], a
    ld [$fe00+22*4], a
    ld [$fe00+23*4], a
    ld [$fe00+24*4], a
    ld [$fe00+25*4], a
    ld [$fe00+26*4], a
    ld [$fe00+27*4], a
    ld [$fe00+28*4], a
    ld [$fe00+29*4], a
    ld [$fe00+30*4], a
    ld [$fe00+31*4], a
    ld [$fe00+32*4], a
    ld [$fe00+33*4], a
    ld [$fe00+34*4], a
    ld [$fe00+35*4], a
    ld [$fe00+36*4], a
    ld [$fe00+37*4], a
    ld [$fe00+38*4], a
    ld [$fe00+39*4], a

    ; set tile palette
    ld a, %11100100
    ldh [$47], a

    ; set sprite palette 1
    ld a, %11100001
    ldh [$48], a

    ; set bg tilemap scrolling
    ld a, 0
    ldh [$43], a ; x
    ld a, 0
    ldh [$42], a ; y

    ;      lcd on: enable later
    ;      |window tilemap select
    ;      ||window on
    ;      |||bg and window pattern select
    ;      ||||bg tilemap select
    ;      |||||8*16 sprite size
    ;      ||||||sprites on
    ;      |||||||bg and window on
    ;      ||||||||
    ld a, %01000111
    ldh [$40], a

    ret

; --------------------------------------------------------------------------------------------------
; function: copyPatterns
; copies "b" * 16 bytes from memory at "hl" to memory at "de"
; --------------------------------------------------------------------------------------------------
copyPatterns:

.morePatterns:
        ld c, 16
.moreBytes:
            ld a, [hl] ; read

            ; "inc hl" replacement to prevent sprite ram bug
            inc l
            jr nz, .notOverflowIncHl
                inc h
.notOverflowIncHl:

            ld [de], a ; write

            ; "inc de" replacement to prevent sprite ram bug
            inc e
            jr nz, .notOverflowIncDe
                inc d
.notOverflowIncDe:

        dec c
        jr nz, .moreBytes
    dec b
    jr nz, .morePatterns

    ret
