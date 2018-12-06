load_test:
.align 4
.section .text
.globl _start
_start:

    # word-align load_test: Cache hit/miss && LRU check
    la x1,  R0S3W0
    la x2,  R0S3W3
    la x3,  R1S3W0
    la x4,  R2S3W1
    lw x5, 0(x1)  # cache miss; expected value=0x600D0300
    lw x5, 0(x2)  # cache hit for line1; expected value=0x600D0303
    lw x5, 0(x3)  # cache miss; expected value=0x600D1300
    lw x5, 0(x4)  # cache miss and repalce line1; expected value=0x600D2301
    lw x5, 4(x3)  # cache hit because line2 is not replaced; expected value=0x600D1301

    # half-word-align load_test
    lw x5, 2(x1) # cahce miss; expected value=0x0301600D
    lw x5, 6(x1) # cahce hit; expected value=0x0302600D
    la x2, R0S6W4
    lh x5, 2(x2) # cache miss for a new set; expected value=0xFFFFF0F0
    lhu x5, 2(x2) # cache hit; expected value=0x0000F0F0
    lb x5, 2(x2) # cache hit; expected value=0xFFFFFFF0
    lbu x5, 2(x2) # cache hit; expected value=0x000000F0

    # byte-algin load_test
    lw x5, 1(x1) # cahce hit; expected value=0x01600D03
    lw x5, 15(x1) # cahce hit; expected value=0x0D030460
    lh x5, 1(x2) # cache hit; expected value=0xFFFFF060
    lhu x5, 1(x2) # cache hit; expected value=0x0000F060
    lb x5, 3(x2) # cache hit; expected value=0xFFFFFFF0
    lbu x5, 3(x2) # cache hit; expected value=0x000000F0


.section .rodata
.balign 256 #align to the start of a new set round
.zero 96    #pad to Set 3
R0S3W0: .word 0x600D0300
R0S3W1: .word 0x600D0301
R0S3W2: .word 0x600D0302
R0S3W3: .word 0x600D0303
R0S3W4: .word 0x600D0304
R0S3W5: .word 0x600D0305
R0S3W6: .word 0x600D0306
R0S3W7: .word 0x600D0307
.zero 64  #pad to Set 6
R0S6W0: .word 0x600DF0F0
R0S6W1: .word 0x600DF0F0
R0S6W2: .word 0x600DF0F0
R0S6W3: .word 0x600DF0F0
R0S6W4: .word 0xF0F0600D
R0S6W5: .word 0xF0F0600D
R0S6W6: .word 0xF0F0600D
R0S6W7: .word 0xF0F0600D


.balign 256 #align to the start of a new set round
.zero 96    #pad to Set 3
R1S3W0: .word 0x600D1300
R1S3W1: .word 0x600D1301
R1S3W2: .word 0x600D1302
R1S3W3: .word 0x600D1303
R1S3W4: .word 0x600D1304
R1S3W5: .word 0x600D1305
R1S3W6: .word 0x600D1306
R1S3W7: .word 0x600D1307
.zero 64    #pad to Set 6
R1S6W0: .word 0xF0F0F0F0
R1S6W1: .word 0xF0F0F0F0
R1S6W2: .word 0xF0F0F0F0
R1S6W3: .word 0xF0F0F0F0
R1S6W4: .word 0xF0F0F0F0
R1S6W5: .word 0xF0F0F0F0
R1S6W6: .word 0xF0F0F0F0
R1S6W7: .word 0xF0F0F0F0

.balign 256 #align to the start of a new set round
.zero 96    #pad to Set 3
R2S3W0: .word 0x600D2300
R2S3W1: .word 0x600D2301
R2S3W2: .word 0x600D2302
R2S3W3: .word 0x600D2303
R2S3W4: .word 0x600D2304
R2S3W5: .word 0x600D2305
R2S3W6: .word 0x600D2306
R2S3W7: .word 0x600D2307
.zero 64    #pad to Set 6
R2S6W0: .word 0xF0F0F0F0
R2S6W1: .word 0xF0F0F0F0
R2S6W2: .word 0xF0F0F0F0
R2S6W3: .word 0xF0F0F0F0
R2S6W4: .word 0xF0F0F0F0
R2S6W5: .word 0xF0F0F0F0
R2S6W6: .word 0xF0F0F0F0
R2S6W7: .word 0xF0F0F0F0
