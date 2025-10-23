.data 

.text
.globl main

main:

	# Start test - Common Case (Multiple moves)
	
	srl x5, x0, x0	# should make t0 equal to x0
	
	addi x5, x5, 1	# displace t0
	srl x5, x0, x0	# should make t0 equal to x0
	
	lui x6, 0xBEEF0 		# place hex 0BEEF000 in t1
	addi x7, x0, 4		# place decimal 4 in t2
	srl x5, x6, x7		# shift x6 by x7 to get BEEF0000/(2*2*2*2)
	srl x5, x5, x7		# shift x6 by x7 to get 0BEEF000/(2*2*2*2)
	srl x5, x5, x7		# shift x6 by x7 to get 00BEEF00/(2*2*2*2)
	srl x5, x5, x7		# shift x6 by x7 to get 000BEEF0/(2*2*2*2)
	srl x5, x5, x7		# shift x6 by x7 to get 0000BEEF/(2*2*2*2)
	srl x5, x5, x7		# shift x6 by x7 to get 00000BEE/(2*2*2*2)
	srl x5, x5, x7		# shift x6 by x7 to get 000000BE/(2*2*2*2)
	srl x5, x5, x7		# shift x6 by x7 to get 0000000B/(2*2*2*2)
	srl x5, x5, x7		# shift x6 by x7 to get 00000000/(2*2*2*2)
	
	
end:
	wfi
	#j end
