mytest.s:
.align 4 
.section .text
.globl _start
_start:

	#TEST LUI
	lui x1, 0xFFFFF # X1 = 0xFFFFF000
	lw  x2, lui_expct #x2 = 0xFFFFF000
	
	#TEST ALL BRANCH INTRUCTIONS
	bne x1, x2, badend 
	addi x1, x1, 1 # now X1 = 0xFFFFF001
	beq x1, x2, badend
	blt x1, x2, badend
	bge x1,x0, badend #now compare X1 to 0. x1 should be negtive in signed operation
	bltu x1, x0, badend 
	bgeu x0, x1, badend
	
	#TEST ARITHMATIC INSTRUCTIONS
	addi x3, x0, -1 #tests correct sign extension x3 = -1
	lw   x4, val2 # x4 = -1
	bne x3, x4, badend 
	lw x4, val1
	add x2, x1, x4 #this tests correct overflow, as it x1 and 0xFFF sum to 0
	bne x2, x0, badend
	lw x3, val1
	add x2, x1, x3
	bne x2, x0, badend
	addi x4, x0, 0x1 #set x4 to 1 
	slti x2, x1, 0 
	bne x2, x4, badend # x1 < 0 when treated as signed, so x2 should be set to 0 
	slt x2, x0, x1
	bne x2, x0, badend
	sltu x2, x1, x0
	bne x2, x0, badend # x1 > 0 when treated as unsigned, so x2 should be set to 1
	sltu x2, x0, x1		
	bne x2, x4, badend 
	
	xori x2, x1, 0
	bne x2, x1, badend #xor a number to 0 should not change it
	xor x2, x1, x1
	bne x2, x0, badend #xor a number to itself should be 0
	
	andi x2, x1, 0
	bne x2, x0, badend #and a number with 0 should give 0
	and  x2, x1, x1
	bne x2, x1, badend #and a number with itself should not change
	
	sub x2, x0, x4 # x2 = -1 #test correct subtraction
	lw  x3, val2 #x3 = -1
	bne x2, x3, badend  
	sub x2, x0, x3 # x2 = 1 #test subtract a negative number
	addi x4, x0, 0x1 #set x4 to 1 
	bne x2, x4, badend
	
	lui x1, 0xFFF0 # X1 = 0x0FFF0000	
	lw  x3, val1 #x3 = 0xfff
	slli x2, x3, 16 #shift x3 left by 16 bits should equal to x1
	bne x2, x1, badend	
	addi x4, x0, 16 #set x4 to 16
	sll x2, x3, x4 
	bne x2, x1, badend	
	srli x2, x3, 12 #x2 should become 0
	bne x2, x0, badend
	addi x4, x0, 12 #set x4 to 12	
	srl x2, x3, x4 
	bne x2, x0, badend
	addi x3, x0, -1 #set x3 to -1	
	srai x2, x3, 12 # arithmatic right shift 0xffffffff should still be 0xffffffff 
	bne x2, x3, badend
	sra x2, x3, x4  
	bne x2, x3, badend	

	#test load and store type smaller than 4 bytes
	lb x1, val2 #should do sign extension, so x1 should become 0xffffffff
	lw x2, val2
	bne x1, x2,badend
	
	lh x1, val2 #should do sign extension, so x1 should become 0xffffffff
	bne x1, x2,badend
	
	lbu x1, val2 #should no extend sign, so x1 is still 0x000000ff
	lw x2, val4 
	bne x1, x2,badend
	
	lhu x1, val2 #should no extend sign, so x1 is still 0x0000ffff
	lw x2, val5 
	bne x1, x2,badend
	
	addi x1, x0, -1 #set x1 to 0xffffffff
	sb x1, 	store, x9
	lw x2, store #should load 0x000000ff
	lw x3, 	val4
	bne x3, x2,badend
	
	sh x1, 	store, x9
	lw x2, store #should load 0x0000ffff	
	lw x3, 	val5	
	bne x3, x2,badend
	
	sw x1, 	store, x9
	lw x2, store #should load 0xffffffff	
	bne x1, x2,badend		

	
# test unaligned access	
	la x1, val7
	sb x0, 3(x1)
	lw x1, val7
	lw x2, val8
	bne x1, x2,badend

	la x1, val9
	sw x0, 2(x1)
	lw x1, val9
	lw x2, val10
	bne x1, x2,badend
	
	jal x2, goodend	
goodloop:
	j goodloop
goodend:
	lw x1, good
	jalr x0, x2	
	
badend: 
	lw x1, bad
badloop: 
	jal x0, badloop


.section .rodata
.balign 256
.zero 96
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
