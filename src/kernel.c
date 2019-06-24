#include "mini_uart.h"
#include "printf.h"
#include "utils.h"
#include "entry.h"
#include "timer.h"
#include "irq.h"

void kernel_main(void)
{
	
	uart_init();
	init_printf(0, putc);
	irq_vector_init();
	timer_init();
	enable_interrupt_controller();
	enable_irq();


	// uart_send_string("Hello, world!\r\n");
	printf("Hello threre raspberry pi %d so nice \r\n Current EL = %d \r\n", 3, get_el());
	while (1) {
		uart_send(uart_recv());
	}
}
