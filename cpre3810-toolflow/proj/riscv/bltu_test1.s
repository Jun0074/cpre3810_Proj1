# Test 01: Stress-test basic functionality of bltu
# Uses only: addi, beq, bltu.

    .text
    .globl _start
_start:
	#test case 1: a0 < a1 (1 < 2)
	addi a0, x0, 1        # a0 = 1
	addi a1, x0, 2        # a1 = 2
	bltu a0, a1, TAKEN1   # if (1 < 2) unsigned, then branch (EXPECT taken)
	beq  x0, x0, FAIL1    # otherwise BLTU failed case 1, got o FAIL1 and loop

TAKEN1:
	#test case 2: a0 > a1 (2 < 1)
	addi a0, x0, 2        # a0 = 2
	addi a1, x0, 1        # a1 = 1
	bltu a0, a1, FAIL2    # if (2 < 1), should NOT branch 
	# fall-through = passed case 2
	
	#test case 3: a0 == a1 (5 == 5)
	addi a0, x0, 5        # a0 = 5
	addi a1, x0, 5        # a1 = 5
	bltu a0, a1, FAIL3    # if (5 < 5), false (strict <), expect NOT taken

PASS:
	wfi
	#beq  x0, x0, PASS     # if all cases pass, loop here

FAIL1:
	wfi
	#beq  x0, x0, FAIL1    # loop here if case 1 fails

FAIL2:
	wfi
	#beq  x0, x0, FAIL2    # loop here if case 2 fails

FAIL3:
	wfi
	#beq  x0, x0, FAIL3    # loop here if case 3 fails

