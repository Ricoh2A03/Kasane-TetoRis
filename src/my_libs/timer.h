#ifndef GB_TIMER_H
#define GB_TIMER_H

#include <gb\gb.h>
#include <stdint.h>

typedef struct{
    uint8_t active;
    uint8_t time;
    uint8_t time_frac;
} Timer;

void StartTimer(Timer *p, uint8_t wait_time);

void UpdateTimer(Timer *p);

void PauseTimer(Timer *p);

void ResumeTimer(Timer *p);

uint8_t GetTimerStatus(Timer *p);

uint8_t GetRemainingTime(Timer *p);

#endif
