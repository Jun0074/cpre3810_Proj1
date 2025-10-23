.data

.text
.globl main

main:

	#Start Test
	
	#Check that result of XORI can be used in another XORI instruction
	li t0, 0x00000FFF
	xori t1, t0, -1
	#Expected value of t1: 0xFFFFF000
	
	xori t2, t1, -1
	#Expected value of t2: 0x00000FFF
	
	xori a0, t2, 1365
	#Expected result: 0x00000AAA
	
	#Check that rd and rs1 can be the same for XORI
	li a0, 0x00000FFF
	xori a0, a0, -1
	#Result in a0 should be: 0xFFFFF000

    wfi               

