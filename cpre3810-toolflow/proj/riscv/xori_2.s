.data

.text
.globl main

main:
	
	#Start Test
	#XORI with zero results in the same number
	li t0, 0xFFFFFFFF
	xori a0, t0, 0x000
	#Expected Result: 0xFFFFFFFF
	
	#Using -1 as input makes XORI act like a not gate
	li t0, 0xFFFFF000
	xori a0, t0, -1
	#Expected Result: 0x00000FFF
	
	#Alternating bit pattern
	li t0, 0xAAAAAAAA # 1010, 1010, ...
	xori a0, t0, 0x555 # ... , 0101, 01010, 0101
	#Expected Result: 0xAAAAAFFF
	
	#Last bit is affected by XORI
	li t0, 0x80000000
	xori a0, t0, -1
	#Expected Result: 0x7FFFFFFF
	
	#XORI a value with an equal immediate should be 0
	li t0, 0x0000000F
	xori a0, t0, 0x00F
	#Expected Result: 0x00000000

    wfi               

