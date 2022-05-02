include "header.asm"
include "helpers.asm"
include "patterns.z80"
include "tilemap.z80"

; variables
frame  equ $c000
sky0X  equ $c001
sky1X  equ $c002
boat0X equ $c003
boat1X equ $c004

; --------------------------------------------------------------------------------------------------
; jump target: main
; --------------------------------------------------------------------------------------------------
main:

    ; init interrupts
    ; for waitForVBlank
    di
    ld a, %00000001 ; ?, ?, ?, ?, joypad, serial, timer, lcdcstatus, vblank
    ldh [$ff], a

    ; init sound
    ; off
    ld a, %00000000
    ldh [$26], a

    ; init graphics
    call vramWriteStart
    call vramInitSome

    ; load tile patterns
    ld b, 58
    ld hl, patterns
    ld de, $9000
    call copyPatterns

    ; load sprite patterns
    ld b, 4
    ld hl, patterns+58*16
    ld de, $8000
    call copyPatterns

    ; load tile map
    ld b, (32*18)/16
    ld hl, tilemap
    ld de, $9800
    call copyPatterns

    ; prepare sprite 0
    ld a, 118
    ld [$fe00+0*4+0], a ; y pos - 16
    ld a, 0
    ld [$fe00+0*4+2], a ; pattern id
    ld a, %00000000
    ld [$fe00+0*4+3], a ; below bg color, y flip, x flip, palette, ?, ?, ?, ?

    ; prepare sprite 1
    ld a, 118+8
    ld [$fe00+1*4+0], a ; y pos - 16
    ld a, 2
    ld [$fe00+1*4+2], a ; pattern id
    ld a, %00000000
    ld [$fe00+1*4+3], a ; below bg color, y flip, x flip, palette, ?, ?, ?, ?

    call vramWriteStop

    ; init variables
    ld a, 0
    ld [frame], a
    ld [sky0X], a
    ld [sky1X], a
    ld a, 100
    ld [boat0X], a
    ld a, 0
    ld [boat1X], a

; --------------------------------------------------------------------------------------------------
; jump target: main loop
; --------------------------------------------------------------------------------------------------
.loop:

    ; wait for next vblank so vram access is possible again
    call waitForVBlank

    ; update sprites
    ld a, [boat0X]
    ld [$fe00+0*4+1], a ; x pos - 8
    sub 8
    ld [$fe00+1*4+1], a ; x pos - 8

    ; prepare next frame
    ld a, [frame]
    inc a
    ld [frame], a

    ld a, [frame]
    and %00000111
    jr nz, .skipChange0
        ld a, [sky0X]
        inc a
        ld [sky0X], a
.skipChange0:

    ld a, [frame]
    and %00000011
    jr nz, .skipChange1
        ld a, [sky1X]
        inc a
        ld [sky1X], a
.skipChange1:

    ld a, [frame]
    and %00000001
    jr nz, .skipChange2
        ld a, [boat0X]
        dec a
        ld [boat0X], a
.skipChange2:

    ld a, [boat1X]
    inc a
    ld [boat1X], a

    ; set x offset for: text
    ld a, 0
    ldh [$43], a

    ; set x offset for: far mountains
    ld h, 56
.waitForScanline0:
        ldh a, [$44]
        cp h
        jr nz, .waitForScanline0
    ld a, [sky0X]
    ldh [$43], a

    ; set x offset for: close mountains
    ld h, 56+16
.waitForScanline1:
        ldh a, [$44]
        cp h
        jr nz, .waitForScanline1
    ld a, [sky1X]
    ldh [$43], a

    ; set x offset for: close boat
    ld h, 56+16+16
.waitForScanline2:
        ldh a, [$44]
        cp h
        jr nz, .waitForScanline2
    ld a, [boat1X]
    ldh [$43], a

    jp .loop

; --------------------------------------------------------------------------------------------------
; interrupt: all
; --------------------------------------------------------------------------------------------------
interrupt:

    ; do nothing

    reti
