# =====================================================
# File: slti_lapnow_3.s
# Author: <Your Name / NetID>
# Purpose: Mixed-sign and near-boundary tests for SLTI
# Notes:
#   - Uses only ADDI (above SLTI)
#   - Focus: transition points where comparison flips between 0 and 1
# =====================================================

    .text
    .globl main

main:
    # Test 1: Positive rs1 vs negative imm
    # Validates sign handling when rs1 is positive
    addi x5, x0, 1
    slti x6, x5, -1          # expect x6 = 0 (1 < -1 false)

    # Test 2: Negative rs1 vs positive imm
    # Checks sign-extended comparison when signs differ
    addi x7, x0, -1
    slti x8, x7, 1           # expect x8 = 1 (-1 < 1 true)

    # Test 3: Equal positive numbers
    # Confirms equality doesn't trigger the condition
    addi x9, x0, 5
    slti x10, x9, 5          # expect x10 = 0 (5 < 5 false)

    # Test 4: Just below the threshold
    # Boundary case to verify precise comparison
    addi x11, x0, 4
    slti x12, x11, 5         # expect x12 = 1 (4 < 5 true)

    # Test 5: Just above the threshold
    # Complements previous test to confirm 0 result
    addi x13, x0, 6
    slti x14, x13, 5         # expect x14 = 0 (6 < 5 false)

end:
    wfi
 #   j end
