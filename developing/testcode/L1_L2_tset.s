load_test:
.align 4
.section .text
.globl _start
_start:
# word-align store_test: Cache hit/miss && LRU check
la x1, R0S3W0
la x2, R0S3W3
la x3, R1S3W0
la x4, R2S3W1
la x8, TESTSIG
lui x7, 0 # Initializing register for testing
lw x8, 0(x8) # cache miss: loading test signal
#TEST CASE ONE: write to cache with miss
sw x8, 0(x1) # cache miss;
lw x5, 0(x1)
bne x8, x5, badend
addi x7, x7, 1
#TEST CASE TWO: write to cache with hit
sw x8, 0(x2) #cache hit for line1;
lw x5, 0(x2)
bne x8, x5, badend
addi x7, x7, 1
#TEST CASE THREE: replace LRU
sw x8, 0(x3) # cache miss;
lw x5, 0(x3)
bne x8, x5, badend
sw x8, 0(x4) # cache miss and repalce line1;
lw x5, 0(x4)
bne x8, x5, badend
sw x8, 4(x3) # cache hit because line2 is not replaced; expected value=0x600D1301
lw x5, 4(x3)
bne x8, x5, badend
lw x5, 0(x2) # reload replaced line1 and check if the replaced value is changed in pmem
bne x8, x5, badend
addi x7, x7, 1
#TEST CASE FOUT: half-word-align load word
sw x8, 2(x1)
lw x5, 2(x1)
bne x8, x5, badend
addi x7, x7, 1
#TEST CASE FIVE: half-word-align load half-wordla x2, R0S6W0
lw x5, 2(x2) # cache miss for a new set;
srli x9, x5, 16
slli x9, x9, 16
slli x10, x8, 16
srli x10, x10, 16
add x9, x9, x10 # load expected value to x9
sh x8, 2(x2) # write to the half-word
lw x5, 2(x2)
bne x5, x9, badend
addi x7, x7, 1
#TEST CASE SIX: half-word-algin load byte
la x2, R0S6W2
lw x5, 2(x2) # cache hit
srli x9, x5, 8
slli x9, x9, 8
slli x10, x8, 24
srli x10, x10, 24
add x9, x9, x10 # load expected value to x9
sb x8, 2(x2) # write to the byte
lw x5, 2(x2)
bne x5, x9, badend
addi x7, x7, 1
#TEST CASE SEVEN: byte-align load word
la x1, R0S3W5
sw x8, 1(x1)
lw x5, 1(x1) # cahce hit
bne x5, x8, badend
addi x7, x7, 1
#TEST CASE EIGHT: byte-align load half-word
la x1, R0S3W6
lw x5, 1(x2) # cache hit;
srli x9, x5, 16
slli x9, x9, 16
slli x10, x8, 16
srli x10, x10, 16
add x9, x9, x10 # load expected value to x9
sh x8, 1(x2)
lw x5, 1(x2)
bne x5, x9, badend
addi x7, x7, 1
#TEST CASE NINE: byte-align load byte
la x1, R0S6W7
slli x9, x8, 24srli x9, x9, 24
sb x8, 3(x1)
lbu x5, 3(x1) # cache hit; expected value=0xFFFFFFF0
bne x5, x9, badend
addi x7, x7, 1
goodend:
jal x0, goodend
badend:
jal x0, badend
.section .rodata
TESTSIG: .word 0x600DFFFF
.balign 256 #align to the start of a new set round
.zero 96 #pad to Set 3
R0S3W0: .word 0x600D0300
R0S3W1: .word 0x600D0301
R0S3W2: .word 0x600D0302
R0S3W3: .word 0x600D0303
R0S3W4: .word 0x600D0304
R0S3W5: .word 0x600D0305
R0S3W6: .word 0x600D0306
R0S3W7: .word 0x600D0307
.zero 64 #pad to Set 6
R0S6W0: .word 0x600DF0F0
R0S6W1: .word 0x600DF0F0
R0S6W2: .word 0x600DF0F0
R0S6W3: .word 0x600DF0F0
R0S6W4: .word 0xF0F0600D
R0S6W5: .word 0xF0F0600D
R0S6W6: .word 0xF0F0600D
R0S6W7: .word 0xF0F0600D
.balign 256 #align to the start of a new set round
.zero 96 #pad to Set 3
R1S3W0: .word 0x600D1300
R1S3W1: .word 0x600D1301
R1S3W2: .word 0x600D1302
R1S3W3: .word 0x600D1303
R1S3W4: .word 0x600D1304
R1S3W5: .word 0x600D1305
R1S3W6: .word 0x600D1306
R1S3W7: .word 0x600D1307
.zero 64 #pad to Set 6
R1S6W0: .word 0xF0F0F0F0
R1S6W1: .word 0xF0F0F0F0
R1S6W2: .word 0xF0F0F0F0
R1S6W3: .word 0xF0F0F0F0R1S6W4: .word 0xF0F0F0F0
R1S6W5: .word 0xF0F0F0F0
R1S6W6: .word 0xF0F0F0F0
R1S6W7: .word 0xF0F0F0F0
.balign 256 #align to the start of a new set round
.zero 96 #pad to Set 3
R2S3W0: .word 0x600D2300
R2S3W1: .word 0x600D2301
R2S3W2: .word 0x600D2302
R2S3W3: .word 0x600D2303
R2S3W4: .word 0x600D2304
R2S3W5: .word 0x600D2305
R2S3W6: .word 0x600D2306
R2S3W7: .word 0x600D2307
.zero 64 #pad to Set 6
R2S6W0: .word 0xF0F0F0F0
R2S6W1: .word 0xF0F0F0F0
R2S6W2: .word 0xF0F0F0F0
R2S6W3: .word 0xF0F0F0F0
R2S6W4: .word 0xF0F0F0F0
R2S6W5: .word 0xF0F0F0F0
R2S6W6: .word 0xF0F0F0F0
R2S6W7: .word 0xF0F0F0F0
