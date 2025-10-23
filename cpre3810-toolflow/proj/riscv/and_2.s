.data

.text
.globl main

# This test covers covers the common cases of every combination of bits for rs1 against rs2 eg. {(rs1 = 1, rs2 = 0), (rs1 = 0, rs2 = 1), etc} 
# This is important as it is key to the and instruction's functionality as an "and" instruction. 

main:

	
	# Start Test
	lui x1, 1044496
	addi x1, x1, -256 # Set x1 to 0xFF00_FF00
	
	lui x2, -16 # Set x2 to 0xFFFF_0000
	
	and x3, x1, x2 # This should result in 0xFF00_0000 as 0x00 and 00 is 0x00, 0xFF and 0x00 is 0x00, 0x00 and 0xFF is 0x00, 0xFF and 0xFF is 0xFF.
#end:
	wfi
	#j end