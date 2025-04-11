#include <gb/gb.h>
#include <gb/hardware.h>
#include <stdint.h>

#include "my_libs/input.h"

#include "scenes/game_scene/game_scene.h"

// png2asset game_screen_palette_fix.png -o game_screen.c -map -use_map_attributes

uint8_t framecount;

void main(void){

    InitGameScene();

    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;

    // Main loop
    while(1) {

        vsync(); // Vblank
        InputRead();
        framecount = framecount + 1;

    }

}
