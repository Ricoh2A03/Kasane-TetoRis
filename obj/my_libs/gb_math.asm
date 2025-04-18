;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module gb_math
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _multiplication
	.globl _calculateIndex
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/my_libs/gb_math.c:4: uint8_t multiplication(uint8_t a, uint8_t b){
;	---------------------------------
; Function multiplication
; ---------------------------------
_multiplication::
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;src/my_libs/gb_math.c:5: uint8_t original_value = a;
	ld	c, l
;src/my_libs/gb_math.c:6: for (uint8_t i = 0; i < b; i++){
	ld	b, #0x00
00105$:
	ld	a, b
	sub	a, e
	ld	a, #0x00
	rla
	ld	d, a
	or	a, a
	jr	Z, 00103$
;src/my_libs/gb_math.c:7: a += original_value;
	add	hl, bc
;src/my_libs/gb_math.c:8: if (i < b){break;}
	ld	a, d
	or	a, a
	jr	NZ, 00103$
;src/my_libs/gb_math.c:6: for (uint8_t i = 0; i < b; i++){
	inc	b
	jr	00105$
00103$:
;src/my_libs/gb_math.c:10: return a;
	ld	a, l
;src/my_libs/gb_math.c:11: }
	ret
;src/my_libs/gb_math.c:16: uint8_t calculateIndex(uint8_t x, uint8_t y, uint8_t size){
;	---------------------------------
; Function calculateIndex
; ---------------------------------
_calculateIndex::
	ld	c, a
	ld	b, e
;src/my_libs/gb_math.c:17: return (multiplication(y, size) + x);
	push	bc
	ldhl	sp,	#4
	ld	e, (hl)
	ld	a, b
	call	_multiplication
	pop	bc
	add	a, c
;src/my_libs/gb_math.c:18: }
	pop	hl
	inc	sp
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
