.data

.text
.globl main

main:
    # This tests the functionality of sw with lw
    # Start Test
    
    lui x1, 0x10000	# Add 0x10000000 to x1
    addi x2, x0, 1	# Add 1 to x2
    sw x2, 0(x1)	# Store 1 with offset of 0 at x1 (0x10000000)
    lw x3, 0(x1)	# Load value at x1 (x2 = 1) into x3
    sw x3, 8(x1)	# Store x3 (1) with offset of 8 at x1 (0x10000008)
    
    end:
      wfi

    
