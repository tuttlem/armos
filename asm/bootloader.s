.section .text
.global _start

_start:
    LDR sp, =stack_top  @ Set up the stack
    BL kmain            @ Call the C main function
    B .                 @ Hang forever

.section .bss
.align 4
stack_top:
.space 1024
