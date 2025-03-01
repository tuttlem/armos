.equ UART0_DR,  0x101f1000  @ UART0 Data Register (write here to send)
.equ UART0_FR,  0x101f1018  @ UART0 Flag Register (read to check status)
.equ TXFF, 0x20             @ Bit 5: Transmit FIFO Full (1 if full)

.section .text
.global uart_putc
.global uart_puts

uart_putc:
    PUSH {r4, lr}
    ldr r1, =UART0_DR      @ Load address of UART data register
    STRB r0, [r1]          @ Store byte from r0 into UART data register
    POP {r4, lr}
    BX lr

uart_puts:
    push {lr}              @ Save return address

next_char:
    ldrb r1, [r0], #1      @ Load byte from string and increment pointer
    cmp r1, #0             @ Check if null terminator
    beq done               @ If so, return

wait_uart:
    ldr r2, =UART0_FR      @ Load address of UART flag register
    ldr r3, [r2]           @ Read UART flag register
    tst r3, #TXFF          @ Check if TX FIFO is full
    bne wait_uart          @ If full, wait

    ldr r2, =UART0_DR      @ Load address of UART data register
    str r1, [r2]           @ Write character to UART
    b next_char            @ Process next character

done:
    pop {lr}               @ Restore return address
    bx lr                  @ Return
