;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module game_scene
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _calculateIndex
	.globl _InputJustPressed
	.globl _InputPressed
	.globl _set_sprite_palette
	.globl _set_bkg_palette
	.globl _rand
	.globl _initrand
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _collision_map
	.globl _timer_frac
	.globl _timer
	.globl _InitGameScene
	.globl _UpdateGameScene
	.globl _DrawUI
	.globl _DrawPiece
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_timer::
	.ds 1
_timer_frac::
	.ds 1
_collision_map::
	.ds 180
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
;src/scenes/game_scene/game_scene.c:35: void InitGameScene(GameScene *p){
;	---------------------------------
; Function InitGameScene
; ---------------------------------
_InitGameScene::
;src/scenes/game_scene/game_scene.c:36: initrand(8);  // randomize seed (TODO: make so the seed will be calculated based on the global frame counter and user input)
	push	de
	ld	bc, #0x0008
	push	bc
	call	_initrand
	pop	hl
	pop	de
;src/scenes/game_scene/game_scene.c:38: SCX_REG = 0;  // reset scroll window
	xor	a, a
	ldh	(_SCX_REG + 0), a
;src/scenes/game_scene/game_scene.c:39: SCY_REG = 0;
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/scenes/game_scene/game_scene.c:41: p->score = 0; // set initial score values
	ld	l, e
	ld	h, d
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/scenes/game_scene/game_scene.c:42: p->level = 0;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;src/scenes/game_scene/game_scene.c:43: p->lines = 0;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;src/scenes/game_scene/game_scene.c:45: p->next_piece = rand();
	ld	hl, #0x0006
	add	hl, de
	push	hl
	push	de
	call	_rand
	ld	a, e
	pop	de
	pop	hl
	ld	(hl), a
;src/scenes/game_scene/game_scene.c:47: timer = FALL_TIMER;
	ld	hl, #_timer
	ld	(hl), #0x10
;src/scenes/game_scene/game_scene.c:48: timer_frac = FALL_TIMER_FRAC;
	ld	hl, #_timer_frac
	ld	(hl), #0x04
;src/scenes/game_scene/game_scene.c:50: p->piece_Xposition = 32; // default piece position
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x20
;src/scenes/game_scene/game_scene.c:51: p->piece_Yposition = 0;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x00
;src/scenes/game_scene/game_scene.c:53: set_bkg_palette(0, game_scene_PALETTE_COUNT, game_scene_palettes); // load palette
	ld	de, #_game_scene_palettes
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/scenes/game_scene/game_scene.c:54: set_bkg_data(0, game_scene_TILE_COUNT, game_scene_tiles);          // load bg tiles
	ld	de, #_game_scene_tiles
	push	de
	ld	hl, #0x5500
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/scenes/game_scene/game_scene.c:55: set_bkg_tiles(0, 0, 20, 18, game_scene_map);                       // load tilemap
	ld	de, #_game_scene_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/scenes/game_scene/game_scene.c:56: set_bkg_attributes(0, 0, 20, 18, game_scene_map_attributes);       // set tilemap color attributes
;c:\gbdk\include\gb\gb.h:1226: VBK_REG = VBK_ATTRIBUTES;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;c:\gbdk\include\gb\gb.h:1227: set_bkg_tiles(x, y, w, h, tiles);
	ld	de, #_game_scene_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;c:\gbdk\include\gb\gb.h:1228: VBK_REG = VBK_TILES;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/scenes/game_scene/game_scene.c:58: set_sprite_data(0, tetramino_graphic_TILE_COUNT, tetramino_graphic_tiles);          // load tetromino tile into VRAM
	ld	de, #_tetramino_graphic_tiles
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_data
	add	sp, #4
;src/scenes/game_scene/game_scene.c:59: set_sprite_palette(0, tetramino_graphic_PALETTE_COUNT, tetramino_graphic_palettes); // load sprite palette
	ld	de, #_tetramino_graphic_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_palette
	add	sp, #4
;src/scenes/game_scene/game_scene.c:60: }
	ret
;src/scenes/game_scene/game_scene.c:62: void UpdateGameScene(GameScene *p){
;	---------------------------------
; Function UpdateGameScene
; ---------------------------------
_UpdateGameScene::
;src/scenes/game_scene/game_scene.c:63: if ( InputJustPressed(J_RIGHT) && (p->piece_Xposition < RIGHT_BORDER - 24) ){
	push	de
	ld	a, #0x01
	call	_InputJustPressed
	ld	c, a
	pop	de
	ld	hl, #0x0007
	add	hl, de
	ld	a, c
	or	a, a
	jr	Z, 00102$
	ld	a, (hl)
	cp	a, #0x40
	jr	NC, 00102$
;src/scenes/game_scene/game_scene.c:64: p->piece_Xposition += 8;}
	add	a, #0x08
	ld	(hl), a
00102$:
;src/scenes/game_scene/game_scene.c:65: if ( InputJustPressed(J_LEFT) && (p->piece_Xposition > LEFT_BORDER) ){
	push	hl
	push	de
	ld	a, #0x02
	call	_InputJustPressed
	pop	de
	pop	hl
	or	a, a
	jr	Z, 00105$
	ld	c, (hl)
	ld	a, #0x08
	sub	a, c
	jr	NC, 00105$
;src/scenes/game_scene/game_scene.c:66: p->piece_Xposition -= 8;}
	ld	a, c
	add	a, #0xf8
	ld	(hl), a
00105$:
;src/scenes/game_scene/game_scene.c:68: if ( InputJustPressed(J_UP) ){
	push	de
	ld	a, #0x04
	call	_InputJustPressed
	ld	c, a
	pop	de
;src/scenes/game_scene/game_scene.c:69: p->piece_Yposition = 0;
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
;src/scenes/game_scene/game_scene.c:68: if ( InputJustPressed(J_UP) ){
	ld	a, c
	or	a, a
	jr	Z, 00108$
;src/scenes/game_scene/game_scene.c:69: p->piece_Yposition = 0;
	xor	a, a
	ld	(de), a
;src/scenes/game_scene/game_scene.c:70: collision_map[calculateIndex(0, 0, GAME_FIELD_LENGTH)] = 1;
	push	de
	ld	a, #0xb4
	push	af
	inc	sp
	xor	a, a
	ld	e, a
	call	_calculateIndex
	pop	de
	add	a, #<(_collision_map)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x00
	adc	a, #>(_collision_map)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(hl), #0x01
00108$:
;src/scenes/game_scene/game_scene.c:74: timer_frac -= 1;
	ld	hl, #_timer_frac
;src/scenes/game_scene/game_scene.c:75: if (timer_frac == 0) {
	dec	(hl)
	jr	NZ, 00110$
;src/scenes/game_scene/game_scene.c:76: timer -= 1;
	ld	hl, #_timer
	dec	(hl)
;src/scenes/game_scene/game_scene.c:78: timer_frac = FALL_TIMER_FRAC;
	ld	hl, #_timer_frac
	ld	(hl), #0x04
00110$:
;src/scenes/game_scene/game_scene.c:82: if (timer == 0) {
	ld	a, (#_timer)
	or	a, a
	ret	NZ
;src/scenes/game_scene/game_scene.c:83: if (p->piece_Yposition < SCREEN_HEIGHT - 16){
	ld	a, (de)
	sub	a, #0x80
	jr	NC, 00114$
;src/scenes/game_scene/game_scene.c:84: if (!InputPressed(J_DOWN)){
	push	de
	ld	a, #0x08
	call	_InputPressed
	pop	de
	or	a, a
	jr	NZ, 00114$
;src/scenes/game_scene/game_scene.c:85: p->piece_Yposition += 8;
	ld	a, (de)
	add	a, #0x08
	ld	(de), a
00114$:
;src/scenes/game_scene/game_scene.c:91: timer = FALL_TIMER; // сброс основного таймера
	ld	hl, #_timer
	ld	(hl), #0x10
;src/scenes/game_scene/game_scene.c:94: }
	ret
;src/scenes/game_scene/game_scene.c:96: void DrawUI(GameScene *p){
;	---------------------------------
; Function DrawUI
; ---------------------------------
_DrawUI::
	dec	sp
	dec	sp
;src/scenes/game_scene/game_scene.c:97: if (p->score < 10){
	ld	c,e
	ld	b,d
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	pop	de
	push	de
	ld	a, e
	sub	a, #0x0a
	ld	a, d
	sbc	a, #0x00
	jr	NC, 00102$
;src/scenes/game_scene/game_scene.c:98: set_bkg_tile_xy(19, 1, p->score);}
	dec	hl
	ld	a, (hl)
	push	bc
	push	af
	inc	sp
	ld	e, #0x01
	ld	a, #0x13
	call	_set_bkg_tile_xy
	pop	bc
00102$:
;src/scenes/game_scene/game_scene.c:100: if (p->level < 10){
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	cp	a, #0x0a
	jr	NC, 00104$
;src/scenes/game_scene/game_scene.c:101: set_bkg_tile_xy(19, 2, p->level);}
	push	bc
	push	af
	inc	sp
	ld	e, #0x02
	ld	a, #0x13
	call	_set_bkg_tile_xy
	pop	bc
00104$:
;src/scenes/game_scene/game_scene.c:103: if (p->lines <10){
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
	ld	e, b
	ld	d, c
	ld	a, e
	sub	a, #0x0a
	ld	a, d
	sbc	a, #0x00
	jr	NC, 00106$
;src/scenes/game_scene/game_scene.c:104: set_bkg_tile_xy(19, 3, p->lines);}
	push	bc
	inc	sp
	ld	e, #0x03
	ld	a, #0x13
	call	_set_bkg_tile_xy
00106$:
;src/scenes/game_scene/game_scene.c:106: if (collision_map[0] != 0){
	ld	a, (#_collision_map + 0)
	or	a, a
	jr	Z, 00109$
;src/scenes/game_scene/game_scene.c:107: set_bkg_tile_xy(1, 0, 5);
	ld	a, #0x05
	push	af
	inc	sp
	ld	e, #0x00
	ld	a, #0x01
	call	_set_bkg_tile_xy
00109$:
;src/scenes/game_scene/game_scene.c:110: }
	inc	sp
	inc	sp
	ret
;src/scenes/game_scene/game_scene.c:112: void DrawPiece(GameScene *p){
;	---------------------------------
; Function DrawPiece
; ---------------------------------
_DrawPiece::
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
;src/scenes/game_scene/game_scene.c:113: if(p->current_piece == 0){ // J piece
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ, 00111$
;c:\gbdk\include\gb\gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;src/scenes/game_scene/game_scene.c:117: move_sprite(0, p->piece_Xposition + SPRITE_X_OFFSET, p->piece_Yposition + SPRITE_Y_OFFSET);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x10
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:\gbdk\include\gb\gb.h:1962: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(bc), a
;c:\gbdk\include\gb\gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x00
;src/scenes/game_scene/game_scene.c:120: move_sprite(1, p->piece_Xposition + SPRITE_X_OFFSET, p->piece_Yposition + SPRITE_Y_OFFSET + 8);
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x18
	ld	b, a
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x08
	ld	c, a
;c:\gbdk\include\gb\gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:\gbdk\include\gb\gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;c:\gbdk\include\gb\gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x00
;src/scenes/game_scene/game_scene.c:123: move_sprite(2, p->piece_Xposition + SPRITE_X_OFFSET + 8, p->piece_Yposition + SPRITE_Y_OFFSET + 8);
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x18
	ld	b, a
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x10
	ld	c, a
;c:\gbdk\include\gb\gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;c:\gbdk\include\gb\gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;c:\gbdk\include\gb\gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x00
;src/scenes/game_scene/game_scene.c:126: move_sprite(3, p->piece_Xposition + SPRITE_X_OFFSET + 16, p->piece_Yposition + SPRITE_Y_OFFSET + 8);
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x18
	ld	b, a
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x18
	ld	c, a
;c:\gbdk\include\gb\gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;c:\gbdk\include\gb\gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/scenes/game_scene/game_scene.c:126: move_sprite(3, p->piece_Xposition + SPRITE_X_OFFSET + 16, p->piece_Yposition + SPRITE_Y_OFFSET + 8);
00111$:
;src/scenes/game_scene/game_scene.c:128: }
	add	sp, #8
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
