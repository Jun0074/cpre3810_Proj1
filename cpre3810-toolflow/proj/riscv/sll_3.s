# Tests for signed bit shifts, overflow, and negative shifts.

.text
.globl main

main:
    # Test 1: Shift -1 by 4
    # Verifies that MSB gets dropped when neccesary 
    addi t1, zero, -1     # rs1 = -1 (0xFFFFFFFF)
    addi t2, zero, 4      # rs2 = 4
    sll  t3, t1, t2       # t3 = 0xFFFFFFFF << 4 = 0xFFFFFFF0
    # EXPECT: t3 = 0xFFFFFFF0

    # Test 2: Shift 0x80000000  by 1
    # Verifies that MSB gets dropped when neccesary 
    lui  t1, 0x80001     # rs1 = 0x80001000
    addi t2, zero, 1     # rs2 = 1
    sll  t4, t1, t2      # t4 = 0x80001000 << 1 = 0
    # EXPECT: t4 = 0x00010000

    # Test 3: Shift 1 by -1
    # Verifies that masking the shift magnitude works for negative shifts
    addi t1, zero, 16    # rs1 = 16
    addi t2, zero, -1    # rs2 = -1
    sll  t5, t1, t2      # t5 = 1 << 31 = 0x80000000
    # EXPECT: t5 = 0x80000000

end:
    wfi
   # j end
     
