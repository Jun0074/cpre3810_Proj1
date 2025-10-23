.data

.text
.globl main

# This test covers covers the common cases of using any register in the rd and rs1 parameters for the and instruction. This has value as it is important that the instruction works for all values of rd and rs1.

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
	and x1, x1, zero
	and x2, x2, zero
	and x3, x3, zero
	and x4, x4, zero
	and x5, x5, zero
	and x6, x6, zero
	and x7, x7, zero
	and x8, x8, zero
	and x9, x9, zero
	and x10, x10, zero
	and x11, x11, zero
	and x12, x12, zero
	and x13, x13, zero
	and x14, x14, zero
	and x15, x15, zero
	and x16, x16, zero
	and x17, x17, zero
	and x18, x18, zero
	and x19, x19, zero
	and x20, x20, zero
	and x21, x21, zero
	and x22, x22, zero
	and x23, x23, zero
	and x24, x24, zero
	and x25, x25, zero
	and x26, x26, zero
	and x27, x27, zero
	and x28, x28, zero
	and x29, x29, zero
	and x30, x30, zero
	and x31, x31, zero
	
#end:
	wfi
#	j end
	
