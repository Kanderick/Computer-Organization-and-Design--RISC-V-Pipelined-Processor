factorial.s:
.align 4
.section .text
.globl _start
      # This piece of code is aim to calculate the factorial of an input
      # integer. This program is using 32-unsigned data type for both the input
      # and the output number. This constraints the input number to be strictly under
      # or equal 12.

      # input and output
      # Please modify the number in memory address(input_integer) to calculate the different
      # ingeger's factorial. The input default value is 5.
      # When the program 'halt,' the following memory(output_integer) should contain the correct
      # output as well as x3. the data in (output_integer) is set to zero while calculating.
_start:
      #load the input number to X1
      lw x1, input_integer
      lui x2, 1
      lui x3, 1
      srli x2, x2, 12   #WB to EX forwarding
      srli x3, x3, 12   #WB to EX forwarding
      blt x1, x2, halt
      beq x1, x2, load_output   # if the input is one, than it should be done
multiply_new_number:
      andi x4, x2, 0       #MEM to EX forwarding
      addi x4, x4, 1
      add x9, x0, x2      #intentionally add dependency
      addi x10, x0, 1
      add x2, x9, x10     #both parameters based on prev two instrs both MEM and WB should forward data to EX stage
      addi x5, x3, 0
keep_multiplying:
      addi x4, x4, 1
      blt x2, x4, iteration_check
      andi x6, x6, 0
add_one_more_multiplicant:
      add x6, x0, x6     #intentionally add dependency
      add x6, x0, x6
      addi x6, x6, 1      # same parameter based on pre two instrs, MEM and WB forwarding conflict

      blt x5, x6, keep_multiplying
      addi x3, x3, 1
      beq x0, x0, add_one_more_multiplicant

iteration_check:
      bge x2, x1, load_output # iteration done
      beq x0, x0, multiply_new_number # start a new iteration that times a new number
load_output:
      la  x6, output_integer # store the output to destination memory
      sw  x3, 0(x6)
halt:                 # Infinite loop to keep the processor
    add x2, x0, 0   #intentionally add dependency
    lw x1, 0(x2)
    add x2, x2, x1  #both parameters based on prev two instrs both MEM and WB should forward data to EX stage
    beq x0, x0, halt  # from trying to execute the data below.

.section .rodata
      # Please modify the following input_integer number to calculate different
      # ingeger's factorial. The input default value is 5.
      # When the program 'halt' the following memory(output_integer) should contain the correct
      # output. the output is set to zero while calculating.
input_integer:    .word     5
output_integer:   .word     0
