.data

.text
.globl main

main:

	#Start Test
	
	#Max positive immediate value
	xori a0, zero, 2047
	#Expected Result: 0x000007FF
	
	#Max negative immediate value
	addi a0, zero, 0
	li t0, 0xFFFFFFFF
	xori a0, t0, -2048
	#Expected Result: 0x000007FF
	
	#Check sign extension for positive
	addi a0, zero, 0
	xori a0, zero, 0x7FF
	#Expected Result: 0x000007FF
	
	#Check sign extension for negative
	addi a0, zero, 0
	xori a0, zero, -2048
	#Expected Result: 0xFFFFF800
	
    wfi               

