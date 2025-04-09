#include <gb/gb.h>
#include <stdint.h>

#include "player.h"
#include "my_libs/input.h"

void initPlayer(Player *p, uint8_t xPos, uint8_t yPos){
    p->X = xPos;
    p->Y = yPos;
    set_sprite_tile(0, 2);
}

void updatePlayer(Player *p){
    if (InputPressed(J_RIGHT)){
        p->direction = 1;
        p->xVelocity = 1;
    }
    else if (InputPressed(J_LEFT)){
        p->direction = 0;
        p->xVelocity = 1;
    }
    else{
        p->xVelocity = 0;
    }

    if (p->direction == 1){
        p->X = p->X + p->xVelocity;
    }
    else if (p->direction == 0){
        p->X = p->X - p->xVelocity;
    }
}

void drawPlayer(Player *p){
    move_sprite(0, p->X, p->Y);
}
