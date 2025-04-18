;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module timer
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _StartTimer
	.globl _UpdateTimer
	.globl _PauseTimer
	.globl _ResumeTimer
	.globl _GetTimerStatus
	.globl _GetRemainingTime
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/my_libs/timer.c:6: void StartTimer(Timer *p, uint8_t wait_time){
;	---------------------------------
; Function StartTimer
; ---------------------------------
_StartTimer::
;src/my_libs/timer.c:7: p->time = wait_time;
	ld	c, e
	ld	b, d
	inc	bc
	ld	(bc), a
;src/my_libs/timer.c:8: p->time_frac = 0;
	inc	de
	inc	de
	xor	a, a
	ld	(de), a
;src/my_libs/timer.c:9: }
	ret
;src/my_libs/timer.c:11: void UpdateTimer(Timer *p){
;	---------------------------------
; Function UpdateTimer
; ---------------------------------
_UpdateTimer::
;src/my_libs/timer.c:12: if (p->active != 0){
	ld	a, (de)
	or	a, a
	ret	Z
;src/my_libs/timer.c:13: p->time_frac -= 1;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ld	a, (bc)
	dec	a
;src/my_libs/timer.c:14: if (p->time_frac == 0){
	ld	(bc), a
	or	a, a
	ret	NZ
;src/my_libs/timer.c:15: p->time -= 1;
	inc	de
	ld	a, (de)
	dec	a
	ld	(de), a
;src/my_libs/timer.c:18: }
	ret
;src/my_libs/timer.c:20: void PauseTimer(Timer *p){p->active = 0;}
;	---------------------------------
; Function PauseTimer
; ---------------------------------
_PauseTimer::
	xor	a, a
	ld	(de), a
	ret
;src/my_libs/timer.c:22: void ResumeTimer(Timer *p){p->active = 1;}
;	---------------------------------
; Function ResumeTimer
; ---------------------------------
_ResumeTimer::
	ld	a, #0x01
	ld	(de), a
	ret
;src/my_libs/timer.c:24: uint8_t GetTimerStatus(Timer *p){return p->active;}
;	---------------------------------
; Function GetTimerStatus
; ---------------------------------
_GetTimerStatus::
	ld	a, (de)
	ret
;src/my_libs/timer.c:26: uint8_t GetRemainingTime(Timer *p){return p->time;}
;	---------------------------------
; Function GetRemainingTime
; ---------------------------------
_GetRemainingTime::
	inc	de
	ld	a, (de)
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
