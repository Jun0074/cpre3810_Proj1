# =====================================================
# File: slti_lapnow_1.s
# Author: <Your Name / NetID>
# Purpose: Basic functionality tests for SLTI
# Notes:
#   - Only uses ADDI (above SLTI) and WFI (halt)
#   - Tests common cases: positive, negative, and zero values
# =====================================================

    .text
    .globl main

main:
    # Test 1: Positive number smaller than imm
    # Checks common case where rs1 < imm, should set result = 1
    addi x5, x0, 5
    slti x6, x5, 10          # expect x6 = 1 (5 < 10)

    # Test 2: Positive number greater than imm
    # Ensures SLTI correctly clears result when false
    addi x7, x0, 20
    slti x8, x7, 10          # expect x8 = 0 (20 < 10 false)

    # Test 3: Negative number compared to 0
    # Confirms proper signed comparison for negative input
    addi x9, x0, -5
    slti x10, x9, 0          # expect x10 = 1 (-5 < 0)

    # Test 4: Zero equal to immediate
    # Verifies equality does NOT trigger less-than condition
    addi x11, x0, 0
    slti x12, x11, 0         # expect x12 = 0 (0 < 0 false)

end:
    wfi
    #j end
