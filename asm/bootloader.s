    .section    .text
    .global     _start

 _start:
    // initialize the stack pointer
    LDR     sp, =stack_top

    // jump to the kernel main loop
    BL      kernel_main

kernel_main:
    // infinite loop to keep the OS running
1:  B 1b

    // fallback loop
    B .

    // reserve space for the stack in a separate section
    .section    .bss
    .align      4
stack_top:
    // allocate 1kb for the stack
    .space      1024
