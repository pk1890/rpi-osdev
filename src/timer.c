#include "peripherals/timer.h"
#include "utils.h"
#include <stdint.h>
#include "printf.h"
const uint32_t interval = 20000;
uint32_t curr_time;

void timer_init(void){
    curr_time = get32(TIMER_CLO);
    put32(TIMER_C1, curr_time + interval);
}

void handle_timer_irq(void){
    curr_time += interval;
    put32(TIMER_C1, curr_time);
    put32(TIMER_CS, TIMER_CS_M1);
    printf("Timer interrupt received \r\n");
}