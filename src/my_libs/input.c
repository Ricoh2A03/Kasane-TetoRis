#include <gb\gb.h>
#include <stdint.h>
#include "input.h"

uint8_t pad_prev;
uint8_t pad_curr;

BOOLEAN InputPressed(uint8_t button){
    return (pad_curr && button);
}

BOOLEAN InputJustPressed(uint8_t button){
    return (pad_curr != (pad_prev && button));
}

void InputRead(void){
    pad_prev = pad_curr;
    pad_curr = joypad();
}
