riscv_mp0test.s:
.align 4
.section .text
.globl _start
    # Refer to the RISC-V ISA Spec for the functionality of
    # the instructions in this test program.
_start:
    addi x1, x0, 0x123          #x1 = 0x123
    nop
    nop
    nop
    nop
    addi x2, x0, 0x321          #x2 = 0x321
    nop
    nop
    nop
    nop
    add x3, x1, x2              #x3 = 0x444
    nop
    nop
    nop
    nop
    slli x3, x3, 8              #x3 = 0x44400
    nop
    nop
    nop
    nop
    lui x4, 0xfff0f             #x4 = 0xfff0f000
    nop
    nop
    nop
    nop
    srli x3, x3, 4              #x3 = 0x4440
    nop
    nop
    nop
    nop
    xor x5, x3, x1              #x5 = 0x4563
    nop
    nop
    nop
    nop
    ori x10, x3, 0x000          #x10 == x3 == 0x4440
    nop
    nop
    nop
    nop
    and x5, x3, x10             #x5 = 0x4440
    nop
    nop
    nop
    nop
    sll x5, x5, x1              #left shift by 3 bits x5 = 0x22200
    nop
    nop
    nop
    nop
    srl x6, x5, x1              #x6 = 0x4440
    nop
    nop
    nop
    nop
    bgeu x5, x6, skip
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
    auipc x7, 0x0           #x7 = pc = 0x164
    nop
    nop
    nop
    nop
    lw x9, 0x80(x7)         #load x9 = deadbeef
    nop
    nop
    nop
    nop
    auipc x7, 0x0           # x7 = pc = 0x18c
    nop
    nop
    nop
    nop
    sw x1, 0x5c(x7)        #store 0x123 in LVAL1
    nop
    nop
    nop
    nop
    auipc x8, 0x0           #x8 = pc = 0x1b4
    nop
    nop
    nop
    nop
    lw x9, 0x34(x8)          #load from LVAL1, should be x1 value 0x123
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
