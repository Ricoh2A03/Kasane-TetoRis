#ifndef PLAYER_H_GB
#define PLAYER_H_GB

#include <stdint.h>

#include "my_libs/input.h"

typedef struct{
    uint8_t X, Y;
    uint8_t xSub, ySub;

    uint8_t xVelocity, yVelocity;
    uint8_t direction;

    uint8_t currentScreen;

} Player;

void initPlayer(Player *p, uint8_t xPos, uint8_t yPos);

void updatePlayer(Player *p);

void drawPlayer(Player *p);

#endif