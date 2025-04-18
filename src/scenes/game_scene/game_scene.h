#ifndef GB_GAME_SCENE_H
#define GB_GAME_SCENE_H

#include <stdint.h>

typedef struct
{
    uint16_t score;
    uint8_t level;
    uint16_t lines;

    uint8_t current_piece;
    uint8_t next_piece;

    uint8_t piece_Xposition, piece_Yposition;

} GameScene;

void InitGameScene(GameScene *p);

void UpdateGameScene(GameScene *p);

void DrawUI(GameScene *p);

void DrawPiece(GameScene *p);

#endif