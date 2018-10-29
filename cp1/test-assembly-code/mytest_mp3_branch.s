mytest.s:
.align 4 
.section .text
.globl _start
_start:
    beq x0, x0, TEST
    nop
    nop
    nop
    nop
    nop
    nop
    nop
        
.section .rodata
.balign 256
#.zero 96
bad:       .word 0xdeaddead
good:      .word 0x600d600d
lui_expct: .word 0xfffff000
val1:      .word 0xfff
val2:      .word 0xffffffff
val3:      .word 0x000fffff
val4:      .word 0x000000ff
val5:      .word 0x0000ffff
val6:      .word 0x0fffffff
store:     .word 0x0
val7:      .word 0xffffffff
val8:      .word 0x00ffffff
val9:     .word 0xffffffff
val10:      .word 0xff0000ff

.section .text
.align 4
TEST:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
	#TEST LUI
	lui x1, 0xFFFFF # X1 = 0xFFFFF000
    nop
    nop
    nop
    nop
    nop
    nop
    nop
	lw  x2, %lo(lui_expct)(x0) #x2 = 0xFFFFF000
    nop
    nop
    nop
    nop
    nop
    nop
    nop	
	#TEST ALL BRANCH INTRUCTIONS
	bne x1, x2, badend 
    nop
    nop
    nop
    nop
    nop
    nop
    nop
	addi x1, x1, 1 # now X1 = 0xFFFFF001
    nop
    nop
    nop
    nop
    nop
    nop
    nop
	beq x1, x2, badend
    nop
    nop
    nop
    nop
    nop
    nop
    nop
	blt x1, x2, badend
    nop
    nop
    nop
    nop
    nop
    nop
    nop
	bge x1,x0, badend #now compare X1 to 0. x1 should be negtive in signed operation
    nop
    nop
    nop
    nop
    nop
    nop
    nop
	bltu x1, x0, badend 
    nop
    nop
    nop
    nop
    nop
    nop
    nop
	bgeu x0, x1, badend
    nop
    nop
    nop
    nop
    nop
    nop
    nop	
	

goodend:
	lw x1, %lo(good)(x0)
    nop
    nop
    nop
    nop
    nop
    nop
    nop

goodloop:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
	j goodloop
	
badend: 
	lw x1, %lo(bad)(x0)
    nop
    nop
    nop
    nop
    nop
    nop
    nop
badloop: 
	jal x0, badloop
    nop
    nop
    nop
    nop
    nop
    nop
    nop


