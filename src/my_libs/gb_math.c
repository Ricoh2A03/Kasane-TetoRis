#include <stdint.h>
#include "gb_math.h"

uint8_t multiplication(uint8_t a, uint8_t b){
    uint8_t original_value = a;
    for (uint8_t i = 0; i < b; i++){
        a += original_value;
        if (i < b){break;}
    }
    return a;
}

// 2D array -> 1D index
// index = (b_index * A_LENGTH) + a_index
// array1D[index]
uint8_t calculateIndex(uint8_t x, uint8_t y, uint8_t size){
    return (multiplication(y, size) + x);
}

// i = row * n + column
