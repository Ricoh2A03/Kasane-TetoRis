#ifndef GAME_SCENE_GB_H
#define GAME_SCENE_GB_H

#include <stdint.h>

typedef struct GameScene
{
    uint16_t score;

    uint8_t current_piece;
    uint8_t next_piece;

    uint8_t piece_Xposition;
    uint8_t piece_Yposition;

    const uint8_t pieceI[];

};

void InitGameScene(void);

void UpdateGameScene(void);

void DrawPiece(void);

#endif