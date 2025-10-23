.data

.text
.globl main

# Test: SRA basic functionality and sign extension
# This test checks shifting positive and negative values by 0 and 1.
# Only addi and lui are used.

main:
    # Load max positive value possible with addi (0x7FFFF7FF = 0x7FFFF0000 + 0x7FF)
    lui x1, 0x7FFFF         # x1 = 0x7FFFF0000
    addi x1, x1, 0x7FF      # x1 = 0x7FFFF7FF

    # Load min negative 32-bit int: 0x80000000
    lui x2, 0x80000         # x2 = 0x80000000

    # Load -1 (all bits set): 0xFFFFFFFF
    addi x3, x0, -1         # x3 = -1

    # Load 0 (shift amount)
    addi x4, x0, 0          # x4 = 0

    # Load 1 (shift amount)
    addi x5, x0, 1          # x5 = 1

    # Load arbitrary positive: 0x12345678
    lui x6, 0x12345         # x6 = 0x12345000
    addi x6, x6, 0x678      # x6 = 0x12345678

    # Load arbitrary negative: 0x87654321
    lui x7, 0x87654         # x7 = 0x87654000
    addi x7, x7, 0x321      # x7 = 0x87654321

    # Shift max positive by 0 (should be unchanged)
    sra x8, x1, x4          # x8 = 0x7FFFF7FF >> 0

    # Shift max positive by 1
    sra x9, x1, x5          # x9 = 0x7FFFF7FF >> 1

    # Shift min negative by 0 (should be unchanged)
    sra x10, x2, x4         # x10 = 0x80000000 >> 0

    # Shift min negative by 1 (should sign-extend)
    sra x11, x2, x5         # x11 = 0x80000000 >> 1

    # Shift -1 by 0 (should be unchanged)
    sra x12, x3, x4         # x12 = -1 >> 0

    # Shift -1 by 1 (should remain -1 due to sign extension)
    sra x13, x3, x5         # x13 = -1 >> 1

    # Shift arbitrary positive by 1
    sra x14, x6, x5         # x14 = 0x12345678 >> 1

    # Shift arbitrary negative by 1
    sra x15, x7, x5         # x15 = 0x87654321 >> 1

end:
    wfi                     
  #  j end                   

# Justification:
# - Tests SRA with shift amounts 0 and 1 for positive, negative, and edge-case values.
# - Verifies sign extension and correct behavior for minimal shifts.
