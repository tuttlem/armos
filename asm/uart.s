.equ UART0_DR, 0x101f1000

.section .text
.global uart_putc
.global uart_puts

uart_putc:
    STRB r0, [r1]        @ Store byte from r0 into UART data register
    BX lr

uart_puts:
    LDR r1, =UART0_DR
1:
    LDRB r0, [r2], #1   @ Load byte from string, increment pointer
    CMP r0, #0          @ Check for null terminator
    BEQ 2f              @ Branch to 2 if we are done
    BL uart_putc        @ If not, call putc
    B 1b                @ Keep looping
2:
    BX lr               @ Return to caller
