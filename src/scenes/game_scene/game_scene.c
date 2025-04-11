#include <gb/gb.h>
#include <gb/hardware.h>
#include <stdint.h>

#include "game_scene.h"
#include "game_scene_TMP.h"

#include "../../sprite_gfx/tetramino_graphic.h"

void InitGameScene(void){
    set_bkg_palette(0, game_scene_PALETTE_COUNT, game_scene_palettes);
    set_bkg_data(0, game_scene_TILE_COUNT, game_scene_tiles);
    set_bkg_tiles(0, 0, 20, 18, game_scene_map);
    set_bkg_attributes(0, 0, 20, 18, game_scene_map_attributes);

    set_sprite_data(0, tetramino_graphic_TILE_COUNT, tetramino_graphic_tiles);
    set_sprite_palette(0, tetramino_graphic_PALETTE_COUNT, tetramino_graphic_palettes);
}

void UpdateGameScene(void){

}

void DrawPiece(void){

}