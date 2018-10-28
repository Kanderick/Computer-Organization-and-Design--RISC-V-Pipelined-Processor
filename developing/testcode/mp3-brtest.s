riscv_mp0test.s:
.align 4
.section .text
.globl _start
    # Refer to the RISC-V ISA Spec for the functionality of
    # the instructions in this test program.
_start:
    addi x1, x0, 0x123
    nop
    nop
    nop
    nop
    addi x2, x0, 0x223
    nop
    nop
    nop
    nop
    bgeu x2, x1, skip
    nop
    nop
    nop
    nop
    addi x1, x1, 0x321      #should not execute
    nop
    nop
    nop
    nop
skip:
    addi x4, x2, 0x1
    nop
    nop
    nop
    nop
    addi x4, x4, 0x1
    nop
    nop
    nop
    nop
    addi x4, x4, 0x1
    nop
    nop
    nop
    nop
loop:
    jal x0, loop
.section .rodata

bad:        .word 0xdeadbeef
LVAL1:	    .word 0x00000020
LVAL2:	    .word 0x000000D5
LVAL3:	    .word 0x0000000F
LVAL4:	    .word 0x00000F0F
LVAL5:	    .word 0x000000FF
LVAL6:	    .word 0x00000004
SVAL1:	    .word 0x00000000
SVAL2:	    .word 0x00000000
SVAL3:	    .word 0x00000000
SVAL4:	    .word 0x00000000
SVAL5:	    .word 0x00000000
SVAL6:	    .word 0x00000000
SVAL7:	    .word 0x00000000
good:       .word 0x600d600d
