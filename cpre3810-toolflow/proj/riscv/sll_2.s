# Tests edge shift amounts including 31 (max) and 32/33 (should be masked to 0 and 1 respectively)

.text
.globl main

main:
    # Test 1: Shift 1 by 31
    # Verifies that a maximum shift amount works
    addi t1, zero, 1      # rs1 = 1
    addi t2, zero, 31     # rs2 = 31
    sll  t3, t1, t2       # t3 = 1 << 31
    # EXPECT: t3 = 0x80000000

    # Test 2: Shift 1 by 32
    # Verifies that masking the shift magnitude works 
    addi t1, zero, 1      # rs1 = 1
    addi t2, zero, 32     # rs2 = 32
    sll  t4, t1, t2       # t4 = 1 << 0 = 1
    # EXPECT: t4 = 0x1

    # Test 3: Shift 1 by 33
    # Verifies that masking the shift magnitude works 
    addi t1, zero, 1      # rs1 = 1
    addi t2, zero, 33     # rs2 = 33
    sll  t5, t1, t2       # t5 = 1 << 1 = 2
    # EXPECT: t5 = 0x2

end:
    wfi
  #  j end
      
