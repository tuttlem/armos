#include "uart.h"

void kmain() {
    uart_puts("Hello from C!\n");
    while (1);
}
