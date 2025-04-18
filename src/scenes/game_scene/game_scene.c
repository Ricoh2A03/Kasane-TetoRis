#include <gb/gb.h>
#include <gb/hardware.h>
#include <stdint.h>
#include <rand.h>

#include "game_scene.h"
#include "game_scene_TMP.h"
#include "../../sprite_gfx/tetramino_graphic.h"

#include "../../my_libs/input.h"
#include "../../my_libs/gb_math.h"

#define SCREEN_WIDTH        160
#define SCREEN_HEIGHT       144

#define SCREEN_WIDTH_TILES  20
#define SCREEN_HEIGHT_TILES 18

#define LEFT_BORDER         8
#define RIGHT_BORDER        88

#define SPRITE_X_OFFSET     8
#define SPRITE_Y_OFFSET     16

#define FALL_TIMER          16
#define FALL_TIMER_FRAC     4

#define GAME_FIELD_WIDTH    10
#define GAME_FIELD_LENGTH   180

uint8_t timer, timer_frac;

uint8_t collision_map[GAME_FIELD_LENGTH];

void InitGameScene(GameScene *p){
    initrand(8);  // randomize seed (TODO: make so the seed will be calculated based on the global frame counter and user input)

    SCX_REG = 0;  // reset scroll window
    SCY_REG = 0;

    p->score = 0; // set initial score values
    p->level = 0;
    p->lines = 0;

    p->next_piece = rand();

    timer = FALL_TIMER;
    timer_frac = FALL_TIMER_FRAC;

    p->piece_Xposition = 32; // default piece position
    p->piece_Yposition = 0;

    set_bkg_palette(0, game_scene_PALETTE_COUNT, game_scene_palettes); // load palette
    set_bkg_data(0, game_scene_TILE_COUNT, game_scene_tiles);          // load bg tiles
    set_bkg_tiles(0, 0, 20, 18, game_scene_map);                       // load tilemap
    set_bkg_attributes(0, 0, 20, 18, game_scene_map_attributes);       // set tilemap color attributes

    set_sprite_data(0, tetramino_graphic_TILE_COUNT, tetramino_graphic_tiles);          // load tetromino tile into VRAM
    set_sprite_palette(0, tetramino_graphic_PALETTE_COUNT, tetramino_graphic_palettes); // load sprite palette
}

void UpdateGameScene(GameScene *p){
    if ( InputJustPressed(J_RIGHT) && (p->piece_Xposition < RIGHT_BORDER - 24) ){
        p->piece_Xposition += 8;}
    if ( InputJustPressed(J_LEFT) && (p->piece_Xposition > LEFT_BORDER) ){
        p->piece_Xposition -= 8;}

    if ( InputJustPressed(J_UP) ){
        p->piece_Yposition = 0;
        collision_map[calculateIndex(0, 0, GAME_FIELD_LENGTH)] = 1;
    }

    // Обновляем таймер-фракцию каждый кадр
    timer_frac -= 1;
    if (timer_frac == 0) {
        timer -= 1;
        // Сбрасываем timer_frac до начального значения
        timer_frac = FALL_TIMER_FRAC;
    }

    // Если основной таймер достиг 0, выполняем падение и сбрасываем основной таймер
    if (timer == 0) {
        if (p->piece_Yposition < SCREEN_HEIGHT - 16){
            if (!InputPressed(J_DOWN)){
                p->piece_Yposition += 8;
            }
            else{
                //p->piece_Yposition += 16;
            }
        }
        timer = FALL_TIMER; // сброс основного таймера
    }

}

void DrawUI(GameScene *p){
    if (p->score < 10){
        set_bkg_tile_xy(19, 1, p->score);}

    if (p->level < 10){
        set_bkg_tile_xy(19, 2, p->level);}

    if (p->lines <10){
        set_bkg_tile_xy(19, 3, p->lines);}

    if (collision_map[0] != 0){
        set_bkg_tile_xy(1, 0, 5);
    }
    
}

void DrawPiece(GameScene *p){
    if(p->current_piece == 0){ // J piece
      /*0
        000*/
        set_sprite_tile(0, 0);
        move_sprite(0, p->piece_Xposition + SPRITE_X_OFFSET, p->piece_Yposition + SPRITE_Y_OFFSET);

        set_sprite_tile(1, 0);
        move_sprite(1, p->piece_Xposition + SPRITE_X_OFFSET, p->piece_Yposition + SPRITE_Y_OFFSET + 8);

        set_sprite_tile(2, 0);
        move_sprite(2, p->piece_Xposition + SPRITE_X_OFFSET + 8, p->piece_Yposition + SPRITE_Y_OFFSET + 8);

        set_sprite_tile(3, 0);
        move_sprite(3, p->piece_Xposition + SPRITE_X_OFFSET + 16, p->piece_Yposition + SPRITE_Y_OFFSET + 8);
    }
}
