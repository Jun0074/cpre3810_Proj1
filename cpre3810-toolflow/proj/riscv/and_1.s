.data

.text
.globl main

# This test covers covers the common cases of using any register in the rs2 parameter for the and instruction. This has value as it is important that the instruction works for all values of rs2.

main:
	
	# Start Test
	addi x1, zero, 1 # fill each register with a 1
	addi x2, zero, 1
	addi x3, zero, 1
	addi x4, zero, 1
	addi x5, zero, 1
	addi x6, zero, 1
	addi x7, zero, 1
	addi x8, zero, 1
	addi x9, zero, 1
	addi x10, zero, 1
	addi x11, zero, 1
	addi x12, zero, 1
	addi x13, zero, 1
	addi x14, zero, 1
	addi x15, zero, 1
	addi x16, zero, 1
	addi x17, zero, 1
	addi x18, zero, 1
	addi x19, zero, 1
	addi x20, zero, 1
	addi x21, zero, 1
	addi x22, zero, 1
	addi x23, zero, 1
	addi x24, zero, 1
	addi x25, zero, 1
	addi x26, zero, 1
	addi x27, zero, 1
	addi x28, zero, 1
	addi x29, zero, 1
	addi x30, zero, 1
	addi x31, zero, 1

	
	# Every and should clear the register.
	and x1, zero, x1
	and x2, zero, x2
	and x3, zero, x3
	and x4, zero, x4
	and x5, zero, x5
	and x6, zero, x6
	and x7, zero, x7
	and x8, zero, x8
	and x9, zero, x9
	and x10, zero, x10
	and x11, zero, x11
	and x12, zero, x12
	and x13, zero, x13
	and x14, zero, x14
	and x15, zero, x15
	and x16, zero, x16
	and x17, zero, x17
	and x18, zero, x18
	and x19, zero, x19
	and x20, zero, x20
	and x21, zero, x21
	and x22, zero, x22
	and x23, zero, x23
	and x24, zero, x24
	and x25, zero, x25
	and x26, zero, x26
	and x27, zero, x27
	and x28, zero, x28
	and x29, zero, x29
	and x30, zero, x30
	and x31, zero, x31

	
#end:
	wfi
#	j end
	
