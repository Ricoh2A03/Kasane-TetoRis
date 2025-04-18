;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module input
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _joypad
	.globl _pad_curr
	.globl _pad_prev
	.globl _InputPressed
	.globl _InputJustPressed
	.globl _InputRead
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_pad_prev::
	.ds 1
_pad_curr::
	.ds 1
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
;src/my_libs/input.c:8: BOOLEAN InputPressed(uint8_t button) {
;	---------------------------------
; Function InputPressed
; ---------------------------------
_InputPressed::
;src/my_libs/input.c:9: return ((pad_curr & button) != 0);
	ld	hl, #_pad_curr
	and	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	xor	a, #0x01
;src/my_libs/input.c:10: }
	ret
;src/my_libs/input.c:12: BOOLEAN InputJustPressed(uint8_t button) {
;	---------------------------------
; Function InputJustPressed
; ---------------------------------
_InputJustPressed::
	ld	c, a
;src/my_libs/input.c:13: return (((pad_curr & button) != 0) && ((pad_prev & button) == 0));
	ld	a, (#_pad_curr)
	and	a,c
	jr	Z, 00103$
	ld	a, (#_pad_prev)
	and	a,c
	jr	Z, 00104$
00103$:
	xor	a, a
	ret
00104$:
	ld	a, #0x01
;src/my_libs/input.c:14: }
	ret
;src/my_libs/input.c:16: void InputRead(void){
;	---------------------------------
; Function InputRead
; ---------------------------------
_InputRead::
;src/my_libs/input.c:17: pad_prev = pad_curr;
	ld	a, (#_pad_curr)
	ld	(#_pad_prev),a
;src/my_libs/input.c:18: pad_curr = joypad();
	call	_joypad
	ld	(#_pad_curr),a
;src/my_libs/input.c:19: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
