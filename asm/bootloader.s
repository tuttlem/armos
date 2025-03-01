.section .text
.global _start

_start:
    LDR sp, =stack_top
    LDR r2, =hello_msg
    BL uart_puts
    B .

.data
hello_msg:
    .asciz "Hello, ARM World!\n"

.section .bss
.align 4
stack_top:
.space 1024
