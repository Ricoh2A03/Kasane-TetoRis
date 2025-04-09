#include <gb\gb.h>
#include <gb\hardware.h>
#include <stdint.h>

#include <gb\cgb.h>

#include "my_libs/input.h"
#include "player.h"

const uint16_t myPalette[] = {
    RGB(0, 0, 0),
    RGB(31, 0, 0),
    RGB(0, 31, 0),
    RGB(0, 0, 31),
    RGB(31, 31, 0),
    RGB(0, 31, 31),
    RGB(31, 0, 31),
    RGB(31, 31, 31)
};

uint8_t framecount;

Player player_instance;
Player *player_ptr = &player_instance;

void main(void)
{

    set_bkg_palette(0, 1, myPalette);
    set_sprite_palette(0, 1, myPalette);

    SHOW_BKG;
    SPRITES_8x8;
    SHOW_SPRITES;
    DISPLAY_ON;

    // Loop forever
    while(1) {
        // Game main loop processing goes here
        
        vsync();
        // Vblank logic here
        InputRead();
        framecount = framecount + 1;

    }

}
