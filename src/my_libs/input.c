#include <gb\gb.h>
#include <stdint.h>
#include "input.h"

uint8_t pad_prev;
uint8_t pad_curr;

BOOLEAN InputPressed(uint8_t button) {
    return ((pad_curr & button) != 0);
}

BOOLEAN InputJustPressed(uint8_t button) {
    return (((pad_curr & button) != 0) && ((pad_prev & button) == 0));
}

void InputRead(void){
    pad_prev = pad_curr;
    pad_curr = joypad();
}
