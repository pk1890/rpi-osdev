#include <stddef.h>
#include <stdint.h>

static inline void mem_write(uint32_t reg, uint32_t value){
    *(volatile uint32_t*) reg = value;
}

static inline uint32_t mem_read(uint32_t reg){
    return *(volatile uint32_t*) reg;
}