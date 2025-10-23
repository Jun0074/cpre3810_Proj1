# Test 02: Stress-test bltu using highest and lowest unsigned binaries to ensure unsigned (signed would be pretty bad)
# Uses only: addi, beq, lui, bltu, jal.
# NOTE: This test uses one jal instruction (17) for the edge case that beq is non-functional in addition to bltu.

    .text
    .globl _start
_start:
	##case 1: 0<1
    	addi a0, x0, -1       # a0 = 0xFFFF_FFFF (max 32-bit) via -1 immediate
    	addi a1, x0, 0        # a1 = 0
    	addi a2, x0, 1        # a2 = 1

    	bltu a1, a2, OK1      # 0 < 1, branch. EXPECT taken
    	beq  x0, x0, FAIL1    # not taken => BLTU failed small ascending.
    	
FAIL1: #works even if program falls through
   	jal  x0, FAIL1    # loop here if failed 0<1 true case, jal in case beq brokeded

OK1:
	##case 2: 0xFFFFFFFF < 0 (max 32-bit)
    	bltu a0, a1, FAIL2    # (max 32-bit) < 0 hopefully false -> expect NOT taken
        # fall-through if correct 

	##case 3: 0 < 0xFFFFFFFF
    	bltu a1, a0, OK3      # 0 < (max 32-bit), EXPECT taken
   	beq  x0, x0, FAIL3    # not taken = BLTU failed 0 < max

OK3:
	##case 4: 0x7FFFFFFF < 0x80000000
	
	# build constant 0x7FF..FF:
    	lui  a3, 0x80000      # a3 = 0x8000_0000 (MSB = 1)
    	lui  a4, 0x80000      # a4 = 0x8000_0000 (upper 20 set except MSB)
    	addi a4, a4, -1    # a4 = 0x8000_0000 - 1 = 0x7FFF_FFFF via overflow 
    	# case comparison:
    	bltu a4, a3, OK4      # 0x7FFF_FFFF < 0x8000_0000 (unsigned), EXPECT taken
    	beq  x0, x0, FAIL4    # not taken => MSB boundary true-case failed

OK4:
	## case 5: 0x80000000 < 0x7FFFFFFF
    	bltu a3, a4, FAIL5    # reverse: 0x8000_0000 < 0x7FFF_FFFF is false -> expect NOT taken

PASS:
	wfi
    	#beq  x0, x0, PASS     # loop here if all cases passed via fall-through


FAIL2:
    	#beq  x0, x0, FAIL2    # loop here if failed max<0 false case
		wfi
FAIL3:
    	#beq  x0, x0, FAIL3    # loop here if failed 0<max true case
		wfi
FAIL4:
    	#beq  x0, x0, FAIL4    # loop here if failed MSB boundary true case
		wfi
FAIL5:
    	#beq  x0, x0, FAIL5    # loop here if failed MSB boundary false case
		wfi
