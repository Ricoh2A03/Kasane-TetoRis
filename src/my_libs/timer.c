#include <gb\gb.h>
#include <stdint.h>

#include "timer.h"

void StartTimer(Timer *p, uint8_t wait_time){
    p->time = wait_time;
    p->time_frac = 0;
}

void UpdateTimer(Timer *p){
    if (p->active != 0){
        p->time_frac -= 1;
        if (p->time_frac == 0){
            p->time -= 1;
        }
    }
}

void PauseTimer(Timer *p){p->active = 0;}

void ResumeTimer(Timer *p){p->active = 1;}

uint8_t GetTimerStatus(Timer *p){return p->active;}

uint8_t GetRemainingTime(Timer *p){return p->time;}
