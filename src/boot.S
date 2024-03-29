#include "mm.h"
#include "sysregs.h"

.section ".text.boot"

.globl _start
_start:
	mrs	x0, mpidr_el1		
	and	x0, x0,#0xFF		// Check processor id
	cbz	x0, master		// Hang for all non-primary CPU
	b	proc_hang

proc_hang: 
	b 	proc_hang

master:
    bl get_el   // gets current el in x0
    sub x0, x0, #2 //compare el to 2
    cbz x0, EL2_to_EL1
    b EL3_to_EL1

EL2_to_EL1:
    ldr    x0, =SCTLR_VALUE_MMU_DISABLED
    msr    sctlr_el1, x0        

    ldr    x0, =HCR_VALUE
    msr    hcr_el2, x0

    ldr    x0, =SPSR_VALUE
    msr    spsr_el2, x0 


    adr    x0, el1_entry        
    msr    elr_el2, x0

    eret         
EL3_to_EL1:
    ldr    x0, =SCTLR_VALUE_MMU_DISABLED
    msr    sctlr_el1, x0        

    ldr    x0, =HCR_VALUE
    msr    hcr_el2, x0

    ldr    x0, =SCR_VALUE
    msr    scr_el3, x0

    ldr    x0, =SPSR_VALUE
    msr    spsr_el3, x0 


    adr    x0, el1_entry        
    msr    elr_el3, x0

    eret         

el1_entry:
	adr	x0, bss_begin
	adr	x1, bss_end
	sub	x1, x1, x0
	bl 	memzero

	mov	sp, #LOW_MEMORY 
	bl	kernel_main
	b 	proc_hang		// should never come here
