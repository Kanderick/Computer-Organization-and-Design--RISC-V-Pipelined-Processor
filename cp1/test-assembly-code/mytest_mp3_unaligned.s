mytest.s:
.align 4 
.section .text
.globl _start
_start:
    beq x0, x0, TEST
        
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
val11:      .word 0x11223344
val12:       .word 0x00000033
val13:       .word 0x00001122
val14:      .word 0x00ff0000
val15:      .word 0x00003344

.section .text
.align 4
TEST:
    
	#test load and store type smaller than 4 bytes

	lb x1, %lo(val2)(x0) #should do sign extension, so x1 should become 0xffffffff
	lw x2, %lo(val2)(x0)
    nop
    nop
    nop
    nop
    nop
	bne x1, x2,badend	
	lh x1, %lo(val2)(x0) #should do sign extension, so x1 should become 0xffffffff
    nop
    nop
    nop
    nop
    nop
	bne x1, x2,badend
	lbu x1, %lo(val2)(x0) #should no extend sign, so x1 is still 0x000000ff
	lw x2, %lo(val4)(x0) 
    nop
    nop
    nop
    nop
    nop
	bne x1, x2,badend
	lhu x1, %lo(val2)(x0) #should no extend sign, so x1 is still 0x0000ffff
	lw x2, %lo(val5)(x0) 
    nop
    nop
    nop
    nop
    nop
	bne x1, x2,badend
	addi x1, x0, -1 #set x1 to 0xffffffff
    	addi x10, x0, %lo(store) # X10 <= address of store
    nop
    nop
    nop
    nop
    nop
	sb x1, 	0(x10)
	lw x2, %lo(store)(x0) #should load 0x000000ff
	lw x3, 	%lo(val4)(x0)
    nop
    nop
    nop
    nop
    nop
	bne x3, x2,badend
        addi x10, x0, %lo(store) # X10 <= address of store
        addi x11, x0, 80
    nop
    nop
    nop
    nop
    nop
	sh x1, 	0(x10)
	lw x2, %lo(store)(x0) #should load 0x0000ffff	
	lw x3, 	%lo(val5)(x0)	
    nop
    nop
    nop
    nop
    nop
	bne x3, x2,badend
	addi x10, x0, %lo(store) # X10 <= address of store
    nop
    nop
    nop
    nop
    nop
	sw x1, 0(x10)
	lw x2, %lo(store)(x0) #should load 0xffffffff	
    nop
    nop
    nop
    nop
    nop
	bne x1, x2,badend			
# test unaligned access	
    	addi x1, x0, %lo(val7) 
    nop
    nop
    nop
    nop
    nop    	
	sb x0, 3(x1)
	lw x1, %lo(val7)(x0)
	lw x2, %lo(val8)(x0)
    nop
    nop
    nop
    nop
    nop	
	bne x1, x2,badend

    	addi x1, x0, %lo(val7) 
    nop
    nop
    nop
    nop
    nop    	
	sh x0, 0(x1)
	lw x1, %lo(val7)(x0)
	lw x2, %lo(val14)(x0)
    nop
    nop
    nop
    nop
    nop	
	bne x1, x2,badend
	
    	addi x1, x0, %lo(val9) 
    nop
    nop
    nop
    nop
    nop    	
	sh x0, 1(x1)
	lw x1, %lo(val9)(x0)
	lw x2, %lo(val10)(x0)
    nop
    nop
    nop
    nop
    nop	
	bne x1, x2,badend

    	addi x1, x0, %lo(val11) 
    nop
    nop
    nop
    nop
    nop
	lb x1, 1(x1)
	lw x2, %lo(val12)(x0)
    nop
    nop
    nop
    nop
    nop
	bne x1, x2,badend

    	addi x1, x0, %lo(val11) 
    nop
    nop
    nop
    nop
    nop
	lh x1, 2(x1)
	lw x2, %lo(val13)(x0)
    nop
    nop
    nop
    nop
    nop
	bne x1, x2,badend

    	addi x1, x0, %lo(val11) 
    nop
    nop
    nop
    nop
    nop
	lh x1, 0(x1)
	lw x2, %lo(val15)(x0)
    nop
    nop
    nop
    nop
    nop
	bne x1, x2,badend
	jal x2, goodend	
goodloop:
	j goodloop
goodend:
	lw x1, %lo(good)(x0)
	jalr x0, x2	
badend: 
	lw x1, %lo(bad)(x0)
badloop: 
	jal x0, badloop


