#include <gb/gb.h>
#include <gb/hardware.h>
#include <stdint.h>

#include "globals.h"
#include "my_libs/input.h"

#include "scenes/game_scene/game_scene.h"

// png2asset game_screen_palette_fix.png -o game_screen.c -map -use_map_attributes

GameScene scn_game;

void main(void){
    
    NR52_REG = 0x80; // Master sound on
    NR50_REG = 0xFF; // Maximum volume for left/right speakers
    NR51_REG = 0xFF; // Turn on sound fully
    
    current_game_state = 0;

    InitGameScene(&scn_game);

    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;

    // Main loop
    while(1) {

        if(current_game_state != 1){
            if (InputJustPressed(J_START)){
                current_game_state = 1;
            }
        }

        if(current_game_state == 1){
            UpdateGameScene(&scn_game);
        }

        vsync(); // Vblank

        if(current_game_state == 1){
            DrawUI(&scn_game);
            DrawPiece(&scn_game);
        }

        InputRead();

    }

}
