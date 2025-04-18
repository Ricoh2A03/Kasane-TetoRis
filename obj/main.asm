;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _DrawPiece
	.globl _DrawUI
	.globl _UpdateGameScene
	.globl _InitGameScene
	.globl _InputRead
	.globl _InputJustPressed
	.globl _vsync
	.globl _scn_game
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_scn_game::
	.ds 9
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
;src/main.c:14: void main(void){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:16: NR52_REG = 0x80; // Master sound on
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:17: NR50_REG = 0xFF; // Maximum volume for left/right speakers
	ld	a, #0xff
	ldh	(_NR50_REG + 0), a
;src/main.c:18: NR51_REG = 0xFF; // Turn on sound fully
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:20: current_game_state = 0;
	ld	hl, #_current_game_state
	ld	(hl), #0x00
;src/main.c:22: InitGameScene(&scn_game);
	ld	de, #_scn_game
	call	_InitGameScene
;src/main.c:24: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:25: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:26: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:29: while(1) {
00110$:
;src/main.c:31: if(current_game_state != 1){
	ld	a, (#_current_game_state)
	dec	a
	jr	Z, 00104$
;src/main.c:32: if (InputJustPressed(J_START)){
	ld	a, #0x80
	call	_InputJustPressed
	or	a, a
	jr	Z, 00104$
;src/main.c:33: current_game_state = 1;
	ld	hl, #_current_game_state
	ld	(hl), #0x01
00104$:
;src/main.c:37: if(current_game_state == 1){
	ld	a, (#_current_game_state)
	dec	a
	jr	NZ, 00106$
;src/main.c:38: UpdateGameScene(&scn_game);
	ld	de, #_scn_game
	call	_UpdateGameScene
00106$:
;src/main.c:41: vsync(); // Vblank
	call	_vsync
;src/main.c:43: if(current_game_state == 1){
	ld	a, (#_current_game_state)
	dec	a
	jr	NZ, 00108$
;src/main.c:44: DrawUI(&scn_game);
	ld	de, #_scn_game
	call	_DrawUI
;src/main.c:45: DrawPiece(&scn_game);
	ld	de, #_scn_game
	call	_DrawPiece
00108$:
;src/main.c:48: InputRead();
	call	_InputRead
;src/main.c:52: }
	jr	00110$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
