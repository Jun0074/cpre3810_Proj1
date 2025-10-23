.data 

.text
.globl main

main:

	# Start test - Edge Case (shift value exceeds last digit = 0)
	
	srl x5, x0, x0	# should make t0 equal to x0
	
	addi x6, x0, 100	# place decimal 100 in t1
	addi x7, x0, 0x1F	# place decimal 31 in t2
	srl x5, x6, x7		# shift x6 by x7 to get 100 shifted by 31 = 100/(2*2*2*2...) = 0
	
	addi x6, x0, 1		# place decimal 1 in t1
	addi x7, x0, 0x1F	# place decimal 31 in t2
	srl x5, x6, x7		# shift x6 by x7 to get 1 shifted by 31 = 1/(2*2*2...) = 0
	
	lui x6, 0x0BEEF		# place large value in upper immediate
	addi x7, x0, 0x1F	# place decimal 31 in t2
	srl x5, x6, x7		# shift x6 by x7 to get x0BEEF000 shifted by 31 = BEEF000/(2*2*2...) = 0
	
	
	
end:
	wfi
	#j end
