.data 

.text
.globl main

main:

	# Start test -- Common Case (Shift amount does not exceed bounds)
	
	srl x5, x0, x0	# should make t0 equal to x0
	
	addi x5, x5, 1	# displace t0
	srl x5, x0, x0	# should make t0 equal to x0
	
	addi x6, x0, 100	# place decimal 100 in t1
	addi x7, x0, 3		# place decimal 3 in t2
	srl x5, x6, x7		# shift x6 by x7 to get 100/(2*2*2)=12
	
	addi x6, x0, 8		# place decimal 8 in t1
	addi x7, x0, 3		# place decimal 3 in t2
	srl x5, x6, x7		# shift x6 by x7 to get 8/(2*2*2)=1
	
	lui x6, 0x80000		# make leftmost bit 1 in t1
	addi x7, x0, 0x1F	# place decimal 31 in t2
	srl x5, x6, x7		# shift x6 by x7 to get 1
	
	
end:
	wfi
#	j end
