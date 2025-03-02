.section .text
.global uart_putc
.global uart_puts

uart_putc:
    PUSH {lr}
    ldr r1, =0x101f1000  @ UART0 Data Register
    STRB r0, [r1]        @ Store byte
    POP {lr}
    BX lr

uart_puts:
    PUSH {lr}

next_char:
    LDRB r1, [r0], #1    @ Load byte from string
    CMP r1, #0
    BEQ done

wait_uart:
    LDR r2, =0x101f1018  @ UART0 Flag Register
    LDR r3, [r2]
    TST r3, #0x20        @ Check if TX FIFO is full
    BNE wait_uart

    LDR r2, =0x101f1000  @ UART0 Data Register
    STR r1, [r2]         @ Write character
    B next_char

done:
    POP {lr}
    BX lr
